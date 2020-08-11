% 赶工作业，没写注释
warning off;
n_toss = 30;
P = zeros(n_toss + 1, n_toss + 1);
N = zeros(n_toss + 1, n_toss + 1);
index = 0;

for n1 = 0:n_toss
    for n3 = 0:n_toss - n1
        n4 = n_toss - n1 - n3;
        num = nchoosek(n_toss, n1) * nchoosek(n_toss - n1, n3);
        p = 0.5^n1 * 0.25^(n3 + n4);
        P(n1 + 1, n3 + 1) = p * num;
        N(n1 + 1, n3 + 1) = num;
    end
end

sum_p = 0;
n_sig = 0;
n1_min = n_toss + 1;
while sum_p <= 0.9
    [p_max, idx] = max(P(:));
    [n1, ~] = ind2sub([n_toss + 1, n_toss + 1], idx);
    if n1 <= n1_min
       n1_min = n1; 
    end
    sum_p = sum_p + p_max;
    n_sig = n_sig + N(idx);
    P(idx) = 0;
end

n_bit = ceil(log2(n_sig));
n_bit_v = (n1_min - 1) + (n_toss - (n1_min - 1)) * 2;
