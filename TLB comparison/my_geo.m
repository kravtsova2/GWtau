function D=my_geo(X)
%%% This function takes a trajectory X where each column of X gives values for a
%%% coordinate of time series. For example, time series X on the plane
%%% (with 2 coordinates) will have two columns. Number of rows is the
%%% length of time series

%%% The function outputs a matrix of intrinsic distances between ALL points
%%% along the time series. This matrix can be for Gromov-Wasserstein
%%% distance or it's lower bounds computations 

D=zeros(size(X,1),size(X,1));

for i=1:size(X,1)-1
D(i,i+1)=norm(X(i,:)-X(i+1,:));
end

for i=1:size(X,1)
    for j=i+2:size(X,1)
D(i,j)=D(i,j-1)+D(j-1,j);
    end
end

D=D+D';
end