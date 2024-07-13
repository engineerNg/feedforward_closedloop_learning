#include "fcl.h"
#include <math.h>
#include <numeric>

/**
 * GNU GENERAL PUBLIC LICENSE
 * Version 3, 29 June 2007
 *
 * (C) 2017-2022, Bernd Porr <bernd@glasgowneuro.tech>
 * (C) 2017, Paul Miller <paul@glasgowneuro.tech>
 **/

FeedforwardClosedloopLearning::FeedforwardClosedloopLearning(const int num_input,
							     const std::vector<int> &num_of_neurons_per_layer) {
#ifdef DEBUG
	fprintf(stderr,"Creating instance of FeedforwardClosedloopLearning.\n");
#endif	

	n_neurons_per_layer = num_of_neurons_per_layer;
	layers = new FCLLayer*[n_neurons_per_layer.size()];
	ni = (unsigned)num_input;

	// creating input layer
#ifdef DEBUG
	fprintf(stderr,"Creating input layer: ");
#endif
	layers[0] = new FCLLayer(n_neurons_per_layer[0], ni);
#ifdef DEBUG
	fprintf(stderr,"n[0]=%d\n",n_neurons_per_layer[0]);
#endif
	
	for(unsigned i=1; i<n_neurons_per_layer.size(); i++) {
#ifdef DEBUG
		fprintf(stderr,"Creating layer %d: ",i);
#endif
		layers[i] = new FCLLayer(n_neurons_per_layer[i], layers[i-1]->getNneurons());
#ifdef DEBUG
		fprintf(stderr,"created with %d neurons.\n",layers[i]->getNneurons());
#endif
	}
	setLearningRate(0);

	// double weightPrev[] = 0;
	// double weightChange = 0;
	
}

FeedforwardClosedloopLearning::~FeedforwardClosedloopLearning() {
	for (unsigned i=0; i<n_neurons_per_layer.size(); i++) {
		delete layers[i];
	}
	delete [] layers;
}


void FeedforwardClosedloopLearning::setStep() {
	for (unsigned k=0; k<n_neurons_per_layer.size(); k++) {
		layers[k]->setStep(step);
	}
}

void FeedforwardClosedloopLearning::setActivationFunction(FCLNeuron::ActivationFunction _activationFunction) {
	for (unsigned k=0; k<n_neurons_per_layer.size(); k++) {
		layers[k]->setActivationFunction(_activationFunction);
	}	
}

void FeedforwardClosedloopLearning::doLearning() {
	for (unsigned k=0; k<n_neurons_per_layer.size(); k++) {
		layers[k]->doLearning();
	}
}


void FeedforwardClosedloopLearning::setDecay(double decay) {
	for (unsigned k=0; k<n_neurons_per_layer.size(); k++) {
		layers[k]->setDecay(decay);
	}
}

