warning('off');

%% 求蜂窝星座
N = 20;
n = [1:N];
bpsym = log2(3*n.^2+3*n+1);
Q = @(x) 1-normcdf(x);
syms SNR;
P_e = (18*n.^2+6*n)./(3*n.^2+3*n+1) .* ...
    Q(sqrt(4*(3*n.^2+3*n+1)./(n.*(n+1).*(5*n.^2+5*n+2))*SNR));
eqns = P_e == 1e-3;

SNR_pb = zeros(1, N);
for k = 1:N
    SNR_pb(k) = solve(eqns(k), SNR)/bpsym(k);
end

%% 求正交幅度调制
NL = 30;
L = [2:1+NL];
bpsym_2 = 2*log2(L);
P_e_2 = 2*(L-1)./L.*Q(sqrt(3./(L.^2-1)*SNR));
eqns_2 = P_e_2 == 1e-3;

SNR_pb_2 = zeros(1, NL);
for k = 1:NL
    SNR_pb_2(k) = solve(eqns_2(k), SNR)/bpsym_2(k);
end

%% 绘图
figure;
hold on;
plot(bpsym, SNR_pb);
plot(bpsym_2, SNR_pb_2);
legend('蜂窝星座', '正交幅度调制');
title('速率-能效曲线 (P_e=1e-3)');
xlabel('bit/sym');
ylabel('SNR/bit');
