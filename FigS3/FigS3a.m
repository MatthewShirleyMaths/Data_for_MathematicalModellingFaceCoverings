%Fig14a


%% Plot compariosn

%Define Colours
LineColour = {[0    0.4470    0.7410],[0.8500    0.3250    0.0980],...
    [0.9290    0.6940    0.1250],[0.4940    0.1840    0.5560],...
    [0.4660    0.6740    0.1880],[0.3010    0.7450    0.9330]};


LineStyle={'-','--'};


%% PLot
fig = figure;
set(gcf,'color','w');
ax = axes;
set(gca,'Color',[1 1 1])


ax.FontSize = 14;

%Data for legend
for ij=1:3
    semilogx(ax,[10^4,10^4],[10^3,10^3],LineStyle{1},'LineWidth',1,'Color',LineColour{ij})
    hold on
    semilogx(ax,[10^4,10^4],[10^3,10^3],LineStyle{2},'LineWidth',1,'Color',LineColour{3+ij})    
end

lgd=legend(ax,{'$\eta$','$\eta$','$\eta_{\mathrm{vert}}$','$\eta_{\mathrm{vert}}$','$\eta_{\mathrm{hoz}}$ (Rectangle)','$\eta_{\mathrm{hoz}}$ (Ellipse)'},'FontSize',13,'Location','northeast','Interpreter','latex');
lgd.AutoUpdate="off";
lgd.NumColumns=3;


%% PLot data

load("Fig14a.mat")

semilogx(ax,k,eta_rect,'-','LineWidth',1,'Color',LineColour{1})

semilogx(ax,k,eta_rect_vert,'-','LineWidth',1,'Color',LineColour{2})
semilogx(ax,k,eta_rect_hoz,'-','LineWidth',1,'Color',LineColour{3})

xlabel('$k$','Interpreter','latex','FontSize',14)
ylabel('$\eta$','Interpreter','latex','FontSize',14)


semilogx(k,eta_ell,'--','LineWidth',1,'Color',LineColour{4})
semilogx(k,eta_ell_vert,'--','LineWidth',1,'Color',LineColour{5})
semilogx(k,eta_ell_hoz,'--','LineWidth',1,'Color',LineColour{6})



%%

xlim([1e-2 1e2])
ylim([0 1.2])
lgd.Position(2)= 1.015*lgd.Position(2);
