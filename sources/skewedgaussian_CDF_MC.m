function t = skewedgaussian_CDF_MC(sigma,alpha,N)
    x = [-3:0.001:3]*sigma; % fs
    dist = skewedgaussian(x,1,0,sigma,alpha);
    %figure;plot(dist)
    CDF = cumtrapz(x,dist)./max(cumtrapz(x,dist));
    t = zeros(1,N);
    for i=1:N
        [~,indx] = min(abs(CDF - rand(1,1)));
        t(i) = x(indx);
    end
%     figure;plot(x,dist);
%     yyaxis right;
%     histogram(t,round(N/10));
end