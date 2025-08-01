function plotConvergence(bestHist, avgHist, titleStr, fileName, xlab)
%PLOTCONVERGENCE  Draws best & average-fitness curves and saves a PNG.
%
%   plotConvergence(bestHist, avgHist, titleStr, fileName, xlab)
%
%   • bestHist  – vector of best fitness values
%   • avgHist   – vector of average fitness values
%   • titleStr  – string for the plot title
%   • fileName  – output PNG file name
%   • xlab      – label for the x-axis (e.g., 'Generation')
%
%   The routine uses the same visual style as the optimiser scripts
%   (2-pt lines, 600 dpi, linear y-axis).

fig = figure('Visible','off');

plot(bestHist, 'LineWidth', 2); hold on
plot(avgHist, '--', 'LineWidth', 2);

xlabel(xlab,  'FontSize', 12);
ylabel('Fitness', 'FontSize', 12);
title(titleStr, 'FontSize', 13);

grid on
legend({'Best', 'Average'}, 'Location', 'northeast', 'FontSize', 11);
set(gca, 'FontSize', 11);

print(fig, '-dpng', '-r600', fileName);
close(fig);
end
