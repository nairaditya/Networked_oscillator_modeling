function plot_fig0(t,z_pert_modal,modeno,type)

z2 = z_pert_modal;
ang_z2 = angle(z2);
figure(3)
z = zeros(size(t')) ;
subplot(311); hold all
surface([t',t'], [real(z2),real(z2)], [z,z], [ang_z2, ang_z2], ...
    'FaceColor', 'No',...
    'EdgeColor', 'Interp',...
    'LineWidth', 4);
surface([t',t'], [imag(z2),imag(z2)], [z,z], [ang_z2, ang_z2], ...
    'FaceColor', 'No',...
    'EdgeColor', 'Interp',...
    'LineWidth', 4);
patch([t',t'],[z,z],[z,z],'FaceColor', 'No',...
    'EdgeColor', 'None',...
    'LineWidth', 4);
set(gca,'Xtick',0:2:18);
xlim([0 6.1*3]);
if modeno == 1
    ylim([-3.25 3.25]);
    set(gca,'Ytick',[-2 0 2]);
elseif modeno == 2
    ylim([-0.5 0.5]);
    set(gca,'Ytick',[-0.4 0 0.4]);
elseif modeno == 3
    ylim([-0.32 0.32]);
    set(gca,'Ytick',[-0.2 0 0.2]);
elseif modeno == 4
    ylim([-0.08 0.08]);
    set(gca,'Ytick',[-0.05 0 0.05]);
end
colormap(phasemap);
caxis([-pi pi]);axis on;
set(gca,'XTickLabel',[]);set(gca,'YTickLabel',[])
if type == 1
    print('-djpeg',['oscdns',num2str(modeno),'_modes.jpg']);close;
elseif type == 2
    print('-djpeg',['osc',num2str(modeno),'_modes.jpg']);close;
elseif type == 3
    print('-djpeg',['oscgs',num2str(modeno),'_modes.jpg']);close;
end

figure(4);
z = zeros(size(t')) ;
subplot(221); hold on
surface([real(z2),real(z2)], [imag(z2),imag(z2)], [z,z], [ang_z2, ang_z2], ...
    'FaceColor', 'No',...
    'EdgeColor', 'Interp',...
    'LineWidth', 4);
hold on;
flag = 1.2*abs(z2(1));
plot([0 flag],[0 0],'k-','LineWidth',1.5);hold on;
plot([0 0],[0 flag],'k-','LineWidth',1.5);hold on;
axis equal,
colormap(phasemap);
caxis([-pi pi]);
if modeno == 1
    xlim([-3.25 3.25]);
    ylim([-3.25 3.25]);
    set(gca,'Xtick',[-2 0 2],'Xticklabel',{'-2','0','2'});
    set(gca,'Ytick',[-2 0 2],'Yticklabel',{'-2','0','2'});
elseif modeno == 2
    xlim([-0.5 0.5]);
    ylim([-0.5 0.5]);
    set(gca,'Xtick',[-0.4 0 0.4],'Xticklabel',{'-0.4','0','0.4'});
    set(gca,'Ytick',[-0.4 0 0.4],'Yticklabel',{'-0.4','0','0.4'});
elseif modeno == 3
    xlim([-0.32 0.32]);
    ylim([-0.32 0.32]);
    set(gca,'Xtick',[-0.2 0 0.2],'Xticklabel',{'-0.2','0','0.2'});
    set(gca,'Ytick',[-0.2 0 0.2],'Yticklabel',{'-0.2','0','0.2'});
elseif modeno == 4
    xlim([-0.08 0.08]);
    ylim([-0.08 0.08]);
    set(gca,'Xtick',[-0.05 0 0.05],'Xticklabel',{'-0.05','0','0.05'});
    set(gca,'Ytick',[-0.05 0 0.05],'Yticklabel',{'-0.05','0','0.05'});
end
set(gca,'XTickLabel',[]);set(gca,'YTickLabel',[])
if type == 1
    print('-djpeg',['oscdns',num2str(modeno),'.jpg']);close;
elseif type == 2
    print('-djpeg',['osc',num2str(modeno),'.jpg']);close;
elseif type == 3
    print('-djpeg',['oscgs',num2str(modeno),'.jpg']);close;
end
