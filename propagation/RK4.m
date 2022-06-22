function [x1,y1,vx1,vy1]= RK4(x,y,vx,vy,px,py,dt,i,THz,setup,B,g,is_on_prism)
                k1_x = vx*dt;
                k1_y = vy*dt;
                [Ex, Bz, Ey] = THz_field(x,y,i*dt,THz,setup);
                k1_px = is_on_prism*F_Lorentz(Ex,B*Bz,k1_y/dt)*dt;
                k1_py = is_on_prism*F_Lorentz(Ey,B*Bz,k1_x/dt)*dt;
                
                k2_x = p_to_v(px+k1_px/2,py+k1_py/2,g)*dt;
                k2_y = p_to_v(py+k1_py/2,px+k1_px/2,g)*dt;
                [Ex, Bz, Ey] = THz_field(x+k1_x/2,y+k1_y/2,i*dt+dt/2,THz,setup);
                k2_px = is_on_prism*F_Lorentz(Ex,B*Bz,k2_y/dt)*dt;
                k2_py = is_on_prism*F_Lorentz(Ey,B*Bz,k2_x/dt)*dt;
                
                k3_x = p_to_v(px+k2_px/2,py+k2_py/2,g)*dt;
                k3_y = p_to_v(py+k2_py/2,px+k2_px/2,g)*dt;
                [Ex, Bz, Ey] = THz_field(x+k2_x/2,y+k2_y/2,i*dt+dt/2,THz,setup);
                k3_px = is_on_prism*F_Lorentz(Ex,B*Bz,k3_y/dt)*dt;
                k3_py = is_on_prism*F_Lorentz(Ey,B*Bz,k3_x/dt)*dt;
                
                k4_x = p_to_v(px+k3_px,py+k3_py,g)*dt;
                k4_y = p_to_v(py+k3_py,px+k3_px,g)*dt;
                [Ex, Bz, Ey] = THz_field(x+k3_x,y+k3_y,i*dt+dt,THz,setup);
                k4_px = is_on_prism*F_Lorentz(Ex,B*Bz,k4_y/dt)*dt;
                k4_py = is_on_prism*F_Lorentz(Ey,B*Bz,k4_x/dt)*dt;
                
                vx1 = p_to_v(px + 1/6*(k1_px + 2*k2_px + 2*k3_px + k4_px),py + 1/6*(k1_py + 2*k2_py + 2*k3_py + k4_py),g);
                vy1 = p_to_v(py + 1/6*(k1_py + 2*k2_py + 2*k3_py + k4_py),px + 1/6*(k1_px + 2*k2_px + 2*k3_px + k4_px),g);
                
                x1 = x + 1/6*(k1_x + 2*k2_x + 2*k3_x + k4_x);
                y1 = y + 1/6*(k1_y + 2*k2_y + 2*k3_y + k4_y);
end