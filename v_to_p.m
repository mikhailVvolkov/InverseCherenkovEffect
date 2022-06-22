function p = v_to_p(v1,v2,g)
    v = sqrt(v1.^2 + v2.^2);
    p = cn.m0*v1./sqrt(1 - v.^2./(g*cn.c).^2);
end