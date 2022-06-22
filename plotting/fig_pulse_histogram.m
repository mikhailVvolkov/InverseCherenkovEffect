function fig_pulse_histogram(uiaxes,content)
    if content.bins <1
        content.bins = 1;
        disp('Warning: number of bins invalid');
    end
    histogram(uiaxes,content.x,content.bins);
    xlim(uiaxes,[-content.xlim content.xlim]); 
    legend_text = [num2str(content.slice) ' mm'];
    legend(uiaxes,legend_text);
end