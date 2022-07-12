function Output=SetNaNstoZero(Input)
%%SETNANSTOZERO replace all nans in input array with zeros

NanIndices=isnan(Input);
Input(NanIndices)=0;
Output=Input;