f_prime = @(x) 1./(2*sqrt(x+1)) + 1./(x.^2); % Определяем производную
x_range = linspace(0.5, 3.0, 100); % Создаем массив точек на интервале
plot(x_range, f_prime(x_range)); % Строим график
grid on; % Включаем сетку
xlabel('x');
ylabel('f''(x)');
title('График производной f''(x)');
