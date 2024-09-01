function [o1,o2,o3,o4] =  AislarObj(f,imgIn)
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
    o1 = FSL-20;
    o2 = FSR-20;
    o3 = columnas+30;
    o4 = filas+30;
%     figure, imshow(imgIn,'Parent',app.UIAxes);
%     hold on
%     rectangle('Position',[FSL-20 FSR-20 columnas+30 filas+30], ...
%         'LineWidth',2,'EdgeColor','m','Curvature',0.3);
%     hold off
end