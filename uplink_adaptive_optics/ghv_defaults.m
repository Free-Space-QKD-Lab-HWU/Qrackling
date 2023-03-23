function ghv_args = ghv_defaults(varargin)

    p = inputParser;


    %% default values
    %HV5-7 normal sea level
    A = 17e-15;
    B = 27e-17;
    C = 3.59e-53;
    HA = 100;
    HB = 1500;
    HC = 1000; %these H distances are in m

    addParameter(p, 'A', A, @isnumeric);
    addParameter(p, 'B', B, @isnumeric);
    addParameter(p, 'C', C, @isnumeric);
    addParameter(p, 'HA', HA, @isnumeric);
    addParameter(p, 'HB', HB, @isnumeric);
    addParameter(p, 'HC', HC, @isnumeric);
    addParameter(p, 'Standard', []);

    parse(p, varargin{:});

    if isempty(p.Results.Standard)
        %if no input is provided, use input or defaults
        A = p.Results.A;
        B = p.Results.B;
        C = p.Results.C;
        HA = p.Results.HA;
        HB = p.Results.HB;
        HC = p.Results.HC;
    else

    switch p.Results.Standard
    case 'HV5-7'
    %HV5-7 normal sea level
    A = 17e-15;
    B = 27e-17;
    C = 3.59e-53;

    case '2HV5-7'
    %2 * HV5-7 bad day at sea level
    A = 34e-15;
    B = 54e-17;
    C = 7.18e-53;

    case 'HV10-10'
    %HV10-10 astronomical average
    A = 4.5e-15;
    B = 9e-17;
    C = 2e-53;

    case 'HV15-12'
    %HV15-12 an excellent site
    A = 2e-15;
    B = 7e-17;
    C = 1.54e-53;
        otherwise
            error('GHV defaults can take "Standard" input of "2HV5-7","HV5-7","HV10-10" or "HV15-12"')
    end
    end


    ghv_args = struct('A', A, ...
                      'B', B, ...
                      'C', C, ...
                      'HA', HA, ...
                      'HB', HB, ...
                      'HC', HC);
end
