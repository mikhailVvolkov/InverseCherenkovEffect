function [t0] = electron_pulse(tau_electron,pulse_shape,skewness,bg_amp,bg_tau,bg_skewness,N)
    tau_fs = tau_electron*1e15;
    bg_tau_fs = bg_tau*1e15;
    switch pulse_shape
        case 'Gaussian'
            t0 = normrnd(0,tau_fs,1,N)*1e-15 + (rand(1,N)<bg_amp).*skewedgaussian_CDF_MC(bg_tau_fs,bg_skewness,N)*1e-15;
        case 'Skewed'
            t0 = skewedgaussian_CDF_MC(tau_fs,skewness,N)*1e-15;
    end
end