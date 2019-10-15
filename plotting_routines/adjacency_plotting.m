function adjacency_plotting(Aij_sin,nosc,type)
%% plotting
xx = 1:nosc+1;yy = 1:nosc+1;
A_temp = zeros(nosc+1,nosc+1);
A_temp(1:nosc,1:nosc) =  Aij_sin(1:nosc,1:nosc);
for i = 1:nosc+1
    A_temp(i,i) = NaN;
end
figure;h1 = subplot(2,2,1);
e2 = pcolor(xx,yy,A_temp);
if type == 1
    colormap(h1,flipud(hot));
elseif type == 2
    colormap(h1,1*phasemap);
end
set(h1,'Ydir','reverse');
if type == 1
    hcb = colorbar;
    set(hcb,'YTicklabel','');
elseif type == 2
    caxis([-pi pi]);
    hcb=colorbar;
    set(hcb,'YTick',[-pi,-pi/2,0,pi/2,pi]);
    set(hcb,'YTicklabel','');
    set(hcb, 'Fontname', 'symbol');
    set(e2,'AlphaData',1)
end
if type == 1
    %title('|A_{mn}|');
elseif type == 2
    %title('\angle A_{mn}');
end
axis off;
set(hcb,'Fontsize',16);
axis square;
print('-depsc',['A_',num2str(type),'.eps']);close;
end

