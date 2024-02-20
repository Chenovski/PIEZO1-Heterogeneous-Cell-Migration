% 01/09/2024 to 02/12/2024
% Visualization script for cko mix yoda1

%% 01 [Load Data] pre-set

load_location = ['C:\Users\cjh_m\Desktop\2024_01_09_Heterogeneous_Cell_Migration_Model\' ...
    '2024_02_12_cko_mix_yoda1'];
% load_location = ['C:\Users\cjh_m\Desktop\2024_01_09_Heterogeneous_Cell_Migration_Model\' ...
%     '2024_02_12_cko_mix_yoda1_a2a3'];
phenotype = 'Yoda1';
load(load_location);

% initialization
sp = 1:-0.1:0; % source percentage
adh_inter = -0.4:0.1:0.6; % interaction adhesion
[xp,yp] = meshgrid(sp,adh_inter);
x_label = [phenotype ' Percentage in Initial and Source Cells'];
y_label = 'Interaction Adhesion \alpha_{uv}';
font_size = 14;

% normalization w.r.t the mixing control for cko mix yoda1
wcs_con = 3.2375;
ael_con = 2.3039;
Wcs_mean = wcs_mean;
Wcs_sem = wcs_sem;
Ael_mean = ael_mean;
Ael_sem = ael_sem;
for i = 1:size(wcs_mean,1)
    Wcs_mean(i,:) = wcs_mean(i,:)/wcs_con;
    Wcs_sem(i,:) = wcs_sem(i,:)/wcs_con;
    Ael_mean(i,:) = ael_mean(i,:)/ael_con;
    Ael_sem(i,:) = ael_sem(i,:)/ael_con;
end

%% 02 [Fig 1-2] wound healing metrics, normalized

figure(1);
clf;
hold on;
errorbar(sp,Wcs_mean(1,:),Wcs_sem(1,:),LineWidth=2);
errorbar(sp,Wcs_mean(3,:),Wcs_sem(3,:),LineWidth=2);
errorbar(sp,Wcs_mean(5,:),Wcs_sem(5,:),LineWidth=2);
errorbar(sp,Wcs_mean(7,:),Wcs_sem(7,:),LineWidth=2);
errorbar(sp,Wcs_mean(9,:),Wcs_sem(9,:),LineWidth=2);
errorbar(sp,Wcs_mean(11,:),Wcs_sem(11,:),LineWidth=2);
plot(sp,ones(size(sp)),'k--',LineWidth=2);
hold off;
xticks(flip(sp));
xlabel(x_label);
ylabel('Norm. Wound Closure');
% ylim([0 2]);% adjust scale for plotting
leg1 = legend('\alpha_{uv} = -0.4','\alpha_{uv} = -0.2','\alpha_{uv} = 0', ...
    '\alpha_{uv} = 0.2','\alpha_{uv} = 0.4','\alpha_{uv} = 0.6','Control','Location','best');
set(leg1,'Box','off')
ax = gca;
ax.FontSize = font_size;

figure(2);
clf;
hold on;
errorbar(sp,Ael_mean(1,:),Ael_sem(1,:),LineWidth=2);
errorbar(sp,Ael_mean(3,:),Ael_sem(3,:),LineWidth=2);
errorbar(sp,Ael_mean(5,:),Ael_sem(5,:),LineWidth=2);
errorbar(sp,Ael_mean(7,:),Ael_sem(7,:),LineWidth=2);
errorbar(sp,Ael_mean(9,:),Ael_sem(9,:),LineWidth=2);
errorbar(sp,Ael_mean(11,:),Ael_sem(11,:),LineWidth=2);
plot(sp,ones(size(sp)),'k--',LineWidth=2);
hold off;
xticks(flip(sp));
xlabel(x_label);
ylabel('Norm. Edge Length');
leg2 = legend('\alpha_{uv} = -0.4','\alpha_{uv} = -0.2','\alpha_{uv} = 0', ...
    '\alpha_{uv} = 0.2','\alpha_{uv} = 0.4','\alpha_{uv} = 0.6','Control','Location','best');
set(leg2,'Box','off')
ax = gca;
ax.FontSize = font_size;

%% 03 [Fig 3] percentage of edge cells

plot_type = 'a';

if strcmp(plot_type,'a') % a: all
    edge_mean = wrp_average_mean;
    edge_sem = wrp_average_sem;
elseif strcmp(plot_type,'f') % f: forward
    edge_mean = forward_mean;
    edge_sem = forward_sem;
elseif strcmp(plot_type,'b') % b: backward
    edge_mean = backward_mean;
    edge_sem = backward_sem;
elseif strcmp(plot_type,'s') % s: still
    edge_mean = still_mean;
    edge_sem = still_sem;
end