void FeedforwardClosedloopLearning::doStep(const std::vector<double> &input, const std::vector<double> &error) {
	if (input.size() != ni) {
		char tmp[256];
		sprintf(tmp,"Input array dim mismatch: got: %ld, want: %d.",input.size(),ni);
		#ifdef DEBUG
		fprintf(stderr,"%s\n",tmp);
		#endif
		throw tmp;
	}
	if (error.size() != ni) {
		char tmp[256];
		sprintf(tmp,
			"Error array dim mismatch: got: %ld, want: %d "
			"which is the number of neurons in the 1st hidden layer!",
			error.size(),layers[0]->getNneurons());
		#ifdef DEBUG
		fprintf(stderr,"%s\n",tmp);
		#endif
		throw tmp;
	}

	doLearning();

	for(int i=0;i<(layers[0]->getNneurons());i++) {
		layers[0]->getNeuron(i)->setError(error[i]);
	}

	// Errors update.
	for (unsigned k=1; k<n_neurons_per_layer.size(); k++) {
		FCLLayer* emitterLayer = layers[k-1];
		FCLLayer* receiverLayer = layers[k];
		
		/* Calculate the errors for the hidden layer and output layer. */
		for(int i=0;i<receiverLayer->getNneurons();i++) 
		{
			double err = 0;
			double l1Norm = 0;
			double l2Norm = 0;
			double absError = 0;

			int sign = 0;
			double errLimited = 0;

			// Vinilla Hebbian learning.
			double _output = 0;

			for(int j=0;j<emitterLayer->getNneurons();j++)
			{
				err = error[0];

				// err = err + receiverLayer->getNeuron(i)->getWeight(j) *
				// 	emitterLayer->getNeuron(j)->getError();

				// l1Norm += fabs(receiverLayer->getNeuron(i)->getWeight(j));

				// l2Norm += receiverLayer->getNeuron(i)->getWeight(j) * 
				// 	receiverLayer->getNeuron(i)->getWeight(j);

#ifdef DEBUG
				if (isnan(err) || (fabs(err)>10000) || (fabs(emitterLayer->getNeuron(j)->getError())>10000)) {
					printf("RANGE! FeedforwardClosedloopLearning::%s, step=%ld, j=%d, i=%d, hidLayerIndex=%d, "
					       "err=%e, emitterLayer->getNeuron(j)->getError()=%e\n",
					       __func__,step,j,i,k,err,emitterLayer->getNeuron(j)->getError());
				}
#endif

			}
			/* Let error signals in all layer remain the same --  */
			/* equal to the raw one. */
			// err = err / emitterLayer->getNneurons();

			// err = err - errorPrev;

			/* learningRateDiscountFactor = 1 in this case. */
			// err = err * learningRateDiscountFactor;

			/* Norm term. */
			// 1. L1 norm.
			// err = err / l1Norm;
			
			// 2. L2 norm.
			// l2Norm = sqrt(l2Norm);
			// err = err / l2Norm;
			 
			// 3. Summation of N neurons.
			// err = err * emitterLayer->getNneurons();

			// 4. Use weight distance change in a step to limit the saturation.
			// weightPrev = 

			/*********************************************************/
			
			/* Limitation of saturation. */
			// 1. dActivation. 
			// err = err * receiverLayer->getNeuron(i)->dActivation();			
			
			// 2. Summation of absolute error of previous neurons.   
			// err = err * absError;

			/*********************************************************/

			/* Vanilla Hebbian Learning */
			_output = receiverLayer->getNeuron(i)->getOutput();

			sign = (err > 0) ? 1 : ((err < 0) ? -1 : 0);

			errLimited = (err > 0.01) ? 0.01: ((err < -0.01) ? -0.01: err); 

			receiverLayer->getNeuron(i)->setError(errLimited * 10);
		}
	}

	// we set the input to the input layer
	layers[0]->setInputs(input.data());
	// ..and calc its output
	layers[0]->calcOutputs();
	// new lets calc the other outputs

	for (unsigned k=1; k<n_neurons_per_layer.size(); k++) {
		FCLLayer* emitterLayer = layers[k-1];
		FCLLayer* receiverLayer = layers[k];
		// now that we have the outputs from the previous layer
		// we can shovel them into the next layer
		for(int j=0;j<emitterLayer->getNneurons();j++) {
			// get the output of a neuron in the input layer
			double v = emitterLayer->getNeuron(j)->getOutput();
			// set that output as an input to the next layer which
			// is distributed to all neurons
			receiverLayer->setInput(j,v);
		}
		
		// now let's calc the output which can then be sent out
		receiverLayer->calcOutputs();
	}

	// the error is injected into the 1st layer!
// 	for(int i=0;i<(layers[0]->getNneurons());i++) {
// 		layers[0]->getNeuron(i)->setError(error[i]);
// 	}
// 	// for(int i=0;i<(getOutputLayer()->getNneurons());i++) {
// 	// 	getOutputLayer()->getNeuron(i)->setError(error[i]);
// 	// }

// 	//printf(stderr, "%e ", getLayer(0)->getNeuron(0)->getOutput());
// 	// double err = error[0];

// 	// err = err - errorPrev;

// 	// Errors update.
// 	// for (unsigned k=1; k<n_neurons_per_layer.size(); k++) {
// 	for (unsigned k=1; k<n_neurons_per_layer.size(); k++) {
// 		FCLLayer* emitterLayer = layers[k-1];
// 		FCLLayer* receiverLayer = layers[k];

// 		// /* Apply layer normalization. */
// 		// /* First calculate mean here. */
// 		// std::vector<double> errorFromEmitterLayer;
// 		// errorFromEmitterLayer.resize(emitterLayer->getNneurons());
// 		// std::vector<double> normalizedErr(errorFromEmitterLayer.size());

// 		// for (int i = 0; i < emitterLayer->getNneurons(); i++)
// 		// {
// 		// 	errorFromEmitterLayer[i] = emitterLayer->getNeuron(i)->getError();
// 		// }

// 		// /* Only applied to Hidden layers and output layer. */
// 		// if (k >= 2)
// 		// {
// 		// 	double mean = std::accumulate(errorFromEmitterLayer.begin(), 
// 		// 				errorFromEmitterLayer.end(), 0.0) / errorFromEmitterLayer.size();

// 		// 	/* Then, calculate variable. */
// 		// 	double sum = 0.0;

// 		// 	for (double val : errorFromEmitterLayer)
// 		// 	{
// 		// 		sum += (val - mean) * (val - mean);
// 		// 	}

// 		// 	double std_dev = std::sqrt(sum / errorFromEmitterLayer.size() + 0.0005);
			
// 		// 	/* Finally calculate normalization. */
// 		// 	for (int i = 0; i < errorFromEmitterLayer.size(); i++) 
// 		// 	{
// 		// 		normalizedErr[i] = (errorFromEmitterLayer[i] - mean) / std_dev;
// 		// 	}
// 		// }
// 		// else
// 		// {
// 		// 	for (int i = 0; i < errorFromEmitterLayer.size(); i++) 
// 		// 	{
// 		// 		normalizedErr[i] = errorFromEmitterLayer[i];
// 		// 	}
// 		// }
		
// 		/* Calculate the errors for the hidden layer and output layer. */
// 		for(int i=0;i<receiverLayer->getNneurons();i++) 
// 		{
// 			double err = 0;
// 			double l1Norm = 0;
// 			double l2Norm = 0;
// 			double absError = 0;

// 			// Vinilla Hebbian learning.
// 			double _output = 0;

// 			for(int j=0;j<emitterLayer->getNneurons();j++)
// 			{
// 				// err = err + receiverLayer->getNeuron(j)->getWeight(i) *
// 				// 	emitterLayer->getNeuron(j)->getError();

// 				// err = err + receiverLayer->getNeuron(i)->getWeight(j) *
// 				// 	emitterLayer->getNeuron(j)->getError();

// 				// l1Norm += fabs(receiverLayer->getNeuron(i)->getWeight(j));

// 				// l2Norm += receiverLayer->getNeuron(i)->getWeight(j) * 
// 				// 	receiverLayer->getNeuron(i)->getWeight(j);
				
// 				// absError = absError + fabs(emitterLayer->getNeuron(j)->getError());

// 				// err = err + receiverLayer->getNeuron(i)	->getWeight(j) *
// 				// 	normalizedErr[j];	

// 				err = error[0];

// #ifdef DEBUG
// 				if (isnan(err) || (fabs(err)>10000) || (fabs(emitterLayer->getNeuron(j)->getError())>10000)) {
// 					printf("RANGE! FeedforwardClosedloopLearning::%s, step=%ld, j=%d, i=%d, hidLayerIndex=%d, "
// 					       "err=%e, emitterLayer->getNeuron(j)->getError()=%e\n",
// 					       __func__,step,j,i,k,err,emitterLayer->getNeuron(j)->getError());
// 				}
// #endif

// 			}
// 			/* Let error signals in all layer remain the same --  */
// 			/* equal to the raw one. */
// 			// err = err / emitterLayer->getNneurons();

// 			// err = err - errorPrev;

// 			/* learningRateDiscountFactor = 1 in this case. */
// 			// err = err * learningRateDiscountFactor;

// 			/* Norm term. */
// 			// 1. L1 norm.
// 			// err = err / l1Norm;
			
// 			// 2. L2 norm.
// 			// l2Norm = sqrt(l2Norm);
// 			// err = err / l2Norm;
			 
// 			// 3. Summation of N neurons.
// 			// err = err * emitterLayer->getNneurons();

// 			// 4. Use weight distance change in a step to limit the saturation.
// 			// weightPrev = 

// 			/*********************************************************/
			
// 			/* Limitation of saturation. */
// 			// 1. dActivation. 
// 			// err = err * receiverLayer->getNeuron(i)->dActivation();			
			
// 			// 2. Summation of absolute error of previous neurons.   
// 			// err = err * absError;

// 			/*********************************************************/

// 			/* Vanilla Hebbian Learning */
// 			// _output = receiverLayer->getNeuron(i)->getOutput();

// 			//err = _output * (err/(fabs(err)+0.000001));

// 			receiverLayer->getNeuron(i)->setError(err);
// 		}
// 	}
	//fprintf(stderr, "%ld %e ", step, err);
	// errorPrev = err;

	// doLearning();
	setStep();
	step++;
}

