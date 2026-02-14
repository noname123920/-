clc;
x = [-2.1, -1.8, -1.5, -1.2, -0.9, -0.6, -0.3, 0, 0.3, 0.6, 0.9, 1.2, 1.5, 1.8, 2.1];
y = [14.1982, 11.4452, 9.1586, 7.2426, 6.3640, 4.8182, 6.1088, 3.9536, 4.6872, 4.7601, 5.8511, 7.1010, 9.1792, 11.4214, 14.0970];

n = length(x);
sigma = zeros(1, n);
m = n - 1;

% Вычисляем СКО для всех степеней
for m = 0:14
    p = polyfit(x, y, m);
    y_fit = polyval(p, x);
    sum_sq = sum((y_fit - y).^2);
    sigma(m+1) = sqrt(sum_sq / (n - m));
end

% Находим оптимальную степень (минимальное СКО среди 0-13)
[min_sigma, r_index] = min(sigma(1:m));
r = r_index - 1;

% Получаем коэффициенты оптимального полинома
p_opt = polyfit(x, y, r);
coeffs = fliplr(p_opt); % переворачиваем для a0, a1, ..., ar

% Выводим результат
fprintf('\nОптимальная степень: r = %d\n', r);
fprintf('СКО = %.2e\n\n', min_sigma);
fprintf('P_%d(x) = ', r);

for i = 1:length(coeffs)
    if i == 1
        fprintf('%.6f', coeffs(i));
    else
        if coeffs(i) >= 0
            fprintf(' + %.6f*x^%d', coeffs(i), i-1);
        else
            fprintf(' - %.6f*x^%d', abs(coeffs(i)), i-1);
        end
    end
end
fprintf('\n');
