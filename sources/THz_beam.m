function Beam = THz_beam(x,THz)
    Beam = exp(-((x-THz.x)/(THz.w0/cos(THz.theta))).^2); % where w0 is Hwe-1M
end