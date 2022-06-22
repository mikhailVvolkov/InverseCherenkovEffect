function v = p_to_v(p1,p2,g)
    p = sqrt(p1.^2 + p2.^2);
    v = sign(p1)*sqrt((p1./cn.m0).^2./(1+(p./cn.m0./(g*cn.c)).^2));
end