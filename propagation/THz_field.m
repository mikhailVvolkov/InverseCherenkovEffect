function [Ex, Bz, Ey] = THz_field(x,y,t,THz,setup)

   Envelope = THz_envelope(x,t,THz);
   Beam = THz_beam(x,THz);
   sqrt_term = sqrt((setup.n*sin(THz.theta)).^2 - 1);
   kappa = k_evanescent(setup.n,THz.theta,THz.w_rad); % = k_evanescent  
   Oscillation = exp(-1i*(THz.w_rad*(t-THz.t0-x/THz.v_x)+THz.phi));
   Evanescent = @(y) heaviside(y).*exp(-y*kappa);

    if setup.second_prism 
           Oscillation = conj(Oscillation);
           k1 = THz.w_rad/cn.c*setup.n*cos(THz.theta);
           s_p = 1 + 1i*kappa*setup.n^2/k1;
           s_m = 1 - 1i*kappa*setup.n^2/k1;
           A1 = 2*s_m./(s_m.^2  - s_p.^2.*Evanescent(2*setup.d));
           A2 = 2*s_p./(s_p.^2  - s_m.^2.*Evanescent(-2*setup.d));
           re_part_x_1 = real(-Oscillation*setup.n.*sqrt_term*1i*(A1.*Evanescent(y) - A2.*Evanescent(-y)));
           re_part_y_1 = real(-Oscillation*setup.n.^2*sin(THz.theta)*(A1.*Evanescent(y) + A2.*Evanescent(-y)));
           
           y = setup.d - y;
           re_part_x_2 = real(-Oscillation*setup.n.*sqrt_term*1i*(A1.*Evanescent(y) - A2.*Evanescent(-y)));
           re_part_y_2 = real(-Oscillation*setup.n.^2*sin(THz.theta)*(A1.*Evanescent(y) + A2.*Evanescent(-y)));

           re_part_x = re_part_x_1 + re_part_x_2;
           re_part_y = re_part_y_1 - re_part_y_2;
    else
            a = 2*setup.n*cos(THz.theta)/(cos(THz.theta) - 1i*setup.n*sqrt_term);
            re_part_y = real(a*setup.n*sin(THz.theta)*Evanescent(y)*Oscillation);
            re_part_x = real(a*(-1i*sqrt_term)*Evanescent(y)*Oscillation);
    end
    
    Ey = THz.E0*Beam*Envelope*re_part_y; % w0 is field-HWe-1M and intensity-HWe-2M; tau is field-HWe-1M and intesnty-HWe-2M
    Bz = - Ey./(setup.n*sin(THz.theta))/cn.c;
    Ex = THz.E0*Beam*Envelope*re_part_x;
end