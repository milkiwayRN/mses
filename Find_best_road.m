function [ path, cost ] = Find_best_road( r,s,E,A,C,func,corres,oldpath,T )
numOfCols = size(E, 2);
tcost = 0;
tpath = [];
cost = -1;
ispath = 0;
isunique = 0;
for k = 1:numOfCols
    isunique = 1;
    for z = 1:length(oldpath)
        if k == oldpath(z)
            isunique = 0;
        end
    end
    if isunique == 0
        continue
    end
    if E(r,k) == 1
        if k == r
            continue
        end
        if k == s
            tcost = double(func(corres + T(r,k),A(r,k),C(r,k)));
            tpath = [s];
        else
            [tpath,tcost] = Find_best_road( k,s,E,A,C,func,corres,[oldpath,k],T );
            if tcost == -1
                continue
            end
            tcost = tcost + double(func(corres,A(r,k),C(r,k)));
            
        end
        if (((tcost < cost) || cost == -1)&&(tcost ~= -1))
            cost = tcost;
            path = [r,tpath];
            ispath = 1;
        end
    end
end
if ispath == 0
    cost = -1;
    path = [];
end
end

