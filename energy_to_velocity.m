function v = energy_to_velocity(E)
    E0 = cn.m0*(cn.c^2);
    v = cn.c.*sqrt(1 - (E0./(E+E0)).^2);
end