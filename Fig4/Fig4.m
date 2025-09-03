
%% Load data
load('Fig4.mat')

%% Make figure
fig = figure;
set(gcf,'color','w');
fig.Units = 'centimeters'; %Convert units of figure to centimetres


%Calculate aspect ratio of mask
asp_rat = b/a;
% 
%calculate max value for plotting
max_val_actual = max([max(abs(Q),[],'all'),max(abs(q_x(:,N_x))),max(abs(q_x(:,1))),max(abs(q_y(N_y,:))),max(abs(q_y(1,:)))]);

max_val_axes = 1.05*max_val_actual; %If setting manually



ax_main =axes;
surf(ax_main,X,Y,Q,'EdgeColor','none');

%Change the colourmap limits
clim(ax_main,[0, max_val_axes]);

ax_main.DataAspectRatio = [1 1 1];
ax_main.DataAspectRatioMode='manual'; %Turn of auto data rescale
ax_main.Units='centimeters'; %Change ax_main units to cms. This disables rescaling
ax_main.XTick=[];
ax_main.YTick=[];
view(ax_main,2)
cb_main = colorbar('southoutside');
cb_main.Units='centimeters';
cb_main.TickLabelInterpreter='latex';
cb_main.FontSize=14;
cb_main.Label.String = '$Q$';
cb_main.Label.Interpreter='latex';

%Resize fig
fig_height = 14;%Height of figure in centimetres
fig.Position(4) = fig_height;
fig.Position(3) = fig_height/asp_rat;


%Move main axes to centre of figure
ax_main.Position(1) = fig.Position(3)/2-ax_main.Position(3)/2;
ax_main.Position(2) = fig.Position(4)/2-ax_main.Position(4)/2;

%Calculate tight position of ax_main
ax_main_tight_pos = tightPosition(ax_main);


%% ADD position of mouth

MouthBox_width = 0.75;
hold on
a1 = E_x-L_x;
a2 = E_x+L_x;
b1 = E_y -L_y;
b2 = E_y + L_y;

plot3([a1 a1],[b1 b2],10*ones(1,2),'r--','LineWidth',MouthBox_width)
plot3([a1 a2],[b1 b1],10*ones(1,2),'r--','LineWidth',MouthBox_width)
plot3([a2 a2],[b1 b2],10*ones(1,2),'r--','LineWidth',MouthBox_width)
plot3([a1 a2],[b2 b2],10*ones(1,2),'r--','LineWidth',MouthBox_width)

%%

%Stretch figure height
fig.Position(4)=1.25*fig.Position(4);
fig.Position(2) = 0; %Make fit on screen

%% Set line plot style

%LinePlotSty=  'flat'; %If want single colour lines
LinePlotSty = 'colour'; %If want line colour to match colormap of surface

LinePlotWidth = 1.5;

%% Add top axes

ax_top = axes;
ax_top.Units='centimeters';
ax_top.DataAspectRatioMode='manual';

% PLot flux out of the top
if strcmp(LinePlotSty,'flat')==1
    plot(ax_top,x,q_y(N_y,:),'-','LineWidth',1);
elseif strcmp(LinePlotSty,'colour')==1
    pl_top=plot(ax_top,x,q_y(N_y,:),'-','LineWidth',1); %Add normal plot
    pl_top.Visible='off'; %Make plot invisible
    %Use patch to make multicoloured line. 
    %Add NaN final value so makes line not polygon
    patch(ax_top,[x,x(end)],[q_y(N_y,:),NaN],[q_y(N_y,:),NaN],'EdgeColor','interp','LineWidth',LinePlotWidth);
    clim(ax_top,[0,max_val_axes])
end

ax_top.TickLabelInterpreter='latex';
ax_top.FontSize = 14;
ax_top.YAxis.Label.Interpreter = 'latex';
ax_top.YAxis.Label.String='$q_{y}$';
ax_top.YAxis.Label.Rotation = 0;

ax_top.YLim =[0, max_val_axes];

