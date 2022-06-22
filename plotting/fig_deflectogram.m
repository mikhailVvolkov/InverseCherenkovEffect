function fig_deflectogram(uiaxes,content,cm,lims)
    pcolor(uiaxes,content.x,content.y,content.data);
    shading(uiaxes,"flat");
    colormap(uiaxes,cm);
    cb = colorbar(uiaxes);
    caxis(uiaxes,[0 30]);
    xlim(uiaxes,lims);
    ylim(uiaxes,[-800 1200]);
    shading(uiaxes,"flat");
    set(uiaxes,'Box','on');
    set(uiaxes,'layer','top');  
end