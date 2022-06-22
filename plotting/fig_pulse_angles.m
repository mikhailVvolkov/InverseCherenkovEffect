function fig_pulse_angles(uiaxes,content)
    scatter(uiaxes,content.x,content.theta,4,"blue","filled",'MarkerFaceAlpha',0.8);
    %ylim(uiaxes,[0 100]);  
    legend_text = [num2str(content.slice) ' mm'];
    legend(uiaxes,legend_text);
end
