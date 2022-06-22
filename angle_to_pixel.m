function pixel = angle_to_pixel(angle,pixel_size,L)
    pixel = tan(angle).*L./pixel_size;
end