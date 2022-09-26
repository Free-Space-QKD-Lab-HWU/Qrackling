%Author: Peter Barrow
%Date: 12/8/22

function scenario = satelliteScenarioWrapper(startTime, stopTime, varargin)
    p = inputParser;
    addRequired(p, 'startTime', @isdatetime);
    addRequired(p, 'stopTime', @isdatetime);
    addParameter(p, 'sampleTime', nan, @isnumeric);
    addParameter(p, 'numSamples', nan, @isnumeric);

    parse(p, startTime, stopTime, varargin{:});

    if all(arrayfun(@isnan, [p.Results.sampleTime, p.Results.numSamples]))
        error("Must supply either length of each sample in seconds or number of samples")
    end

    if isnan(p.Results.sampleTime)
        % calc sample time from start stop and num
        sampleTime = seconds(stopTime - startTime) / p.Results.numSamples;
    else
        sampleTime = p.Results.sampleTime;
    end

    scenario = satelliteScenario(startTime, stopTime, sampleTime);
end
