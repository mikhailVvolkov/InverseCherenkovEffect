function [t0,theta,vx_final,vy_final,traj_x,traj_y] = pump_probe_scan(THz,el,sim,setup)
    theta = zeros(1,sim.N_delay);
    vx_final = zeros(1,sim.N_delay);
    vy_final = zeros(1,sim.N_delay);
    traj_x = zeros(sim.N_delay,sim.N_steps);
    traj_y = zeros(sim.N_delay,sim.N_steps);
    t0=zeros(1,sim.N_delay);
    y_max=zeros(1,sim.N_delay);
    f = waitbar(0,'1','Name','pump-probe scan');
    for i=1:sim.N_delay
        waitbar(i/sim.N_delay,f,['T = ',num2str(i*sim.dT*1e12,'%.1f'),' ps']);
        THz.t0 = 0;
        t0(i) = sim.dT*(i-sim.N_delay/2);
        el.x0 = t0(i)*el.v; 
        el.vy = 0;
        [traj_x(i,:),traj_y(i,:),vx,vy] = propagate_electron(THz,el,sim,setup);
        theta(i) = atan(vy(end)./vx(end));
        vx_final(i) = vx(end);
        vy_final(i) = vy(end);
        y_max(i) = max(traj_y(i,:));
    end
    disp(sim.dt);
    delete(f);
end