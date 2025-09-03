%%Plot comparision of rectangular and elliptic mouht shape


% Mask occupies region [0,a]*[0,b]
%Mouth is [a1,a2]*[b1,b2]


%% PLot
fig = figure;
fig.Units='pixels';
fig.Position = [488   242   560   530];


set(gcf,'color','w');
ax = axes('Position',[0.5 0.5 0.1 0.1]); %Position axis at dummy posisition in normalised units
ax.Units='pixels';
ax.Position = [73.8 60 434 342.3];
set(gca,'Color',[1 1 1])


ax.FontSize = 14;

N_sweep=2;
SweepName={'Fig14b_rectangle.mat','Fig14b_ellipse.mat'};

LineStyle={'-','--'};

LineColour = {[0    0.4470    0.7410],[0.8500    0.3250    0.0980],...
    [0.9290    0.6940    0.1250],[0.4940    0.1840    0.5560],...
    [0.4660    0.6740    0.1880],[0.3010    0.7450    0.9330]};

%Data for legend
for ij=1:3
    semilogx(ax,[10^4,10^4],[10^3,10^3],LineStyle{1},'LineWidth',1,'Color',LineColour{ij})
    hold on
    semilogx(ax,[10^4,10^4],[10^3,10^3],LineStyle{2},'LineWidth',1,'Color',LineColour{3+ij})    
end

lgd=legend(ax,{'$\eta$','$\eta$','$\eta_{\mathrm{vert}}$','$\eta_{\mathrm{vert}}$','$\eta_{\mathrm{hoz}}$ (Rectangle)','$\eta_{\mathrm{hoz}}$ (Ellipse)'},'FontSize',13,'Location','northeast','Interpreter','latex');
lgd.AutoUpdate="off";
lgd.NumColumns=3;

%% Plot data
for i=1:N_sweep
    %Load in data
    load(SweepName{i});

    semilogx(ax,aspect_ratio_vec,eta,LineStyle{i},'LineWidth',1,'Color',LineColour{3*(i-1)+1})
    hold on
    semilogx(aspect_ratio_vec,eta_vert,LineStyle{i},'LineWidth',1,'Color',LineColour{3*(i-1)+2})
    semilogx(aspect_ratio_vec,eta_hoz,LineStyle{i},'LineWidth',1,'Color',LineColour{3*(i-1)+3})

end


ax.TickLabelInterpreter='latex';
ax.FontSize = 14;

xlabel('Mouth Aspect Ratio','Interpreter','latex','FontSize',14)
ylabel('$\eta$','Interpreter','latex','FontSize',14)



%% Plot shapes1

%Preallocate cell array to store axes
ax_top1 = {};

pic_pos_x = [0.14, 0.36, 0.58, 0.80];
pic_pos_xwidth = 0.2;

pic_pos_y1 = 0.9;
pic_pos1 = {[pic_pos_x(1) pic_pos_y1 pic_pos_xwidth 0.1],[pic_pos_x(2) pic_pos_y1 pic_pos_xwidth 0.1],[pic_pos_x(3) pic_pos_y1 pic_pos_xwidth 0.1],[pic_pos_x(4) pic_pos_y1 pic_pos_xwidth 0.1]}; %3 figures

%pic_idx = [1,(N_shapes+1)/2,N_shapes]; %Use mesh 

col_blue= [0.7137    0.8118    0.9922];
col_red = [0.8500    0.3250    0.0980];

%Create axes
for j=1:4
    ax_top1{j} =axes('Position',pic_pos1{j});
end


%Specify aspect ratios to plot manuallly
%aspect_ratio_pics = [10^(-1.5), 1, 10^2]; %OLD VERSION
aspect_ratio_pics = [10^(-1), 1, 10^1, 10^2];


%Add pictures of masks

for j=1:4
    ax_top1{j}.Visible='off';

    % IF using mesh to specify
    % a1=a1_vec(pic_idx(j));
    % a2=a2_vec(pic_idx(j));
    % b1=b1_vec(pic_idx(j));
    % b2=b2_vec(pic_idx(j));

    %If manually specifying shapes
    a=2;
    b=1;
    Area_mouth = 0.025;
    mouth_centre_x = 1.0;
    mouth_centre_y  =0.5;

    L_x = sqrt(Area_mouth*aspect_ratio_pics(j));
    Ly = sqrt(Area_mouth./aspect_ratio_pics(j));
    %Calculate verticies
    a1 = mouth_centre_x-0.5*L_x;
    a2 = mouth_centre_x+0.5*L_x;
    b1 = mouth_centre_y-0.5*Ly;
    b2 = mouth_centre_y+0.5*Ly;



    patch(ax_top1{j},[0 a a 0],[0 0 b b],col_blue,'EdgeColor','none')
    patch(ax_top1{j},[a1 a2 a2 a1],[b1 b1 b2 b2],col_red,'EdgeColor','none')
    ax_top1{j}.DataAspectRatio=[1 1 1]; %Force aspect ratio of diagrams

    ax_top1{j}.Position(1)=pic_pos_x(j);
end


xlim(ax,[10^-(1.5), 100])



%% Plot shapes2

%Preallocate cell array to store axes
ax_top2 = {};

pic_pos_y2 = 0.78;
pic_pos2 = {[pic_pos_x(1) pic_pos_y2 pic_pos_xwidth 0.1],[pic_pos_x(2) pic_pos_y2 pic_pos_xwidth 0.1],[pic_pos_x(3) pic_pos_y2 pic_pos_xwidth 0.1],[pic_pos_x(4) pic_pos_y2 pic_pos_xwidth 0.1]}; %3 figures

%pic_idx = [1,(N_shapes+1)/2,N_shapes]; %Use mesh 

col_blue= [0.7137    0.8118    0.9922];
col_red = [0.8500    0.3250    0.0980];

%Create axes
for j=1:4
    ax_top2{j} =axes('Position',pic_pos2{j});
end


%Specify aspect ratios to plot manuallly
%aspect_ratio_pics = [10^(-1.5), 1, 10^2]; %OLD VERSION
aspect_ratio_pics = [10^(-1), 1, 10^1, 10^2];


%Add pictures of elliptical mouths
%Since ellipse need lots of points
theta = linspace(0,2*pi,64);


for j=1:4
    ax_top2{j}.Visible='off';

    %Get semimajor and semiminor axes
    %If using endpoints sweep
    % R_x=R_x_vec(pic_idx(j));
    % R_y=R_y_vec(pic_idx(j));
    %Custom values
    R_x= sqrt(Area_mouth*aspect_ratio_pics(j)./pi);
    R_y = sqrt(Area_mouth./(pi*aspect_ratio_pics(j)));


    x_pic = mouth_centre_x+R_x*cos(theta);
    y_pic = mouth_centre_y+R_y*sin(theta);

    patch(ax_top2{j},[0 a a 0],[0 0 b b],col_blue,'EdgeColor','none')
    patch(ax_top2{j},x_pic,y_pic,col_red,'EdgeColor','none')

    ax_top2{j}.DataAspectRatio=[1 1 1]; %Force aspect ratio of diagrams
end


xlim(ax,[10^-(1.5), 100])

%% SAVE RESULTS
%save('Sweep3D_rectangle_12_12_23','a','a1','a2','b','b1','b2','cons_mass','flux_bottom_vec','flux_in_vec','flux_leak_vec','flux_left_vec','flux_mask_vec','flux_right_vec','flux_top_vec','aspect_ratio_vec','m_max','n_max','N_Lambda','r_x','r_y')
