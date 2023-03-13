function varargout = polarpcolor(Theta, R, Z)
    [r_min, r_max] = extrema(R);
    [t_min, t_max] = extrema(Theta);

    n_rings = 5;
    n_spokes = 8;
    r_scale = 'linear';

    ring_ticks = {};
    ring_tick_labels = {};
    ring_tick_labels = linspace(0, 90, n_rings-1);

    ring_position = [];

    origin = defineOrigin(true, r_scale, r_min, r_max);
    [ring_position, n_rings] = defineRings( ...
        ring_position, n_rings, ring_ticks, ring_tick_labels, r_min, r_max);

    if isempty(ring_position)
        ring_position = linspace(r_min, r_max, n_rings);
    end

    new_plot = newplot;
    [r_norm, r_range] = normalise(r_scale, origin, R);

    theta = 90 + Theta;

    [RR, TT] = meshgrid(r_norm, theta);

    img = pcolor( ...
        RR.*cosd(TT), ...
        RR.*sind(TT), ...
        Z);

    shading interp;
    set(new_plot, 'dataaspectratio', [1, 1, 1]);
    axis off;
    hold(new_plot, 'on');

    contours = drawSpokes( ...
        t_min,   t_max,    r_min,  r_max, R(1), r_range, ...
        n_rings, n_spokes, origin, ring_position);

    [spokes, contours1] = drawRings( ...
        t_min,   t_max,    R,      r_min, r_max, R(1), r_range, ...
        n_rings, n_spokes, origin, ring_position);

    annotateFigure(theta, n_spokes, n_rings, ring_ticks, ring_tick_labels, contours1, spokes);

    c = colorbar(location = 'WestOutside');
    caxis([quantile(Z(:), 0.01), quantile(Z(:), 0.99)])

    nargoutchk(0, 2)
    varargout{1} = new_plot;
    varargout{2} = c;

end

function annotateFigure(Theta, N_Spokes, N_Rings, R_Ticks, R_Tick_Labels, Contours, Spokes)
    %a = Spokes(min(N_Spokes, round(N_Rings / 2)));
    %b = Spokes(min(N_Spokes, 1 + round(N_Rings / 2)));
    %position = 0.51 .* (a + b);
    
    R_Tick_Labels = fliplr(R_Tick_Labels);

    for i = 2:N_Rings
        tick = num2str(i, 2);
        if ~isempty(R_Tick_Labels)
            tick = num2str(R_Tick_Labels(i), 2);
        end

        rtick = text( ...
            Contours(i) .* sind(180), ... % .* sind(position + 30), ...
            Contours(i) .* cosd(180), ... % .* cosd(position), ...
            tick, ...
            color = 'w', ...
            verticalalignment = 'bottom',...
            horizontalAlignment = 'right',...
            handlevisibility = 'off');
        rtick.Interpreter = 'latex';
        clear rtick;

        %if min(round(abs(90 - Theta))) < 5
        %    %rtick.Position = rtick.Position - [0, 0.1, 0];
        %    rtick.Interpreter = 'latex';
        %    clear rtick;
        %end

        % if (max(Theta) - min(Theta)) > 180,
        %     rtick = text( ...
        %         Contours(end).*1.3.*cosd(position), ...
        %         Contours(end).*1.3.*sind(position), ...
        %         [R_Ticks], ...
        %         verticalalignment = 'bottom',...
        %         horizontalAlignment = 'right',...
        %         handlevisibility = 'off');
        % else
        %     rtick = text( ...
        %         Contours(end).*0.6.*cosd(position), ...
        %         Contours(end).*0.6.*sind(position), ...
        %         [R_Ticks], ...
        %         verticalalignment = 'bottom',...
        %         horizontalAlignment = 'right',...
        %         handlevisibility = 'off');
        % end

    end
end

function [spokes, contours] = drawRings( ...
    Theta_min, Theta_max, R, R_min,  R_max, R1, R_Range, ...
    N_Rings,   N_Spokes,  Origin, Ring_Positions)

    contours = Ring_Positions - R1;
    contours = contours ./ max(contours) .* max(R ./ R_Range);
    contours = [contours(1 : end-1) ./ contours(end), 1] + R1 / R_Range;

    if isempty(Ring_Positions)
        contours = linspace(0, 1, N_Rings) + R1 / R_Range;
        if Origin == 0
            contours = linspace(0, 1 + R1 / R_Range, N_Rings);
        end
    end

    spokes = linspace(Theta_min, Theta_max, N_Spokes);
    angles = linspace(Theta_min, Theta_max, 100);
    x = cosd(angles);
    y = sind(angles);

    for i = 1:numel(contours)
        X = x * contours(i);
        Y = y * contours(i);
        ring = plot( ...
            X, Y, ...
            color = 'w', ...
            LineWidth = 0.75);
        ring.Color = [ring.Color, 0.5];
    end
