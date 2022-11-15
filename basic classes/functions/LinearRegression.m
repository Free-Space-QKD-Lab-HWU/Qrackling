function [m,c]=LinearRegression(X,Y)
%return the least-squares regression gradient and y intercept of two
%datasets

%% input validation
if ~(isvector(X)&&isvector(Y))
    error('both inputs must be vectors')
end
if ~(numel(X)==numel(Y))
    error('input vectors must be the same length')
end
if isrow(X)%ensure X and Y are columns
    X=X';
end
if isrow(Y)
    Y=Y';
end

%% regression
X_With_Ones=[ones(numel(X),1),X];
B=X_With_Ones\Y;
m=B(2);
c=B(1);