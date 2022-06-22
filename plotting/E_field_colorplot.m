function [x,y,Ex_2D,Ey_2D,Bz_2D] = E_field_colorplot(THz,setup,t,injection_time)
    x_group = THz.v_x*t;
    x_lim_left = x_group - 2.5e-4;
    x_lim_right = x_group + 2.5e-4;
    x = [x_lim_left:5e-6:x_lim_right];
    y = [0:5e-6:3e-4];
    lnx = length(x);
    lny = length(y);
    Ex_2D = zeros(lnx,lny);
    Ey_2D = zeros(lnx,lny);
    Bz_2D = zeros(lnx,lny);
    THz.t0 = injection_time;
    for i=1:lnx
        for j=1:lny
            if x(i)<setup.L_prism && x(i)>0
                [Ex_2D(i,j), Bz_2D(i,j), Ey_2D(i,j)] = THz_field(x(i),y(j),t,THz,setup);
            end
        end
    end
end