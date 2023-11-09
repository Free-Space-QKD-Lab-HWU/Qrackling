function varargout = polarpcolor(Theta, R, Z, options)
    arguments
        Theta {mustBeNumeric}
        R {mustBeNumeric}
        Z {mustBeNumeric}
        options.TotalRings {mustBeInteger} = 3
        options.TotalSpokes {mustBeInteger} = 8
        options.normalisation {mustBeMember( ...
        options.normalisation, {'linear', 'logarithmic'})} = 'linear'
        options.SpokePositions {mustBeNumeric} = nan
        options.Title {mustBeTextScalar} = ''
        options.Colourbar {mustBeNumericOrLogical} = true,
        options.ColourBarLabel {mustBeTextScalar} = ''
        options.Interpreter {mustBeMember( ...
        options.Interpreter, {'tex', 'latex', 'none'})} = 'tex'
        options.Offset {mustBeNumeric} = 0
        options.Normalisation = [];
    end

    [r_min, r_max] = extrema(R);
    [t_min, t_max] = extrema(Theta);

    n_rings = options.TotalRings + 2;
    n_spokes = options.TotalSpokes;
    % r_scale = 'linear';
    r_scale = options.normalisation;

    ring_ticks = {};
    ring_tick_labels = linspace(0, 90, n_rings-1);

    ring_position = [];

    origin = defineOrigin(true, r_scale, r_min);
    [ring_position, n_rings] = defineRings( ...
        ring_position, n_rings, ring_ticks, ring_tick_labels, r_min);

    if isempty(ring_position)
        ring_position = linspace(r_min, r_max, n_rings);
    end

    new_plot = newplot;
    [r_norm, r_range] = normalise(r_scale, origin, R);

    theta = 90 + Theta;

    [RR, TT] = meshgrid(r_norm, theta);

    [~] = pcolor(RR.*cosd(TT), RR.*sind(TT), Z);

    shading interp;
    set(new_plot, 'dataaspectratio', [1, 1, 1]);
    axis off;
    hold(new_plot, 'on');

    [~] = drawSpokes( ...
        t_min, t_max, R(1), r_range, n_spokes, origin, ring_position, ...
        SpokePositions=options.SpokePositions, Interpreter=options.Interpreter);

    [~, contours1] = drawRings( ...
        t_min, t_max, R, R(1), r_range, n_rings, n_spokes, origin, ring_position);


    annotateFigure(ring_tick_labels, contours1, n_rings, ...
        Interpreter=options.Interpreter, Offset=options.Offset);
    clim([quantile(Z(:), 0.01), quantile(Z(:), 0.99)]);

    if options.Colourbar == true
        c = colorbar(location = 'WestOutside');
        if isempty(options.Normalisation)
            clim([quantile(Z(:), 0.01), quantile(Z(:), 0.99)]);
        else
            clim([options.Normalisation(1), options.Normalisation(2)]);
        end
    end

    if ~isempty(options.ColourBarLabel)
        c.Label.String = options.ColourBarLabel;
    end

    if contains(options.Interpreter, 'latex')
        c.Label.Interpreter = options.Interpreter;
        c.TickLabelInterpreter = options.Interpreter;
    end

    if ~isempty(options.Title)
        title(options.Title);
    end

    nargoutchk(0, 2)
    varargout{1} = new_plot;
    if options.Colourbar == true
        varargout{2} = c;
    end

end

function annotateFigure(R_Tick_Labels, Contours, N_Rings, options)
    arguments
        R_Tick_Labels
        Contours
        N_Rings
        options.Interpreter {mustBeMember( ...
            options.Interpreter, {'tex', 'latex', 'none'})} = 'tex'
        options.Offset {mustBeNumeric} = 0;
    end

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
            Contours(i) .* sind(180 + options.Offset), ... % .* sind(position + 30), ...
            Contours(i) .* cosd(180 + options.Offset), ... % .* cosd(position), ...
            tick, ...
            color = 'w', ...
            verticalalignment = 'bottom',...
            horizontalAlignment = 'right',...
            handlevisibility = 'off');
        rtick.Interpreter = options.Interpreter;
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
    Theta_min, Theta_max, R, R1, R_Range, ...
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
    Theta_min, Theta_max, R1, R_Range, N_Spokes, Origin, Ring_Positions, options)

    arguments
        Theta_min
        Theta_max
        R1
        R_Range
        N_Spokes
        Origin
        Ring_Positions
        options.SpokePositions {mustBeNumeric} = nan
        options.Interpreter {mustBeMember( ...
            options.Interpreter, {'tex', 'latex', 'none'})} = 'tex'
    end

    if ~isnan(options.SpokePositions)
        spokes = options.SpokePositions(1:end-1);
    else
        spokes = fliplr(round(linspace(Theta_min, Theta_max, N_Spokes+1)));
        spokes =spokes(2:end);
    end

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
        if contains(options.Interpreter, 'latex')
            tick = ['$', num2str(spokes(i), 3), '^{\circ}$'];
        else
            tick = [num2str(spokes(i), 3), '\circ'];
        end
        rtick = text( ...
            1.1 .* contours(1) .* x(i), ...
            1.1 .* contours(1) .* y(i), ...
            tick, ...
            'horiz', ...
            'center', ...
            'vert', ...
            'middle');

        rtick.Interpreter = options.Interpreter;
        clear rtick;
    end
end

function origin = defineOrigin(isAuto, scale, R_min)
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

    %assert((numel(ringTicks) < N | isempty(ringTicks)), ...
    %    'R ticks must be >= N or empty');
    %assert((numel(ringTickLabels) < N | isempty(ringTickLabels)), ...
    %    'R tick labels must be >= N or empty');

    if ~isempty(ringPosition)
        %origin = max([min(ring_position), R_min])
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
    [x_min, ~] = extrema(values);
    assert(x_min <= 0, 'Logarithmic scale requires values greater than 0');

    normalisation = log10(values);
    normalisation = normalisation - normalisation(1);

    norm_max = max(normalisation(:));
    norm_distance = max(values ./ distance);

    normalisation = normalisation / norm_max * norm_distance;
end
