%ищет наименьший по цене путь между вершинами r и s
%E,A,C - матрицы из условия задачи
%func -  весовая функция
%corres - количество корреспонденции, которую нужно доставить из r в s
%oldpath - вспомоателная штука, в неё записываются все вершины,
% через которые мы уже проходили
% T - матрица потоков между вершинами, которые уже проходят по путям
% (матрица Xij из условия)

function [ path, cost ] = Find_best_road( r,s,E,A,C,func,corres,oldpath,T )
numOfCols = size(E, 2);
tcost = -1;
tpath = [];
cost = -1;
ispath = 0;%индикатор, есть ли из этой вершины путь в s
isunique = 0;
%if length(oldpath)==1
%    disp(['for r = ',num2str(r)]);
%end
for k = 1:numOfCols
    isunique = 1;
    for z = 1:length(oldpath)
        %если мы уже проходили через вершину к - не идем в неё(иначе можно
        %бесконечную рекурсию получить)
        if k == oldpath(z)
            isunique = 0;
        end
    end
    if isunique == 0
        continue
    end
    if E(r,k) == 1%если есть путь из r в s
        if k == r
            continue
        end
        if k == s% если это прямой путь из r в s
            tcost = double(func(corres + T(r,k),A(r,k),C(r,k)));%вычисляем стоимость прохода по ребру(r,s)
            tpath = [s];
        else
            [tpath,tcost] = Find_best_road( k,s,E,A,C,func,corres,[oldpath,k],T );
            if tcost == -1%если не было пути из к в s - дальше можно и не продолжать :)
                continue
            end
            tcost = tcost + double(func( corres + T(r,k),A(r,k),C(r,k)));%фактически - стоимость прохода по ребру (r,k) + стоимость кратчайшего пути из k в s
            
        end
        %if length(oldpath)==1
        %    disp(' K tpath')
        %    disp([k,tpath]);
        %    disp('tcost');
        %    disp(tcost);
       % end
        if (((tcost < cost) || cost == -1)&&(tcost ~= -1))%записываем лучший путь
            cost = tcost;
            path = [r,tpath];
            ispath = 1;
        end
    end
    
end
if ispath == 0% если ни одного пути из r в s не существует
    cost = -1;
    path = [];
end
end

