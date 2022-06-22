function fig_prism(uiaxes,content)
    hold(uiaxes,'On');
    fill(uiaxes,content.x,content.y,[1 0.6275 0.3804]);
    if content.second_prism
        content.y = (content.y + content.d).*[1 1 -1];
        fill(uiaxes,content.x,content.y,[1 0.6275 0.3804]);
    end
    hold(uiaxes,'Off');
    ylim(uiaxes,[-50 300]);
end