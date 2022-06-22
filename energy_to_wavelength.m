function lambda = energy_to_wavelength(E)
    lambda = 2*pi*cn.h_bar./sqrt(2*cn.m0.*E.*(1 + E./2/cn.mc2));
end