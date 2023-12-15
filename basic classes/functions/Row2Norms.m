% FIX: isn't this just the 'vecnorm' function?
% TODO: replace all instances of this wil vecnorm
function Row_Norms= Row2Norms(Array)
%%ROW2NORMS return a column vector which contains the 2 norm of each row in
%%the 2d array Array

%% input validation
if ~isnumeric(Array)
    error('input to Row2Norms must be numeric')
end
sz=size(Array);
if (numel(sz)>2)
    error('input to Row2Norms must be at most a 2 dimensional array')
end

%% prepare memory
Row_Norms=zeros(sz(1),1);

%% iterate over array to compute 2-norm
for n=1:sz(1)
Row_Norms(n)=norm(Array(n,:));
end
