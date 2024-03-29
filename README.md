This is the set of codes serving as Supplementary Information for "Scalable Gromov-Wasserstein based comparison of biological time series" by Natalia Kravtsova, Reginald L. McGee II, and Adriana T. Dawes (accepted in Bulletin of Mathematical Biology). Detailed description for each folder is given below.  

The folder "GWtau_tutorial" contains the following:
The main (Matlab) code file 'gwtau_tutorial_main.m' loads the trajectory data from Ignacio et al. 2022 (file 'Ignacio2022.mat') and computes matrix of GWtau distances between the trajectories using two functions: 'vec_geo_dist.m' and 'wass_sorted.m'.
Reference: 
Ignacio, D.P., Kravtsova, N., Henry, J., Palomares, R.H., Dawes, A.T. (2022).
Dynein localization and pronuclear movement in the C. elegans zygote.
Cytoskeleton 79(12), 133-143


The folder "FGW barycenters" constains the following:
The main (Python) code file 'compute_FGW_bary.py' loads the trajectory data from Ignacio et al. 2022 (files 'WT.txt','GPB1.txt', and 'LET99.txt' for three groups of trajectories, respectively) and computes Fused Gromov-Wassserstein barycenter from Vayer et al. 2020 for a given group of trajectories
Reference:
Vayer, T., Chapel, L., Flamary, R., Tavenard, R., Courty, N. (2020). Fused Gromov-Wasserstein distance for structured objects. Algorithms, 13 (9),
212.


The folder "Embedding with GWtau" contains the following:
The main (R) code 'Lotka_Volterra.R' loads distance matrices corresponding to simulated data from the model of Xiao and Li 2000 ('LVGW.dat','LVDT.dat', and 'LVE.dat' for GWtau, Dynamic Time Warping, and Euclidean dsitances, respectively) and computes and plots MDS embedding (choose metric or non-metric option by uncommenting the lines). Cluster tree can be also constructed and plotted, as well as 3d plot of representative trajectory ('Lotka1.dat','Lotka2.dat',and 'Lotka3.dat') for each of the 3 classes discussed in the paper (please run selected lines to see plots of interest). 
Reference:
Xiao, D., & Li, W. (2000). Limit cycles for the competitive three dimensional
Lotka–Volterra system. Journal of Differential Equations, 164 (1), 1–15


The folder "1-Nearest Neighbor on UCR archive"contains the Matlab code (with all needed functions inside) to reproduce the results of Table 1 of the paper, i.e. the 1-Nearest Neighbor classification of time series from UCR Time Series Classification Archive (accessed at: https://www.cs.ucr.edu/~eamonn/time_series_data_2018/).
Reference: Hoang Anh Dau, Eamonn Keogh, Kaveh Kamgar, Chin-Chia Michael Yeh, Yan Zhu, Shaghayegh Gharghabi , Chotirat Ann Ratanamahatana, Yanping Chen, Bing Hu, Nurjahan Begum, Anthony Bagnall , Abdullah Mueen, Gustavo Batista, & Hexagon-ML (2019). The UCR Time Series Classification Archive. URL https://www.cs.ucr.edu/~eamonn/time_series_data_2018/


The folder "TLB comparison" contains the following: 
The main (Matlab) code file 'TLB_GW_GWtau_comparison_main.m' loads data from Ignacio et al. 2022 (file 'Ignacio2022.mat') and GW matrix (file 'gw.mat') computed in Python (code to compute it is the file 'compute_gw.py' that uses data file 'WOBBLE.txt'). The code computes matrices of TLB's from Memoli 2011 and GWtau's between trajectories using 3 functions: 'my_geo.m' (needed for TLB) and 'vec_geo_dist.m' and 'wass_sorted.m' (needed for GWtau). The code also plots matrices of TLB, GW, and GWtau.
References:
Memoli, F. (2011). Gromov-Wasserstein distances and the metric approach
to object matching. Found. Comput. Math., 11 (4), 417–487.
Chowdhury, S., & Memoli, F. (2019). The Gromov–Wasserstein distance
between networks and stable network invariants. Information and
Inference: A Journal of the IMA, 8 (4), 757-787.
