clc;
% clear
close all
clear m

EE = [1 1 1; 1 1 1; 1 1 1];
myFolder = 'fotos';
filePattern = fullfile(myFolder, '*.jpg'); % Change to whatever pattern you need.
theFiles = dir(filePattern);
for k = 1 : length(theFiles)
  baseFileName = theFiles(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  delete(fullFileName);
end
fprintf('Archivos borrados')

m = mobiledev;
cam = camera(m,'back');
cam.Resolution = '640x480';
cam.Autofocus = 'on';
%1 a 9 normal
%10 a 15 de lado
%16 a 20 apachurradas
% cam = webcam("USB2.0 Camera");
for k=18:20
    [videoFrame,~] = snapshot(cam,'manual');
    frameSize = size(videoFrame);
    ym = zeros(frameSize(1),frameSize(2));
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
             bm(j,i) = (H(j,i)>190 && H(j,i)<255);
             rm(j,i) = (H(j,i)>330 || H(j,i)<30);
         end
     end
    end

    f = 0;
    colores = [sum(sum(ym)) sum(sum(bm)) sum(sum(rm))];
    [value, index] = max(colores);
    if value > 500
        switch index
            case 1
                f = imopen(ym,EE);
                str = 'amarillo'
            case 2
                f = imopen(bm,EE);
                str = 'azul'
            case 3
                f = imopen(rm,EE);
                str = 'rojo'
        end
        imshow(f);
    end
    [phi1 phi2 phi3 phi4 phi5 phi6 phi7] = hu(f);
    [c1 c2 c3 c4 c5 c6 c7] = normalizacionMomentos(phi1, phi2, phi3, phi4, phi5, phi6, phi7);
    Patterns(:,k) = [c1 c2 c3 c4 c5 c6 c7];
    Patterns(:,k) = Patterns(:,k)/norm(Patterns(:,k));
    frameName = strcat('P_',num2str(k),'.jpg')
    ruta = strcat('fotos\',frameName);
    % imwrite(videoFrame,ruta);
    str2 = strcat('Foto numero ',num2str(k),' Guardada')
    Patterns
end