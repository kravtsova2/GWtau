clear all
close all
clc

%%% This code computes classification errors and runtimes when running
%%% 1-Nearest Neighbor algorithm (using built-in Matlab function 'fitcknn')
%%% with GWtau as a distance (requires distfun_GWtau - apears at the end of the code). Comparison is made
%%% with Dynamic Time Warping (DTW) as a distance (requires distfun_DTW - appears at the end of the code)

%%% the following datasets are checked:
%ts_name=['BirdChicken' 'DistalPhalanxOutlineAgeGroup' 'MiddlePhalanxOutlineAgeGroup' 'Adiac' 'Worms' 'InsectWingbeatSound' 'CinCECGTorso' 'SemgHandMovementCh2'];

%%% example on BirdChicken dataset. This and all other datasets can be
%%% downloaded from: https://www.cs.ucr.edu/~eamonn/time_series_data_2018/

TRAIN=load('BirdChicken_TRAIN.tsv'); %%% insert training dataset name here
TEST=load('BirdChicken_TEST.tsv');   %%% insert testing dataset name here

X=TRAIN(:,2:end); %%% time series (training)
Y=TRAIN(:,1);     %%% class labels (training)

Xnew=TEST(:,2:end); %%% time series (testing)
Ynew=TEST(:,1);     %%% class labels (testing)

disp('Runtimes for DTW and GWtau')

%%% 1-Neareast Neighbor with DTW distance
tic
Mdl = fitcknn(X,Y,'NumNeighbors',1,'distance',@distfun_dtw);
label = predict(Mdl,Xnew); %predict new labels
DTW_time=toc

er=abs(label-Ynew);
f=find(er>0);
DTW_error=length(f)/size(TEST,1); 

%%% 1-Neareast Neighbor with GWtau distance
tic
Mdl = fitcknn(X,Y,'NumNeighbors',1,'distance',@distfun_GWtau);
label = predict(Mdl,Xnew);
GWtau_time=toc

disp('1-NN error: GWtau and Euclidean')

er=abs(label-Ynew);
f=find(er>0);
GWtau_error=length(f)/size(TEST,1) % GWtau error

%%% For completion, we report results with Euclidean distance (which is fast, so not reporting the times)
Mdl = fitcknn(X,Y,'NumNeighbors',1,'distance','Euclidean');
label = predict(Mdl,Xnew);
er=abs(label-Ynew);
f=find(er>0);
Euclidean_error=length(f)/size(TEST,1) %Euclidean error

disp('DTW error below. Warning: for some datasets could differ from reported by UCR in DTW(w=100) column')
DTW_error


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Runtimes results:
%%% these are the runtimes resulted when we run the code on the 8 datasets from above:
rt_DTW=[3.2,3.6,3.9,17.3,38.2,82.8,356.8,1629.9];
rt_GWtau=[0.12,0.71,0.99,3.0,2.0,10.4,8.04,27.1];

%%% Needed functions:
function D2=distfun_GWtau(ZI,ZJ)
time=(1:length(ZI))';
D2=zeros(size(ZJ,1),1);
for k=1:size(ZJ,1)
v1=ZI;
v2=ZJ(k,:);   
X=[time v1'];
Y=[time v2'];
D2(k)=compute_GWtau(X,Y);
end
end

function res=compute_GWtau(X,Y)
norm_vec_x=vecnorm(diff(X),2,2);
norm_vec_y=vecnorm(diff(Y),2,2);
v1=cumsum(norm_vec_x);
v2=cumsum(norm_vec_y);
res=norm(v1-v2)/sqrt(length(v1)); %2-Wasserstein
end

function D2=distfun_dtw(ZI,ZJ)
time=(1:length(ZI))';
D2=zeros(size(ZJ,1),1);
for k=1:size(ZJ,1)
v1=ZI;
v2=ZJ(k,:);   
D2(k)=dtw(v1,v2);
end
end