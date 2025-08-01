function [bestSol, bestHist, avgHist] = de_rastrigin(seed)
% Differential Evolution (DE/rand/1/bin) for 2-D Rastrigin minimisation.
% Produces 'de_convergence.png'.

if nargin < 1, seed = 42; end
rng(seed);

popSize = 30;  gens = 100;  F = 0.5;  Cr = 0.9;
bounds = [-5.12 5.12];

pop = bounds(1) + (bounds(2) - bounds(1)) .* rand(popSize, 2);
bestHist = zeros(gens, 1);  avgHist = zeros(gens, 1);

for g = 1:gens
    fit = rastrigin(pop(:, 1), pop(:, 2));
    bestHist(g) = min(fit);  avgHist(g) = mean(fit);
    newPop = pop;

    for i = 1:popSize
        idx = setdiff(1:popSize, i);
        r = idx(randperm(numel(idx), 3));
        donor = pop(r(1), :) + F .* (pop(r(2), :) - pop(r(3), :));

        trial = zeros(1, 2);
        R = randi(2);
        for j = 1:2
            if rand < Cr || j == R
                trial(j) = donor(j);
            else
                trial(j) = pop(i, j);
            end
        end
        trial = max(bounds(1), min(bounds(2), trial));

        if rastrigin(trial(1), trial(2)) <= fit(i)
            newPop(i, :) = trial;
        end
    end
    pop = newPop;
end

fit = rastrigin(pop(:, 1), pop(:, 2));
[bestFit, bestIdx] = min(fit);
bestSol = pop(bestIdx, :);

fprintf('DE  best (x = %.6f, y = %.6f)  fitness = %.10e\n', bestSol(1), bestSol(2), bestFit);
plotConvergence(bestHist, avgHist, 'DE – 2-D Rastrigin', 'de_convergence.png', 'Generation');
end
