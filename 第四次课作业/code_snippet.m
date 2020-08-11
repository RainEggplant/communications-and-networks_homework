%% ����
A = 1;
sigma = 1;
M = 2;
n = 2;
a = 1;

%% ׼������
% X ������ȡֵ
xc = zeros(1, M);
for k = 1:M
    xc(k) = (k-M/2-0.5)*A;
end

% �����˹�����ĸ����ܶȺ���
f_N = @(x, u, s) 1/(sqrt(2*pi)*s)*exp(-(x-u).^2./(2*s^2));

% ���屻������
f_Y = @(x) 1/M*(f_N(x, xc(1), sigma)+f_N(x, xc(2), sigma));
f_numer = @(x) x.*f_Y(x);

n_z = n^2; % �ؽ���ƽ��

% ��ʼ���ֲ��ƽ
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

%% ������ؽ���ƽ�� H(Z)
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

%% ����ѷֲ��ƽ
function y = find_y_opt(n_z, z)
    y = zeros(1, n_z+1);

    for k = 2:n_z-1  
        y(k) = (z(k-1)+z(k))/2;
    end
end