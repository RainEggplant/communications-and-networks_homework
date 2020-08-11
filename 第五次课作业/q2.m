Ts = 1/(3e6);
fc = 100e6;
A = 1;

%% q2_1
f = [-10e6:1e2:10e6];
ss1 = (125e12 * A^2 ./ (4 * Ts * pi^4 * f.^4)) .* (1 - sin(2 * pi * f * Ts)) ...
    .* (sin(0.2e-6 * pi * f) .* sin(0.3e-6 * pi * f)).^2;
figure;
plot(f, ss1);
xlabel('f (Hz)');
title('基带信号功率谱');

%% q2_2
ss2 = 1e12 * (26 * A^2 ./ (Ts * pi^4 * f.^4)) .* (1 - sin(2 * pi * f * Ts)) ...
    .* (sin(0.2e-6 * pi * f) .* sin(0.3e-6 * pi * f)).^2;
figure;
plot(f, ss2);
xlabel('f (Hz)');
title('基带信号功率谱（连续谱部分）');
f_d = [-floor(1e8 * Ts) / Ts:1/Ts:floor(1e8 * Ts) / Ts];
ss2_d = 1e12 * (0.5 * A^2 ./ (Ts^2 * pi^4 * f_d.^4)) ...
    .* (sin(0.2e-6 * pi * f_d) .* sin(0.3e-6 * pi * f_d)).^2;
ss2_d0 = 1e12 * 0.5 * 0.06^2 * A^2 ./ Ts^2;

figure;
hold on;
stem(f_d, ss2_d, 'b');
stem(0, ss2_d0, 'b');
set(gca(), 'YScale', 'log');
xlabel('f (Hz)');
title('基带信号功率谱（线谱部分）');

%% q2_3
f = [-10e6:1e2:10e6];
ss3 = (125e12 * A^2 ./ (2 * Ts * pi^4 * f.^4)) .* (1 + cos(2 * pi * f * Ts)) ...
    .* (sin(0.2e-6 * pi * f) .* sin(0.3e-6 * pi * f)).^2;
figure;
plot(f, ss3);
xlabel('f (Hz)');
title('基带信号功率谱');
