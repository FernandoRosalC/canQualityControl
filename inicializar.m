function [f11,f22,f33,f44,f55,f66,f77,f88,f99,f100,f111,f122,f133,f144,f155,f166,f177,f188] = inicializar
    load Firmas.mat f1 f2 f3 f4 f5 f6 f7 f8 f9 f10 f11 f12 f13 f14 f15 f16 f17 f18;
    f11 = f1;
    f22 = Preprocessing(f1,f2);
    f33 = Preprocessing(f1,f3);
    f44 = Preprocessing(f1,f4);
    f55 = Preprocessing(f1,f5);
    f66 = Preprocessing(f1,f6);
    f77 = Preprocessing(f1,f7);
    f88 = Preprocessing(f1,f8);
    f99 = Preprocessing(f1,f9);
    f100 = Preprocessing(f1,f10);
    f111 = Preprocessing(f1,f11);
    f122 = Preprocessing(f1,f12);
    f133 = Preprocessing(f1,f13);
    f144 = Preprocessing(f1,f14);
    f155 = Preprocessing(f1,f15);
    f166 = Preprocessing(f1,f16);
    f177 = Preprocessing(f1,f17);
    f188 = Preprocessing(f1,f18);
end