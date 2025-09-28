% Пункт 1: График f'(x) на [a,b]
a = 0.6; b = 0.8;
x = a:0.001:b;

f_prime = @(x) 1./(2*sqrt(x+1)) + 1./(x.^2);
y_prime = f_prime(x);

figure;
plot(x, y_prime, 'b', 'LineWidth', 2);
grid on;
title('График производной f''(x) на интервале [0.6, 0.8]');
xlabel('x');
ylabel('f''(x)');
