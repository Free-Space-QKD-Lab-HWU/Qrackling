function AddToLegend(varargin)
%%ADDTOLEGEND add the input text objects in order to the current figure's legend

leg=legend;
for i=1:nargin
  leg.String{end+1-i}=varargin{i};
end
                