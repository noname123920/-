f=@(t,y) y./(t+2)+t.^2+2.*t;

function [t,y]=euler_method(f,interval,y0,h)
    t=interval(1):h:interval(2);
    y=zeros(size(t));
    y(1)=y0;
    for i=1:(length(t)-1)
        y(i+1)=y(i)+h*f(t(i),y(i));
    end
end

function [t,y]=euler_cauchy_method(f,interval,y0,h)
    t=interval(1):h:interval(2);
    y=zeros(size(t));
    y(1)=y0;
    for i=1:(length(t)-1)
        y_pred=y(i)+h*f(t(i),y(i));
        y(i+1)=y(i)+(h/2)*(f(t(i),y(i))+f(t(i+1),y_pred));
    end
end

function [t,y]=runge_kutta4(f,interval,y0,h)
    t=interval(1):h:interval(2);
    y=zeros(size(t));
    y(1)=y0;
    for i=1:(length(t)-1)
        k1=f(t(i),y(i));
        k2=f(t(i)+h/2,y(i)+h*k1/2);
        k3=f(t(i)+h/2,y(i)+h*k2/2);
        k4=f(t(i)+h,y(i)+h*k3);
        y(i+1)=y(i)+h/6*(k1+2*k2+2*k3+k4);
    end
end

t0=-1;
T=0;
y0=1.5;
h=0.1;
t=t0:h:T;
y_exact=(t.^3)/2+t.^2+t+2;

[t_euler,y_euler]=euler_method(f,[t0,T],y0,h);
[t_cauchy,y_cauchy]=euler_cauchy_method(f,[t0,T],y0,h);
[t_rk4,y_rk4]=runge_kutta4(f,[t0,T],y0,h);

err_euler=max(abs(y_exact-y_euler));
err_cauchy=max(abs(y_exact-y_cauchy));
err_rk4=max(abs(y_exact-y_rk4));

y_euler;
y_cauchy;
y_rk4;

fprintf('Погрешность метода Эйлера: %e\n',err_euler);
fprintf('Погрешность метода Эйлера-Коши: %e\n',err_cauchy);
fprintf('Погрешность метода Рунге-Кутта 4: %e\n',err_rk4);

h2=0.2;

[t_euler2,y_euler2]=euler_method(f,[t0,T],y0,h2);
[t_cauchy2,y_cauchy2]=euler_cauchy_method(f,[t0,T],y0,h2);
[t_rk42,y_rk42]=runge_kutta4(f,[t0,T],y0,h2);

y_euler2;
y_cauchy2;
y_rk42;

y_euler_h_double=y_euler(1:2:end);
y_cauchy_h_double=y_cauchy(1:2:end);
y_rk4_h_double=y_rk4(1:2:end);

p_euler=1;
p_cauchy=2;
p_rk4=4;

runge_euler=max(abs(y_euler_h_double-y_euler2))/(2^p_euler-1);
runge_cauchy=max(abs(y_cauchy_h_double-y_cauchy2))/(2^p_cauchy-1);
runge_rk4=max(abs(y_rk4_h_double-y_rk42))/(2^p_rk4-1);

fprintf('\nПогрешность по правилу Рунге:\n');
fprintf('Метод Эйлера (p=1): %e\n',runge_euler);
fprintf('Метод Эйлера-Коши (p=2): %e\n',runge_cauchy);
fprintf('Метод Рунге-Кутта 4 (p=4): %e\n',runge_rk4);

figure;
plot(t_euler,y_euler,'b-o','LineWidth',1.2,'MarkerSize',4,'MarkerFaceColor','b'); hold on;
plot(t_cauchy,y_cauchy,'g-s','LineWidth',1.2,'MarkerSize',4,'MarkerFaceColor','g');
plot(t_rk4,y_rk4,'m-^','LineWidth',1.2,'MarkerSize',4,'MarkerFaceColor','m');
plot(t,y_exact,'r-','LineWidth',2);
grid on;
xlabel('t');
ylabel('y');
title('Priblizhennoe i tochnoe reshenie ODU');
legend('Euler','Euler-Cauchy','Runge-Kutta 4','Exact','Location','northwest');
hold off;

subplot(1,2,1);
t;
plot(t,abs(y_exact-y_euler),'b-o','LineWidth',1.2,'MarkerSize',4); hold on;
plot(t,abs(y_exact-y_cauchy),'g-s','LineWidth',1.2,'MarkerSize',4);
plot(t,abs(y_exact-y_rk4),'r-^','LineWidth',1.2,'MarkerSize',4);
grid on;
xlabel('t');
ylabel('Error');
title('Pogreshnost |y(t_i)-y_i|');
legend('Euler','Euler-Cauchy','RK4','Location','northeast');

subplot(1,2,2);
t_double=t(1:2:end);
plot(t_double,abs(y_euler_h_double-y_euler2),'b-o','LineWidth',1.2,'MarkerSize',4); hold on;
plot(t_double,abs(y_cauchy_h_double-y_cauchy2),'g-s','LineWidth',1.2,'MarkerSize',4);
plot(t_double,abs(y_rk4_h_double-y_rk42),'r-^','LineWidth',1.2,'MarkerSize',4);
grid on;
xlabel('t');
ylabel('Error');
title('Pogreshnost po pravilu Runge');
legend('Euler(p=1)','Euler-Cauchy(p=2)','RK4(p=4)','Location','northeast');
