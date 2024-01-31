function SameDims = AreSameDimensions(varargin)
%ARESAMEDIMENSIONS Returns true if all input arrays are of the same
%dimensions, else returns false

%% input validation
if nargin<=1
    error('AreSameDimensions must take at least 2 inputs')
end

%% validate same dimensions
%take size of first input
Input1=varargin{1};
Dim1=size(Input1);
%iterate through remaining inputs
for n=2:nargin
    NextInput=varargin{n};
    NextDim=size(NextInput);
    if ~isequal(Dim1,NextDim)
        %if not same dimensions, return false
        SameDims=false;
        return
    end
end
%if have not returned yet, all dims are the same, return true
SameDims=true;
end