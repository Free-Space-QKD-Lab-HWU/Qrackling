function Location_String=LocationofFile(File_String)
%% LOCATIONOFFILE return the relative path of the folder in which the specified file sits

%% locate path separators in file string
Separator_Locations=isequal(File_String,'\');

%% if no separators are present, or only one at the start return an empty char
if any(Separator_Locations)==false||(Separator_Locations(1)&&sum(Separator_Locations)==1)
    Location_String='';
    return
else
    Separator_Indices=find(Separator_Locations);
    Last_Separator_Index=Separator_Indices(end);
    Location_String=File_String(1:Last_Separator_Index-1);
end