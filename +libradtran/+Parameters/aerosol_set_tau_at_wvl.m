classdef aerosol_set_tau_at_wvl
    properties (Access = protected)
        lambda {mustBeNumeric}
        tau {mustBeNumeric}
   end

   methods
        function tau_at_wvl = aerosol_set_tau_at_wvl(lambda, tau)
            arguments
                lambda {mustBeNumeric}
                tau {mustBeNumeric}
            end
            tau_at_wvl.lambda = lambda;
            tau_at_wvl.tau = tau;
        end
   end
end
