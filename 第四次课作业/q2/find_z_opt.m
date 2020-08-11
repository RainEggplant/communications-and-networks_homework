function [z, H_Z] = find_z_opt(n_z, y, f_numer, f_Y)
% 求最佳重建电平和 H(Z)
    z = zeros(1, n_z);
    H_Z = 0;

    for k = 1:n_z  
        numer = integral(f_numer, y(k), y(k+1), 'ArrayValued', true);
        denom = integral(f_Y, y(k), y(k+1), 'ArrayValued', true);
        numer = sum(numer);
        denom = sum(denom);
        z(k) = numer/denom;
        H_Z = H_Z+max(-denom*log2(denom), 0);
    end
end
