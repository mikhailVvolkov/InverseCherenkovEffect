function d = electron_beam(diameter,N,shape)
switch shape
    case 'Gauss'
        d = normrnd(0,diameter,1,N);
    case 'SuperGauss'
        d = diameter*(rand(1,N)-0.5);
end
end