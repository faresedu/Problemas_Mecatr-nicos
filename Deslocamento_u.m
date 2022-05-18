graphics_toolkit('gnuplot')

%Variáveis do problema
k = 10000;
L = 0.50;
d = 0.20;
g = 9.81;
m = 212;
h = sqrt((L^2 - d^2));
W = m*g;

%Função que retorna a força resultante
function fr = Deslocamento_u(u, W, k, L, d, h)
  fr = W + (2 .*k.*(h-u).*(1 - (L./sqrt(((h-u).^2) + d^2))));
endfunction

%Função que retorna o k efetivo
function kef = k_efetivo(u, W, k, L, d, h)
  kef = (-2 .*k.*(h-u).*(1 - (L./sqrt(((h-u).^2) + d^2))))./u;
endfunction

%Chamada das funções
f = @(x) Deslocamento_u(x, W, k, L, d, h);
fkef = @(x) k_efetivo(x, W, k, L, d, h);

%%Raízes da Função do Problema
valor_u = [fzero(f, -1000), fzero(f, 0.4)]
u = [0:.01:0.6];
fig = figure();

%Plotagem das figuras
%Primeira função
plot(u, f(u)/1000, 'r-', 'LineWidth', 1.5);
hold on;
plot(valor_u, f(valor_u)/1000, '.', 'MarkerSize', 13);
title('Gráfico 1 - Força Resultante x U', 'FontName', 'Times', 'FontSize', 12)
xlabel('Deslocamento, u (m)', 'FontName', 'Times', 'FontSize', 12)
ylabel('Força Resultante, F (kN)', 'FontName', 'Times', 'FontSize', 12)
legend('Função', 'Zeros', 'Location', 'northwest')
grid on;

%Segunda função
plot(u,fkef(u)/1000, 'r-', 'LineWidth', 1.5);
hold on;
title('Gráfico 2 - kef x U', 'FontName', 'Times', 'FontSize', 12)
xlabel('Deslocamento, u (m)', 'FontName', 'Times', 'FontSize', 12)
ylabel('K efetivo, kef (kN/m)', 'FontName', 'Times', 'FontSize', 12)
grid on;




