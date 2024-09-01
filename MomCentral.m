%% Momentos centrales
function upq = MomCentral(p,q,f,xc,yc)
    [filas,columnas] = size(f);
    for j=1:filas
        for i=1:columnas
            M(j,i)=(i-1-xc)^p*(j-1-yc)^q.*f(j,i);
        end
    end
    upq = sum(sum(M));
end