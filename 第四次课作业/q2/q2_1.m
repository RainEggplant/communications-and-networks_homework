%% 参数
A = 1;
s = 1; % 高斯噪声均方根
M = 2;
n = 2;
a = 1;

%% 准备工作
n_z = 2^n; % 重建电平数

% 定义高斯噪声的概率密度函数
f_N = @(x, u, s) 1/(sqrt(2*pi)*s)*exp(-(x-u).^2./(2*s^2));

% 求 X 的所有取值
xc = zeros(1, M);
for k = 1:M
    xc(k) = (k-M/2-0.5)*A;
end

% 定义被积函数
% 注：采用这种方式定义具有可扩展性，但是带来了 (M-1) 倍的性能损失
%     想要获得更高性能，可以把 f_Y 写死成函数之和，就像这样
%     f_Y = @(x) 1/M*(f_N(x, xc(1), s)+f_N(x, xc(2), s));
f_Y = @(x) 1/M*f_N(x, xc, s);
f_numer = @(x) x.*f_Y(x);

%% 扫描 a, 求 I(Z;Y) 和 I(Z;C)
y = calc_y(n_z, a);
[z, H_Z] = find_z_opt(n_z, y, f_numer, f_Y);
H_Z_g_X = calc_H_Z_g_X(f_N, xc, s, n_z, M, y);

disp(['z = ',  num2str(z)]);
disp(['I(Z;Y) = ', num2str(H_Z)]);
disp(['I(Z;C) = ', num2str(H_Z-H_Z_g_X)]);
