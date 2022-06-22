function fig_cm_deflection(ax,content)
            plot(ax,content.x,content.y);
            %left_lim = ylim(ax);
            %right_lim = pixel_to_angle(left_lim,app.setup.pixel_size,app.setup.L_to_screen);
            %yyaxis(ax,'right');
            %ylim(ax,right_lim*1e3);
            %ylabel(ax,'Angle (mrad)');
            %yyaxis(ax,'left');
end