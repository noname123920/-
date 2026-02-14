clc;
x = [-2.1, -1.8, -1.5, -1.2, -0.9, -0.6, -0.3, 0, 0.3, 0.6, 0.9, 1.2, 1.5, 1.8, 2.1];
y = [14.1982, 11.4452, 9.1586, 7.2426, 6.3640, 4.8182, 6.1088, 3.9536, 4.6872, 4.7601, 5.8511, 7.1010, 9.1792, 11.4214, 14.0970];

figure;

% Группируем степени по 3-4 на subplot
% Subplot 1: степени 1-4
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

% Subplot 2: степени 5-8
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

% Subplot 3: степени 9-12
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

% Subplot 4: степени 13-14
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