void FeedforwardClosedloopLearning::doStepBackProp(const std::vector<double> &input, const std::vector<double> &error)
{
	// we set the input to the input layer
	layers[0]->setInputs(input.data());
	// ..and calc its output
	layers[0]->calcOutputs();
	// new lets calc the other outputs

	for (unsigned k=1; k<n_neurons_per_layer.size(); k++) {
		FCLLayer* emitterLayer = layers[k-1];
		FCLLayer* receiverLayer = layers[k];
		// now that we have the outputs from the previous layer
		// we can shovel them into the next layer
		for(int j=0;j<emitterLayer->getNneurons();j++) {
			// get the output of a neuron in the input layer
			double v = emitterLayer->getNeuron(j)->getOutput();
			// set that output as an input to the next layer which
			// is distributed to all neurons
			receiverLayer->setInput(j,v);
		}
		
		// now let's calc the output which can then be sent out
		receiverLayer->calcOutputs();
	}

	// Error is injected into the output layer.
	getOutputLayer()->getNeuron(0)->setError(error[0]);


	for (unsigned k=1; k<n_neurons_per_layer.size(); k++) {
		FCLLayer* emitterLayer = layers[n_neurons_per_layer.size()-k];
		FCLLayer* receiverLayer = layers[n_neurons_per_layer.size()-k-1];

		/* Apply layer normalization. */
		/* First calculate mean here. */
		std::vector<double> errorFromEmitterLayer(emitterLayer->getNneurons());
		std::vector<double> normalizedErr(errorFromEmitterLayer.size());

		for (int i = 0; i < emitterLayer->getNneurons(); i++)
		{
			errorFromEmitterLayer[i] = emitterLayer->getNeuron(i)->getError();
		}

		/* Only applied to Hidden layers. */
		if (k >= 2)
		{
			double mean = std::accumulate(errorFromEmitterLayer.begin(), 
						errorFromEmitterLayer.end(), 0.0) / errorFromEmitterLayer.size();

			/* Then, calculate variable. */
			double sum = 0.0;

			for (double val : errorFromEmitterLayer)
			{
				sum += (val - mean) * (val - mean);
			}

			double std_dev = std::sqrt(sum / errorFromEmitterLayer.size() + 0.00001);
			
			/* Finally calculate normalization. */
			for (int i = 0; i < errorFromEmitterLayer.size(); i++) 
			{
				normalizedErr[i] = (errorFromEmitterLayer[i] - mean) / std_dev;
			}
		}
		else
		{
			for (int i = 0; i < errorFromEmitterLayer.size(); i++) 
			{
				normalizedErr[i] = errorFromEmitterLayer[i];
			}
		}
		
		/* Calculate the errors for the hidden layer and output layer. */
		for(int i=0;i<receiverLayer->getNneurons();i++) 
		{
			double err = 0;

			for(int j=0;j<emitterLayer->getNneurons();j++)
			{
				// err = err + emitterLayer->getNeuron(j)->getWeight(i) *
				// 	emitterLayer->getNeuron(j)->getError();

				err = err + emitterLayer->getNeuron(j)->getWeight(i) * normalizedErr[j];

#ifdef DEBUG
				if (isnan(err) || (fabs(err)>10000) || (fabs(emitterLayer->getNeuron(j)->getError())>10000)) {
					printf("RANGE! FeedforwardClosedloopLearning::%s, step=%ld, j=%d, i=%d, hidLayerIndex=%d, "
					       "err=%e, emitterLayer->getNeuron(j)->getError()=%e\n",
					       __func__,step,j,i,k,err,emitterLayer->getNeuron(j)->getError());
				}
#endif

			}

			err = err * receiverLayer->getNeuron(i)->getOutput();
			
			// dActivation. 
			err = err * receiverLayer->getNeuron(i)->dActivation();		

			// if((n_neurons_per_layer.size()-k-1) == 0)
			// {
			// 	fprintf(stderr, "%e ", err);
			// }	
			
			receiverLayer->getNeuron(i)->setError(err);
		}

		// fprintf(stderr, "\n");
	}

	doLearning();
	setStep();
	step++;
}