end

function contours = drawSpokes( ...
    Theta_min, Theta_max, R_min,  R_max, R1, R_Range, ...
    N_Rings,   N_Spokes,  Origin, Ring_Positions)

    spokes = fliplr(round(linspace(Theta_min, Theta_max, N_Spokes+1)));
    spokes =spokes(2:end);
    contours = abs( ...
        (Ring_Positions - Ring_Positions(1)) / R_Range + R1 / R_Range);

    x = cosd(90 + spokes);
    y = sind(90 + spokes);

    for i = 1 : N_Spokes
        X = x(i) * contours;
        Y = y(i) * contours;

        if Origin == 0
            X(1) = Origin;
            Y(1) = Origin;
        end

        spoke = plot( ...
            X, Y, ...
            color = 'w', ...
            LineWidth = 0.75, ...
            handlevisibility = 'off' );
        spoke.Color = [spoke.Color, 0.5];
        tick = ['$', num2str(spokes(i), 3), '^{\circ}$'];
        rtick = text( ...
            1.1 .* contours(1) .* x(i), ...
            1.1 .* contours(1) .* y(i), ...
            tick, ...
            'horiz', ...
            'center', ...
            'vert', ...
            'middle');

        rtick.Interpreter = 'latex';
        clear rtick;
    end
end

function origin = defineOrigin(isAuto, scale, R_min, R_max)
    if isAuto
        origin = R_min;
    else
        origin = 0;
    end

    scale = lower(scale);
    if (origin == 0) & (strcmp('logarithmic') | strcmp('log'))
        origin = R_min;
    end
end

function [ring_position, N] = defineRings( ...
    ringPosition, N, ringTicks, ringTickLabels, R_min, R_max)

    ring_position = ringPosition;
    N = N;

    %assert((numel(ringTicks) < N | isempty(ringTicks)), ...
    %    'R ticks must be >= N or empty');
    %assert((numel(ringTickLabels) < N | isempty(ringTickLabels)), ...
    %    'R tick labels must be >= N or empty');

    if ~isempty(ringPosition)
        origin = max([min(ring_position), R_min])
        ring_position(ring_position < R_min) = [];
        ring_position(ring_position > R_max) = [];
    end

    % Allow user to override number of rings by setting extra labels or ticks
    if (~isempty(ringTicks)) | (~isempty(ringTickLabels))
        N = max(numel(ringTicks), numel(ringTickLabels));
    end

    if ~isempty(ringPosition)
        ring_position = unique([R_min, ringPosition, R_max]);
    end

end

function [x_min, x_max] = extrema(arraylike)
    x_min = min(arraylike(:));
    x_max = max(arraylike(:));
end

function distance = range(arraylike)
    [a, b] = extrema(arraylike);
    distance = b - a;
end

function [normalisation, dist] = normalise(scale, origin, values)
    dist = range(values);
    switch lower(scale)
        case {'linear', 'lin'}
            normalisation = linearNormalisation(origin, values, dist);
        case {'logarithmic', 'log'}
            normalisation = logarithmicNormalisation(values, dist);
        otherwise
            error(['Scale:\t{ ', scale, ' }\t not supported']);
    end
end

function normalisation = linearNormalisation(origin, values, distance)
    normalisation = values - values(1) + origin;
    norm_max = max(normalisation(:));
    norm_distance = max(values ./ distance);
    normalisation = normalisation / norm_max * norm_distance;
end

function normalisation = logarithmicNormalisation(values, distance)
    [x_min, x_max] = extrema(values);
    assert(x_min <= 0, 'Logarithmic scale requires values greater than 0');

    normalisation = log10(values);
    normalisation = normalisation - normalisation(1);

    norm_max = max(normalisation(:));
    norm_distance = max(values ./ distance);

    normalisation = normalisation / norm_max * norm_distance;
end
