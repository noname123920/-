a = 0.6;
b = 0.8;
x = a:0.001:b;

phi1_deriv = 1 ./ (2 * (x + 1).^(3/2));

plot(x, phi1_deriv, 'b', 'LineWidth', 2);
