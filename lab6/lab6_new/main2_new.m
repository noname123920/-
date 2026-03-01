graphics_toolkit('gnuplot');

a = 1;
b = 1.44;
c0 = 1.5;
c1 = 0;
c2 = -2.1;
c3 = -1.1;
c4 = 3.1;

P = @(x) c4*x.^4 + c3*x.^3 + c2*x.^2 + c1*x + c0;

F = @(x) c4*x.^5/5 + c3*x.^4/4 + c2*x.^3/3 + c1*x.^2/2 + c0*x;

I = F(b) - F(a)

gauss_data = {
    [0], [2];
    [-0.577350269189626, 0.577350269189626], [1, 1];
    [-0.774596669299540, 0, 0.774596669299540], [0.555555555555556, 0.888888888888888, 0.555555555555556];
    [-0.861136311594052, -0.339981043584856, 0.339981043584856, 0.861136311594052], ...
    [0.347854845137454, 0.652145154862546, 0.652145154862546, 0.347854845137454]
};

N_nodes = [1, 2, 3, 4];
S_values = zeros(1, 4);
errors = zeros(1, 4);

for k = 1:4
    t = gauss_data{k, 1};
    A = gauss_data{k, 2};

    S = 0;
    for i = 1:length(t)
        x = (a + b)/2 + (b - a)/2 * t(i);
        S = S + A(i) * P(x);
    end
    S = (b - a)/2 * S;

    S_values(k) = S;
    errors(k) = abs(I - S);
end

fprintf('N\tS\t\t\tr\n');
for i = 1:4
    fprintf('%d\t%.18f\t%.18f\n', i, S_values(i), errors(i));
end

bar(N_nodes, errors);
xlabel('N');
ylabel('r');
grid on;

for N = 0:3
    m = 2*N + 1;
    t = gauss_data{N+1, 1};
    A = gauss_data{N+1, 2};

    test_f = @(x) x.^m;

    I_test = (b^(m+1) - a^(m+1))/(m+1);

    S_test = 0;
    for i = 1:length(t)
        x = (a + b)/2 + (b - a)/2 * t(i);
        S_test = S_test + A(i) * test_f(x);
    end
    S_test = (b - a)/2 * S_test;

    error_test = abs(I_test - S_test);

    fprintf('N = %d, m = %d, погрешность = %.18f\n', N, m, error_test);
end
