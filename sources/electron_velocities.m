function dv = electron_velocities(el,t,N) 
    dene_rnd = normrnd(el.ene,el.dene,1,N);
    dv = energy_to_velocity(dene_rnd) + t.*el.chirp/2*1e15;
end