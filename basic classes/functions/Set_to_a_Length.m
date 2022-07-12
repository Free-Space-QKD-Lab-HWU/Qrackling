function ArrayOut=Set_to_a_Length(ArrayIn,Length,PadSpecies)
%%SET_TO_A_LENGTH
%input ArrayIn must be a vector
%if a vector is empty, set it to be an array of PadSpecies
%if the vector is populated, pad with PadSpecies or crop to achieve Length

%PadSpecies can be 'zero', 'one' or 'nan'

%% input validation
if isempty(ArrayIn)
    switch PadSpecies
        case 'zero'
  ArrayOut=zeros(1,Length);
        case 'nan'
   ArrayOut=nan(1,Length);
        case 'one'
    ArrayOut=ones(1,Length);
        case 'true'
    ArrayOut=true(1,Length);
        case 'false'
    ArrayOut=false(1,Length);
        otherwise
            error('PadSpecies can be "zero", "one", "false", "true" or "nan"');
    end
    return
end
%% else this vector already has content
if ~isvector(ArrayIn)
    error('input must be a vector');
end
if iscolumn(ArrayIn)%transpose to a row vector
    ArrayIn=ArrayIn';
end

if ~(Length>=0&&mod(Length,1)==0)
    error('Length must be a non-negative integer')
end


if length(ArrayIn)>=Length
    switch PadSpecies
        case 'true'
    ArrayOut=[ArrayIn,true(1,Length-length(ArrayIn))];
        case 'false'
    ArrayOut=[ArrayIn,false(1,Length-length(ArrayIn))];
        case 'zero'
    ArrayOut=[ArrayIn,zeros(1,Length-length(ArrayIn))];
        case 'nan'
    ArrayOut=[ArrayIn,nan(1,Length-length(ArrayIn))];
        case 'one'
    ArrayOut=[ArrayIn,ones(1,Length-length(ArrayIn))];
        otherwise
            error('PadSpecies can be "zero", "one" or "nan"');
    end
    return

else
    ArrayOut=ArrayIn(1:Length);
end

if iscolumn(ArrayIn)%transpose back to a column vector
    ArrayOut=ArrayOut';
end