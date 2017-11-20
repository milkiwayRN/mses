%--------traffic assignment----------
clear all;
syms x;syms a; syms c; syms alpha;
func(x,a,c) = a + (x/c)^4;
D = [0,40,0 ,0;
     0,0 ,70,0;
     0,80,0 ,0;
     0,0 ,0 ,0 ];
A = [0,0,2,3;
     1,0,2,0;
     0,0,0,1;
     1,2,1,0];
C = [0,0,2,3;
     1,0,2,0;
     0,0,0,1;
     1,2,1,0];
E = [0,0,1,1;
     1,0,1,0;
     0,0,0,1;
     1,1,1,0];
T = zeros(size(E,1));
temppath = [];
trash = 0;
%first iteration - find x0
for i = 1:size(D,1)
    for j = 1:size(D,2)
        if D(i,j) ~=0
            [shortestPath,trash] = Find_best_road( i,j,E,A,C,func,D(i,j),[i],zeros(size(E,1)) );
            for z = 1:(length(shortestPath)-1)
                T(shortestPath(z),shortestPath(z + 1)) = T(shortestPath(z),shortestPath(z + 1)) + D(i,j);
            end
        end
    end
end
%end of first iteration
epsilon = inf;
iteration = 0;
int_func = int(func,x,0,x);
int_func(x,a,c) = int_func;
x0 = T(:);
while (epsilon > 1) && (iteration < 10) 
    Y = zeros(size(E,1));
    for i = 1:size(D,1)%составляем кратчайшие пути во взвешенном графе
        for j = 1:size(D,2)
            if D(i,j) ~=0
                [shortestPath,trash] = Find_best_road( i,j,E,A,C,func,D(i,j),[i],T );
                for z = 1:(length(shortestPath)-1)
                    Y(shortestPath(z),shortestPath(z + 1)) = Y(shortestPath(z),shortestPath(z + 1)) + D(i,j);
                end
            end
        end
    end
    % теперь находим направление смещения - d и получаем функцию G для
    % минимизации
    y = Y(:);
    d = y - x0;
    G = get_function_G_for_optimize( A,C,int_func,x0,d,alpha );
    %минимизация функции G и нахождение нового ответа - x0
    alpha_fl = fminbnd(G,0,1);
    y = x0;
    x0 = x0 + d * alpha_fl;
    epsilon = norm(x0 - y);
    iteration = iteration + 1;
    T = reshape(x0,size(T,1),size(T,2));
end

