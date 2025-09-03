%% Make Fig 6

%% PLot results

Line_width= 1.0;

fig = figure;
fig.Position(3)=620;
set(gcf,'color','w');
ax = axes;
set(gca,'Color',[1 1 1])

%% Plot dummy data for legend
plot([-1, -1],[-1,-2],'LineWidth',Line_width)
hold on
plot([-1, -1],[-1,-2],'LineWidth',Line_width)
plot([-1, -1],[-1,-2],'LineWidth',Line_width)

%Add the limit
plot([-1, -1],[-1,-2],'--','LineWidth',Line_width,'Color','k')




%% Range of k


k_mask_nominal = 4.5447;
k_gaiter_nominal =    10.1623;


%Specify endpoints
k_mask_min = 1.3698;
k_mask_max = 7.2168;

k_gaiter_min = 3.063;
k_gaiter_max = 16.137;

x_patch_mask = [k_mask_min, k_mask_max, k_mask_max,k_mask_min];
y_patch_mask = [-1, -1, 2, 2];

x_patch_gaiter = [k_gaiter_min, k_gaiter_max, k_gaiter_max,k_gaiter_min];
y_patch_gaiter = [-1, -1, 2, 2];

patch(x_patch_mask,y_patch_mask,0.5*[1,1,1],'FaceAlpha',.35,'EdgeColor','none')
hold on

patch(x_patch_gaiter,y_patch_gaiter,'green','FaceAlpha',.35,'EdgeColor','none')


xline(k_mask_nominal,'LineWidth',Line_width,'Color',0.3*[1,1,1])

xline(k_gaiter_nominal,'--','LineWidth',Line_width,'Color',0.8*[0.460    0.80    0.180])



%% DATA

ax.ColorOrderIndex=1;

%PLot mask data
load('Fig6_mask.mat')
semilogx(k,eta,'LineWidth',Line_width)
hold on
semilogx(k,eta_vert,'LineWidth',Line_width)
semilogx(k,eta_hoz,'LineWidth',Line_width)

% Plot gaiter data
load('Fig6_gaiter.mat')
semilogx(k,eta_gaiter,'--','LineWidth',Line_width,'Color','k')


ax.YTick = [0, 0.2,0.4,0.6,0.8,1.0];


xlabel('$k$','Interpreter','latex','FontSize',16)
ylabel('$\eta$','Interpreter','latex','FontSize',16,'Rotation',0)


lgd = legend(ax,{'$\eta$ (Mask)','$\eta_{\mathrm{vert}}$ (Mask)','$\eta_{ \mathrm{hoz}}$ (Mask)','$\eta$ (Gaiter)'},'Interpreter','latex','FontSize',14);
lgd.Location = 'northeastoutside';

ax.YLabel.Rotation=0;

ax.XLabel.FontSize = 14;
ax.YLabel.FontSize = 14;

ax.XLim = [1e-2 1e2];
ax.YLim = [0 1];

ax.FontSize = 12;
ax.YLabel.FontSize = 14;
ax.XLabel.FontSize = 14;

ax.XScale='log';
ax.Box='on';

text(1.7,0.95,'Mask','Interpreter','latex','FontSize',14)
text(3.45,0.89,'Gaiter','Interpreter','latex','FontSize',14)

