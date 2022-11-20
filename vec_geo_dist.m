function v=vec_geo_dist(X)
y=X(:,2);
dold=0;
for i=1:length(y)-1
dnew=norm(X(i,:)-X(i+1,:));
v(i)=dold+dnew;
dold=v(i);
end

end