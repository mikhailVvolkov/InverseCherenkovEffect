function F = energy_to_field(E,tau,w0)
    P = E/sqrt(pi/2)/tau; % where tau is HWe-1M in field
    I =  2*P/(pi*w0.^2); % where w0 is HWe-2M in intensity, that is HWe-1M in field.
    F = sqrt(2*I/cn.c/cn.epsilon_0); 
end