function varargout = smarts_files(varargin)

    assert(0 < nargin, 'Some arguments must be supplied');

    p = inputParser;

    parse(p, varargin{:});

end
