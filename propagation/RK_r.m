function kr = RK_r(p,dp,sim)
   k_r = p_to_v(p+dp,sim.g)*sim.dt;
end