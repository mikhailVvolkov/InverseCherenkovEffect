function fig_beam(uiaxes,content)
    hold(uiaxes,'On');
    scatter(uiaxes,content.x,content.y,"cyan","filled",'MarkerFaceAlpha',content.alpha);
    hold(uiaxes,'Off');           
    xlim(uiaxes,content.xlim);
    ylim(uiaxes,[0 1e-1]);    
end