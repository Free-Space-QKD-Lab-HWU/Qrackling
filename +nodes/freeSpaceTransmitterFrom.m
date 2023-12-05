function fs_tx = freeSpaceTransmitterFrom(obj)
    arguments
        obj {mustBeA(obj, ...
            ["nodes.Satellite", "nodes.Ground_Station"])}
    end

    assert(~isempty(obj.Source), [ ...
        'Supplied', class(obj), ' { ', inputname(1), ' } does not have a ', ...
        'source, can not make a transmitter']);

    location = nodes.Located_Object();
    location = location.SetPosition( ...
        'Latitude',  obj.Latitude, ...
        'Longitude', obj.Longitude, ...
        'Altitude',  obj.Altitude);

    switch class(obj)
    case "nodes.Satellite"
        % FIX: this should be extended to cameras so that we can use this for
        % the beacon model as well
        fs_tx = nodes.FreeSpaceTransmitter(obj.Source, obj.Telescope, ...
                location, timestamps = obj.Times);
    case "nodes.Ground_Station"
        fs_tx = nodes.FreeSpaceTransmitter(obj.Source, obj.Telescope, location);
    end

end
