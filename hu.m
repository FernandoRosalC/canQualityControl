%% Momentos de hu
function [phi1 phi2 phi3 phi4 phi5 phi6 phi7] = hu(f)
    m00 = MomInicial(0,0,f);
    m10 = MomInicial(1,0,f);
    m01 = MomInicial(0,1,f);
    
    xc = m10/m00;
    yc = m01/m00;
    
    u00 = MomCentral(0,0,f,xc,yc);
    u20 = MomCentral(2,0,f,xc,yc);
    u02 = MomCentral(0,2,f,xc,yc);
    u11 = MomCentral(1,1,f,xc,yc);
    u30 = MomCentral(3,0,f,xc,yc);
    u03 = MomCentral(0,3,f,xc,yc);
    u12 = MomCentral(1,2,f,xc,yc);
    u21 = MomCentral(2,1,f,xc,yc);
    
    n20 = MomNorma(2,0,u00,u20);
    n02 = MomNorma(0,2,u00,u02);
    n11 = MomNorma(1,1,u00,u11);
    n30 = MomNorma(3,0,u00,u30);
    n03 = MomNorma(0,3,u00,u03);
    n12 = MomNorma(1,2,u00,u12);
    n21 = MomNorma(2,1,u00,u21);
    
    %Momentos invariantes de Hu
    phi1 = n20+n02;
%     phi1 = abs(log(abs(phi1)));

    phi2 = (n20-n02)^2+4*(n11)^2;
%     phi2 = abs(log(abs(phi2)));

    phi3 = (n30-3*n12)^2+(3*n21-n03)^2;
%     phi3 = abs(log(abs(phi3)));

    phi4 = (n30+n12)^2+(n21+n03)^2;
%     phi4 = abs(log(abs(phi4)));

    phi5 = (n30-3*n12)*(n30+n12)*((n30+n12)^2-3*(n21+n03)^2)+(3*n21-n03)*(n21+n03)*(3*(n30+n12)^2-(n21+n03)^2);
%     phi5 = abs(log(abs(phi5)));

    phi6 = (n20-n02)*((n30+n12)^2-(n21+n03)^2)+4*n11*(n30+n12)*(n21+n03);
%     phi6 = abs(log(abs(phi6)));

    phi7 = (3*n21-n03)*(n30+n12)*((n30+n12)^2-3*(n21+n03)^2)+(3*n12-n03)*(n21+n03)*(3*(n30+n12)^2-(n21+n03)^2);
%     phi7 = abs(log(abs(phi7)));
end