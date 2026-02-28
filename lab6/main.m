f = @(x) x - 1./x.^2;
a = 2;
b = 3;
x_mid = (a + b)/2;
epsilon = 1e-4;

f1 = @(x) 1 + 2./(x.^3);
f2 = @(x) -6./(x.^4);
f1(x_mid)
f2(x_mid)

n = 2;
while true
    x_nodes = linspace(a, b, n + 1);
    y_nodes = f(x_nodes);

    p = polyfit(x_nodes, y_nodes, n);
    p1 = polyder(p);

    L1_mid = polyval(p1, x_mid);
    R = abs(f1(x_mid) - L1_mid);

    fprintf('n = %d, погрешность = %.2e\n', n, R);

    if R <= epsilon
        fprintf('Точность достигнута при n = %d\n\n', n);
        break;
    else
        n = n + 1;
    end
end

x_plot = linspace(a, b, 200);
R1_plot = abs(f1(x_plot) - polyval(p1, x_plot));

figure(1);
plot(x_plot, R1_plot, 'b-');
xlabel('x');
ylabel('R_1(x)');
grid on;

m = n;
while true
    x_nodes = linspace(a, b, m + 1);
    y_nodes = f(x_nodes);

    p = polyfit(x_nodes, y_nodes, m);
    p2 = polyder(polyder(p));

    L2_mid = polyval(p2, x_mid);
    R2 = abs(f2(x_mid) - L2_mid);

    fprintf('m = %d, погрешность 2й производной = %.2e\n', m, R2);

    if R2 <= epsilon
        fprintf('Точность для 2й производной достигнута при m = %d\n', m);
        break;
    else
        m = m + 1;
    end
end

R2_plot = abs(f2(x_plot) - polyval(p2, x_plot));

figure(2);
plot(x_plot, R2_plot, 'r-');
xlabel('x');
ylabel('R_2(x)');
grid on;
