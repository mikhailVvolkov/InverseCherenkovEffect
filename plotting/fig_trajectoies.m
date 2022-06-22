function fig_trajectoies(uiaxes,content)
    color = 'm';
    %color = [0.5 0 1];
    color = [0.62 0 1];
    plot(uiaxes,content.x,content.y,'color',color,'LineStyle','-','LineWidth',0.5);  
    ylim(uiaxes,[-50 300]);
end