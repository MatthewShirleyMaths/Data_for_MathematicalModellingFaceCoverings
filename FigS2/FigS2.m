%% Make fig 7

fig = figure;
set(gcf,'color','w');
ax = axes;
set(gca,'Color',[1 1 1])
ax.FontSize = 14;
hold on
ax.TickLabelInterpreter='latex';

%% make corner mouth position boxes

% centres of mouth boxes
mouth_center_x_vec =[0.1580, 0.1580,1.8420,1.8420];
mouth_center_y_vec =[0.0350,0.9650,0.0350,0.9650];
%Mouth dimensions 2L_x, 2L_y
L_x = 0.148;
L_y = 0.025;


%define mouh plot style
MouthStyle = '--';
MouthLineThickness = 0.5;

%loop over mouths to plot
for s=1:length(mouth_plot_idx_y)
    %Add boxes for mouth position
    mouth_centre_x = mouth_center_x_vec(s);
    mouth_centre_y = mouth_center_y_vec(s);
    %Calculate verticies
    a1 = mouth_centre_x-L_x;
    a2 = mouth_centre_x+L_x;
    b1 = mouth_centre_y-L_y;
    b2 = mouth_centre_y+L_y;
    plot(ax,[a1 a2 a2 a1 a1], [b1 b1 b2 b2 b1],'Color',[0 0 0],'LineStyle',MouthStyle,'LineWidth',MouthLineThickness)

end


%% Countours

load("Fig7.mat")


contour(X_mesh,Y_mesh,eta,'ShowText','off')

grid(ax,'off')
ax.DataAspectRatio= [1 1 1];

ax.Box='on';
view(2)
cb = colorbar;
%Move colorbar to be horizontal at top of box
cb.Location = 'north';
%Move ticks to top
set(cb, 'YAxisLocation','top') 

cb.TickLabelInterpreter='latex';
cb.Label.String='$\eta$';
cb.Label.Interpreter='latex';

cb.Position(2) = cb.Position(2)-0.05;

xlim([0 a])
ylim([0 b])

xlabel('$E_{x}$','Interpreter','latex','FontSize',14)
ylabel('$E_{y}$','Interpreter','latex','FontSize',14,'Rotation',0)

cb.Location='northoutside';