void FeedforwardClosedloopLearning::setLearningRate(double rate) {
	for (unsigned i=0; i<n_neurons_per_layer.size(); i++) {
#ifdef DEBUG_FCL
		fprintf(stderr,"setLearningRate in layer %d\n",i);
#endif
		layers[i]->setLearningRate(rate);
	}
}

void FeedforwardClosedloopLearning::setMomentum(double momentum) {
	for (unsigned i=0; i<n_neurons_per_layer.size(); i++) {
#ifdef DEBUG_FCL
		fprintf(stderr,"setMomentum in layer %d\n",i);
#endif
		layers[i]->setMomentum(momentum);
	}
}



void FeedforwardClosedloopLearning::initWeights(double max, int initBias, FCLNeuron::WeightInitMethod weightInitMethod) {
	for (unsigned i=0; i<n_neurons_per_layer.size(); i++) {
		layers[i]->initWeights(max,initBias,weightInitMethod);
	}
}


void FeedforwardClosedloopLearning::setBias(double _bias) {
	for (unsigned i=0; i<n_neurons_per_layer.size(); i++) {
		layers[i]->setBias(_bias);
	}
}

void FeedforwardClosedloopLearning::setDebugInfo() {
	for (unsigned i=0; i<n_neurons_per_layer.size(); i++) {
		layers[i]->setDebugInfo(i);
	}
}

