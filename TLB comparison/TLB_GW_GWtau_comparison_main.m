%%%%% This code compares TLB (custom code below) and GW (loaded data computed by Python ot.gromov package) from Memoli 2011 and GWtau on the dataset
%%%%% Ignacio2022 from Ignacio et al. 2022

%%% it requires 3 functions: my_geo, vec_geo_dist, wass_sorted

%%% 2 figures will be generated: matrix of TLB's between time series and
%%% matrix of GWtau between time series from Ignacio2022 dataset. 

%%% Note that TLB <= GW <= GWtau, and both
%%% matrices produce similar time series comparison

%%%%%%%%% This computation would take about half a minute
%%%%%%%%% due to use of built-in Matlab solver linprog
%%%%%%%%% used for computing TLB from Memoli 2011. The TLB can be computed
%%%%%%%%% faster using the code for Chowdhury and Memoli 2019

%%%%% References: 

%%% Memoli, F. (2011). Gromov-Wasserstein distances and the metric approach
%%% to object matching. Found. Comput. Math., 11(4), 417–487.

%%% Chowdhury, S., & M emoli, F. (2019). The Gromov–Wasserstein distance
%%% between networks and stable network invariants. Information and
%%% Inference: A Journal of the IMA, 8 (4), 757-787.


clear all
close all
clc

load Ignacio2022.mat
load gw.mat


XX=[wt gpb1 let99];

num_curves=size(XX,2);

TLB_matrix=zeros(num_curves,num_curves);
time=(1:size(XX,1))';

for k=1:size(XX,2)
    for kk=k+1:size(XX,2)

vi=XX(:,k);
vj=XX(:,kk);

%%% construct matrix of intrinsic distances for each curve
X=[time vi];
Y=[time vj];
Dx=my_geo(X);
Dy=my_geo(Y);

%%% construct cost matrix as a matrix of Wasserstein distances between
%%% local distributions of distances
for i=1:size(Dx,1)
    for j=1:size(Dy,1)
        v1=sort(Dx(i,:),'descend');
        v2=sort(Dy(j,:),'descend');
     C(i,j) = wass_sorted(v1,v2); %Wasserstein distance between local distributions
    end
end

[n m]=size(C);

mux=1/n*ones(n,1);
muy=1/m*ones(m,1);

A1=kron(eye(n),ones(1,m));
A2=kron(ones(1,n),eye(m));

Aeq=[A1;A2];
beq=[mux;muy];

f=reshape(C',1,n*m);
[mu xval]= linprog(f,[],[],Aeq,beq,zeros(n*m,1),[]);

TLB_matrix(k,kk)=0.5*xval;

    end

end

TLB_matrix=TLB_matrix+TLB_matrix';

%%%%%%%%%%%%%%%%%%% Compute GWtau distance matirx
GWtau=zeros(num_curves,num_curves);
for i=1:num_curves
    for j=i+1:num_curves
x=[time XX(:,i)];
y=[time XX(:,j)];
vec1=vec_geo_dist(x);
vec2=vec_geo_dist(y);
GWtau(i,j)=wass_sorted(vec1,vec2);
    end
end
GWtau=GWtau+GWtau';


figure(1)
heatmap(GWtau,'Colormap',cool)
title('GWtau')


figure(2)
heatmap(TLB_matrix,'Colormap',cool)
title('TLB')

%%% Correct the diagonal (place 0's) of GW matrix computed numericaly in Python  
for i=1:size(gw,1)
    gw(i,i)=0;
end
gw=0.5*gw.^(1/2);

figure(3)
heatmap(gw,'Colormap',cool)
title('GW')



