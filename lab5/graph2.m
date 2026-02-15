clc;

x = [-1.5, -1.2, -0.9, -0.6, -0.3, 0, 0.3, 0.6, 0.9, 1.2, 1.5]';
y = [0.0829, 0.2192, 0.5794, 1.5315, 4.0481, 10.7, 4.0481, 1.5315, 0.5794, 0.2192, 0.0829]';

x_fit = linspace(-1.5, 1.5, 500);
y_fit = a .* exp(b .* abs(x_fit));

figure;
plot(x_fit, y_fit, 'b');
hold on;
plot(x, y, 'ro');
xlabel('x');
ylabel('y');


grid on;
hold off;








