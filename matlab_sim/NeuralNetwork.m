classdef NeuralNetwork
    properties
        layers;
        activationFunctions;
        learningRate;
        weights;
        biases;
        savedWeights;
        momentum;
        lastWeights;
    end
    
    methods
        function obj = NeuralNetwork(layers, activationFunctions, learningRate, momentum)
            obj.layers = layers;
            obj.activationFunctions = activationFunctions;
            obj.learningRate = learningRate;
            obj.momentum = momentum;
            obj = obj.initializeWeights();
        end
        
        function obj = initializeWeights(obj)
            num_layers = length(obj.layers);
            obj.weights = cell(num_layers - 1, 1);
            obj.biases = cell(num_layers - 1, 1);
            obj.lastWeights = cell(num_layers - 1, 1);

            epsilon = 1e-6;
            for i = 1:num_layers - 1
                nInputs = obj.layers(i);
                nOutputs = obj.layers(i+1);
                max_val = 1/(10 * nInputs); % Adjusted formula based on your description
                obj.weights{i} = (2 * rand(nOutputs, nInputs) - 1) * max_val;
                obj.lastWeights{i} = zeros(nOutputs, nInputs);
                obj.biases{i} = zeros(nOutputs, 1); % You can adjust bias initialization as needed
            end
        end

        function [output, activations] = forward(obj, input)
            activations = cell(length(obj.layers), 1);
            activations{1} = input;
            for i = 1:length(obj.layers) - 1
                z = obj.weights{i} * activations{i} + obj.biases{i};
                activations{i+1}  = obj.activation(z, obj.activationFunctions{i});
                % activations{i+1} = temp(i);
            end
            output = activations{end};
        end

        function obj = updateWeights(obj, input, error)
            % 前向传播，保存每一层的激活值
            [~, activations] = obj.forward(input);
            
            % 计算误差并更新权重和偏置
            delta = error;
            for i = 1:length(obj.layers) - 1
                grad_w = delta .* activations{i}';
                obj.weights{i} = obj.weights{i} + obj.learningRate .* grad_w + obj.momentum .* obj.lastWeights{i};
                obj.lastWeights{i} = obj.learningRate .* grad_w;
                % obj.weights{i} = obj.weights{i} + 0.05;
            end
        end

        % function obj = updateWeights(obj, input, error)
        %     a = input;
        %     for i = 1:length(obj.layers) - 1
        %         z = obj.weights{i} * a + obj.biases{i};
        %         a = obj.activation(z, obj.activationFunctions{i});
        %         grad_w = error * a';
        %         obj.weights{i} = obj.weights{i} - obj.learningRate * (a * error');
        %         obj.biases{i} = obj.biases{i} - obj.learningRate * error;
        %         error = obj.weights{i}' * error;
        %         a = z; % Update 'a' to be the current layer's output for the next iteration
        %     end
        % end
        % 

        function output = activation(~, z, func)
            switch func
                case 'sigmoid'
                    output = 1 ./ (1 + exp(-z));
                case 'tanh'
                    output = tanh(z);
                case 'relu'
                    output = max(0, z);
                otherwise
                    error('Unsupported activation function');
            end
        end

        function saveWeights(obj)
            assignin('base', 'savedWeights', obj.savedWeights);
        end

    end
end
