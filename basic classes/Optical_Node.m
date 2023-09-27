classdef (Abstract) Optical_Node
    %OPTICAL_NODE an optical transmitter or receiver

    properties
        Telescope = Telescope.empty([0, 1])
    end
end
