function varargout = dopFromStokes(i_data, q_data, u_data, v_data, direction)
% DOPFROMSTOKES Calculates the degree of polarisation from Stokes parameters
% Takes an array for each Stokes parameter and optionally a repeating argument
% for polarisation direction. The direction arguments specifies if the full (
% I, Q, U, V), linear (I, Q, U) or circular (I, V) parameters are to be used.
% This argument can be repeated allowing for all variations to be calculated.
% If no direction is supplied then the full degree of polarisation is 
% calculated, otherwise the specific cases are returned in the order they are 
% specified in the function call.
% ----
% Performs: 
%   "Direction" {I[], Q[], U[], V[]} -> Direction[]
%   "Direction1, Direction2" {I[], Q[], U[], V[]} -> {Direction1[], Direction2[]}
%   etc, etc.
% ----
% Example usage:
% full = libradtran.dopFromStokes(I, Q, U, V);
% full = libradtran.dopFromStokes(I, Q, U, V, "Full");
% circular = libradtran.dopFromStokes(I, Q, U, V, "Circular");
% [full, linear] = libradtran.dopFromStokes(I, Q, U, V, "Full", "Linear");
% [full, linear, circular] = ...
%       libradtran.dopFromStokes(I, Q, U, V, "Full", "Linear", "Circular");

    arguments
        i_data { mustBeNonempty, mustBeNumeric }
        q_data { mustBeNonempty, mustBeNumeric }
        u_data { mustBeNonempty, mustBeNumeric }
        v_data { mustBeNonempty, mustBeNumeric }
    end

    arguments (Repeating)
        direction { mustBeMember(direction, { 'Full', 'Linear', 'Circular' }) }
    end

    directions = unique(cellstr(direction));
    % if we supply any 'direction' arguments that should set the minimum number
    % of returned values
    n_dirs = numel(directions);
    nargoutchk(n_dirs, 3)
    % we will reasign this to varargout later, the functions calculating the
    % dop can all fail
    tmp = cell(nargout, 1);

    % in the case no 'direction' is supplied, calculate the full dop and return
    if n_dirs == 0
        tmp{1} = fullDegreeOfPolarisation(i_data, q_data, u_data, v_data);
        varargout = tmp;
        return
    end

    idx = linspace(1, n_dirs, n_dirs);
    out_arg_idx = @(d) max(contains(cellstr(direction), d) .* idx);
    for d = directions'
        i = out_arg_idx(d{1});
        switch d{1}
        case 'Full'
            tmp{i} = fullDegreeOfPolarisation(i_data, q_data, u_data, v_data);
        case 'Linear'
            tmp{i} = linearDegreeOfPolarisation(i_data, q_data, u_data);
        case 'Circular'
            tmp{i} = circularDegreeOfPolarisation(i_data, v_data);
        end
    end

    varargout = tmp;
end

function p = fullDegreeOfPolarisation(i, q, u, v)
    arguments
        i {mustBeNumeric}
        q {mustBeNumeric}
        u {mustBeNumeric}
        v {mustBeNumeric}
    end

    utilities.equalDimensions(i, q);
    utilities.equalDimensions(q, u);
    utilities.equalDimensions(u, v);

    p = sqrt((q .^ 2) + (u .^ 2) + (v .^ 2)) ./ i;
end

function p_lin = linearDegreeOfPolarisation(i, q, u)
    arguments
        i {mustBeNumeric}
        q {mustBeNumeric}
        u {mustBeNumeric}
    end

    utilities.equalDimensions(i, q);
    utilities.equalDimensions(q, u);

    p_lin = sqrt((q .^ 2) + (u .^ 2)) ./ i;
end

function p_circ = circularDegreeOfPolarisation(i, v)
    arguments
        i {mustBeNumeric}
        v {mustBeNumeric}
    end

    utilities.equalDimensions(i, v);

    p_circ = v ./ i;
end
