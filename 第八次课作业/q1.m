alpha = 0.2;
n0 = 1;
h = 1;

%% 求蜂窝星座
k = [2:25];
tmp1 = 1e-3 ./ ((18 * k.^2 + 6 * k) ./ (3 * k.^2 + 3 * k + 1));
tmp2 = qfuncinv(tmp1);
E_s = tmp2.^2 ./ (4 * (3 * k.^2 + 3 * k + 1) ./ ...
    (k .* (k + 1) .* (5 * k.^2 + 5 * k + 2))) * n0 / h^2;
R_M = log2(3 * k.^2 + 3 * k + 1);
spect_eff = 1 / (1 + alpha) .* R_M;

figure;
plot(E_s, spect_eff);
set(gca(), 'XScale', 'log');
xlabel('E_s (J)');
ylabel('Spectrum Efficiency (bps/Hz)')
title('频谱效率-能效关系曲线');

%% 求 QAM
L = [2:30];
tmp1 = 1e-3 ./ (4 * (L - 1) ./ L);
tmp2 = qfuncinv(tmp1);
E_s_QAM = tmp2.^2 ./ (3 ./ (L.^2 - 1)) * n0 / h^2;
spect_eff_QAM = 1 / (1 + alpha) .* 2 * log2(L);
hold on;
plot(E_s_QAM, spect_eff_QAM);
legend('蜂窝星座', 'QAM', 'Location', 'northwest');
