function fig_spectrum(uiaxes,content)
    if content.bins <1
        content.bins = 1;
        disp('Warning: number of bins invalid');
    end
    histogram(uiaxes,content.x,content.bins);
end