function array = skewedgaussian_generate(sigma,alpha)
    x = [-3:0.001:3]*sigma; % fs
    dist = skewedgaussian(x,1,0,sigma,alpha);
    CDF = cumtrapz(x,dist)./max(cumtrapz(x,dist));
    N = 1000;
    for i=1:N
        [vl,indx] = min(abs(CDF - rand(1,1)));
        t0(i) = indx;
    end
    figure;histogram(x(t0));
    array = [];
    for i=1:length(x)
        %array = [array, x(i)*ones(1,round(dist(i)))];
        array = [array, x(i)*ones(1,dist(i))];  
    end
    figure;histogram(array,length(x));
    figure;plot(array);
end

