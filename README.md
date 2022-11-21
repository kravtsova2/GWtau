The folder "GWtau_tutorial" contains the following:
The main (Matlab) code file 'gwtau_tutorial_main.m' loads the trajectory data from Ignacio et al. 2022 (file 'Ignacio2022.mat') and computes matrix of GWtau distances between the trajectories using two functions: 'vec_geo_dist.m' and 'wass_sorted.m'.

The folder "FGW barycenters" constains the follwing:
The main (Python) code file 'compute_FGW_bary.py' loads the trajectory data from Ignacio et al. 2022 (files 'WT.txt','GPB1.txt', and 'LET99.txt' for three groups of trajectories, respectively) and computes Fused Gromov-Wassserstein barycenter for a given group of trajectories

The folder "Embedding with GWtau" constains the following:
The main (R) code 'Lotka_Volterra.R' loads distance matrices ('LVGW.dat','LVDT.dat', and 'LVE.dat' for GWtau, Dynamic Time Warping, and Euclidean dsitances, respectively) and computes and plots MDS embedding (choose metric or non-metric option by uncommenting the lines). Cluster tree can be also constructed and plotted, as well as 3d plot of representative trajectory for each of the 3 classes discussed in the paper (please run selected lines to see required plots). 
