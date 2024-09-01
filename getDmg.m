function [dmg] = getDmg(sign)
tam = length(sign);
pt1 = sign(50:tam/2);
pt2 = sign(tam/2+1:tam-50);

dmg1 = min(pt1)*100;
dmg2 = min(pt2)*100;

dmg = dmg1+dmg2;
end