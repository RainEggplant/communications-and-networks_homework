%% ����
A = 1;
s = 1; % ��˹����������
M = 2;
n = 2;

%% ׼������
n_z = 2^n; % �ؽ���ƽ��

% �����˹�����ĸ����ܶȺ���
f_N = @(x, u, s) 1/(sqrt(2*pi)*s)*exp(-(x-u).^2./(2*s^2));

% �� X ������ȡֵ
xc = zeros(1, M);
for k = 1:M
    xc(k) = (k-M/2-0.5)*A;
end

% ���屻������
% д�� f_Y ���������
f_Y = @(x) 1/M*(f_N(x, xc(1), s)+f_N(x, xc(2), s));
% ע�������������ַ�ʽ������п���չ�ԣ����Ǵ����� (M-1) ����������ʧ
% f_Y = @(x) 1/M*f_N(x, xc, s);
f_numer = @(x) x.*f_Y(x);

%% ɨ�� a, �� I(Z;Y) �� I(Z;C)
n_a = 1000;
a = linspace(0.01, 5, n_a);
H_Z = zeros(1, n_a);
H_Z_g_X = zeros(1, n_a);

for k = 1:n_a
    y = calc_y(n_z, a(k));
    
    % ������� f_Y ��д���ģ����������������
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
