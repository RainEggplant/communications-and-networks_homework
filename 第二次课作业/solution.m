lambda = 0.3; % 载波波长
B = 1e6; % 带宽
k = 1.38064852e-23; % 玻尔兹曼常数
T = 27+273.15; % 温度
P0 = 1e-3;
eta = 0.7;

d = 100; % 距离
D_T = 0.6; % 采集器天线直径
D_R = 0.6; % 传感器天线直径

G_T = (pi*D_T/lambda)^2; % 增益
G_R = (pi*D_R/lambda)^2;
m = (lambda/(4*pi*d))^2; % 损耗因子
N = k*T*B; % 噪声功率

T_ratio = [1:6000]'; % T1, T2 之比
R = 1024*8*(1+T_ratio); % 传输速率
SNR = 2.^(R/B)-1; % 信道容量等于传输速率时的信噪比
SNR0 = SNR.*10^0.2; % 采集器接收到的信号的信噪比
S = N*SNR0; % 采集器接收到的信号功率
P2 = S/(G_T*G_R*m); % 传感器的发射功率
P1 = (P0+P2)./(T_ratio*G_T*G_R*m*eta); % 采集器的发射功率

figure;
semilogy(T_ratio, P1);
