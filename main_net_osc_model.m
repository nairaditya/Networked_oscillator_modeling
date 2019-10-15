%% A. G. Nair, S. L. Brunton, & K. Taira, Networked oscillator-based 
%% modeling and control of unsteady wake flows, Phys. Rev. E, 2018
%% Networked-oscillator modeling

addpath('functions');
addpath('plotting_routines');

%% Baseline data analysis

baseline_modal = load(['Data/baseline.dat']);
baseline_modal_1 = (baseline_modal(1:end,2)+...
    1i*baseline_modal(1:end,3));    % Osc I (baseline)               
baseline_modal_2 = (baseline_modal(1:end,4)+...
    1i*baseline_modal(1:end,5));% Osc II (baseline)
baseline_modal_3 = (baseline_modal(1:end,6)+...
    1i*baseline_modal(1:end,7));% Osc III (baseline
baseline_modal_4 = (baseline_modal(1:end,8)+...
    1i*baseline_modal(1:end,9));% Osc IV (baseline)
osc1_ref = baseline_modal_1(ns_start:1:9150+ns_start);
osc2_ref = baseline_modal_2(ns_start:1:9150+ns_start);
osc3_ref = baseline_modal_3(ns_start:1:9150+ns_start);
osc4_ref = baseline_modal_4(ns_start:1:9150+ns_start);

% Plotting
ns_start = 1541;dt = 0.002;t = 0:dt:(length(osc1_ref)-1)*dt;
plot_fig0(t,osc1_ref,1,1);
plot_fig0(t,osc2_ref,2,1);
plot_fig0(t,osc3_ref,3,1);
plot_fig0(t,osc4_ref,4,1);

%% Perturbed data analysis

clear;clc;close all;
load ('Data/baseline_energy.mat');
load ('Data/perturbed_data.mat');
load ('Data/gs_projection.mat');
nosc = 4;
A = networked_oscillator_model(size(zprime_dot ,1),...
    size(zprime_dot ,2),zprime,zprime_dot );
L = A-diag(sum(A,2));
vf = @(t,x) L*x;
[~,zprime_reg] = ode45(vf,t,zprime(1,:));
z_ref = zb;
z_pert_fluc_diff = zprime.*z_ref;
z_pert_fluc_diff_model = zprime_reg.*z_ref;
z_pert_fluc_diff_gs = z_gs-z_ref;
for i = 1:nosc
    z_pert_fluc_diff(:,i) = z_pert_fluc_diff(:,i)/r0(i);
    z_pert_fluc_diff_model(:,i) = z_pert_fluc_diff_model(:,i)/r0(i);
    z_pert_fluc_diff_gs(:,i) = z_pert_fluc_diff_gs(:,i)/r0(i);
end
z_pert_p = zp;
z_pert_p_model = zprime_reg.*z_ref + z_ref;
E_p = (abs(z_pert_p).^2 - abs(z_ref).^2)/2;
E_p_model = (abs(z_pert_p_model).^2 - abs(z_ref).^2)/2;
E_p_gs= (abs(z_gs).^2 - abs(z_ref).^2)/2;
for i = 1:nosc
    E_p(:,i) = E_p(:,i)/(r0(i)^2);
    E_p_model(:,i) = E_p_model(:,i)/(r0(i)^2);
    E_p_gs(:,i) = E_p_gs(:,i)/(r0(i)^2);
end

% Plotting adjacency matrix

adjacency_plotting(abs(A),4,1);
adjacency_plotting(angle(A),4,2);

% Plotting phase trajectories

plot_fig2(t',z_pert_p(:,1),1,1);
plot_fig2(t',z_pert_p_model(:,1),1,2);
plot_fig2(t',z_gs(:,1),1,3);
plot_fig2(t',z_pert_p(:,2),2,1);
plot_fig2(t',z_pert_p_model(:,2),2,2);
plot_fig2(t',z_gs(:,2),2,3);
plot_fig2(t',z_pert_p(:,3),3,1);
plot_fig2(t',z_pert_p_model(:,3),3,2);
plot_fig2(t',z_gs(:,3),3,3);
plot_fig2(t',z_pert_p(:,4),4,1);
plot_fig2(t',z_pert_p_model(:,4),4,2);
plot_fig2(t',z_gs(:,4),4,3);
close all;
% Comparing modal perturbation

figure;
subplot(221);
plot(t,real(z_pert_fluc_diff(:,1)),'k-','Linewidth',2);hold on;
plot(t,real(z_pert_fluc_diff_model(:,1)),'r--','Linewidth',2);hold on;
plot(t,imag(z_pert_fluc_diff_gs(:,1)),'--','Color',color_save(3),...
    'Linewidth',2);hold on;
xlim([0 6.1*3]);
xlabel('$t-t_0$','Interpreter','Latex','Fontsize',18);
ylabel('$a_1^\prime/\overline{r^b_\mathrm{I}}$','Interpreter','Latex',...
    'Fontsize',18);
ylim([-0.75 0.75]);
set(gca,'Fontsize',18);
set(gca,'Fontname','Times')
box off;
subplot(222);
plot(t,real(z_pert_fluc_diff(:,2)),'k-','Linewidth',2);hold on;
plot(t,real(z_pert_fluc_diff_model(:,2)),'r--','Linewidth',2);hold on;
plot(t,real(z_pert_fluc_diff_gs(:,2)),'--','Color',color_save(3),...
    'Linewidth',2);hold on;
xlim([0 6.1*3]);
xlabel('$t-t_0$','Interpreter','Latex','Fontsize',18);
ylabel('$a_3^\prime/\overline{r^b_\mathrm{II}}$','Interpreter','Latex',...
'Fontsize',18);
ylim([-2 2]);
set(gca,'Fontsize',18);
set(gca,'Fontname','Times')
box off;
subplot(223);
plot(t,real(z_pert_fluc_diff(:,3)),'k-','Linewidth',2);hold on;
plot(t,real(z_pert_fluc_diff_model(:,3)),'r--','Linewidth',2);hold on;
plot(t,real(z_pert_fluc_diff_gs(:,3)),'--','Color',color_save(3),...
    'Linewidth',2);hold on;
xlim([0 6.1*3]);
xlabel('$t-t_0$','Interpreter','Latex','Fontsize',18);
ylabel('$a_5^\prime/\overline{r^b_\mathrm{III}}$','Interpreter','Latex',...
    'Fontsize',18);
ylim([-2 2]);
set(gca,'Fontsize',18);
set(gca,'Fontname','Times')
box off;
subplot(224);
plot(t,real(z_pert_fluc_diff(:,4)),'k-','Linewidth',2);hold on;
plot(t,real(z_pert_fluc_diff_model(:,4)),'r--','Linewidth',2);hold on;
plot(t,real(z_pert_fluc_diff_gs(:,4)),'--','Color',color_save(3),...
    'Linewidth',2);hold on;
xlim([0 6.1*3]);
xlabel('$t-t_0$','Interpreter','Latex','Fontsize',18);
ylabel('$a_7^\prime/\overline{r^b_\mathrm{IV}}$','Interpreter','Latex',...
    'Fontsize',18);
box off;
ylim([-2 2]);
set(gca,'Fontsize',18);
set(gca,'Fontname','Times')
print('-depsc','modal_perturbation.eps');close;

% Comparing modal energy

figure;
subplot(221);
plot(t,E_p(:,1),'k-','Linewidth',2);hold on;
plot(t,E_p_model(:,1),'r--','Linewidth',2);hold on;
plot(t,E_p_gs(:,1),'--','Color',color_save(3),'Linewidth',2);hold on;
xlim([0 6.1*3]);
ylim([-0.25 0.25]);
set(gca,'Xtick',[0;5;10;15],'XtickLabel',{'0','5','10','15'});
xlabel('$t-t_0$','Interpreter','Latex','Fontsize',18);
ylabel('$E_\mathrm{I}^\prime/(\overline{r^b_\mathrm{I}})^2$','Interpreter','Latex',...
    'Fontsize',18);
set(gca,'Fontsize',18);
set(gca,'Fontname','Times')
legend boxoff;
box off;
subplot(222);
plot(t,E_p(:,2),'k-','Linewidth',2);hold on;
plot(t,E_p_model(:,2),'r--','Linewidth',2);hold on;
plot(t,E_p_gs(:,2),'--','Color',color_save(3),'Linewidth',2);hold on;
xlim([0 6.1*3]);
ylim([-1 6]);
set(gca,'Xtick',[0;5;10;15],'XtickLabel',{'0','5','10','15'});
xlabel('$t-t_0$','Interpreter','Latex','Fontsize',18);
ylabel('$E_\mathrm{II}^\prime/(\overline{r^b_\mathrm{II}})^2$','Interpreter','Latex',...
    'Fontsize',18);
set(gca,'Fontsize',18);
legend('DNS','Network model','Galerkin model','Location','Best');
legend boxoff;
set(gca,'Fontname','Times')
box off;
subplot(223);
plot(t,E_p(:,3),'k-','Linewidth',2);hold on;
plot(t,E_p_model(:,3),'r--','Linewidth',2);hold on;
plot(t,E_p_gs(:,3),'--','Color',color_save(3),'Linewidth',2);hold on;
xlim([0 6.1*3]);
set(gca,'Xtick',[0;5;10;15],'XtickLabel',{'0','5','10','15'});
xlabel('$t-t_0$','Interpreter','Latex','Fontsize',18);
ylabel('$E_\mathrm{III}^\prime/(\overline{r^b_\mathrm{III}})^2$','Interpreter',...
    'Latex','Fontsize',18);
set(gca,'Fontsize',18);
set(gca,'Fontname','Times')
box off;
subplot(224);
plot(t,E_p(:,4),'k-','Linewidth',2);hold on;
plot(t,E_p_model(:,4),'r--','Linewidth',2);hold on;
plot(t,E_p_gs(:,4),'--','Color',color_save(3),'Linewidth',2);hold on;
xlim([0 6.1*3]);
set(gca,'Xtick',[0;5;10;15],'XtickLabel',{'0','5','10','15'});
xlabel('$t-t_0$','Interpreter','Latex','Fontsize',18);
ylabel('$E_\mathrm{IV}^\prime/(\overline{r^b_\mathrm{IV}})^2$','Interpreter','Latex',...
    'Fontsize',18);
set(gca,'Fontsize',18);
set(gca,'Fontname','Times')
box off;
print('-depsc','modal_energy.eps');close;

%% Aggregate network model

clear;clc;close all;

% Load test data

dt = 0.002;     % time interval
nt = 6100;      % number of snapshots
time = 0:dt:dt*(nt-1);% set time vector
nosc = 4;
load('Data/test_data.mat');
zrefd = (zprimedot_test);

% training data - combined

load('Data/training_data1.mat');
load('Data/training_data2.mat');
load('Data/training_data3.mat');
load('Data/training_data4.mat');
zprime_train = [zprime_train1;zprime_train2;zprime_train3;zprime_train4];
zprimedot_train = [zprimedot_train1;zprimedot_train2;zprimedot_train3;zprimedot_train4];
Areg = networked_oscillator_model(size(zprimedot_train ,1),...
    size(zprimedot_train ,2),zprime_train,zprimedot_train );
Lreg=Areg-diag(sum(Areg,2));
z_reg_dot = zeros(size(zprime_test));
for i = 1:size(zprime_test,1)
    z_reg_dot(i,:) = odefun(1,...
        zprime_test(i,1:nosc),Areg);
end
zrd = (z_reg_dot);

% Error plotting

r = sqrt( sum( abs((zrefd(:,:)-zrd(:,:)).^2)) / numel(zrefd) )./...
    (max(abs(zrefd(:,:)))-min(abs(zrefd(:,:))))*100;

figure;
subplot(221);hold all;
plot(r,'o-','Color',color_save_new(5),'MarkerEdgeColor',color_save_new(5),...
    'MarkerFaceColor',color_save_new(5),'Linewidth',2);
xlabel('m','Fontsize',16);
ylabel('$\triangle_m (\%)$','Interpreter','Latex','Fontsize',16);
set(gca,'Xtick',[1,2,3,4],'Xticklabel',{'I','II','III','IV'});

ylim([0 25]);
set(gca,'Fontsize',16);
set(gca,'Fontname','Times');
print('-depsc','error_check.eps');
hh = legend('Train:Osc I','Train:Osc II','Train:Osc III','Train:Osc IV',...
'Aggregate','Location','Southoutside');
legend boxoff;
set(hh,'Fontname','Times');
print('-depsc','RSME_error.eps');close all;

adjacency_plotting(abs(Areg),4,1);
adjacency_plotting(angle(Areg),4,2);


