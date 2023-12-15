function enu = ned2enu(ned)
    % The satellite toolbox returns satellite velocities in the North-
    % East-Down coordinate system when we ask it for positions in LLA.
    % As such it would be convenient to convert these to NED coords to
    % ENU since this is what is already in use in the Located_Object
    %[n, e, d] = utilities.splat(ned');
    n = ned(1, :);
    e = ned(2, :);
    d = ned(3, :);
    enu = [e', n', -d']';
end
