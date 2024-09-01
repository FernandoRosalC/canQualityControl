clc;
clear all
close all
clear m
load Firmas.mat;
%% Inicializar
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
f13 = Preprocessing(f1,f13);
f14 = Preprocessing(f1,f14);
f15 = Preprocessing(f1,f15);
f16 = Preprocessing(f1,f16);
f17 = Preprocessing(f1,f17);
f18 = Preprocessing(f1,f18);
figure,subplot(3,1,1);
plot(f1)
subplot(3,1,2);
plot(f4)
subplot(3,1,3);
plot(f8)

figure,subplot(3,1,1);
plot(f13)
subplot(3,1,2);
plot(f16)
subplot(3,1,3);
plot(f10)

[dmg] = getDmg(f1)
[dmg] = getDmg(f2)
[dmg] = getDmg(f3)
[dmg] = getDmg(f4)
[dmg] = getDmg(f5)
[dmg] = getDmg(f6)
[dmg] = getDmg(f7)
[dmg] = getDmg(f8)
[dmg] = getDmg(f9)
[dmg] = getDmg(f10)
[dmg] = getDmg(f11)
[dmg] = getDmg(f12)
[dmg] = getDmg(f13)
[dmg] = getDmg(f14)
[dmg] = getDmg(f15)
[dmg] = getDmg(f16)
[dmg] = getDmg(f17)
[dmg] = getDmg(f18)


%% training

% P = [f1;f2;f3;f4;f5;f6;f7;f8;f9;f10;f11;f12;f13;f14;f15;f16;f17;f18];
% W = [P(1,:);P(10,:)];
% load Patterns.mat;
% W = [Patterns(:,1);Patterns(:,10);Patterns(:,16)];
% 
% for epochs=1:1000
%     for j=1:20
%         for i=1:3
%             W(i,:) = W(i,:)/norm(W(i,:));
%         end
%         a = compet(W*P(j,:)');
%         W = W+0.0001*a*P(j,:);
%     end
% end

%%
m = mobiledev;
cam = camera(m,'back');
cam.Resolution = '640x480';
% cam.Autofocus = 'on';
% cam.Flash = 'on';

EE = [1 1 1; 1 1 1; 1 1 1];
[videoFrame,t] = snapshot(cam,'manual');
frameSize = size(videoFrame);
ym = zeros(frameSize(1),frameSize(2));
gm = zeros(frameSize(1),frameSize(2));
bm = zeros(frameSize(1),frameSize(2));
rm = zeros(frameSize(1),frameSize(2));

HSV = rgb2hsv(videoFrame);
H = 360*(HSV(:,:,1));
S = 100*(HSV(:,:,2));
V = 100*(HSV(:,:,3));

for j=1:frameSize(1)
 for i=1:frameSize(2)
     if (S(j,i)>60 && V(j,i)>25)
         ym(j,i) = (H(j,i)>30 && H(j,i)<90);
         gm(j,i) = (H(j,i)>90 && H(j,i)<150);
         bm(j,i) = (H(j,i)>190 && H(j,i)<255);
         rm(j,i) = (H(j,i)>330 || H(j,i)<30);
     end
 end
end

f = 0;
colores = [sum(sum(ym)) sum(sum(gm)) sum(sum(bm)) sum(sum(rm))];
[value, index] = max(colores);

if value > 500

    switch index
        case 1
            ym = imopen(ym,EE);
            f = edge(ym,'log');
            figure,imshow(ym);
            AislarObj(ym,videoFrame);
            str = 'Lata amarilla'
        case 3
            bm = imopen(bm,EE);
            f = edge(bm,'log',0);
            figure,imshow(bm);
            AislarObj(bm,videoFrame);
            str = 'Lata azul'
        case 4
            rm = imopen(rm,EE);
            f = edge(rm,'log',0);
            figure,imshow(rm);
            AislarObj(rm,videoFrame);
            str = 'Lata roja'
        otherwise
            str = 'Sin lata'
    end
    figure,imshow(f);
    firma = GenerateSign(f);
    firma = Preprocessing(f1,firma);
    figure, plot(firma)
    a = compet(W*firma');
    [~,index] = max(a);
    if index == 1
        str2 = 'lata completa'
    else
        str2 = 'lata apachurrada'
    end
    

else
   str = 'Sin lata' 
end


%% Generar firma
function sign = GenerateSign(f)
    [filas, columnas] = size(f);
    P = [3 2 1; 4 0 8; 5 6 7];
    for j=1:filas
        for i=1:columnas
            if f(j,i) == 1
                break;
            end
        end
        if f(j,i) == 1
            break;
        end 
    end
    x = [1:columnas];
    y = [1:filas];
    fx = sum(double(f),1);
    fy = sum(double(f),2)';
    cx = sum(x.*fx)/sum(fx);
    cy = sum(y.*fy)/sum(fy);
    f(uint16(cy),uint16(cx)) = 1;
    k = 1;
%     figure,
    while 1
        sign(k) = sqrt((cx-i)^2+(cy-j)^2);
        k = k+1;
        f(j,i) = 0;
        DIR = max(max(f(j-1:j+1,i-1:i+1).*P));
        i;
        j;
        switch DIR
            case 1
                i = i+1;
                j = j-1;
            case 2
                j = j-1;
            case 3
                i = i-1;
                j = j-1;
            case 4
                i = i-1;
            case 5
                i = i-1;
                j = j+1;
            case 6
                j = j+1;
            case 7
                j = j+1;
                i = i+1;
            case 8
                i = i+1;
            otherwise
                break;
        end
%         imshow(f);
%         drawnow
    end
    sign = normalize(sign, "range",[0,1]);
end
%% Preprocesamiento
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
%% Para aislar al objeto
function AislarObj(f,imgIn)
    SR = sum(f,2);
    n1 = 1;
    n2 = 1;
    for i=2:length(SR)-1
        if SR(i)>0 && SR(i-1) == 0
            FSR(n1) = i;
            n1 = n1+1; 
        end
        if SR(i)==0 && SR(i-1) > 0
            FBR(n2) = i;
            n2=n2+1;
        end
    end
    reng= f(FSR(1):FBR(1),:);
    SL = sum(reng,1);
    n3 = 1;
    n4 = 1;
    FSL = 0;
    FBL = 0;
    for j=2:length(SL)-1
        if SL(j)>0 && SL(j-1)==0
            FSL(n3) = j;
            n3 = n3+1;
        end
        if SL(j+1)==0 && SL(j) > 0
            FBL(n4) = j;
            n4 = n4+1;
        end
    end
   
    for j=1:length(FSL)
        objeto = f(FSR(1):FBR(1),FSL(j):FBL(j));
    end
    [filas, columnas] = size(objeto);
    figure, imshow(imgIn);
    hold on
    rectangle('Position',[FSL-20 FSR-20 columnas+30 filas+30], ...
        'LineWidth',2,'EdgeColor','m','Curvature',0.3);
    hold off
end