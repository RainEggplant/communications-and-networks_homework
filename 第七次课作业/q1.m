%% q1-1
Ts = 1 / (3e6);
f = [-20e6:1e2:20e6];
g = @(f) 5e6 ./ (pi^2 * f.^2) .* sin(0.2e-6 * pi * f) .* sin(0.3e-6 * pi * f);
figure;
plot(f, g(f));
title('G(f)');
xlabel('Frequency (Hz)');

[~, len] = size(f);
g_overlap = zeros(1, len);
for k = -20:20
    g_overlap = g_overlap + g(f - k / Ts);
end
figure;
plot(f, g_overlap);
title('以 1/T_s 采样后频谱')
ylim([0, 4e-7]);
xlabel('Frequency (Hz)');

%% q1-3
f = [-20e6:1e2:20e6];
h_recv = @(f) 2e3 ./ (pi * f) .* sin(0.25e-6 * pi * f);
figure;
plot(f, h_recv(f));
title('收发滤波器频率幅度响应');
xlabel('Frequency (Hz)');
syms t;
figure;
fplot(2000 * rectangularPulse(-0.125e-6, 0.125e-6, t), [-0.5e-6, 0.5e-6]);
title('收发滤波器时域冲激响应');
xlabel('Time (s)');

%% q1-5
figure;
fplot(1690.31 * rectangularPulse(-0.175e-6, 0.175e-6, t), [-0.5e-6, 0.5e-6]);
title('收发滤波器时域冲激响应');
xlabel('Time (s)');
