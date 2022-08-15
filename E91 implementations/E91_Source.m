classdef E91_Source < Source
%E91_Source a source ready for E91
    methods
        function E91_Source = E91_Source(Wavelength)
            %E91_Source Construct an instance of this class

            %construct a transmitter object
            E91_Source=E91_Source@Source(Wavelength);
        end
    end

end