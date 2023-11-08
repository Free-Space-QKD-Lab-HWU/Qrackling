function varargout = splat(varargin)

    n_in = nargin;
    n_out = nargout;

    if ~n_in == 1
        error('Too many input arguments, %d', n_in);
    end

    elements = numel(varargin{1});

    if elements == 0
        error('Nothing to splat')
        return
    end

    % if n_out > elements
    %     error('Splatting up to element %d', n_out);
    % end

    if utilities.is_1dim(utilities, varargin{1})
        for i = 1 : n_out
            varargout(i) = {varargin{1}(i)};
        end
    else
        major = major_axis(utilities, varargin{1});
        if strcmp(major, 'y')
            for i = 1 : n_out
                varargout(i) = {varargin{1}(i,:)};
            end
        else
            for i = 1 : n_out
                temp = varargin{1}(:,i);
                if utilities.is_1dim(utilities, temp)
                    %[xdim, ydim] = size(temp);
                    [xdim, ~] = size(temp);
                    if ~(xdim == 1)
                        varargout(i) = {temp'};
                    else
                        varargout(i) = {temp};
                    end
                end
            end
        end
    end
end