x_label = 'v cells Percentage in Initial and Source Cells';
y_label = 'v cells Percentage in Edge Cells';

figure(3);
clf;
hold on;
plot(0:0.1:1,0:0.1:1,'--',LineWidth=1);
errorbar(sp,1-edge_mean(1,:),edge_sem(1,:),LineWidth=2);
errorbar(sp,1-edge_mean(3,:),edge_sem(3,:),LineWidth=2);
errorbar(sp,1-edge_mean(5,:),edge_sem(5,:),LineWidth=2);
errorbar(sp,1-edge_mean(7,:),edge_sem(7,:),LineWidth=2);
errorbar(sp,1-edge_mean(9,:),edge_sem(9,:),LineWidth=2);
errorbar(sp,1-edge_mean(11,:),edge_sem(11,:),LineWidth=2);
xticks(flip(sp));
xlabel(x_label,"FontSize",font_size);
ylabel(y_label,"FontSize",font_size);
leg1 = legend('y=x line','\alpha_{uv} = -0.4','\alpha_{uv} = -0.2','\alpha_{uv} = 0', ...
    '\alpha_{uv} = 0.2','\alpha_{uv} = 0.4','\alpha_{uv} = 0.6','Location','best');
set(leg1,'Box','off')
ax = gca;
ax.FontSize = font_size;
hold off;

%% 04 [Fig 4] percentage of edge cells
% plot individually

designated_adh = 0.6;
idx = round((designated_adh+0.4)/0.1)+1;

x_label = 'v cells Percentage in Initial and Source Cells';
y_label = 'v cells Percentage in Edge Cells';

figure(4);
clf;
hold on;
plot(0:0.1:1,0:0.1:1,'--',LineWidth=1);
errorbar(sp,1-forward_mean_new(idx,:),forward_sem_new(idx,:),LineWidth=2);
errorbar(sp,1-backward_mean_new(idx,:),backward_sem_new(idx,:),LineWidth=2);
errorbar(sp,1-still_mean_new(idx,:),still_sem_new(idx,:),LineWidth=2);
xticks(flip(sp));
xlabel(x_label);
ylabel(y_label);
leg = legend('y=x line','forward edge cells','backward edge cells', ...
    'stationary edge cells','Location','best');
set(leg,'Box','off')
ax = gca;
ax.FontSize = font_size;
title(['Interaction Adhesion = ' num2str(designated_adh)]);


%% S01 [Optional] wound healing metrics, without normalization

figure(1);
clf;
hold on;
errorbar(sp,wcs_mean(1,:),wcs_sem(1,:),LineWidth=2);
errorbar(sp,wcs_mean(3,:),wcs_sem(3,:),LineWidth=2);
errorbar(sp,wcs_mean(5,:),wcs_sem(5,:),LineWidth=2);
errorbar(sp,wcs_mean(7,:),wcs_sem(7,:),LineWidth=2);
errorbar(sp,wcs_mean(9,:),wcs_sem(9,:),LineWidth=2);
errorbar(sp,wcs_mean(11,:),wcs_sem(11,:),LineWidth=2);
plot(sp,wcs_con*ones(size(sp)),'k--',LineWidth=2);
hold off;
xticks(flip(sp));
xlabel(x_label);
ylabel('Norm. Wound Closure');
leg1 = legend('\alpha_{uv} = -0.4','\alpha_{uv} = -0.2','\alpha_{uv} = 0', ...
    '\alpha_{uv} = 0.2','\alpha_{uv} = 0.4','\alpha_{uv} = 0.6','Control','Location','best');
set(leg1,'Box','off')
ax = gca;
ax.FontSize = font_size;

figure(2);
clf;
hold on;
errorbar(sp,ael_mean(1,:),ael_sem(1,:),LineWidth=2);
errorbar(sp,ael_mean(3,:),ael_sem(3,:),LineWidth=2);
errorbar(sp,ael_mean(5,:),ael_sem(5,:),LineWidth=2);
errorbar(sp,ael_mean(7,:),ael_sem(7,:),LineWidth=2);
errorbar(sp,ael_mean(9,:),ael_sem(9,:),LineWidth=2);
errorbar(sp,ael_mean(11,:),ael_sem(11,:),LineWidth=2);
plot(sp,ael_con*ones(size(sp)),'k--',LineWidth=2);
hold off;
xticks(flip(sp));
xlabel(x_label);
ylabel('Norm. Edge Length');
leg2 = legend('\alpha_{uv} = -0.4','\alpha_{uv} = -0.2','\alpha_{uv} = 0', ...
    '\alpha_{uv} = 0.2','\alpha_{uv} = 0.4','\alpha_{uv} = 0.6','Control','Location','best');
set(leg2,'Box','off')
ax = gca;
ax.FontSize = font_size;