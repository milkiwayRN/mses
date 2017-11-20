%���� ���������� �� ���� ���� ����� ��������� r � s
%E,A,C - ������� �� ������� ������
%func -  ������� �������
%corres - ���������� ���������������, ������� ����� ��������� �� r � s
%oldpath - ������������� �����, � �� ������������ ��� �������,
% ����� ������� �� ��� ���������
% T - ������� ������� ����� ���������, ������� ��� �������� �� �����
% (������� Xij �� �������)

function [ path, cost ] = Find_best_road( r,s,E,A,C,func,corres,oldpath,T )
numOfCols = size(E, 2);
tcost = -1;
tpath = [];
cost = -1;
ispath = 0;%���������, ���� �� �� ���� ������� ���� � s
isunique = 0;
%if length(oldpath)==1
%    disp(['for r = ',num2str(r)]);
%end
for k = 1:numOfCols
    isunique = 1;
    for z = 1:length(oldpath)
        %���� �� ��� ��������� ����� ������� � - �� ���� � ��(����� �����
        %����������� �������� ��������)
        if k == oldpath(z)
            isunique = 0;
        end
    end
    if isunique == 0
        continue
    end
    if E(r,k) == 1%���� ���� ���� �� r � s
        if k == r
            continue
        end
        if k == s% ���� ��� ������ ���� �� r � s
            tcost = double(func(corres + T(r,k),A(r,k),C(r,k)));%��������� ��������� ������� �� �����(r,s)
            tpath = [s];
        else
            [tpath,tcost] = Find_best_road( k,s,E,A,C,func,corres,[oldpath,k],T );
            if tcost == -1%���� �� ���� ���� �� � � s - ������ ����� � �� ���������� :)
                continue
            end
            tcost = tcost + double(func( corres + T(r,k),A(r,k),C(r,k)));%���������� - ��������� ������� �� ����� (r,k) + ��������� ����������� ���� �� k � s
            
        end
        %if length(oldpath)==1
        %    disp(' K tpath')
        %    disp([k,tpath]);
        %    disp('tcost');
        %    disp(tcost);
       % end
        if (((tcost < cost) || cost == -1)&&(tcost ~= -1))%���������� ������ ����
            cost = tcost;
            path = [r,tpath];
            ispath = 1;
        end
    end
    
end
if ispath == 0% ���� �� ������ ���� �� r � s �� ����������
    cost = -1;
    path = [];
end
end

