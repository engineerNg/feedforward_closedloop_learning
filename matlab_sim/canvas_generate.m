% 生成赛道图像
clc;
clear;

% 创建一个空白图像
trackImage = 255 * ones(500, 500, 'uint8');

% 定义赛道参数
center = [250, 250];
outerRadius = 200;
innerRadius = 100;
numPoints = 100;

% 生成赛道外圈
theta = linspace(0, 2*pi, numPoints);
outerX = center(1) + outerRadius * cos(theta);
outerY = center(2) + outerRadius * sin(theta);

% 生成赛道内圈
innerX = center(1) + innerRadius * cos(theta);
innerY = center(2) + innerRadius * sin(theta);

% 创建赛道
for i = 1:numPoints-1
    trackImage = insertShape(trackImage, 'Line', [outerX(i), outerY(i), outerX(i+1), outerY(i+1)], 'Color', 'black', 'LineWidth', 5);
    trackImage = insertShape(trackImage, 'Line', [innerX(i), innerY(i), innerX(i+1), innerY(i+1)], 'Color', 'black', 'LineWidth', 5);
end

% 填充赛道内部
mask = false(size(trackImage));
for i = 1:numPoints
    mask = mask | poly2mask([outerX(i), outerX(mod(i,numPoints)+1), center(1)], [outerY(i), outerY(mod(i,numPoints)+1), center(2)], size(trackImage, 1), size(trackImage, 2));
    mask = mask & ~poly2mask([innerX(i), innerX(mod(i,numPoints)+1), center(1)], [innerY(i), innerY(mod(i,numPoints)+1), center(2)], size(trackImage, 1), size(trackImage, 2));
end
trackImage(mask) = 0;

% 显示赛道图像
imshow(trackImage);

% 保存图像
imwrite(trackImage, 'track.png');
