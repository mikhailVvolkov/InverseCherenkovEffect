function g_skewed = skewedgaussian(x,amp,mu,sigma,alpha)
    gaussian = amp*(1/sqrt((2*pi)/sigma)*exp(-((x-mu)).^2/2/sigma.^2));
    g_skewed = gaussian.*normcdf(alpha*x,mu*alpha,sigma);
end