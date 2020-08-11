%% q2-1
f = [-1:0.01:1];
S = 1 * (abs(f) <= 1 / 4) + ...
    0.5 * (1 + sin(2 * pi * abs(f))) .* (1 / 4 < abs(f) & abs(f) < 3 / 4) + ...
    0 * (abs(f) >= 3 / 4);
figure;
plot(f, S);
title('·¢ËÍ¹¦ÂÊÆ×');
xlabel('Frequency (Hz)');
xticks([-1, -3/4, -1/2, -1/4, 0, 1/4, 1/2, 3/4, 1]);
xticklabels({'-1/T_s','-0.75/T_s','-0.5/T_s', '-0.25/T_s', '0', ...
    '0.25/T_s', '0.5/T_s', '0.75/T_s','1/T_s'});
yticks([0, 1/4, 1/2, 3/4, 1]);
yticklabels({'0', '0.25A^2/T_s', '0.5A^2/T_s', '0.75A^2/T_s','A^2/T_s'});

%% q2-2
g = rcosdesign(0.5, 6, 100, 'sqrt');
bit_stream = {'0000', '0011', '0101', '0110', ...
    '1001', '1010', '1100', '1111'};
figure;
for k = 1:8
    subplot(2, 4, k);
    t = [-200:700];
    y1 = (str2double(bit_stream{k}(1)) - 0.5) * 2 * [g, zeros(1, 300)];
    y2 = (str2double(bit_stream{k}(2)) - 0.5) * 2 * [zeros(1, 100), g, zeros(1, 200)];
    y3 = (str2double(bit_stream{k}(3)) - 0.5) * 2 * [zeros(1, 200), g, zeros(1, 100)];
    y4 = (str2double(bit_stream{k}(4)) - 0.5) * 2 * [zeros(1, 300), g];
    plot(t, y1 + y2 + y3 + y4);
    title(bit_stream{k});
    xlim([-200, 700]);
    xticks([-200, 0, 200, 400, 600]);
    xticklabels({'-2T_s', '0', '2T_s', '4T_s', '6T_s'});
end

