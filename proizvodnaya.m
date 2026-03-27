clear all

dx=pi/6.;
x=[0:dx:pi];

xy_table(:,1)=x;
xy_table(:,2)=sin(x);
xy_table(:,3)=cos(x);

for i=1:1:length(x)-1
xy_table(i,4)=(sin(x(i+1))-sin(x(i)))/dx;
end

for i=2:1:length(x)
xy_table(i,5)=(sin(x(i))-sin(x(i-1)))/dx;
end

for i=2:1:length(x)-1
xy_table(i,6)=(sin(x(i+1))-sin(x(i-1)))/(2*dx);
end




xy_2d(:,1)=x;
xy_2d(:,2)=sin(x);
xy_2d(:,3)=-sin(x);

for i=2:1:length(x)-1
xy_2d(i,4)=(sin(x(i-1))-2*sin(x(i))+sin(x(i+1)))/(dx*dx);
end
