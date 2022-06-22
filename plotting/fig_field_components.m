function fig_field_components(uiaxes,content)
    plot(uiaxes,content.x,content.Ex,'k','LineStyle','-');
    hold(uiaxes,'On');
    plot(uiaxes,content.x,content.Ey,'k','LineStyle','--');
    hold(uiaxes,'Off');
    yyaxis(uiaxes,'right');
    plot(uiaxes,content.x,content.Bz,'k','LineStyle','-');
    yyaxis(uiaxes,'left');
end