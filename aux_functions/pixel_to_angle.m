function angle = pixel_to_angle(pixel,pixel_size,L)
    angle = atan(pixel.*pixel_size./L);
end