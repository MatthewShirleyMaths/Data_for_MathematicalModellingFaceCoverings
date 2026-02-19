%% Fig 9


a= 2;

b= 1;

Lambda_f = [1.0, 0.07,0.0, 50, 0.6, 25.0, 0.55 ,0]; 

Lambda_g = [1.0, 0.02, 0.1, 51, 0.605, 15.0, 0.48 ,1e-2]; 


%%

epsilon = 1.2e-2;
b_dim = 9e-2; %metres


%% 

N_x = 400;
N_y = 200;

x = linspace(0,a,N_x);
y = linspace(0,b,N_y).';



F= @(x,y,Lambda)  exp( -(x-Lambda(1)).^2./(Lambda(2)+Lambda(3)*y) ).*Lambda(4).*(1-Lambda(5).*y)./(1+exp(-Lambda(6).*(y-Lambda(7))))+Lambda(8);

f = F(x,y,Lambda_f);
g = F(x,y,Lambda_g);


f_dim = b_dim*epsilon*f;
g_dim = b_dim*epsilon*g;


[X_dim,Y_dim]= meshgrid(b_dim*x,b_dim*y);


for j=1:3
%% 3D  Plotting

fig = figure;

set(gcf,'color','w');

col_f= 0.65*[1,1,1];

col_mask= [160,190,238]/255;


ax = axes;


surf(X_dim,f_dim,Y_dim,f_dim,'EdgeColor','none')
colormap('gray')
clim([-0.015,0.03])


hold on

surf(X_dim,g_dim,Y_dim,'EdgeColor','none','FaceColor',col_mask,'FaceAlpha',0.5)

ax.DataAspectRatio = [1 1 1];

%% Add mouth
mouth_x = b_dim*[0.852, 1.148,1.148,0.852,0.852];
mouth_y = b_dim*[0.275,0.275,0.325,0.325,0.275].';

mouth_z = epsilon*b_dim*F(mouth_x./b_dim,mouth_y./b_dim,Lambda_f);


%Surface mouth
[X_mouth,Y_mouth]= meshgrid(mouth_x,mouth_y);
f_mouth = epsilon*b_dim*F(mouth_x./b_dim,mouth_y./b_dim,Lambda_f)+1e-4;

surf(X_mouth,f_mouth,Y_mouth,'EdgeColor','none','FaceColor',[1,0,0]) % block


xlabel('$\hat{x} (m)$','FontSize',12,'Interpreter','latex')
ylabel('$\hat{z} (m)$','FontSize',12,'Interpreter','latex')
zlabel('$\hat{y} (m)$','FontSize',12,'Interpreter','latex',Rotation=0)


xlim([0, b_dim*a])
zlim([0, b_dim*b])



ax.XTick =[0, 0.06, 0.12, 0.18];
ax.ZTick = [0, 0.03, 0.06, 0.09];
ax.YTick = [0, 0.01, 0.02, 0.03];




if j==1
    view(90,0)
elseif j==2
    view(2)
elseif j==3
set(gca,'XDir','reverse')
ax.YAxis.TickValues=[0, 0.03];
% ax.YLabel.Position(2)=0.022;
% ax.YLabel.Position(3)=-0.004;
% 
% ax.XLabel.Position(1)=0.11;
% ax.XLabel.Position(3)=-0.012;
% ax.XLabel.Position(2)=0.03;

    campos([-0.4725    0.8265    0.2949])
end

end

