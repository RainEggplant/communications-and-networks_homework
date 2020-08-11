%% ����
A = 1;
s = 1; % ��˹����������
M = 2;
n = 2;
a = 1;

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
% ע���������ַ�ʽ������п���չ�ԣ����Ǵ����� (M-1) ����������ʧ
%     ��Ҫ��ø������ܣ����԰� f_Y д���ɺ���֮�ͣ���������
%     f_Y = @(x) 1/M*(f_N(x, xc(1), s)+f_N(x, xc(2), s));
f_Y = @(x) 1/M*f_N(x, xc, s);
f_numer = @(x) x.*f_Y(x);

%% ɨ�� a, �� I(Z;Y) �� I(Z;C)
y = calc_y(n_z, a);
[z, H_Z] = find_z_opt(n_z, y, f_numer, f_Y);
H_Z_g_X = calc_H_Z_g_X(f_N, xc, s, n_z, M, y);

disp(['z = ',  num2str(z)]);
disp(['I(Z;Y) = ', num2str(H_Z)]);
disp(['I(Z;C) = ', num2str(H_Z-H_Z_g_X)]);
