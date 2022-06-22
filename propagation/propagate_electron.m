function [x,y,vx,vy] = propagate_electron(THz,el,sim,setup)

    [x,y,vx,vy,px,py] = init_phase_space(sim.N_steps);
    [x(1),y(1),vx(1),vy(1),px(1),py(1)] = el_input(el.v,el.vy,sim.g,el.y0,el.x0);

    for i = 1:(sim.N_steps-1)
        is_on_prism = (x(i)<setup.L_prism);
        switch sim.algorithm
            case 'RK4'
                [x(i+1),y(i+1),vx(i+1),vy(i+1)]= RK4(x(i),y(i),vx(i),vy(i),px(i),py(i),sim.dt,i-1,THz,setup,sim.B,sim.g,is_on_prism);
                px(i+1) = v_to_p(vx(i+1),vy(i+1),sim.g);
                py(i+1) = v_to_p(vy(i+1),vx(i+1),sim.g);
            otherwise     
                [Ex, Bz, Ey] = THz_field(x(i),y(i),(i-1)*sim.dt,THz,setup);
                % Kozak uses left-handed system. here we use plus.
                % The physical reality is that electron is pulled against the
                % poynting Vector
                px(i+1) = px(i) + sim.dt*is_on_prism*F_Lorentz(Ex,sim.B*Bz,vy(i));
                vx(i+1) = p_to_v(px(i+1),py(i+1),sim.g);
                x(i+1) = next_coordinate(x,vx,sim.dt,i,sim.algorithm);

                py(i+1) = py(i) + sim.dt*is_on_prism*F_Lorentz(Ey,sim.B*Bz,vx(i)); % should push electron to the prism, note B is negative
                vy(i+1) = p_to_v(py(i+1),px(i+1),sim.g); 
                y(i+1) = next_coordinate(y,vy,sim.dt,i,sim.algorithm);
        
        end  
        [x,y,vx,vy,py,cropped_on_prism] = prism_cropping(x,y,vx,vy,py,i,setup);
        [x,y,vx,vy,py,cropped_on_aperture] = aperture_cropping(x,y,vx,vy,py,i,setup);
        if cropped_on_prism || cropped_on_aperture
            break
        end
    end
end