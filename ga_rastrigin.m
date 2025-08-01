function [bestSol, bestHist, avgHist] = ga_rastrigin(seed)
% Genetic Algorithm (real-coded) for 2-D Rastrigin minimisation.
%
% Output:
%   bestSol  – [x y] coordinates of best solution
%   bestHist – best fitness at each generation
%   avgHist  – average fitness at each generation
%
% Usage:
%   [bestSol,bestHist,avgHist] = ga_rastrigin(123);

% ─────────────────── configuration ───────────────────
if nargin < 1, seed = 42; end
rng(seed);

popSize   = 30;
gens      = 100;
pc        = 0.9;     % crossover probability
pm        = 0.1;     % mutation probability per gene
mutStep   = 1.0;     % maximum mutation step
bounds    = [-5.12 5.12];

% ─────────────────── initial population ───────────────────
pop = bounds(1) + (bounds(2) - bounds(1)) .* rand(popSize, 2);

bestHist = zeros(gens, 1);
avgHist  = zeros(gens, 1);

for g = 1:gens
    fitness = rastrigin(pop(:, 1), pop(:, 2));
    bestHist(g) = min(fitness);
    avgHist(g)  = mean(fitness);

    % elitism
    [~, eliteIdx] = min(fitness);
    newPop = pop(eliteIdx, :);

    while size(newPop, 1) < popSize
        p1 = tournamentSelect(pop, fitness);
        p2 = tournamentSelect(pop, fitness);

        if rand < pc
            child = arithmeticCrossover(p1, p2);
        else
            child = p1;
        end
        child = mutate(child, pm, mutStep, bounds);
        newPop = [newPop; child]; 
    end
    pop = newPop;
end

% best solution
fitness = rastrigin(pop(:, 1), pop(:, 2));
[bestFit, bestIdx] = min(fitness);
bestSol = pop(bestIdx, :);

fprintf('GA  best (x = %.6f, y = %.6f)  fitness = %.10e\n', bestSol(1), bestSol(2), bestFit);

% plot convergence
plotConvergence(bestHist, avgHist, 'GA – 2-D Rastrigin', 'ga_convergence.png', 'Generation');
end


function f = rastrigin(x, y)
f = 20 + x.^2 + y.^2 - 10 .* (cos(2 .* pi .* x) + cos(2 .* pi .* y));
end

function parent = tournamentSelect(pop, fitness)
k = 3;
idx = randperm(size(pop, 1), k);
[~, bestIdx] = min(fitness(idx));
parent = pop(idx(bestIdx), :);
end

function child = arithmeticCrossover(p1, p2)
alpha = rand;
child = alpha .* p1 + (1 - alpha) .* p2;
end

function ind = mutate(ind, pm, step, bounds)
for d = 1:2
    if rand < pm
        ind(d) = ind(d) + (2 * rand - 1) * step;
        ind(d) = max(bounds(1), min(bounds(2), ind(d)));
    end
end
end

function plotConvergence(bestHist, avgHist, titleStr, fileName, xlab)
figure('Visible', 'off');
plot(bestHist, 'LineWidth', 2); hold on
plot(avgHist, '--', 'LineWidth', 2);
xlabel(xlab); ylabel('Fitness');
title(titleStr);
grid on; legend({'Best', 'Average'}, 'Location', 'northeast');
set(gca, 'FontSize', 11);
print('-dpng', '-r600', fileName);
close;
end
