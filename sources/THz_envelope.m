function Envelope = THz_envelope(x,t,THz)
    switch THz.shape
        case 'cos2'
        h_right = (1-heaviside((t-THz.t0-x/THz.v_x)/THz.tau-pi/2));
        h_left = (heaviside((t-THz.t0-x/THz.v_x)/THz.tau+pi/2));          
        Envelope = (cos((t-THz.t0-x/THz.v_x)/THz.tau).^2).*h_right.*h_left;
        case 'Gauss'
            Envelope = exp(-((t-THz.t0-x/THz.v_x)/THz.tau).^2); % where tau is HWe-1M
        case 'CW'
            Envelope = ones(1,length(t));
    end   
end