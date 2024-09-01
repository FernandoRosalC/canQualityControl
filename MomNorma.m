%% Momentos normalizados
function npq = MomNorma(p,q,u00,upq)
    d = (p+q)/2+1;
    npq = upq/(u00^d);
end