%% 参数
A = 1;
s = 1; % 高斯噪声均方根
M = 2;
n = 2;

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
% 写死 f_Y 以提高性能
f_Y = @(x) 1/M*(f_N(x, xc(1), s)+f_N(x, xc(2), s));
% 注：采用下面这种方式定义具有可扩展性，但是带来了 (M-1) 倍的性能损失
% f_Y = @(x) 1/M*f_N(x, xc, s);
f_numer = @(x) x.*f_Y(x);

%% 扫描 a, 求 I(Z;Y) 和 I(Z;C)
n_a = 1000;
a = linspace(0.01, 5, n_a);
H_Z = zeros(1, n_a);
H_Z_g_X = zeros(1, n_a);

for k = 1:n_a
    y = calc_y(n_z, a(k));
    
    % 如果上面 f_Y 是写死的，则用下面这个函数
    [~, H_Z(k)] = find_z_opt_high_perf(n_z, y, f_numer, f_Y);
    % [~, H_Z(k)] = find_z_opt(n_z, y, f_numer, f_Y);
    H_Z_g_X(k) = calc_H_Z_g_X(f_N, xc, s, n_z, M, y);
end

I_Z_C = H_Z-H_Z_g_X;

figure;
hold on;
plot(a, H_Z);
plot(a, I_Z_C);
legend('I(Z;Y)', 'I(Z;C)');
xlabel('a');
[I_Z_Y_max, idx] = max(H_Z);
disp(['a = ', num2str(a(idx)), ...
    ', I(Z;Y)_max = ', num2str(I_Z_Y_max)]);
[I_Z_C_max, idx] = max(I_Z_C);
disp(['a = ', num2str(a(idx)), ...
    ', I(Z;C)_max = ', num2str(I_Z_C_max)]);
