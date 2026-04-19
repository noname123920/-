a = 1.3; b = 2.4; B = 3.2; eps = 0.1;

printf("\n ПОДБОР ШАГА \n");

h = 0.55;
first_calc = true;

while true
    n = round((b - a) / h);
    x = a:h:b;

    den = 1 - h/2;
    for i = 1:n-1
        xi = x(i+1);
        m(i) = (-2 + 2*h^2*xi^2) / den;
        k(i) = (1 + h/2) / den;
        F(i) = (xi + 1) / den;
    end

    alfa = zeros(1, n+2);
    beta = zeros(1, n+2);
    alfa(1) = 0;
    beta(1) = 1;

    for i = 1:n-1
        znam = m(i) + k(i)*alfa(i);
        alfa(i+1) = -1 / znam;
        beta(i+1) = (h^2*F(i) - k(i)*beta(i)) / znam;
    end

    c1 = 1 + 3/(2*h);
    c2 = -4/(2*h);
    c3 = 1/(2*h);

    y = zeros(1, n+1);
    y(n+1) = (B - c2*beta(n) - c3*(alfa(n-1)*beta(n) + beta(n-1))) / ...
             (c1 + c2*alfa(n) + c3*alfa(n-1)*alfa(n));

    for i = n:-1:1
        y(i) = alfa(i)*y(i+1) + beta(i);
    end

    if first_calc
        fprintf("h = %.5f, n = %d\n", h, n);
        fprintf("y = [");
        for i = 1:length(y)
            fprintf("%.10f ", y(i));
        end
        fprintf("]\n\n");

        first_calc = false;
        y_prev = y;
        x_prev = x;
        h_prev = h;
        h = h / 2;
    else
        % Берём из нового решения y только те узлы,
        % которые совпадают с узлами предыдущего решения y_prev
        y_at_prev_nodes = zeros(1, length(y_prev));
        for i = 1:length(y_prev)
            idx = 2*(i-1) + 1;
            if idx <= length(y)
                y_at_prev_nodes(i) = y(idx);
            end
        end

        err = max(abs(y_at_prev_nodes - y_prev));

        fprintf("h = %.5f, n = %d\n", h, n);
        fprintf("Погрешность = %.6f\n", err);
        fprintf("y = [");
        for i = 1:length(y)
            fprintf("%.10f ", y(i));
        end
        fprintf("]\n\n");

        if err < eps
            fprintf("ТОЧНОСТЬ ДОСТИГНУТА!\n");
            break;
        end

        y_prev = y;
        x_prev = x;
        h_prev = h;
        h = h / 2;
    end
end

% График
plot(x, y, 'r-o', 'LineWidth', 2);
grid on;
xlabel('x');
ylabel('u(x)');
title('Решение краевой задачи (вариант 5)');
