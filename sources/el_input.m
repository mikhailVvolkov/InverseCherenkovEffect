function [x1,y1,vx1,vy1,px1,py1] = el_input(v,vy,g,y0,x0)
    v_to_p = @(v) cn.m0*v./sqrt(1 - (v/(g*cn.c))^2);
    x1 = x0; % [m]
    y1 = y0; % [m] beam offset from the prism edge
    vx1 = v; % [m/s]
    px1 = v_to_p(vx1);
    vy1 = vy; % [c]
    py1 = v_to_p(vy1);
end