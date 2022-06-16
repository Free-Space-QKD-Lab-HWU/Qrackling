function Logical=AreSameSize(varargin)
%%ARESAMESIZE return a logical value which describes whether all inputs
%%have same dimensions

if nargin<2
    error('AreSameSize must take at least 2 inputs')
end

%get first size
sz1=size(varargin{1});

%iterate through other inputs
for n=2:nargin
    szn=size(varargin{n});
    if ~isequal(sz1,szn)
        Logical=false;
        return
    end
end

%if we get to the end, they must all be the same size
Logical=true;
end