function LLATData=ReadOrbitLLATFile(LLATFileName)
%%READORBITLLATFILE a function which reads a text file produced by GMAT which stores the Latitude, longitude, altitude and time data of a satellite pass over the UK

%% open the file and assign it an ID
FileID=fopen(LLATFileName);

%% read file as an arrray
LLATData=fscanf(FileID,'%f,%f,%f,%f',[4,inf]);
%then transpose to convert to columns of LLA and T
LLATData=LLATData';

%% close the file
fclose(FileID);
