function gamma = shape_factor_to_skewness(alpha)
    delta = alpha/(sqrt(1+alpha^2));
    gamma = (4-pi)/2*(delta*sqrt(2/pi))^3/((1-2*delta^2/pi)^3/2); 
end