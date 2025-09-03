
components =1;

%% PLot results

Line_width= 1.0;

fig = figure;
fig.Position(3)=660;
set(gcf,'color','w');
ax = axes;
set(gca,'Color',[1 1 1])

load('Fig10_variable.mat')
semilogx(k_variable,eta,'-','LineWidth',Line_width)
hold on
semilogx(k_variable,eta_top-1e-3,'-','LineWidth',Line_width)
semilogx(k_variable,eta_bottom,'-','LineWidth',Line_width)
semilogx(k_variable,eta_hoz,'-','LineWidth',Line_width)

%PLot constant gap width data
load('Fig10_constant.mat')

% %PLot main data
semilogx(k_constant,eta,'k--','LineWidth',1.2*Line_width)



ax.YTick = [0, 0.2,0.4,0.6,0.8,1.0];


xlabel('$k$','Interpreter','latex','FontSize',16)
ylabel('$\eta$','Interpreter','latex','FontSize',16,'Rotation',0)

lgd = legend(ax,{'$\eta$  \hspace{4.5ex} ($h$ variable)','$\eta_{\mathrm{top}}$  \hspace{2.15ex} ($h$ variable)','$\eta_{\mathrm{bottom}}$  ($h$ variable)','$\eta_{\mathrm{hoz}}$ \hspace{2.15ex} ($h$ variable)','$\eta$ \hspace{4.7ex} ($h=1$)'},'Interpreter','latex','FontSize',14);
lgd.Location = 'northeastoutside';

ax.YLabel.Rotation=0;

ax.XLabel.FontSize = 14;
ax.YLabel.FontSize = 14;

ax.XLim = [1e-2 1e2];
ax.YLim = [0 1];

ax.FontSize = 12;
ax.YLabel.FontSize = 14;
ax.XLabel.FontSize = 14;


