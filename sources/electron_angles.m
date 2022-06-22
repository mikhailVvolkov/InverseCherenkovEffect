function angle = electron_angles(sigma,N,d,f)
            angle = -atan(d./f) + normrnd(0,sigma,1,N);
end