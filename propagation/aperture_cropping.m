function [x,y,vx,vy,py,cropped] = aperture_cropping(x,y,vx,vy,py,i,setup)
        cropped = false;
        y_crop = (y(i+1)< setup.aperture.y1 || y(i+1)> setup.aperture.y2);
        x_condition = x(i+1)>setup.aperture.x && x(i+1)<(setup.aperture.x + setup.aperture.thickness);
        if  x_condition && y_crop && setup.aperture.crop
            y(i+1:end)=NaN;
            x(i+1:end)=NaN;
            vx(i+1:end)=NaN;
            vy(i+1:end)=NaN;
            cropped = true;
        end
end