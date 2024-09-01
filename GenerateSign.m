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