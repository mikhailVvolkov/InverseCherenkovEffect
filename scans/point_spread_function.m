function [image] = point_spread_function(position,sigma,pixels)
    image = exp(-((pixels-position)./sigma).^2);
end