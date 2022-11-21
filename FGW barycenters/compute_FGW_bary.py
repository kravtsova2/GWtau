### This code takes a matrix whose columns are trajectories (defined on the same equally spaced time points) and outputs their FGW barycenter trajectory as a vector of values defined on the same time points as original trajectories. The vector is saved in the file 'Bary.mat'


import numpy as np
import ot
import scipy.io
from scipy.spatial import distance_matrix

dat = np.loadtxt("LET99.txt",delimiter=',') #W.txt, GPB1.txt or LET99.txt

Npts=np.shape(dat)[0] #number of poitns along a trajectory (the same for all trajectories)
x1=np.linspace(0,5*(Npts-1),Npts) #time vector (same for all trajectories). Can change this if time vector is different

ncurves=np.shape(dat)[1] #number of trajectories in the dataset


D=list() #structures
Y=list() #features
for i in range(ncurves):
  v=np.array([dat[:,i]])
  Y.append(v.T)
  x=np.array([x1])
  x=x.T
  D.append(distance_matrix(x,x,p=2))

p=list() #measures (all discrete uniform)
for i in range(ncurves):
  p.append((1/Npts)*np.ones(Npts))
  
lambdast=1/ncurves*np.ones(ncurves) #weights in the barycenter

A, C, log = ot.gromov.fgw_barycenters(Npts, Y, D, p, lambdast, alpha=0.5,fixed_structure=True,log=True,init_C=D[0])

Bary=A #rename 

scipy.io.savemat('Bary.mat', {'Bary': Bary}) #and save in .mat format

print('barycenter computed')