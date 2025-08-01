% Runs GA, DE, PSO once each (fixed seeds) and creates
%   • comparison_best.png
%   • comparison_average.png
% Also prints the best solution and fitness from each method.

clear; clc;

[gaSol,  gaBest,  gaAvg ] = ga_rastrigin(123);
[deSol,  deBest,  deAvg ] = de_rastrigin(456);
[psoSol, psoBest, psoAvg] = pso_rastrigin(789);

fprintf('\nSummary (best fitness):\n');
fprintf(' GA  : %.6e at (%.6f, %.6f)\n', gaBest(end),  gaSol(1),  gaSol(2));
fprintf(' DE  : %.6e at (%.6f, %.6f)\n', deBest(end),  deSol(1),  deSol(2));
fprintf(' PSO : %.6e at (%.6f, %.6f)\n', psoBest(end), psoSol(1), psoSol(2));

% best-fitness comparison
figure('Visible', 'off');
plot(gaBest,  'LineWidth', 2); hold on
plot(deBest,  'LineWidth', 2);
plot(psoBest, 'LineWidth', 2);
xlabel('Iteration'); ylabel('Best fitness');
title('Best-Fitness Convergence – 2-D Rastrigin');
legend({'GA', 'DE', 'PSO'}, 'Location', 'northeast');
grid on; set(gca, 'FontSize', 11);
print('-dpng', '-r600', 'comparison_best.png'); close;

% average-fitness comparison
figure('Visible', 'off');
plot(gaAvg,  '--', 'LineWidth', 2); hold on
plot(deAvg,  '--', 'LineWidth', 2);
plot(psoAvg, '--', 'LineWidth', 2);
xlabel('Iteration'); ylabel('Average fitness');
title('Average-Fitness Convergence – 2-D Rastrigin');
legend({'GA', 'DE', 'PSO'}, 'Location', 'northeast');
grid on; set(gca, 'FontSize', 11);
print('-dpng', '-r600', 'comparison_average.png'); close;
