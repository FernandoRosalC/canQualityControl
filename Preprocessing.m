function [sign2] = Preprocessing(signD,signC)
    m1 = max(signD);
    m2 = max(signC);
    
    %Reajustamos el tamaño máximo de la firma a comparar con respecto a la
    %firma dibujada
    sign2 = signC*(m1/m2);
    
    x1 = size(signD,2);
    x2 = size(signC,2);
    
    %Reajustamos el número de muestras de acuerdo a la firma dibujada
    [P1,Q1] = rat(x1/x2);
    sign2 = resample(sign2,P1,Q1);
end