ax_top.Position = [ax_main_tight_pos(1),ax_main_tight_pos(2)+ax_main_tight_pos(4),ax_main_tight_pos(3),3]; %This sets x-position correctly
ax_top.OuterPosition = [ax_top.OuterPosition(1),ax_main_tight_pos(2)+ax_main_tight_pos(4),ax_top.OuterPosition(3),ax_top.OuterPosition(4)];
ax_top_tight_pos = tightPosition(ax_top,IncludeLabels=true); %Calculate position containing labels
ax_top.Position(2) = ax_top.Position(2)- (ax_top_tight_pos(2)-ax_top.OuterPosition(2));  %Fix bottom y position correctly

ax_top.XAxis.TickDirection = 'both';
ax_top.Box='off';


%% Add right axes

ax_right = axes;
ax_right.Units='centimeters';
ax_right.DataAspectRatioMode='manual';




% PLot flux out of the right
if strcmp(LinePlotSty,'flat')==1
    plot(ax_right,q_x(:,N_x),y,'-','LineWidth',1);
elseif strcmp(LinePlotSty,'colour')==1
    pl_right=plot(ax_right,q_x(:,N_x),y,'-','LineWidth',1); %Add normal plot
    pl_right.Visible='off'; %Make plot invisible
    %Use patch to make multicoloured line.
    %Add NaN final value so makes line not polygon
    patch(ax_right,[q_x(:,N_x);NaN],[y;y(end)],[q_x(:,N_x);NaN],'EdgeColor','interp','LineWidth',LinePlotWidth);
    clim(ax_right,[0,max_val_axes])
end



ax_right.XAxisLocation='top';
ax_right.TickLabelInterpreter='latex';
ax_right.FontSize = 14;
ax_right.XAxis.Label.Interpreter = 'latex';
ax_right.XAxis.Label.String='$q_{x}$';

ax_right.XLim =[0, max_val_axes];


ax_right.Position = [ax_main_tight_pos(1)+ax_main_tight_pos(3),ax_main_tight_pos(2),3,ax_main_tight_pos(4)]; %Fix y position
ax_right_tight_pos = tightPosition(ax_right,IncludeLabels=true); %Calculate position including labels

ax_right.Position(1) = ax_right.Position(1) + ax_right.Position(1) - ax_right_tight_pos(1);



ax_right.YAxis.TickDirection = 'both';
ax_right.Box='off';

%% Add left axis

ax_left = axes;
ax_left.Units='centimeters';
ax_left.DataAspectRatioMode='manual';



% PLot flux out of the left
if strcmp(LinePlotSty,'flat')==1
    plot(ax_left,q_x(:,1),y,'-','LineWidth',1);
elseif strcmp(LinePlotSty,'colour')==1
    pl_left=plot(ax_left,q_x(:,1),y,'-','LineWidth',1); %Add normal plot
    pl_left.Visible='off'; %Make plot invisible
    %Use patch to make multicoloured line.
    %Add NaN final value so makes line not polygon
    patch(ax_left,[q_x(:,1);NaN],[y;y(end)],abs([q_x(:,1);NaN]),'EdgeColor','interp','LineWidth',LinePlotWidth); %Absolute value
    clim(ax_left,[0,max_val_axes])
end




ax_left.TickLabelInterpreter='latex';
ax_left.FontSize = 14;

ax_left.XAxisLocation='top';
ax_left.YAxisLocation='right';
ax_left.XDir = 'normal';
ax_left.XAxis.Label.Interpreter = 'latex';
ax_left.XAxis.Label.String='$q_{x}$';

ax_left.XLim =[-max_val_axes, 0];


ax_left.Position = [ax_main_tight_pos(1)-3,ax_main_tight_pos(2),3,ax_main_tight_pos(4)]; %This sets x-position correctly
ax_left.Position(4) = ax_main_tight_pos(4); %Set height correctly

ax_left_tight_pos = tightPosition(ax_left,IncludeLabels=true); %Calculate position including labels
ax_left.Position(1) = ax_main.Position(1) - ax_left_tight_pos(2);

