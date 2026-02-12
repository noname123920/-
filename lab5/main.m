clear; clc;

x = [-2.1, -1.8, -1.5, -1.2, -0.9, -0.6, -0.3, 0, 0.3, 0.6, 0.9, 1.2, 1.5, 1.8, 2.1];
y = [14.1982, 11.4452, 9.1586, 7.2426, 6.3640, 4.8182, 6.1088, ...
    3.9536, 4.6872, 4.7601, 5.8511, 7.1010, 9.1792, 11.421, 14.097];

n = length(x);
m_max = n - 1;
sigma = zeros(1, m_max + 1);
coeffs = cell(1, m_max + 1);

for m = 0:m_max
    p = polyfit(x, y, m);
    coeffs{m+1} = p;
    y_fit = polyval(p, x);
    sigma(m+1) = sqrt(1/(n - m) * sum((y_fit - y).^2));


    fprintf('СТЕПЕНЬ %d:\n', m);
    polyout(p, 'x');
    fprintf('\n----------------\n\n');
end

figure(1);
