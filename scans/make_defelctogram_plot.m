function [pixels,beam] = make_defelctogram_plot(theta,shifts,setup)
    [ln1,ln2] = size(theta);
    %screen.max = angle_to_pixel(max(theta,[],'all'),setup.pixel_size,setup.L_to_screen);
    %screen.min = angle_to_pixel(min(theta,[],'all'),setup.pixel_size,setup.L_to_screen);
    screen.range = angle_to_pixel(max(abs(theta),[],'all'),setup.pixel_size,setup.L_to_screen);
    pixels = [-1.1*screen.range:1.1*screen.range];
    beam_d = zeros(ln1,length(pixels));
    beam = zeros(length(pixels),ln2);
    for i=1:ln2
        for j=1:ln1
                position = angle_to_pixel(theta(j,i),setup.pixel_size,setup.L_to_screen) + shifts(j,i)/setup.pixel_size;
                cropped_by_prism = isnan(position);
                if cropped_by_prism
                    position = 0;
                end
                beam_d(j,:) = (~cropped_by_prism)*point_spread_function(position,setup.point_spread,pixels);   
        end
        beam(:,i) = sum(beam_d,1);
    end  
end