function E = velocity_to_energy(v)
    E0 = cn.m0*((cn.c)^2);
    E = E0*(sqrt(1./(1-v.^2/cn.c^2)) - 1);
end