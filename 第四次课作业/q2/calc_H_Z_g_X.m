function H_Z_g_X = calc_H_Z_g_X(f_N, xc, s, n_z, M, y)
% calc_H_Z_g_X �� H(Z|X)
% f_N, xc, s: ��˹�����Ķ��壬X ��ȡֵ���ϣ�����������
% n_z, M, y: �ؽ���ƽ���������ƽ�������ֲ��ƽȡֵ
    p_Z_g_X = zeros(n_z, M);
    H_Z_g_X = 0;

    for kx = 1:M
        f_Y_g_X = @(x) f_N(x, xc(kx), s);

        for kz = 1:n_z
            p_Z_g_X(kz, kx) = integral(f_Y_g_X, y(kz), y(kz+1));
            H_Z_g_X = H_Z_g_X+ ...
                1/M*max(-p_Z_g_X(kz, kx)*log2(p_Z_g_X(kz, kx)), 0);
        end
    end
end
