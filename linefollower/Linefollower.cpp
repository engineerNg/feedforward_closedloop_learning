#include "Racer.h"
#include <QApplication>
#include <QtGui>
#include "fcl_util.h"
#include <viewer/Viewer.h>

#include "Linefollower.h"

using namespace Enki;
using namespace std;

class LineFollower : public ViewerWidget {
protected:
	// The robot
	Racer* racer;
	
	// Is set by the learning rate setter. Do not change here!
	double learningRate = 0;
	
	FeedforwardClosedloopLearningWithFilterbank* fcl = NULL;
	FeedforwardClosedloopLearningWithFilterbank* nn_control = NULL;

	FeedforwardClosedloopLearning* dynamicModel = NULL;

	std::vector<double> pred;
	std::vector<double> err;


	FILE* flog = NULL;

	FILE* llog = NULL;

	FILE* fcoord = NULL;
	
	int learningOff = 1;

	long step = 0;

	double avgError = 0;

	int successCtr = 0;

	int trackCompletedCtr = 5000;
	
	// Flag to represent the finish of training.
	int trainingFinished = 0;

	// Sliding window average.
	double avgOutput[6] = {0};

	double weightChange = 0;
	double weightSum = 0;

	// Identify goodness of previous data.
	double nowDistance = 0;
	double lastDistance = 0;

	// history step = 3.
	double lastError[3] = {0};
	double lastControl[3] = {0};

	// NN control error input.
	std::vector<double> nnError;

public:
	LineFollower(World *world, QWidget *parent = 0) :
		ViewerWidget(world, parent) {

		flog = fopen("flog.tsv","wt");
		fcoord = fopen("coord.tsv","wt");

		// setting up the robot
		racer = new Racer(nInputs);
		racer->pos = Point(100, 40);
		// racer->pos = Point(100, 10);
		racer->angle = 1;
		racer->leftSpeed = speed;
		racer->rightSpeed = speed;
		world->addObject(racer);

		pred.resize(nInputs);
		err.resize(nInputs);
		nnError.resize(nInputs);

		// setting up deep feedforward learning
		fcl = new FeedforwardClosedloopLearningWithFilterbank(
			nInputs,
			nNeuronsInLayers,
			nFiltersInput,
			minT,
			maxT);

		nn_control = new FeedforwardClosedloopLearningWithFilterbank(
			nInputs,
			nNeuronsInLayers,
			nFiltersInput,
			minT,
			maxT);

		fcl->initWeights(1,0,FCLNeuron::MAX_OUTPUT_RANDOM);
		fcl->setLearningRate(learningRate);
		fcl->setLearningRateDiscountFactor(1);
		fcl->setBias(1);
		fcl->setActivationFunction(FCLNeuron::TANH);
		// fcl->setMomentum(0.9);	
		fcl->setMomentum(0.9);	

		nn_control->initWeights(1,0,FCLNeuron::MAX_OUTPUT_RANDOM);
		nn_control->setLearningRate(learningRate);
		nn_control->setLearningRateDiscountFactor(1);
		nn_control->setBias(1);
		nn_control->setActivationFunction(FCLNeuron::TANH);
		nn_control->setMomentum(0.9);

		// dynamicModel = new FeedforwardClosedloopLearning(
		// 	2,
		// 	nNeuronsInLayersBackProp);

		// dynamicModel->initWeights(1,0,FCLNeuron::MAX_OUTPUT_RANDOM);
		// dynamicModel->setLearningRate(0.002);
		// dynamicModel->setLearningRateDiscountFactor(1);
		// dynamicModel->setBias(1);
		// dynamicModel->setActivationFunction(FCLNeuron::TANH);
		// dynamicModel->setMomentum(0.9);
	}

	~LineFollower() {
		fclose(flog);
		fclose(fcoord);
		delete fcl;
		delete nn_control;
		//delete dynamicModel;
	}

	void setLearningRate(double _learningRate) {
		if (_learningRate < 0) return;
		learningRate = _learningRate;
		fcl->setLearningRate(learningRate);	
		nn_control->setLearningRate(learningRate);	
	}

	inline long getStep() {return step;}

	inline double getAvgError() {return avgError;}

