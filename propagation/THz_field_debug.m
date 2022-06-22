function [Ex, Bz, Ey] = THz_field_debug(x,y,t,THz,setup)
    switch THz.shape
        case 'cos2'
        h_right = (1-heaviside((t-THz.t0-x/THz.v_x)/THz.tau-pi/2));
        h_left = (heaviside((t-THz.t0-x/THz.v_x)/THz.tau+pi/2));          
        Envelope = (cos((t-THz.t0-x/THz.v_x)/THz.tau).^2).*h_right.*h_left;
        case 'Gauss'
            Envelope = exp(-((t-THz.t0-x/THz.v_x)/THz.tau).^2);
        case 'CW'
            Envelope = ones(1,length(t));
    end
            sqrt_term = sqrt((setup.n*sin(THz.theta)).^2 - 1);
            a = 2*setup.n*cos(THz.theta)/(cos(THz.theta) - 1i*setup.n*sqrt_term);
            k_evan = k_evanescent(setup.n,THz.theta,THz.w_rad);
            Evanescent = heaviside(y).*exp(-y*k_evan);
            Oscillation = exp(-1i*(THz.w_rad*(t-THz.t0-x/THz.v_x)+THz.phi));
            Beam = exp(-((x-THz.x)/(THz.w0/cos(THz.theta))).^2);
            re_part_y = real(a*setup.n*sin(THz.theta)*Evanescent*Oscillation);
            re_part_x = real(a*(-1i*sqrt_term)*Evanescent*Oscillation);
            Ey = THz.E0*Beam*Envelope*re_part_y;
            Bz = - Ey./(setup.n*sin(THz.theta))/cn.c;
            Ex = THz.E0*Beam*Envelope*re_part_x;
            
            
       if setup.mirror
           y = 2*setup.d-y;
               switch THz.shape
                    case 'cos2'
                    h_right = (1-heaviside((t-THz.t0-x/THz.v_x)/THz.tau-pi/2));
                    h_left = (heaviside((t-THz.t0-x/THz.v_x)/THz.tau+pi/2));          
                    Envelope = (cos((t-THz.t0-x/THz.v_x)/THz.tau).^2).*h_right.*h_left;
                    case 'Gauss'
                        Envelope = exp(-((t-THz.t0-x/THz.v_x)/THz.tau).^2);
                    case 'CW'
                        Envelope = ones(1,length(t));
               end
                sqrt_term = sqrt((setup.n*sin(THz.theta)).^2 - 1);
                a = 2*setup.n*cos(THz.theta)/(cos(THz.theta) - 1i*setup.n*sqrt_term);
                k_evan = k_evanescent(setup.n,THz.theta,THz.w_rad);
                Evanescent = heaviside(y).*exp(-y*k_evan);
                Oscillation = exp(-1i*(THz.w_rad*(t-THz.t0-x/THz.v_x)+THz.phi));
                Beam = exp(-((x-THz.x)/(THz.w0/cos(THz.theta))).^2);
                re_part_y = real(a*setup.n*sin(THz.theta)*Evanescent*Oscillation);
                re_part_x = real(a*(-1i*sqrt_term)*Evanescent*Oscillation);
                Ey_mirror = THz.E0*Beam*Envelope*re_part_y;
                Bz_mirror = - Ey./(setup.n*sin(THz.theta))/cn.c;
                Ex_mirror = THz.E0*Beam*Envelope*re_part_x;
            
                Ex = Ex+Ex_mirror;
                Ey = Ey - Ey_mirror;
                Bz = Bz + Bz_mirror;
       end
       
       if setup.second_prism
           version = 'exact';
           %version = 'superposition';
           %switch version
               %case 'superposition'
                   y = setup.d-y;
                   switch THz.shape
                        case 'cos2'
                        h_right = (1-heaviside((t-THz.t0-x/THz.v_x)/THz.tau-pi/2));
                        h_left = (heaviside((t-THz.t0-x/THz.v_x)/THz.tau+pi/2));          
                        Envelope = (cos((t-THz.t0-x/THz.v_x)/THz.tau).^2).*h_right.*h_left;
                        case 'Gauss'
                            Envelope = exp(-((t-THz.t0-x/THz.v_x)/THz.tau).^2);
                        case 'CW'
                            Envelope = ones(1,length(t));
                   end
                    sqrt_term = sqrt((setup.n*sin(THz.theta)).^2 - 1);
                    a = 2*setup.n*cos(THz.theta)/(cos(THz.theta) - 1i*setup.n*sqrt_term);
                    k_evan = k_evanescent(setup.n,THz.theta,THz.w_rad);
                    Evanescent = heaviside(y).*exp(-y*k_evan);
                    Oscillation = exp(-1i*(THz.w_rad*(t-THz.t0-x/THz.v_x)+THz.phi));
                    Beam = exp(-((x-THz.x)/(THz.w0/cos(THz.theta))).^2);
                    re_part_y = real(a*setup.n*sin(THz.theta)*Evanescent*Oscillation);
                    re_part_x = real(a*(-1i*sqrt_term)*Evanescent*Oscillation);
                    Ey_mirror = THz.E0*Beam*Envelope*re_part_y;
                    Bz_mirror = - Ey./(setup.n*sin(THz.theta))/cn.c;
                    Ex_mirror = THz.E0*Beam*Envelope*re_part_x;
                    
                    Ex = Ex + Ex_mirror;
                    Ey = Ey - Ey_mirror;
                    Bz = Bz - Bz_mirror;
               %case 'exact'
                   Envelope = exp(-((t-THz.t0-x/THz.v_x)/THz.tau).^2);
                   kappa = THz.w_rad/cn.c*sqrt((setup.n*sin(THz.theta)).^2 - 1);
                   k1 = THz.w_rad/cn.c*setup.n*cos(THz.theta);
                   s_p = 1 + 1i*kappa*setup.n^2/k1;
                   s_m = 1 - 1i*kappa*setup.n^2/k1;
                   A = THz.E0*Envelope*exp(-((x-THz.x)/(THz.w0/cos(THz.theta))).^2);
                   A1 = 2*A*s_m./(s_m.^2  - s_p.^2.*exp(-2*kappa*setup.d));
                   A2 = 2*A*s_p./(s_p.^2  - s_m.^2.*exp(+2*kappa*setup.d));
                   Bz_m = 1/cn.c*(A1.*exp(-kappa*y) + A2.*exp(+kappa*y));
                   Ex_m = -setup.n.*kappa*cn.c/THz.w_rad*1i*(A1.*exp(-kappa*y) - A2.*exp(+kappa*y));
                   Ey_m = -setup.n.^2*sin(THz.theta)*(A1.*exp(-kappa*y) + A2.*exp(+kappa*y));
                   plane_wave_phase = exp(1i*THz.w_rad*t - 1i*THz.w_rad/cn.c*setup.n*sin(THz.theta)*x + 1i*THz.phi);
                   Ex_m = real(Ex_m*plane_wave_phase);
                   Ey_m = real(Ey_m*plane_wave_phase);
                   Bz_m = real(Bz_m*plane_wave_phase);

                   y = setup.d-y;
                   Envelope = exp(-((t-THz.t0-x/THz.v_x)/THz.tau).^2);
                   kappa = THz.w_rad/cn.c*sqrt((setup.n*sin(THz.theta)).^2 - 1);
                   k1 = THz.w_rad/cn.c*setup.n*cos(THz.theta);
                   s_p = 1 + 1i*kappa*setup.n^2/k1;
                   s_m = 1 - 1i*kappa*setup.n^2/k1;
                   A = THz.E0*Envelope*exp(-((x-THz.x)/(THz.w0/cos(THz.theta))).^2);
                   A1 = 2*A*s_m./(s_m.^2  - s_p.^2.*exp(-2*kappa*setup.d));
                   A2 = 2*A*s_p./(s_p.^2  - s_m.^2.*exp(+2*kappa*setup.d));
                   Bz_mirror_m  = 1/cn.c*(A1.*exp(-kappa*y) + A2.*exp(+kappa*y));
                   Ex_mirror_m  = -setup.n*kappa*cn.c/THz.w_rad*1i*(A1.*exp(-kappa*y) - A2.*exp(+kappa*y));
                   Ey_mirror_m  = -setup.n.^2*sin(THz.theta)*(A1.*exp(-kappa*y) + A2.*exp(+kappa*y));
                   plane_wave_phase = exp(1i*THz.w_rad*t - 1i*THz.w_rad/cn.c*setup.n*sin(THz.theta)*x + 1i*THz.phi);
                   Ex_mirror_m  = real(Ex_mirror_m *plane_wave_phase);
                   Ey_mirror_m  = real(Ey_mirror_m *plane_wave_phase);
                   Bz_mirror_m  = real(Bz_mirror_m *plane_wave_phase);
                   
                   Ex_m  = Ex_m  + Ex_mirror_m ;
                   Ey_m  = Ey_m  - Ey_mirror_m ;
                   Bz_m  = Bz_m  - Bz_mirror_m ;
           %end
       end
       if(sum(abs(Ex - Ex_m) + abs(Ey - Ey_m) + abs(Bz - Bz_m))>1e-1)
           disp(1);
       end
end