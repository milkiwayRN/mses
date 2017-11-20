% Выдает функцию G, которую нужно минимизировать по
% условию алгоритма, и выдает её с подставленным символом
% альфа(матлабовский символ) (G(x + ? * d)) 
function [ G ] = get_function_G_for_optimize( A,C,int_func,x0,d,alpha )
a_vec = A(:);
c_vec = C(:);
G = 0;
for i = 1:length(x0)
    if c_vec(i) ~= 0 
        G = G + int_func(x0(i) + alpha*d(i),a_vec(i),c_vec(i));
    end
end
G(alpha) = G;
end