// need to add bias weight
bool FeedforwardClosedloopLearning::saveModel(const char* name) {
	FCLLayer *layer;
	FCLNeuron *neuron;

	FILE *f=fopen(name, "wt");

	if(f) {
		for (unsigned i=0; i<n_neurons_per_layer.size(); i++) {
			layer = layers[i];
			for (int j=0; j<layer->getNneurons(); j++) {
				neuron = layer->getNeuron(j);
				for (int k=0; k<neuron->getNinputs(); k++) {
					if(neuron->getMask(k)) {
						fprintf(f, "%.16lf ", neuron->getWeight(k));
					}
				}
				fprintf(f, "%.16lf ", neuron->getBiasWeight());
				fprintf(f, "\n");
			}
			fprintf(f, "\n");
		}
		fprintf(f, "\n");
	}
	else {
		return false;
	}

	fclose(f);
	return true;
}

bool FeedforwardClosedloopLearning::loadModel(const char* name) {
	FCLLayer *layer;
	FCLNeuron *neuron;
	double weight;
	int r;

	FILE *f=fopen(name, "r");

	if(f) {
		for (unsigned i=0; i<n_neurons_per_layer.size(); i++) {
			layer = layers[i];
			for (int j=0; j<layer->getNneurons(); j++) {
				neuron = layer->getNeuron(j);
				for (int k=0; k<neuron->getNinputs(); k++) {
					if(neuron->getMask(k)) {
						r = fscanf(f, "%lf ", &weight);
						if (r < 0) return false;
						neuron->setWeight(k, weight);						
					}
				}
				r = fscanf(f, "%lf", &weight);
				if (r < 0) return false;
				neuron->setBiasWeight(weight);
				r = fscanf(f, "%*c");
				if (r < 0) return false;
			}
			r = fscanf(f, "%*c");
			if (r < 0) return false;
		}
		r = fscanf(f, "%*c");
		if (r < 0) return false;
	}
	else {
		return false;
	}

	fclose(f);
	return true;
}
