function y = calc_y(n_z, a)
% 求分层电平
    y = zeros(1, n_z+1);
    
    for k = 1:n_z
        if k == 1
            y(k) = -inf;
            y(k+1) = (-n_z/2+1)*a;
        elseif k == n_z
            y(k) = (n_z/2-1)*a;
            y(k+1) = inf;
        else
            y(k) = (k-1-n_z/2)*a;
            y(k+1) = y(k)+a;
        end
    end
end
