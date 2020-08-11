%% 参数
A = 1;
sigma = 1;
M = 2;
n = 2;
a = 1;

%% 准备工作
% X 的所有取值
xc = zeros(1, M);
for k = 1:M
    xc(k) = (k-M/2-0.5)*A;
end

% 定义高斯噪声的概率密度函数
f_N = @(x, u, s) 1/(sqrt(2*pi)*s)*exp(-(x-u).^2./(2*s^2));

% 定义被积函数
f_Y = @(x) 1/M*(f_N(x, xc(1), sigma)+f_N(x, xc(2), sigma));
f_numer = @(x) x.*f_Y(x);

n_z = n^2; % 重建电平数

% 初始化分层电平
y = zeros(1, n_z+1);
for k = 1:n_z
    if k == 1
        y(k) = -inf;
        y(k+1) = (-n_z/2+1)*a;
    elseif k == n^2
        y(k) = (n_z/2-1)*a;
        y(k+1) = inf;
    else
        y(k) = (k-1-n_z/2)*a;
        y(k+1) = y(k)+a;
    end
end

%% 求最佳重建电平和 H(Z)
function [z, H_Z] = find_z_opt(n_z, y, f_Y)
    z = zeros(1, n_z);
    H_Z = 0;

    for k = 1:n_z  
        numer = integral(f_numer, y(k), y(k+1));
        denom = integral(f_Y, y(k), y(k+1));
        z(k) = numer/denom;
        H_Z = H_Z-denom*log2(denom);
    end
end

%% 求最佳分层电平
function y = find_y_opt(n_z, z)
    y = zeros(1, n_z+1);

    for k = 2:n_z-1  
        y(k) = (z(k-1)+z(k))/2;
    end
end