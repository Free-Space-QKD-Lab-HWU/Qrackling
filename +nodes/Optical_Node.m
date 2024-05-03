classdef (Abstract) Optical_Node
    %OPTICAL_NODE an optical transmitter or receiver

    properties
        Telescope components.Telescope = components.Telescope.empty([0, 1])
    end
end
