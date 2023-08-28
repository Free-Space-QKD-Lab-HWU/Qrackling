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


        function true_anomaly = eccentricity2trueAnomaly(self, eccentricity)
            true_anomaly = 2 .* atan(...
                sqrt(...
                (1 + eccentricity) ...
                / (1 - eccentricity)) ...
                .* tan(eccentricity / 2));
        end

        function semimajor_axis = meanmotion2semimajoraxis(self, mean_motion)
            M = 5.97237e24;
            G = 6.67430e-11;
            mu = G * M;

            semimajor_axis = mu ./ (mean_motion .^ 2);
        end

        function [name, kepler_elements] = TLE2Kepler(Utils, ...
                varargin)

            % Derive the names and kepler elements from TLE sets.
            % EXAMPLE
            % fpath = 'threeSatelliteConstellation.tle';
            % if strcmp('.tle', lower(fpath(numel(fpath)-3 : end)))
            %     tledata = readlines(fpath);
            % end
            % [names, k_e] = utils().TLE2Kepler(TLE=tledata)

            p = inputParser;

            addRequired(p, 'Utils');
            addParameter(p, 'TLE', strings(0,0));
            addParameter(p, 'Line1', strings(0,0));
            addParameter(p, 'Line2', strings(0,0));
            addParameter(p, 'name', strings(0,0));

            parse(p, Utils, varargin{:});

            if ~isempty(p.Results.TLE)
                if strcmp('', p.Results.TLE(end))
                    
                    % lines = strsplit(sprintf(...
                    %             '%s', p.Results.TLE(1:end-1)), "\n");
                    lines = p.Results.TLE(1:end-1);
                else
                    lines = strsplit(p.Results.TLE, "\n");
                end
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
            disp(lines)
            disp(numel(lines))
            disp(n_tle);
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

        function start_time = tleStartTime(utils, tle_set)
            % Extract the start time from a two-line element set
            %
            % EXAMPLE:
            % tle_lines = readlines("threeSatelliteConstellation.tle");
            % first_satellite_str = sprintf('%s', join(tleraw(1:3), newline));
            % startTime = utils().tleStartTime(first_satellite_str);
            % stopTime = startTime + hours(5);
            %
            assert(ischar(tle_set), ...
                   'TLE set must be a string or character vector');

            if strcmp('.tle', lower(tle_set(numel(tle_set)-3: end)))
                
            end

            lines = strsplit(tle_set, '\n');
            assert(3 == numel(lines), 'TLE set malformed, must be 3 lines');
            assert(69 == numel(lines{2}), ...
                'TLE set malformed, line 1 must be 69 characters long');
            assert(69 == numel(lines{3}), ...
                'TLE set malformed, line 2 must be 69 characters long');

            year = str2num(lines{2}(19:20));
            % this is shakey but since we only get the last two digits of the
            % year from the tle set assume that if its greater than 30 (writing
            % this is 2022) that the TLE data is probably from 19XX.
            warning(['### POTENTIALLY INCORRECT YEAR ###', newline, ...
                'Only the last two digits of the year are provided in ', ...
                'the TLE format. Adjust the year as needed']);
            if 50 < year
                year = 1900 + year;
            else
                year = 2000 + year;
            end

            month_year_ratio = 365 / 12;

            days = str2num(lines{2}(21:32));

            month = floor(days / month_year_ratio);
            day = floor(days - floor(month_year_ratio * month));

            HOUR = (days - (floor(month_year_ratio * month) + day)) * 24;
            hour = floor(HOUR);

            MINUTES = (HOUR - hour) * 60;
            minutes = floor(MINUTES);

            seconds = (MINUTES - minutes) * 60;

            start_time = datetime(year, month, day, hour, minutes, seconds);
        end



    end

    methods(Static)

        function total = nan_present(varargin)
            n = nargin - 1;
            s = 3;
            total = 0;
            for i = s : n
                try
                    total = total + ~isnan(varargin{i});
                catch
                    total = total;
                end
            end
        end

        function msg = sameSizeMessage(arg_name_a, arg_name_b)
            msg = ['Argument: ', arg_name_a, ', and Argument : ', ...
                arg_name_b, ', are of different sizes'];
        end

        function result = sameSize(A, B)
            size_a = size(A);
            size_b = size(B);
            result = (size_a(1) == size_b(1)) && (size_a(2) == size_b(2));
        end

        function k = wavenumberFromWavelength(wvl)
            k = 2 .* pi ./ wvl;
        end

        function wvl = wavelengthFromWavenumber(k)
            wvl = 2 .* pi ./ k;
        end

        function dydx = FiniteDifferenceGradient(x, y)
            assert(utils.sameSize(WindShear, LapseRate), ...
                utils.sameSizeMessage(inputname(1), inputname(2)));

            dydx = zeros(size(x));

            for i = 2:numel(x)
                j = i - 1;
                dy = y(j) - y(i);
                dx = x(j) - x(i);
                dydx(j) = dy / dx;
            end

        end

    end

end
