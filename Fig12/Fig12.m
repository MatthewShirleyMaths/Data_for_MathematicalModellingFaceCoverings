%Fig12

%% Load data
load('Fig12.mat')


k0 = 14.52;


%%Make Plot
f = tiledlayout(1,2);

f.Padding = 'compact';
f.TileSpacing = 'compact';

set(gcf,'Color','w')


ax= {}; %empty cell arry to stor

ax{1} = nexttile(1);

ax{2} = nexttile(2);



%Increase size of plot
f.Parent.Position(3)=1.3*f.Parent.Position(3);


%% Fix hold on on all axes
for jj=1:2
    hold(ax{jj},'on')
    ax{jj}.FontSize = 12;
    xlabel(ax{jj},'$\Gamma_{0}$','Interpreter','latex','FontSize',14)
    ax{jj}.XLim = [1e-3 1e2];
    
end


%% PLot typical lines


k_mask_nominal =     4.5447;
k_gaiter_nominal =   10.1623;



%% Plot patches

k_mask_min = 1.3698;
k_mask_max = 7.2168;

k_gaiter_min = 3.063;
k_gaiter_max = 16.137;


x_patch_mask = [1e-3, 1e2, 1e2, 1e-3];
y_patch_mask = [k_mask_min,k_mask_min,k_mask_max,k_mask_max];

x_patch_gaiter = [1e-3, 1e2, 1e2, 1e-3];
y_patch_gaiter = [k_gaiter_min,k_gaiter_min,k_gaiter_max,k_gaiter_max];


patch(ax{1},x_patch_mask,y_patch_mask,0.5*[1,1,1],'FaceAlpha',.35,'EdgeColor','none')
patch(ax{1},x_patch_gaiter,y_patch_gaiter,'green','FaceAlpha',.35,'EdgeColor','none')

yline(ax{1},k_mask_nominal,'LineWidth',1.0,'Color',0.3*[1,1,1])

yline(ax{1},k_gaiter_nominal,'--','LineWidth',1.0,'Color',0.8*[0.460    0.8   0.180])








%%
ylabel(ax{1},'$k^*$','Interpreter','latex','FontSize',14,'Rotation',0);


%Define colours
col_blue = [0 0.4470 0.7410];
col_red = [0.8500 0.3250 0.0980];	
col_blck = [0,0,0]; 

load("Fig12.mat")

plot(ax{1},Gamma0_vec,k_opt_vec,'LineWidth',1,'Color',[0 0 0])

plot(ax{2},Gamma0_vec,eta_opt_vec,'LineWidth',1,'Color',col_blue);
plot(ax{2},Gamma0_vec,FE_opt_vec,'LineWidth',1,'Color',col_red);
plot(ax{2},Gamma0_vec,FFE_opt_vec,'LineWidth',1,'Color',col_blck);


ax{1}.XScale ='log';
ax{2}.XScale ='log';

ax{2}.YLim = [0 1];

ax{1}.Box = 'on';
ax{2}.Box = 'on';

for jj=1:2
        ax{jj}.TickLength=1.5*ax{jj}.TickLength;
        ax{jj}.XLim = [1e-2 30];
end

ax{1}.YLim = [0 35];

for jj=1:2
    ax{jj}.XLabel.FontSize=14;
    ax{jj}.YLabel.FontSize=14; 
end

%% Define legend
lgd=legend(ax{2},{'$\eta^*$','$FE^*$','$FFE^*$'},'FontSize',14,'Location','northeast','Interpreter','latex');

lgd.AutoUpdate="off";
lgd.Location = 'northwest';

lgd.Position(2)=0.95*lgd.Position(2);

%%
text(ax{1},5,3.2,'Mask','Interpreter','latex','FontSize',14)
text(ax{1},5,7.1,'Gaiter','Interpreter','latex','FontSize',14)
