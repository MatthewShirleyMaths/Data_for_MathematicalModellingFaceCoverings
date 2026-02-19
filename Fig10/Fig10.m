%Fig11

%%
f = tiledlayout(1,3);

f.Padding = 'compact';
f.TileSpacing = 'compact';

set(gcf,'Color','w')


ax= {}; %empty cell arry to stor

ax{1} = nexttile(1);

ax{2} = nexttile(2);

ax{3} = nexttile(3);


%Increase size of plot
f.Parent.Position(3)=1.7*f.Parent.Position(3);


%% Fix hold on on all axes
for jj=1:3
    hold(ax{jj},'on')
end

%% Plot data for legend


%Define colours
col_blue = [0 0.4470 0.7410];
col_red = [0.8500 0.3250 0.0980];	
col_blck = [0, 0, 0]; 

lgd_idx = 1;

plot(ax{lgd_idx},[-1, -1],[-1,-2],'LineWidth',1,'Color',col_blue)
plot(ax{lgd_idx},[-1, -1],[-1,-2],'LineWidth',1,'Color',col_red)
plot(ax{lgd_idx},[-1, -1],[-1,-2],'LineWidth',1,'Color',col_blck)


%% Plot patches


k_mask_nominal = 4.5447;
k_gaiter_nominal = 10.1623;



k_mask_min = 1.3698;
k_mask_max = 7.2168;

k_gaiter_min = 3.063;
k_gaiter_max = 16.137;

x_patch_mask = [k_mask_min, k_mask_max, k_mask_max,k_mask_min];
y_patch_mask = [-1, -1, 2, 2];

x_patch_gaiter = [k_gaiter_min, k_gaiter_max, k_gaiter_max,k_gaiter_min];
y_patch_gaiter = [-1, -1, 2, 2];

for jj=1:3
    patch(ax{jj},x_patch_mask,y_patch_mask,0.5*[1,1,1],'FaceAlpha',.35,'EdgeColor','none')
    patch(ax{jj},x_patch_gaiter,y_patch_gaiter,'green','FaceAlpha',.35,'EdgeColor','none')

    xline(ax{jj},k_mask_nominal,'LineWidth',1.0,'Color',0.3*[1,1,1])    
    xline(ax{jj},k_gaiter_nominal,'--','LineWidth',1.0,'Color',0.8*[0.4660    0.6740    0.1880])
end



%% PLot curves


dat_names={'Fig11_Gamma0p4.mat','Fig11_Gamma1p0.mat','Fig11_Gamma2p5.mat'};
Gamma0 = [0.4, 1.0,2.5];

for jj=1:3
    %load
    load(dat_names{jj})

    ax{jj}.FontSize = 14;
    plot(ax{jj},k,eta,'LineWidth',1,'Color',col_blue)
    hold on
    plot(ax{jj},k,FE,'LineWidth',1,'Color',col_red)
    plot(ax{jj},k,FFE,'LineWidth',1,'Color',col_blck)



    xlabel(ax{jj},'$k$','Interpreter','latex','FontSize',14)


    title(ax{jj},strcat('$\Gamma_0=',num2str(Gamma0(jj)),'$'),'FontSize',14,'Interpreter','latex')
    ylim(ax{jj},[0 1])
end


%Define legend

lgd=legend(ax{lgd_idx},{'$\eta$','$FE$','$FFE$'},'FontSize',14,'Location','northeast','Interpreter','latex');
lgd.AutoUpdate="off";
lgd.Location = 'northwest';

lgd.Position(2)=0.95*lgd.Position(2);

%set x scale
for jj=1:3
    ax{jj}.XScale='log';
    ax{jj}.Box='on';
    ax{jj}.XLim=[1e-2 1e2];
    ax{jj}.TickLength=1.5*ax{jj}.TickLength;
end

%% Tidy layout

f.Parent.Position(3)=1052;
text(ax{1},1.5,0.95,'Mask','Interpreter','latex','FontSize',14)
text(ax{1},3.15,0.88,'Gaiter','Interpreter','latex','FontSize',14)
