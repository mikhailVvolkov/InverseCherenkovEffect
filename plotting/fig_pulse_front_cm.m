function fig_pulse_front_cm(uiaxes,content)
    scatter(uiaxes,content.x,content.y_cm,4,"blue","filled",'MarkerFaceAlpha',0.8);
    ylim(uiaxes,[-100 100]);  
    legend_text = [num2str(content.slice) ' mm'];
    legend(uiaxes,legend_text);
end