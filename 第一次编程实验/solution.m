%% Calculate results
% 取噪声的标准差 sigma = 1 作为基准
ratio = [0.25, 1, 5, 25]; % x1, x2 均方之比
A1 = logspace(-2, 2, 100)';
A1 = repmat(A1, 1, 4);
A2 = A1./sqrt(ratio);

P1 = 8/3*A1.^2;
%P2 = 8/3*A2.^2;
P2 = P1./ratio;
P = P1+P2; % 总信号功率

% 定义高斯噪声的概率密度函数
f_N = @(x, u, s) 1/(sqrt(2*pi)*s)*exp(-(x-u).^2./(2*s^2));

% 信道输出 Y, Y|X1, Y|X2, Y|X1X2 的概率密度函数
f_Y = @(x) ...
    1/9 * (...
    f_N(x, -2*A1-2*A2, 1) + f_N(x, -2*A1, 1) + f_N(x, -2*A1+2*A2, 1) + ...
    f_N(x, -2*A2, 1) + f_N(x, 0, 1) + f_N(x, 2*A2, 1) + ...
    f_N(x, 2*A1-2*A2, 1) + f_N(x, 2*A1, 1) + f_N(x, 2*A1+2*A2, 1) ...
    );
f_Y_g_X1 =  @(x) ...
    1/3 * (f_N(x, -2*A2, 1) + f_N(x, 0, 1) + f_N(x, 2*A2, 1));
f_Y_g_X2 =  @(x) ...
    1/3 * (f_N(x, -2*A1, 1) + f_N(x, 0, 1) + f_N(x, 2*A1, 1));
f_Y_g_X1X2 =  @(x) f_N(x, 0, 1);

% 熵的被积表达式
fi_H_Y = @(x) max(-f_Y(x).*log2(f_Y(x)), 0);
fi_H_Y_g_X1 = @(x) max(-f_Y_g_X1(x).*log2(f_Y_g_X1(x)), 0);
fi_H_Y_g_X2 = @(x) max(-f_Y_g_X2(x).*log2(f_Y_g_X2(x)), 0);
fi_H_Y_g_X1X2 =  @(x) max(-f_Y_g_X1X2(x).*log2(f_Y_g_X1X2(x)), 0);

% 熵
H_Y = integral(fi_H_Y, -inf, inf, 'ArrayValued', true);
H_Y_g_X1 = integral(fi_H_Y_g_X1, -inf, inf, 'ArrayValued', true);
H_Y_g_X2 = integral(fi_H_Y_g_X2, -inf, inf, 'ArrayValued', true);
H_Y_g_X1X2 = integral(fi_H_Y_g_X1X2, -inf, inf, 'ArrayValued', true);

% 平均互信息
I_X1_Y = H_Y-H_Y_g_X1;
I_X2_Y = H_Y-H_Y_g_X2;
I_X1X2_Y = H_Y-H_Y_g_X1X2;

%% Plot results
figure;
for k = 1:4
    ax = subplot(2, 2, k);
    hold on;
    plot(P(:, k), I_X1_Y(:, k), 'r');
    plot(P(:, k), I_X2_Y(:, k), '--g');
    plot(P(:, k), I_X1X2_Y(:, k), '-.k');
    legend('I(X_1;Y)', 'I(X_2;Y)', 'I(X_1X_2;Y)', ...
        'Location', 'northwest');
    ax.XScale = 'log';
    title(['P_1/P_2 = ', num2str(ratio(k))]);
    xlabel('(P_1+P_2)/\sigma ^2');
    xlim([1e-3, 1e4]);
end
