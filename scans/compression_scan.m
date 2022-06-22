function [t0,traj_x,traj_y,theta_final,vx_array,v_mod,theta] = compression_scan(THz,el,sim,setup)
    theta_final = zeros(1,sim.N_tr);
    v_mod = zeros(1,sim.N_tr);
    theta = zeros(sim.N_tr,sim.N_steps);
    traj_x = zeros(sim.N_tr,sim.N_steps);
    traj_y = zeros(sim.N_tr,sim.N_steps);
    vx_array = zeros(sim.N_tr,sim.N_steps);
    vy_array = zeros(sim.N_tr,sim.N_steps);
    offset = el.y0;
    %skewedgaussian_lookup = skewedgaussian_generate(el.tau*1e15,el.skewness);
    t0 = electron_pulse(el.tau,el.shape,el.skewness,el.bg_amp,el.bg_tau,el.bg_skewness,sim.N_tr);
    d = electron_beam(el.w0,sim.N_tr,el.beam_shape);
    el_sigma = electron_angles(el.sigma,sim.N_tr,d,el.f);
    v_arrray = electron_velocities(el,t0,sim.N_tr); 
    f = waitbar(0,'1','Name','compression scan');
    for i=1:sim.N_tr 
            waitbar(i/sim.N_tr,f,['Trajectory N = ',num2str(i)]);
            el.y0 = offset + d(i); % [m]
            THz.t0 = sim.t_offset; % [s]
            el.x0 = t0(i)*el.v;
            el.v = v_arrray(i);
            el.vy = tan(el_sigma(i))*el.v;
            [traj_x(i,:),traj_y(i,:),vx_array(i,:),vy_array(i,:)] = propagate_electron(THz,el,sim,setup);
            theta_final(i) = atan(vy_array(i,end)./vx_array(i,end));
            theta(i,:) = atan(vy_array(i,:)./vx_array(i,:)) ;
            v_mod(i) = sqrt(vy_array(i,end).^2 + vx_array(i,end).^2);
    end
    delete(f);
end