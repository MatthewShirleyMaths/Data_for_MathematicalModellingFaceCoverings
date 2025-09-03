#Fig13

import numpy as np
import matplotlib.pyplot as plt

plt.rcParams['text.usetex'] = True

fontsize  = 11

plt.rc('font', size=fontsize)


flux_stretch = 1




flns = ["Fig13_r0p0.npz","Fig13_r0p01.npz","Fig13_r0p1.npz","Fig13_r0p2.npz"]

colours = ['k',
    "#0072BD",
    "#D95319",
    "#7E2F8E",
    "#77AC30",
    "#4DBEEE",
    "#A2142F"
] 

labels = ["No rounding", "Rounding=0.01", "Rounding= 0.1", "Rounding=0.2"]
labels = ["$r=0$","$r=0.01$","$r=0.1$","$r=0.2$"]


from matplotlib.gridspec import GridSpec

# Create a figure
fig = plt.figure(figsize=(8, 4))  # Adjust size as needed



ax1 = fig.add_axes([0.05 ,0.1, 0.65, 0.85])
ax2 = fig.add_axes([0.7, 0.1, 0.25, 0.5])

axes = [ax1,ax2]



#Loop over data
for i, fln in enumerate(flns):

    loaded = np.load(fln)

    boundary_coords= loaded['boundary_coords']
    q_vals = loaded['q_vals']

    #Split data into x and y components
    x_boundary_coords = boundary_coords[:,0] 
    y_boundary_coords = boundary_coords[:,1] 


    #Split flux 
    q_x = q_vals[:,0]
    q_y = q_vals[:,1]

    for ax in axes:
        ax.plot(np.append(x_boundary_coords, x_boundary_coords[0]),np.append(y_boundary_coords, y_boundary_coords[0]),color=colours[i],linestyle='-',label=labels[i])
        ax.plot(np.append(x_boundary_coords+flux_stretch*q_x, x_boundary_coords[0]+flux_stretch*q_x[0]),np.append(y_boundary_coords+flux_stretch*q_y, y_boundary_coords[0]+flux_stretch*q_y[0]),color=colours[i],linestyle='--')
        ax.set_aspect("equal")



ax2.set_xlim((1.8,2.1))
ax2.set_ylim((0.8,1.1))
from matplotlib.ticker import MultipleLocator
ax2.yaxis.set_major_locator(MultipleLocator(0.1))

ax2.legend(loc='lower center',bbox_to_anchor=(0.5,1.15),ncol=1)


for ax in axes:
    ax.set_xlabel('$x$',fontsize=fontsize)
    ax.set_ylabel('$y$',rotation=0,fontsize=fontsize)



ax1.set_yticks([0.0, 0.5, 1.0])


#For completion of all current layout commands
fig.canvas.draw()


#----------Create inset axes

#FIRST NEED TO CALCULATE Correct scale for figure
# Step 1: Get y-limits in data coordinates
ymin, ymax = ax1.get_ylim()

# Step 2: Transform y-limits to display coordinates (in pixels)
_, y_pix_min = ax1.transData.transform((0, ymin))
_, y_pix_max = ax1.transData.transform((0, ymax))

# Step 3: Transform to figure coordinates
_, y_fig_min = ax1.figure.transFigure.inverted().transform((0, y_pix_min))
_, y_fig_max = ax1.figure.transFigure.inverted().transform((0, y_pix_max))

# Step 4: Compute distance in figure units
y_distance_ax1_fig_units = y_fig_max - y_fig_min
#This gives the hgeiht of ax1 in figure units


# Define size of inset (as fraction of figure)
inset_height = 0.2

#Calculate the upper ylimit for inset 
y_max_inset_ax = inset_height/y_distance_ax1_fig_units * (ymax-ymin)/flux_stretch

#Set x location of inset axes in ax1 coordinates
x_ax1ccord = 0.5
# Transform data (1,1) to figure coordinates
x_display, y_display = ax1.transData.transform((x_ax1ccord, 1))  # to pixels
x_fig, y_fig = fig.transFigure.inverted().transform((x_display, y_display))  # to figure coords


# Add inset axes starting at (x=1, y=1) in data space
inset_ax = fig.add_axes([x_fig, y_fig, 0, inset_height])

# Example plot in inset
inset_ax.xaxis.set_visible(False)
inset_ax.set_ylabel('$\\bf{q}$',rotation=0)

inset_ax.set_ylim((0.0,flux_stretch*y_max_inset_ax))
inset_ax.set_yticks([0.0, 0.2, 0.4])

#For completion of all current layout commands
fig.canvas.draw()


ax1.annotate("", xytext=(x_ax1ccord, 1), xy=(x_ax1ccord, 1.6),
            arrowprops=dict(arrowstyle="->",lw =1.0))

##REctangle
from matplotlib.patches import Rectangle
from matplotlib.lines import Line2D

# Define rectangle in data coordinates of ax1
rect_x, rect_y = 1.8, 0.8
rect_w, rect_h = 0.3, 0.3

# Add rectangle to ax1
rect = Rectangle((rect_x, rect_y), rect_w, rect_h,
                 linewidth=1.0, edgecolor='black', facecolor='none')
ax1.add_patch(rect)

# Transform rectangle corners from data to figure coordinates
data_corners = [
    (rect_x, rect_y),                             # bottom-left
    (rect_x + rect_w, rect_y),                    # bottom-right
    (rect_x, rect_y + rect_h),                    # top-left
    (rect_x + rect_w, rect_y + rect_h),           # top-right
]
rect_corners_display = [ax1.transData.transform(p) for p in data_corners]
rect_corners_fig = [fig.transFigure.inverted().transform(p) for p in rect_corners_display]


# ax2 corners in axes coordinates → transform to figure coordinates
ax2_corners_axes = [
    (0, 0), (1, 0),  # bottom-left, bottom-right
    (0, 1), (1, 1),  # top-left, top-right
]
ax2_corners_display = [ax2.transAxes.transform(p) for p in ax2_corners_axes]
ax2_corners_fig = [fig.transFigure.inverted().transform(p) for p in ax2_corners_display]

i=0
# Draw lines between each corresponding corner
for rc_fig, a2_fig in zip(rect_corners_fig, ax2_corners_fig):
    if i== 1 or i==2:
        i+=1
        continue

    line = Line2D(
        [rc_fig[0], a2_fig[0]],
        [rc_fig[1], a2_fig[1]],
        transform=fig.transFigure,
        color='black',
        linewidth=1.0,
    )
    fig.lines.append(line)
    i+=1



plt.show()