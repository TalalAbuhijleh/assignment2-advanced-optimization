function [bestSol, bestHist, avgHist] = pso_rastrigin(seed)
% Particle Swarm Optimization (global-best) for 2-D Rastrigin minimisation.
% Produces 'pso_convergence.png'.

if nargin < 1, seed = 42; end
rng(seed);  % sets both rand and randi

swarmSize = 30;  iters = 100;
w = 0.7;  c1 = 1.5;  c2 = 1.5;
bounds = [-5.12 5.12];

pos = bounds(1) + (bounds(2) - bounds(1)) .* rand(swarmSize, 2);
vel = -1 + 2 .* rand(swarmSize, 2);

pbest = pos;  pbestVal = rastrigin(pos(:, 1), pos(:, 2));
[gbestVal, gIdx] = min(pbestVal);  gbest = pbest(gIdx, :);

bestHist = zeros(iters, 1);  avgHist = zeros(iters, 1);

for t = 1:iters
    bestHist(t) = gbestVal;
    avgHist(t)  = mean(rastrigin(pos(:, 1), pos(:, 2)));

    for i = 1:swarmSize
        r1 = rand;  r2 = rand;
        vel(i, :) = w .* vel(i, :) + ...
                    c1 .* r1 .* (pbest(i, :) - pos(i, :)) + ...
                    c2 .* r2 .* (gbest      - pos(i, :));

        pos(i, :) = pos(i, :) + vel(i, :);
        % bounds with reflection
        for d = 1:2
            if pos(i, d) < bounds(1) || pos(i, d) > bounds(2)
                vel(i, d) = -vel(i, d);
                pos(i, d) = max(bounds(1), min(bounds(2), pos(i, d)));
            end
        end

        fit = rastrigin(pos(i, 1), pos(i, 2));
        if fit < pbestVal(i)
            pbest(i, :)  = pos(i, :);
            pbestVal(i)  = fit;
            if fit < gbestVal
                gbestVal = fit;  gbest = pos(i, :);
            end
        end
    end
end

bestSol = gbest;
fprintf('PSO best (x = %.6f, y = %.6f)  fitness = %.10e\n', bestSol(1), bestSol(2), gbestVal);
plotConvergence(bestHist, avgHist, 'PSO – 2-D Rastrigin', 'pso_convergence.png', 'Iteration');
end
