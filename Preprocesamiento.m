clc;
clear all
close all
load Firmas.mat;

f2 = Preprocessing(f1,f2);
f3 = Preprocessing(f1,f3);
f4 = Preprocessing(f1,f4);
f5 = Preprocessing(f1,f5);
f6 = Preprocessing(f1,f6);
f7 = Preprocessing(f1,f7);
f8 = Preprocessing(f1,f8);
f9 = Preprocessing(f1,f9);
f10 = Preprocessing(f1,f10);
f11 = Preprocessing(f1,f11);
f12 = Preprocessing(f1,f12);


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