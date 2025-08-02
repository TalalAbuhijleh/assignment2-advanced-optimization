% compare_rastrigin.m
% ------------------------------------------------------------
% Runs GA, DE, PSO on the 2-D Rastrigin function, produces
%   • comparison_best.png
%   • comparison_average.png
%   • ga_fitness.csv
%   • de_fitness.csv
%   • pso_fitness.csv
% and prints the best solution and fitness for each method.
%
% Author : <Your Name>
% Date   : 2025-08-02
% ------------------------------------------------------------

clear; clc;

% ────────── run the three optimisers ──────────
[gaSol,  gaBest,  gaAvg ] = ga_rastrigin(123);
[deSol,  deBest,  deAvg ] = de_rastrigin(456);
[psoSol, psoBest, psoAvg] = pso_rastrigin(789);

% ────────── print a concise summary ──────────
fprintf('\nSummary (best fitness):\n');
fprintf(' GA  : %.6e at (%.6f, %.6f)\n', gaBest(end),  gaSol(1),  gaSol(2));
fprintf(' DE  : %.6e at (%.6f, %.6f)\n', deBest(end),  deSol(1),  deSol(2));
fprintf(' PSO : %.6e at (%.6f, %.6f)\n', psoBest(end), psoSol(1), psoSol(2));

% ────────── comparison figures ──────────
plotComparison(gaBest, deBest, psoBest, ...
               'Best-Fitness Convergence – 2-D Rastrigin', ...
               'Best fitness', 'comparison_best.png');

plotComparison(gaAvg,  deAvg,  psoAvg, ...
               'Average-Fitness Convergence – 2-D Rastrigin', ...
               'Average fitness', 'comparison_average.png');

% ────────── export CSV tables ──────────
exportCSV('ga_fitness.csv',  gaBest,  gaAvg );
exportCSV('de_fitness.csv',  deBest,  deAvg );
exportCSV('pso_fitness.csv', psoBest, psoAvg);

fprintf('\nCSV files written:\n  ga_fitness.csv\n  de_fitness.csv\n  pso_fitness.csv\n');
fprintf('Figures written :\n  comparison_best.png\n  comparison_average.png\n');

% ============================================================
% local helper functions
% ============================================================

function plotComparison(best, de, pso, titleStr, ylab, fileName)
    figure('Visible', 'off');
    plot(best, 'LineWidth', 2); hold on
    plot(de,   'LineWidth', 2);
    plot(pso,  'LineWidth', 2);
    xlabel('Iteration', 'FontSize', 12);
    ylabel(ylab,        'FontSize', 12);
    title(titleStr,     'FontSize', 13);
    legend({'GA', 'DE', 'PSO'}, 'Location', 'northeast', 'FontSize', 11);
    grid on; set(gca, 'FontSize', 11);
    print('-dpng', '-r600', fileName);
    close;
end

function exportCSV(fname, bestHist, avgHist)
    gen      = (1:numel(bestHist)).';
    tbl      = table(gen, bestHist(:), avgHist(:), ...
                     'VariableNames', {'Generation', 'Best', 'Average'});
    writetable(tbl, fname);
end
