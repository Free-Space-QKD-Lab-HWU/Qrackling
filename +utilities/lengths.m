function l = lengths(varargin)
    n = nargin;
    disp(n)
    l = zeros(1, n);
    for i = 1: n
        l(i) = numel(varargin{i});
    end
end
