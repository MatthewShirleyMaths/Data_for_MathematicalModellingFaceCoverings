%% Make Fig 3
%Results for 1D reduced model


%% PLot results
%Load Data
load('Fig3.mat')

Line_width= 0.9;

fig = figure;
set(gcf,'color','w');
ax = axes;
set(gca,'Color',[1 1 1])
%PLot main data
semilogx(k,eta,'LineWidth',Line_width)
hold on
%Add the limit
semilogx(k,eta_LargeM,'k--','LineWidth',Line_width)
ax.YTick = [0, 0.2,0.4,0.6,0.8,1.0];
xlabel('$k$','Interpreter','latex','FontSize',16)
ylabel('$\eta$','Interpreter','latex','FontSize',16,'Rotation',0)
legend(ax,{'$\mathcal{M}=2/3$','$\mathcal{M}=1/2$','$\mathcal{M}=1/3$','$\mathcal{M}=1/4$','$\mathcal{M}=1/5$','$\mathcal{M}\to0$'},'Interpreter','latex','FontSize',14)

ax.YLabel.Rotation=0;

ax.XLabel.FontSize = 14;
ax.YLabel.FontSize = 14;

