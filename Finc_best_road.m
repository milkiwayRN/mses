function [ path, cost ] = Finc_best_road(r,s,E,A,C,func,price,T)
    Temp = zeros(size(T,1));
    for i = 1:size(T,1)
        for j = 1:size(T,2)
            if E(i,j)~=0
                Temp(i,j)=func(T(i,j)+price,A(i,j),C(i,j));
            end
        end
    end
    [cost path] = dijkstra(Temp,r,s);
    path = path(end:-1:1);
end