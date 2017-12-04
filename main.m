function T = main(A, C, D, E, eps, iter, func)

T = zeros(size(E, 1));

% first iteration - find x0
for i = 1 : size(D, 1)
    for j = 1 : size(D, 2)
        if D(i, j) ~=0
            [shortestPath, ~] = fastFindBestRoad(i, j, E, A, C, func, D(i, j), zeros(size(E, 1)));
            for z = 1 : (length(shortestPath) - 1)
                T(shortestPath(z), shortestPath(z + 1)) = T(shortestPath(z), shortestPath(z + 1)) + D(i, j);
            end
        end
    end
end
% end of first iteration

int_func = int(func, x, 0, x);
int_func(x, a, c) = int_func;
x0 = T(:);

epsilon = inf;
iteration = 0;

while (epsilon > eps) && (iteration < iter) 
    Y = zeros(size(E, 1));
    for i = 1 : size(D, 1) % составляем кратчайшие пути во взвешенном графе
        for j = 1 : size(D, 2)
            if D(i, j) ~=0
                [shortestPath, ~] = fastFindBestRoad(i, j, E, A, C, func, D(i, j), T);
                for z = 1 : (length(shortestPath) - 1)
                    Y(shortestPath(z), shortestPath(z + 1)) = Y(shortestPath(z), shortestPath(z + 1)) + D(i, j);
                end
            end
        end
    end
    
    % теперь находим направление смещения - d и получаем функцию G для
    % минимизации
    y = Y(:);
    d = y - x0;
    G = getFunctionGForOptimize(A, C, int_func, x0, d, alpha);
    
    % минимизация функции G и нахождение нового ответа - x0
    alpha_fl = fminbnd(G, 0, 1);
    y = x0;
    x0 = x0 + d * alpha_fl;
    epsilon = norm(x0 - y);
    iteration = iteration + 1;
    T = reshape(x0, size(T, 1), size(T, 2));
end
end

