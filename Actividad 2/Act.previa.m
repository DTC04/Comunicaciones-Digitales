T = 1; 
f0 = 1 / T;
t = linspace(0, 10*T, 1000); 
f = linspace(-4*f0, 4*f0, 1000); 
beta_vals = [0, 0.25, 0.75, 1]; 

figure;
for beta = beta_vals
    sinc_term = sin(pi * t / T) ./ (pi * t / T);
    sinc_term(t == 0) = 1;

    denom = 1 - (4 * beta^2 * t.^2) / T^2;
    h_t = zeros(size(t));
    valid = abs(denom) > 1e-12;
    h_t(valid) = sinc_term(valid) .* (cos(pi * beta * t(valid) / T) ./ denom(valid));

    plot(t, h_t, 'DisplayName', sprintf('\\beta = %.2f', beta));
    hold on;
end
title('Respuesta al Impulso del Filtro de Coseno Alzado');
xlabel('Tiempo (t)');
ylabel('h(t)');
legend;
grid on;

figure;
for beta = beta_vals
    f1 = (1 - beta) / (2 * T);
    f2 = (1 + beta) / (2 * T);

    H_f = zeros(size(f));

    idx1 = abs(f) <= f1;
    idx2 = (abs(f) > f1) & (abs(f) <= f2);

    H_f(idx1) = 1;
    H_f(idx2) = 0.5 * (1 + cos((pi * T / beta) * (abs(f(idx2)) - f1)));

    plot(f, H_f, 'DisplayName', sprintf('\\beta = %.2f', beta));
    hold on;
end
title('Respuesta en Frecuencia del Filtro de Coseno Alzado');
xlabel('Frecuencia (Hz)');
ylabel('H(f)');
legend;
grid on;
xlim([-4*f0 4*f0]);
ylim([-0.2 1.2]);
