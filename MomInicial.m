%% Momentos iniciales
function mpq = MomInicial(p,q,f)
    [filas,columnas] = size(f);
    for j=1:filas
        for i=1:columnas
            M(j,i)=(i-1)^p*(j-1)^q.*f(j,i);
        end
    end
    mpq = sum(sum(M));
end