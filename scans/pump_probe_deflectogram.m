function [delay,theta,shifts] = pump_probe_deflectogram(THz,el,sim,setup)                                                     
    theta = zeros(sim.N_tr,sim.N_delay);
    shifts = zeros(sim.N_tr,sim.N_delay);
    offset = el.y0;
    %skewedgaussian_lookup = skewedgaussian_generate(eltau*1e15,el.skewness);
    f = waitbar(0,'1','Name','Calculating a pump-probe scan');
    for i=1:sim.N_delay
        waitbar(i/sim.N_delay,f,['T = ',num2str(i*sim.dT*1e12),' ps']);
        t0 = electron_pulse(el.tau,el.shape,el.skewness,el.bg_amp,el.bg_tau,el.bg_skewness,sim.N_tr);
        d = electron_beam(el.w0,sim.N_tr,el.beam_shape);
        for j=1:sim.N_tr
            delay(i) = sim.dT*(i-sim.N_delay/2);
            el.y0 = offset + d(j); % [m]
            el.x0 = 0;
            el.vy = 0;
            THz.t0 = delay(i) + t0(j); % [s]
            [~,y,vx,vy] = propagate_electron(THz,el,sim,setup);
            theta(j,i) = atan(vy(end)./vx(end));
            shifts(j,i) = y(end);
        end
    end
    delete(f);  
end