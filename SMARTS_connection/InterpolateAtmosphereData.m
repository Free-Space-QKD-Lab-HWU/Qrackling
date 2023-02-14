%function for interpolating atmosphere data
function Atmosphere_Sweep_Datum = InterpolateAtmosphereData(Atmosphere, Current_Heading,Current_Elevation)


   %extract data
   Heading_Column = Atmosphere.Azimuth(:,1);
   Elevation_Row = Atmosphere.Elevation(1,:);
   Atmosphere_Grid_Data = Atmosphere.data;

   %% first, need interpolation constants
   %used in the form X=alpha*x_i + (1-alpha)*x_(i+1)
   [Heading_Below,Heading_Below_Index] = max(Heading_Column(Heading_Column<Current_Heading));
   Heading_Above_Index = Heading_Below_Index+1;
                %heading should be a complete circle from 0 to 360, therfore
                %allow interpolation around the join
   if Heading_Above_Index<numel(Heading_Column)
                Heading_Above = Heading_Column(Heading_Below_Index+1,1);
   else
                Heading_Above = Heading_Column(1,1);
                Heading_Above_Index = 1;
   end
   Alpha_Heading = (Heading_Above-Current_Heading)/(Heading_Above-Heading_Below);


   %% get the name of variables used so that table-array-table conversion can be done
   VariableNames = Atmosphere.fields(1:end-3); %remove end 3 entries to remove rows, vars, properties

   [Elevation_Below,Elevation_Below_Index] = max(Elevation_Row(Elevation_Row<Current_Elevation));
   Elevation_Above_Index = Elevation_Below_Index + 1;
   Elevation_Above = Elevation_Row(1,Elevation_Above_Index);
   Alpha_Elevation = (Elevation_Above-Current_Elevation)/(Elevation_Above-Elevation_Below);

   %% now, can interpolate

   %convert tables to arrays for numeric use
   Atmosphere_Sweep_Array = Alpha_Heading*Alpha_Elevation*table2array(Atmosphere.sky_dome{Heading_Below_Index,Elevation_Below_Index}.data)+...
                    Alpha_Heading*(1-Alpha_Elevation)*table2array(Atmosphere.sky_dome{Heading_Below_Index,Elevation_Below_Index}.data)+...
                    (1-Alpha_Heading)*Alpha_Elevation*table2array(Atmosphere.sky_dome{Heading_Below_Index,Elevation_Below_Index}.data)+...
                    (1-Alpha_Heading)*(1-Alpha_Elevation)*table2array(Atmosphere.sky_dome{Heading_Below_Index,Elevation_Below_Index}.data);
   %now can convert back
   Atmosphere_Sweep_Datum = array2table(Atmosphere_Sweep_Array,'VariableNames',VariableNames);

end