clc;
clear;
close all;

% 设定仿真参数
T = 0.1; % 时间步长
totalTime = 100; % 总仿真时间
numSteps = totalTime / T; % 仿真步数

% 设定机器人参数
L = 0.1; % 左右轮距离 (m)
v = 0.2; % 线速度 (m/s)
Kp = 0.5; % P控制器增益

% 初始化机器人的位置和方向
x = 250;
y = 250;
theta = 0;

% 初始化轨迹
trajectory = [x; y];

% 初始化传感器
numFrontSensors = 5; % 前方传感器数量
sensorDistance = 0.05; % 传感器之间的距离 (m)
leftSensorPos = [-L/2; 0];
rightSensorPos = [L/2; 0];

% 创建赛道图像
trackImage = imread('track.png');
trackImage = rgb2gray(trackImage);
trackImage = imresize(trackImage, [500, 500]); % 调整图像大小

% 初始化误差
e = 0;

% 创建神经网络
net = feedforwardnet(10); % 创建一个简单的前馈神经网络
net = configure(net, [x; y; theta; e], [0; 0; 0]); % 配置网络

% 仿真循环
for step = 1:numSteps
    % 获取前方传感器的灰度值
    frontSensors = zeros(1, numFrontSensors);
    for i = 1:numFrontSensors
        sensorX = x + (i - ceil(numFrontSensors/2)) * sensorDistance * cos(theta);
        sensorY = y + (i - ceil(numFrontSensors/2)) * sensorDistance * sin(theta);
        frontSensors(i) = getGrayValue(trackImage, sensorX, sensorY);
    end

    % 获取地面传感器的灰度值
    leftGray = getGrayValue(trackImage, x + leftSensorPos(1), y + leftSensorPos(2));
    rightGray = getGrayValue(trackImage, x + rightSensorPos(1), y + rightSensorPos(2));

    % 计算误差
    e = leftGray - rightGray;

    % P控制器计算控制信号
    omega = Kp * e;

    % 记录当前状态
    prev_x = x;
    prev_y = y;
    prev_theta = theta;

    % 更新机器人位置和方向
    x = x + v * cos(theta) * T;
    y = y + v * sin(theta) * T;
    theta = theta + omega * T;

    % 记录轨迹
    trajectory = [trajectory [x; y]];

    % 更新神经网络
    inputs = [prev_x; prev_y; prev_theta; e];
    targets = [x; y; theta];
    net = adapt(net, inputs, targets);

    % 绘制轨迹和传感器
    imshow(trackImage);
    hold on;
    plot(trajectory(1,:), trajectory(2,:), 'r');
    plot(x, y, 'bo');
    hold off;
    drawnow;
end

function grayValue = getGrayValue(image, x, y)
    % 获取图像中指定位置的灰度值
    imageSize = size(image);
    if x < 1 || x > imageSize(2) || y < 1 || y > imageSize(1)
        grayValue = 255; % 图像外视为白色
    else
        grayValue = image(round(y), round(x));
    end
end
