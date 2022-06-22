function x_out = next_coordinate(x,vx,dt,i,algorithm)
        switch algorithm
            case 'Euler'
                x(i+1) = x(i) + vx(i)*dt;
            case 'Midpoint'
                x(i+1) = x(i) + 0.5*(vx(i) + vx(i+1))*dt;
            case 'Forward'
                x(i+1) = x(i) + vx(i+1)*dt;
        end
        x_out = x(i+1);
end