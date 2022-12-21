### This code takes a matrix whose columns are trajectories from the Wobble dataset and outputs a matrix of GW distances (computed with built-in python function ot.gromov.gromov_wasserstein2). The resulting matrix of GW dsitances is saved in the file 'gw.mat'


import numpy as np
import ot
import scipy.io
from scipy.spatial import distance_matrix

dat = np.loadtxt("WOBBLE.txt",delimiter=',') #loads Wobble dataset. The first 10 columns are wt, the next 12 columns are gob-1, and the last 7 columns are let-99

Npts=np.shape(dat)[0] #number of points along a trajectory (the same for all trajectories)
x1=np.linspace(0,Npts-1,Npts) #time vector (same for all trajectories). Can change this if time vector is different

ncurves=np.shape(dat)[1] #number of trajectories in the dataset

### This function computes a matrix of intrinsic distances 
### The input is in the form x=vector of time points, y=1D time series defined at points of x 
def my_geo(x,y):
  my_D=np.zeros((len(y),len(y)))
  for i in range(len(y)-1):
    v = np.array([x[i],y[i]])
    w= np.array([x[i+1],y[i+1]])
    my_D[i,i+1] = np.linalg.norm(v-w,2)
  for i in range(len(y)):
    for j in range(i+2,len(y)):
      my_D[i,j] = my_D[i,j-1]+my_D[j-1,j]
  return my_D+my_D.T


  

Raw_data=list()
for i in range(ncurves):
  Raw_data.append(dat[:,i])

### compute distance matrices and measures to be used in computation of GW
D=list()
p=list()
for i in range(ncurves):
  p.append((1/Npts)*np.ones(Npts))
  D.append(my_geo(x1,Raw_data[i]))


### Compute a matrix of GW distances between pairs of trajectories
gw=np.zeros((ncurves,ncurves))
for i in range(ncurves):
  for j in range(ncurves):
    gwij, log = ot.gromov.gromov_wasserstein2(D[i], D[j], p[i], p[j], 'square_loss', verbose=True, log=True)
    gw[i][j]=gwij

### save matrix of GW distances as Matlab matrix in .mat format
scipy.io.savemat('gw.mat', {'gw': gw})
