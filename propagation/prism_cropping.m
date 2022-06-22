function [x,y,vx,vy,py,cropped] = prism_cropping(x,y,vx,vy,py,i,setup)
        cropped = false;
        if (y(i+1)<0 || (y(i+1)>setup.d) && setup.second_prism) && setup.crop && (x(i+1)<setup.L_prism) && ~setup.reflect
            y(i+1:end)=NaN;
            x(i+1:end)=NaN;
            vx(i+1:end)=NaN;
            vy(i+1:end)=NaN;
            cropped = true;
        elseif y(i+1)<0 && setup.reflect && (x(i+1)<setup.L_prism) && ~setup.crop
            vy(i+1)=-vy(i+1);
            py(i+1)=-py(i+1);
        end
        
end