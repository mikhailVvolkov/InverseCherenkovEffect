function k = k_evanescent(n,theta,w)
    sqrt_term = sqrt((n*sin(theta)).^2 - 1);
    k = w/cn.c*sqrt_term;
end