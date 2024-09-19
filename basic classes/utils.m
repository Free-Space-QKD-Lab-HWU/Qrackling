% Collection of useful functions
% Currently unsure of whether or not any of these will be moved into specfic
% classes. For now this serves as a namespace to be used elsewhere

classdef utils
    methods
        function l = lengths(varargin)
            n = nargin-1;
            l = zeros(1, n);
            for i = 1: n
                l(i) = numel(varargin{i+1});
            end
        end

        function varargout = splat(varargin)

            n_in = nargin - 1;
            n_out = nargout;

            if ~n_in == 1
                error('Too many input arguments, %d', n_in);
            end

            elements = numel(varargin{2});

            if elements == 0
                error('Nothing to splat')
                return
            end

            if n_out > elements
                error('Splatting up to element %d', n_out);
            end

            if is_1dim(utils, varargin{2})
                for i = 1 : n_out
                    varargout(i) = {varargin{2}(i)};
                end
            else
                major = major_axis(utils, varargin{2});
                if strcmp(major, 'y')
                    for i = 1 : n_out
                        varargout(i) = {varargin{2}(i,:)};
                    end
                else
                    for i = 1 : n_out
                        temp = varargin{2}(:,i);
                        if is_1dim(utils, temp)
                            [xdim, ydim] = size(temp);
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

        function one_dimensional = is_1dim(self, ARRAY)
            one_dimensional = any(size(ARRAY) == 1);
        end

        function major = major_axis(self, ARRAY)
            [x, y] = size(ARRAY);
            if x == 1
                major = 'y';
            else
                major = 'x';
            end
        end

        function enu = ned2enu(self, ned)
            % The satellite toolbox returns satellite velocities in the North-
            % East-Down coordinate system when we ask it for positions in LLA.
            % As such it would be convenient to convert these to NED coords to
            % ENU since this is what is already in use in the Located_Object
            [n, e, d] = utils().splat(ned');
            enu = [e', n', -d']';
        end

        function total = nan_present(target, varargin)
            result = false;
            n = nargin - 1;
            s = 3;
            target = varargin{1};
            total = 0;
            for i = s : n
                try
                    total = total + ~isnan(varargin{i});
                catch
                    total = total;
                end
            end
        end

        function true_anomaly = eccentricity2trueAnomaly(self, eccentricity)
            true_anomaly = 2 .* atan(...
                sqrt(...
                (1 + eccentricity) ...
                / (1 - eccentricity)) ...
                .* tan(eccentricity / 2));
        end

        function semimajor_axis = meanmotion2semimajoraxis(self, mean_motion)
            % TODO is this correct
            M = 5.97237e24;
            G = 6.67430e-11;
            mu = G * M;

            semimajor_axis = mu ./ (mean_motion .^ 2);
        end

        function [name, kepler_elements] = TLE2Kepler(Utils, ...
                varargin)
            % TODO -> expand this out to accept multi TLE settings, currently
            % only works for a single TLE

            p = inputParser;

            addRequired(p, 'Utils');
            addParameter(p, 'TLE', strings(0,0));
            addParameter(p, 'Line1', strings(0,0));
            addParameter(p, 'Line2', strings(0,0));
            addParameter(p, 'name', strings(0,0));

            parse(p, Utils, varargin{:});

            if ~isempty(p.Results.TLE)
                lines = strsplit(p.Results.TLE, "\n");
            end

            if isempty(p.Results.name)
                name = matlab.lang.internal.uuid();
            else
                name = p.Results.name;
            end

            if (2 == length(arrayfun(@isempty, [p.Results.Line1, ...
                    p.Results.Line2])))
                Line1 = p.Results.Line1;
                Line2 = p.Results.Line2;
                lines = {name, Line1, Line2};
            end

            n_tle = length(lines) / 3;
            if n_tle > 1
                name = cell.empty;
            end

            tle_sets = reshape(lines, 3, n_tle);

            inc = zeros(1, n_tle);
            raan = zeros(1, n_tle);
            ecc = zeros(1, n_tle);
            aop = zeros(1, n_tle);
            sma = zeros(1, n_tle);
            ta = zeros(1, n_tle);

            n = 1;
            j = 3;
            for i = 1 : n_tle

                name{i} = tle_sets{n};
                elem2 = split(tle_sets{j});

                inc(i) = str2double(elem2{3});
                raan(i) = str2double(elem2{4});
                ecc(i) = str2double(['0.', elem2{5}]);
                aop(i) = str2double(elem2{6});
                ma = str2double(elem2{7});
                mm = str2double(elem2{8});

                sma(i) = utils().meanmotion2semimajoraxis(mm);
                ta(i) = utils().eccentricity2trueAnomaly(ecc(i));
                n = n + 3;
                j = j + 3;
            end

            kepler_elements = [sma', ecc', inc', raan', aop', ta'];
        end
    end
end