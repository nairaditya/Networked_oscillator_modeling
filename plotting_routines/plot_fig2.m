function plot_fig2(t,z_pert_modal,modeno,flag)

z2 = z_pert_modal;
ang_z2 = angle(z2);
figure;
z = zeros(size(t')) ;
subplot(221); hold on
surface([real(z2),real(z2)], [imag(z2),imag(z2)], [z,z], [ang_z2, ang_z2], ...
    'FaceColor', 'No',...
    'EdgeColor', 'Interp',...
    'LineWidth', 4);
hold on;
if modeno == flag
    plot(real(z2(1)),imag(z2(1)),'o','MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',12);hold on;
else
    plot(real(z2(1)),imag(z2(1)),'o','MarkerEdgeColor',[0.3 0.3 0.3],'MarkerFaceColor',[0.3 0.3 0.3],'MarkerSize',12);hold on;
end
axis equal, %axis off;
colormap(phasemap);
caxis([-pi pi]);
if modeno == 1
    xlim([-3 3]);
    ylim([-3 3]);
    set(gca,'Xtick',[-2 0 2],'Xticklabel',{'-2','0','2'});
    set(gca,'Ytick',[-2 0 2],'Yticklabel',{'-2','0','2'});
elseif modeno == 2
    xlim([-1.5 1.5]);
    ylim([-1.5 1.5]);
    set(gca,'Xtick',[-1 0 1],'Xticklabel',{'-1','0','1'});
    set(gca,'Ytick',[-1 0 1],'Yticklabel',{'-1','0','1'});
elseif modeno == 3
    xlim([-0.75 0.75]);
    ylim([-0.75 0.75]);
    set(gca,'Xtick',[-0.5 0 0.5],'Xticklabel',{'-0.5','0','0.5'});
    set(gca,'Ytick',[-0.5 0 0.5],'Yticklabel',{'-0.5','0','0.5'});
elseif modeno == 4
    xlim([-0.2 0.2]);
    ylim([-0.2 0.2]);
    set(gca,'Xtick',[-0.1 0 0.1],'Xticklabel',{'-0.1','0','0.1'});
    set(gca,'Ytick',[-0.1 0 0.1],'Yticklabel',{'-0.1','0','0.1'});
end