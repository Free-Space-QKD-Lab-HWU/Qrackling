function AddToLegend(varargin)
%% add the input character vectors to the current figure's legend


                leg=legend;
                for i=1:nargin
                    leg.String{end+1-i}=varargin{i};
                end
                