A=0;
B=1.5;
b1=1;
b2=3.0;
b3=10;
a0=1;
a1=-2.4;
a2=0.09;
a3=48.87;

f=@(t) sin(t)-7*t+2;

ode_system=@(t,Y) [
    Y(2);
    Y(3);
    (f(t)-a1*Y(3)-a2*Y(2)-a3*Y(1))/a0
];

Y0=[b1;b2;b3];

options=odeset('RelTol',1e-5,'AbsTol',1e-5);

[t,Y]=ode45(ode_system,[A,B],Y0,options);

y=Y(:,1);
dy=Y(:,2);
d2y=Y(:,3);

d3y=(f(t)-a1*d2y-a2*dy-a3*y)/a0;

fprintf('%-8s %-12s %-12s %-12s %-12s\n', 't', 'y(t)',  "y'(t) ",  "y''(t) ",  "y'''(t) ");
fprintf('%s\n', repmat('-', 1, 62));
for i = 1:length(t)
    fprintf('%-8.4f %-12.6f %-12.6f %-12.6f %-12.6f\n', ...
        t(i), y(i), dy(i), d2y(i), d3y(i));
end

figure;
plot(t, y);
xlabel('t');
ylabel('y(t)');
grid on;