	// here we do all the behavioural computations
	// as an example: line following and obstacle avoidance
	virtual void sceneCompletedHook()
	{
		// These 4 variables are for reflex loop.  
		double leftGround = racer->groundSensorLeft.getValue();
		double rightGround = racer->groundSensorRight.getValue();
		double leftGround2 = racer->groundSensorLeft2.getValue();
		double rightGround2 = racer->groundSensorRight2.getValue();
		
		// fprintf(stderr,"%e\t",racer->pos.x);
		fprintf(fcoord,"%e\t%e\n",racer->pos.x,racer->pos.y);
		// check if we've bumped into a wall
		if ((racer->pos.x<75) ||
		    (racer->pos.x>(maxx-border)) ||
		    (racer->pos.y<border) ||
		    (racer->pos.y>(maxy+border)) ||
		    (leftGround<a) ||
		    (rightGround<a) ||
		    (leftGround2<a) ||
		    (rightGround2<a)) {
			learningOff = 30;
			// learningOff = 5;
		}
		if (racer->pos.x < border) {
			racer->angle = 0;
			trackCompletedCtr = STEPS_OFF_TRACK;
		}
		trackCompletedCtr--;
		if (trackCompletedCtr < 1) {
			// been off the track for a long time!
			step = MAX_STEPS;
			qApp->quit();
		}
		//fprintf(stderr,"%d ",learningOff);
		if (learningOff>0) {
			fcl->setLearningRate(0);
			nn_control->setLearningRate(0);
			learningOff--;
		} else {
			fcl->setLearningRate(learningRate);
			nn_control->setLearningRate(learningRate);
		}

		fprintf(stderr,"%e %e %e %e ",leftGround,rightGround,leftGround2,rightGround2);
		for(int i=0;i<racer->getNsensors();i++) {
			pred[i] = -(racer->getSensorArrayValue(i))*10;
			// workaround of a bug in Enki
			if (pred[i]<0) pred[i] = 0;
			//if (i>=racer->getNsensors()/2) fprintf(stderr,"%e ",pred[i]);
		}

		/* When the robot is on track, sensors capture a large value, vise versa. */ 
		double error = (leftGround+leftGround2*2)-(rightGround+rightGround2*2);
		fprintf(stderr, "%e ", error);

		//fprintf(stderr,"%e %e %e %e ",pred[0], pred[14], pred[15], pred[29]);

		for(auto &e:err) {
			e = error;
                }
		// !!!!

		// nowDistance = error;

		// // if (nowDistance < lastDistance)
		// // {
		// // 	fcl->setLearningRate(learningRate);
		// // 	fprintf(stderr, "Learning! ");
		// // }
		// // else
		// // {
		// // 	fcl->setLearningRate(0);
		// // }

		// lastDistance = nowDistance;

		// std::vector<double> dynamicInput = {lastControl[2], -lastControl[2], lastError[0]};
		
		// std::vector<double> dynamicError = {abs(error) - dynamicModel->getOutputLayer()->getNeuron(0)->getOutput()};

		// fprintf(stderr, "%e %e ", dynamicModel->getOutputLayer()->getNeuron(0)->getOutput()- (error), lastError);

		// dynamicModel->doStepBackProp(dynamicInput, dynamicError);

		nn_control->getOutputLayer()->setActivationFunction(FCLNeuron::ActivationFunction::LINEAR);
	
		if (step > 8000)
		{
			nn_control->setLearningRate(0);
		}
		else
		{
			nn_control->setLearningRate(learningRate);
		}

		for(auto &e:nnError) 
		{
			e = error - nn_control->getOutputLayer()->getNeuron(0)->getOutput();
		}
		if (step > 100)
		{
			//nn_control->doStepBackProp(pred, nnError);
		}

		fcl->getOutputLayer()->setActivationFunction(FCLNeuron::ActivationFunction::LINEAR);


		fcl->doStep(pred,err);
				
		// weightChange -= weightSum;

		// float vL = (float)((fcl->getOutputLayer()->getNeuron(0)->getOutput())*50 +
		// 		   (fcl->getOutputLayer()->getNeuron(1)->getOutput())*10 +
		// 		   (fcl->getOutputLayer()->getNeuron(2)->getOutput())*2);
		// float vR = (float)((fcl->getOutputLayer()->getNeuron(3)->getOutput())*50 +
		// 		   (fcl->getOutputLayer()->getNeuron(4)->getOutput())*10 +
		// 		   (fcl->getOutputLayer()->getNeuron(5)->getOutput())*2);


		float vL = (float)((fcl->getOutputLayer()->getNeuron(0)->getOutput())*200);
		float vR = (float)((fcl->getOutputLayer()->getNeuron(0)->getOutput())*(200));

		// float vL = 0;
		// float vR = 0;

		double erroramp = error * fbgain;

		fprintf(stderr, "%ld ", step);

		// fprintf(stderr, "%e ", erroramp);
		//fprintf(stderr,"%e ",error);
		
		// Outputs of each neuron of output layer. 
		// fprintf(stderr,"%e ",vL);
		// fprintf(stderr,"%e \n",vR);

		// fprintf(stderr,"%e ", nn_control->getLayer(2)->getNeuron(0)->getError());
		// fprintf(stderr,"%e ", nn_control->getLayer(1)->getNeuron(0)->getError());
		// fprintf(stderr,"%e ", nn_control->getLayer(0)->getNeuron(0)->getError());
		// fprintf(stderr,"%e ", nn_control->getLayer(0)->getNeuron(1)->getError());
		// fprintf(stderr,"%e ", nn_control->getLayer(0)->getNeuron(2)->getError());


		fprintf(stderr,"\n");

		// racer->leftSpeed = speed + erroramp + vL;
		// racer->rightSpeed = speed - (erroramp + vR);

		racer->leftSpeed = speed + erroramp + vL;
		racer->rightSpeed = speed - (erroramp + vR);
		
		// documenting
		// if the learning is off we set the error to zero which
		// happens on the edges when the robot is turned violently around
		if (learningOff) error = 0;
       	avgError = avgError + (error - avgError)*avgErrorDecay;
		double absError = fabs(avgError);
		if (absError > SQ_ERROR_THRES) {
			successCtr = 0;
		} else {
			successCtr++;
		}

		if (successCtr>STEPS_BELOW_ERR_THRESHOLD) {
			qApp->quit();
		}
		if (step>MAX_STEPS) {
			qApp->quit();
		}

		/********************************************************************************/
		// The derivative of activation function shown below:
		// for (int i = 0; i < fcl->getOutputLayer()->getNneurons(); i++)
		// {
		// 	fprintf(flog, "%e\t", dActivation[i]);
		// }

		// fprintf(flog,"%e\t",error);
		// fprintf(flog,"%e\t",erroramp);
		// fprintf(flog,"%e\t%e",vL,vR); 
		// fprintf(flog,"\t%e", racer->leftSpeed - racer->rightSpeed);

		// for (int i = 0; i < fcl->getLayer(1)->getNneurons(); i++)
		// {
		// 	fprintf(flog, "\t%e", fcl->getLayer(1)->getError(i));
		// }
				
		// for (int i = 0; i < fcl->getLayer(1)->getNneurons(); i++)
		// {
		// 	fprintf(flog, "\t%e", fcl->getLayer(1)->getOutput(i));
		// }

		fprintf(flog, "\t%e", fcl->getOutputLayer()->getError(0));
		// fprintf(flog, "\t%e", nn_control->getOutputLayer()->getError(0));
		fprintf(flog, "\t%e", erroramp/fbgain);


		fprintf(flog, "\t%e", fcl->getOutputLayer()->getOutput(0));
		// fprintf(flog, "\t%e", nn_control->getOutputLayer()->getOutput(0));


		// fprintf(flog, "\t%e", fcl->getLayer(0)->getWeightDistanceFromInitialWeights());
		fprintf(flog, "\t%e", fcl->getLayer(1)->getWeightDistanceFromInitialWeights());

		// fprintf(flog, "\t%e", 0);

		// fprintf(flog, "\t%e", nn_control->getLayer(1)->getWeightDistanceFromInitialWeights());

		fprintf(flog, "\t%e", fcl->getOutputLayer()->getWeightDistanceFromInitialWeights());
		// fprintf(flog, "\t%e", nn_control->getOutputLayer()->getWeightDistanceFromInitialWeights());
		// fprintf(flog, "\t%e", dynamicModel->getOutputLayer()->getNeuron(0)->getOutput());
		// fprintf(flog, "\t%e", dynamicModel->getOutputLayer()->getWeightDistanceFromInitialWeights());
		// fprintf(flog, "\t%e", dynamicError[0]);
		// fprintf(flog, "\t%e", dynamicInput[0]);
		// fprintf(flog, "\t%e", dynamicInput[1]);
		// fprintf(flog, "\t%e", dynamicInput[2]);

		// fprintf(flog, "\t%e", fcl->getLayer(0)->getNeuron(0)->getOutput());
		// fprintf(flog, "\t%e", fcl->getLayer(0)->getNeuron(0)->getError());
		// fprintf(flog, "\t%e", fcl->getLayer(1)->getNeuron(0)->getWeight(0));
		// double sum = 0;
		// for (int i = 0; i < fcl->getLayer(0)->getNneurons(); i++)
		// {
		// 	sum += fcl->getLayer(1)->getNeuron(0)->getWeight(i);
		// }
		// fprintf(flog, "\t%e", sum);
		// fprintf(flog, "\t%e", fcl->getLayer(1)->getNeuron(0)->getError());

		// for (int i = 0; i < fcl->getLayer(0)->getNneurons(); i++)
		// {
		// 	fprintf(flog, "\t%e", fcl->getLayer(0)->getNeuron(i)->getError());
		// }

		// for(int i=0;i<fcl->getNumLayers();i++) {
		// 	fprintf(flog,"\t%e",fcl->getLayer(i)->getWeightDistanceFromInitialWeights());
		// }
		fprintf(flog,"\n");
		/********************************************************************************/

		if ((step%100)==0) {
			for(int i=0;i<fcl->getNumLayers();i++) {
				char tmp[256];
				sprintf(tmp,"layer%d.dat",i);
				fcl->getLayer(i)->saveWeightMatrix(tmp);
			}
		}

		lastError[0] = error;
		lastError[1] = error;
		lastError[2] = error;

		lastControl[0] = erroramp;
		lastControl[1] = erroramp;
		lastControl[2] = erroramp;

		step++;

		// if (step==11000) {
		// 	for(int i=0;i<fcl->getNumLayers();i++) {
		// 		char tmp[256];
		// 		sprintf(tmp,"layer%d.dat",i);
		// 		fcl->getLayer(i)->saveWeightMatrix(tmp);
		// 	}
		// }
	}

};


