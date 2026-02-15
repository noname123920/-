clc;
x = [-2.1, -1.8, -1.5, -1.2, -0.9, -0.6, -0.3, 0, 0.3, 0.6, 0.9, 1.2, 1.5, 1.8, 2.1];
y = [14.1982, 11.4452, 9.1586, 7.2426, 6.3640, 4.8182, 6.1088, 3.9536, 4.6872, 4.7601, 5.8511, 7.1010, 9.1792, 11.4214, 14.0970];

n = length(x);
sigma = zeros(1, n);

% Вычисляем СКО для всех степеней и выводим коэффициенты
for m = 0:n-1
    p = polyfit(x, y, m);
    y_fit = polyval(p, x);
    sum_sq = sum((y_fit - y).^2);
    sigma(m+1) = sqrt(sum_sq / (n - m));

    fprintf('\n Степень %d (СКО = %.6e) \n', m, sigma(m+1));
    coeffs = fliplr(p);  % a0, a1, ..., am
##    fprintf('Коэффициенты (от a0 до a%d):\n', m);
##    disp(coeffs);
end

% Находим оптимальную степень
[min_sigma, r_index] = min(sigma);
r = r_index - 1;

% Получаем коэффициенты оптимального полинома
p_opt = polyfit(x, y, r);
coeffs_opt = fliplr(p_opt); % переворачиваем для a0, a1, ..., ar

% Выводим результат
fprintf('\nОПТИМАЛЬНАЯ СТЕПЕНЬ: r = %d\n', r);
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
