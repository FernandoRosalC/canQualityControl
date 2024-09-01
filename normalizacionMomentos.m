%% Normalización de momentos
function [c1 c2 c3 c4 c5 c6 c7] = normalizacionMomentos(phi1, phi2, phi3, phi4, phi5, phi6, phi7)
    c1 = 1;
    c2 = phi2/(phi1^2);
    c3 = phi3/(phi1^3);
    c4 = phi4/(phi1^3);
    c5 = phi5/(phi1^6);
    c6 = phi6/(phi1^4);
    c7 = phi7/(phi1^6);
end