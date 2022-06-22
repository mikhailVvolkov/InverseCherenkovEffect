function fig_experiment(uiaxes,content)
    hold(uiaxes,'On');
    plot(uiaxes,content.x,content.y);
    hold(uiaxes,'Off');
end