ax_left.YAxis.TickDirection = 'both';
ax_left.Box='off';


ax_left.YAxis.Label.Interpreter = 'latex';
ax_left.YAxis.Label.String='$y$';
ax_left.YLabel.Rotation=0;

%% add bottom axes

ax_bottom = axes;
ax_bottom.Units='centimeters';
ax_bottom.DataAspectRatioMode='manual';

% PLot flux out of the top
if strcmp(LinePlotSty,'flat')==1
    plot(ax_bottom,x,q_y(1,:),'-','LineWidth',1);
elseif strcmp(LinePlotSty,'colour')==1
    pl_top=plot(ax_bottom,x,q_y(1,:),'-','LineWidth',1); %Add normal plot
    pl_top.Visible='off'; %Make plot invisible
    %Use patch to make multicoloured line. 
    %Add NaN final value so makes line not polygon
    patch(ax_bottom,[x,x(end)],[q_y(1,:),NaN],abs([q_y(1,:),NaN]),'EdgeColor','interp','LineWidth',LinePlotWidth);  %Absolute value colour
    clim(ax_bottom,[0,max_val_axes])
end


ax_bottom.TickLabelInterpreter='latex';
ax_bottom.FontSize = 14;
ax_bottom.YAxis.Label.Interpreter = 'latex';
ax_bottom.YAxis.Label.String='$q_{y}$';
ax_bottom.YAxis.Label.Rotation = 0;

ax_bottom.XAxisLocation='top';
ax_bottom.YAxisLocation='right';
ax_bottom.YDir = 'normal';

ax_bottom.YLim =[-max_val_axes, 0];


ax_bottom.Position = [ax_main_tight_pos(1),ax_main_tight_pos(2)-3,ax_main_tight_pos(3),3]; %This sets x-position correctly
ax_bottom_tight_pos = tightPosition(ax_bottom,IncludeLabels=true); %Calculate position including  lables
ax_bottom.Position(2) = ax_bottom.Position(2)+ax_bottom.Position(4)-ax_bottom_tight_pos(4);

ax_bottom.XAxis.TickDirection = 'both';
ax_bottom.Box='off';


ax_bottom.XAxis.Label.Interpreter = 'latex';
ax_bottom.XAxis.Label.String='$x$';




ax_bottom.Box ='on';
ax_top.Box ='on';
ax_left.Box ='on';
ax_right.Box='on';

ax_top.XAxisLocation='top';
ax_left.YAxisLocation='left';
ax_right.YAxisLocation='right';
ax_bottom.XAxisLocation='bottom';
ax_left.XAxisLocation='bottom';

ax_top.Position(2) = ax_top.Position(2)+1;
ax_main.Position(2) = ax_main.Position(2)+1;
ax_bottom.Position(2) = ax_bottom.Position(2)+1;
ax_left.Position(2) = ax_left.Position(2)+1;
ax_right.Position(2) = ax_right.Position(2)+1;



cb_main.Location='eastoutside';
cb_main.Position(1)=cb_main.Position(1)+4.8;
cb_main.Position(4) = cb_main.Position(4) + 1*(cb_main.Position(4)-cb_main.Position(2));
cb_main.Label.Rotation = 0;


%% Rearrange Figure


move_amount = 0.5;

ax_top.Position(2) = ax_top.Position(2) - move_amount;
ax_bottom.Position(2)=ax_bottom.Position(2) + move_amount;
ax_left.Position(1)=ax_left.Position(1)+ move_amount;
ax_right.Position(1)=ax_right.Position(1)- move_amount;

cb_main.Location='northoutside';
cb_main.Position(2) = 15.5;

ticklengths = 0.02*ones(1,2);

ax_bottom.TickLength = 0.75*ticklengths;
ax_top.TickLength = 0.75*ticklengths;
ax_left.TickLength = ticklengths;
ax_right.TickLength = ticklengths;

ax_bottom.TickDir ='in';
ax_top.TickDir ='in';
ax_left.TickDir ='in';
ax_right.TickDir ='in';


