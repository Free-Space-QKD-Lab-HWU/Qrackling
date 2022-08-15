function ghv_args = ghv_defaults(varargin)

    p = inputParser;

    A = 17e-15;
    B = 27e-17;
    C = 3.59e-53;
    HA = 100;
    HB = 1500;
    HC = 1000;

    addParameter(p, 'A', A, @isnumeric);
    addParameter(p, 'B', B, @isnumeric);
    addParameter(p, 'C', C, @isnumeric);
    addParameter(p, 'HA', HA, @isnumeric);
    addParameter(p, 'HB', HB, @isnumeric);
    addParameter(p, 'HC', HC, @isnumeric);

    parse(p, varargin{:});

    ghv_args = struct('A', p.Results.A, ...
                      'B', p.Results.B, ...
                      'C', p.Results.C, ...
                      'HA', p.Results.HA, ...
                      'HB', p.Results.HB, ...
                      'HC', p.Results.HC);
end