void singleRun(int argc,
	       char *argv[],
	       float learningrate,
	       FILE* f = NULL) {
	QApplication app(argc, argv);
	// QString filename("loop.png");
	QString filename("loop.png");
	QImage loopImage;
	loopImage = QGLWidget::convertToGLFormat(QImage(filename));
	if (loopImage.isNull()) {
		fprintf(stderr,"Racetrack file not found\n");
		exit(1);
	}
	const uint32_t *bitmap = (const uint32_t*)loopImage.constBits();
	World world(maxx, maxy,
		    Color(1000, 1000, 100),
		    World::GroundTexture(loopImage.width(), loopImage.height(), bitmap));
	LineFollower linefollower(&world);
	linefollower.setLearningRate(learningrate);
	linefollower.show();
	app.exec();
	fprintf(stderr,"Finished.\n");
	if (f) {
		fprintf(f,"%e %ld %e\n",learningrate,linefollower.getStep(),linefollower.getAvgError());
	}
}


void statsRun(int argc,
	      char *argv[]) {
	FILE* f = fopen("stats.dat","wt");
	for(float learningRate = 0.00001f; learningRate < 0.1; learningRate = learningRate * 1.25f) {
		srandom(1);
		singleRun(argc,argv,learningRate,f);
		fflush(f);
		srandom(42);
		singleRun(argc,argv,learningRate,f);
		fflush(f);
	}
	fclose(f);
}


int main(int argc, char *argv[]) {
	int n = 0;
	if (argc>1) {
		n = atoi(argv[1]);
	} else {
		fprintf(stderr,"Single run: %s 0\n",argv[0]);
		fprintf(stderr,"Stats run: %s 1\n",argv[0]);
		return 0;
	}
	switch (n) {
	case 0:
		singleRun(argc,argv,0.001f);
		// singleRun(argc,argv,0.00025f);
		break;
	case 1:
		statsRun(argc,argv);
		break;
	case 2:
		singleRun(argc,argv,0);
		break;
	}
	return 0;
}
