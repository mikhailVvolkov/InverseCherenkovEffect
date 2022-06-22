function drawn_array = skewedgaussian_draw(skewedgaussian_lookup,N)   
    random_index = round(rand(1,N)*length(skewedgaussian_lookup));
    random_index(random_index==0)=1;
    drawn_array = skewedgaussian_lookup(random_index);
end