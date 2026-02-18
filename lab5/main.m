clc;
x = [-2.1, -1.8, -1.5, -1.2, -0.9, -0.6, -0.3, 0, 0.3, 0.6, 0.9, 1.2, 1.5, 1.8, 2.1];
y = [14.1982, 11.4452, 9.1586, 7.2426, 6.3640, 4.8182, 6.1088, 3.9536, 4.6872, 4.7601, 5.8511, 7.1010, 9.1792, 11.4214, 14.0970];

n = length(x);
sigma = zeros(1, n);

for m = 0:n-1
    p = polyfit(x, y, m);
    y_fit = polyval(p, x);
    sum_sq = sum((y_fit - y).^2);
    sigma(m+1) = sqrt(sum_sq / (n - m));
    coeffs = fliplr(p);
end


[min_sigma, r_index] = min(sigma);
r = r_index - 1;


p_opt = polyfit(x, y, r);
coeffs_opt = fliplr(p_opt);

fprintf('МИНИМАЛЬНОЕ СКО = %.6e\n\n', min_sigma);
fprintf('P_%d(x) = ', r);

for i = 1:length(coeffs_opt)
    if i == 1
        fprintf('%.6f', coeffs_opt(i));
    else
        if coeffs_opt(i) >= 0
            fprintf(' + %.6f*x^%d', coeffs_opt(i), i-1);
        else
            fprintf(' - %.6f*x^%d', abs(coeffs_opt(i)), i-1);
        end
    end
end
fprintf('\n');

figure;

subplot(2,2,1);
hold on;
plot(x, y, 'ko', 'MarkerSize', 6, 'MarkerFaceColor', 'k');
for n = 1:4
    p = polyfit(x, y, n);
    y_fit = polyval(p, x);
    plot(x, y_fit, 'LineWidth', 1.5, 'DisplayName', sprintf('n=%d', n));
end
title('Степени 1-4');
legend show;
grid on;
hold off;


subplot(2,2,2);
hold on;
plot(x, y, 'ko', 'MarkerSize', 6, 'MarkerFaceColor', 'k');
for n = 5:8
    p = polyfit(x, y, n);
    y_fit = polyval(p, x);
    plot(x, y_fit, 'LineWidth', 1.5, 'DisplayName', sprintf('n=%d', n));
end
title('Степени 5-8');
legend show;
grid on;
hold off;


subplot(2,2,3);
hold on;
plot(x, y, 'ko', 'MarkerSize', 6, 'MarkerFaceColor', 'k');
for n = 9:12
    p = polyfit(x, y, n);
    y_fit = polyval(p, x);
    plot(x, y_fit, 'LineWidth', 1.5, 'DisplayName', sprintf('n=%d', n));
end
title('Степени 9-12');
legend show;
grid on;
hold off;


subplot(2,2,4);
hold on;
plot(x, y, 'ko', 'MarkerSize', 6, 'MarkerFaceColor', 'k');
for n = 13:14
    p = polyfit(x, y, n);
    y_fit = polyval(p, x);
    plot(x, y_fit, 'LineWidth', 1.5, 'DisplayName', sprintf('n=%d', n));
end
title('Степени 13-14');
legend show;
grid on;
hold off;
