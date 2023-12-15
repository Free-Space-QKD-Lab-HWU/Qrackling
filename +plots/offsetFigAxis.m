function varargout = offsetFigAxis(Axes, varargin)

    p = inputParser;
    p.addParameter('x', 0);
    p.addParameter('y', 0.1);
    p.addParameter('xlocation', 'bottom');
    p.addParameter('ylocation', 'left');
    p.parse(varargin{:});
    Results = p.Results;

    %[have_x, have_y] = destructure_array([Results.x, Results.y] > 0);
    have_x = Results.x > 0;
    have_y = Results.y > 0;
    %assert(sum(use_axis) > 0, 'Atleast one axis must have an offset');

    parent = ancestor(Axes(:), {'figure', 'uipanel'});
    if numel(Axes) == 1
        parent = {parent};
    end

    axis_colour = cell(size(Axes));
    [axis_colour{:}] = deal('none');

    if have_x
        x_axes = gobjects(size(Axes));
    end

    if have_y
        y_axes = gobjects(size(Axes));
    end

    for i = 1:numel(Axes)
        if have_x
            x_axes(i) = offsetAxis(Axes(i), x_axes(i), parent{i}, 'x', Results);
        end
        if have_y
            disp(y_axes(i))
            y_axes(i) = offsetAxis(Axes(i), y_axes(i), parent{i}, 'y', Results);
        end
    end


end

function Axis = offsetAxis(Axes, Axis, Parent, choice, colour, vArgs)
    assert(sum(contains({'x', 'y'}, lower(choice))) > 0, ...
        'Choice of axis must be "x" or "y"');

    position = get(Axis, 'position');

    switch choice
        case ' x'
            new_position = [ ...
                pos(1), ...
                pos(2) - pos(4) * Opt.x, ...
                pos(3), ...
                pos(4) + 2 * pos(4) * Opt.x ...
            ];
        case 'y'
            new_position = [ ...
                pos(1) - pos(3) * Opt.y, ...
                pos(2), ...
                pos(3) + 2 * Opt.y * pos(3), ...
                pos(4) ...
            ];
    end

    UpdatedAxis = axes('parent', Parent, ...
            'position', new_position, ...
            'color', 'none', ...
            'xcolor', colour);

    nAxis = [upper(choice), 'Axis'];
    switch class(get(Axes, nAxis))
        case 'matlab.graphics.axis.decorator.DatetimeRuler'
            set(UpdatedAxis, nAxis, matlab.graphics.axis.decorator.DatetimeRuler);
        case 'matlab.graphics.axis.decorator.DurationRuler'
            set(UpdatedAxis, nAxis, matlab.graphics.axis.decorator.DurationRuler);
        case 'matlab.graphics.axis.decorator.CategoricalRuler'
            set(UpdatedAxis, nAxis, matlab.graphics.axis.decorator.CategoricalRuler);
    end

    choice = lower(choice);

    keys = cellfun(@(s) [choice,s], ...
        {'lim', 'dir', 'tick', 'ticklabel', 'label'}, ...
        UniformOutput=false);
    keys{numel(keys)+1} = 'TickDir';

    for i = 1:numel(keys)
        key = keys(i);
        set(Axis, key, get(Axis, key));
    end

    set(Axis, [choice, 'color'], colour, [choice, 'tick'], []);
    link = linkprop([Axes, Axis], [upper(choice), 'Lim']);
    setappdata(Axes, [choice, 'offsetlink'], link);

    switch lower(choice)
        case 'y'
            switch vArgs.ylocation
                case {'lr', 'rl'}
                    set(UpdateAxis, 'box', 'on');
                case 'l'
                    set(UpdateAxis, 'box', 'off', 'yaxisloc', 'left');
                case 'r'
                    set(UpdateAxis, 'box', 'off', 'yaxisloc', 'right');
            end
            uistack(UpdateAxis, 'bottom');

        case 'x'
            switch vArgs.xlocation
                case {'tb', 'bt'}
                    set(hx(iax), 'box', 'on');
                case 't'
                    set(hx(iax), 'box', 'off', 'xaxisloc', 'top');
                case 'b'
                    set(hx(iax), 'box', 'off', 'xaxisloc', 'bottom');
            end
            uistack(hx(iax), 'bottom');
    end

end

function varargout = destructure_array(array)
    s = numel(array);
    n = nargout;

    assert(n > s, 'Array is empty');
    if n == 0; return; end

    for i = 1:n
        varargout(i) = {array(i)};
    end
end
