% Simulink模型初始化
simulinkModel = 'NeuralNetworkController';
open_system(simulinkModel);

% 定义神经网络结构
layers = [1, 10, 1];
activationFunctions = {'relu', 'sigmoid'};
learningRate = 0.01;
nn = NeuralNetwork(layers, activationFunctions, learningRate);

% 创建闭环控制系统
T = 1; % 延迟时刻
P_gain = 2; % P控制器增益

% Simulink参数设置
set_param([simulinkModel '/P Controller'], 'P', num2str(P_gain));
set_param([simulinkModel '/Neural Network'], 'NN', 'nn');
set_param([simulinkModel '/Delay'], 'Delay', num2str(T));

% 运行仿真
sim(simulinkModel);

% 获取仿真结果
simout = get(simout, 'yout');
plot(simout.time, simout.signals.values);
xlabel('Time');
ylabel('Output');
title('Closed-loop System Response with Neural Network Controller');
