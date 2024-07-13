Fs = 1;  % 采样频率 (Hz)
f = Fs/10;  % 归一化频率 (0 到 0.5)
q = 0.51;  % 品质因数

fTimesPi = f * pi * 2;
e = fTimesPi / (2.0 * q);
w = sqrt(fTimesPi^2 - e^2);

s1 = -e + 1i * w;
s2 = -e - 1i * w;

denominator1 = real(-exp(s2) - exp(s1));
denominator2 = real(exp(s1 + s2));

b = [1 0 0];  % 分子系数
a = [1 denominator1 denominator2];  % 分母系数

assignin('base', 'b_coeff_10', b);
assignin('base', 'a_coeff_10', a);


% 查看滤波器的频率响应
%fvtool(b, a);

% 在 Simulink 中使用这些系数
% 使用 From Workspace 模块导入 b 和 a 系数到 Simulink 中
