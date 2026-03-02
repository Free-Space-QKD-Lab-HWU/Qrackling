function env = loadPreset(visibility)
            % loadPreset
            %
            % Create an Environment object from a .mat file with a specified
            % visibility in m
            % (note, this is a wrapped for Environment.load
            % for the purposes of PyQrackling operation)
            %
            % Syntax:
            % env = loadPreset(visibility)
            %
            % Inputs:
            % visibility - (1x1) numeric representing visibility in m
            %
            % Outputs:
            % env – (1x1) environment.Environment object
       arguments
           visibility (1,1) 
       end

    % input validation
    % Validate visibility input
    validVisibilities = [100, 200, 500, 1000, 2000, 5000, 10000, 20000, 50000, inf];
    if ~ismember(visibility, validVisibilities)
        error('Invalid visibility value %s. Must be one of the following: %s', num2str(visibility), num2str(validVisibilities));
    end

     switch visibility
         case 100
             file_path = "Examples\Data\atmospheric transmittance\Dark Environment 100m.mat";
         case 200
             file_path = "Examples\Data\atmospheric transmittance\Dark Environment 200m.mat";
         case 500
             file_path = "Examples\Data\atmospheric transmittance\Dark Environment 500m.mat";
         case 1000
             file_path = "Examples\Data\atmospheric transmittance\Dark Environment 1km.mat";
         case 2000
             file_path = "Examples\Data\atmospheric transmittance\Dark Environment 2km.mat";
         case 5000
             file_path = "Examples\Data\atmospheric transmittance\Dark Environment 5km.mat";
         case 10000
             file_path = "Examples\Data\atmospheric transmittance\Dark Environment 10km.mat";
         case 20000
             file_path = "Examples\Data\atmospheric transmittance\Dark Environment 20km.mat";
         case 50000
             file_path = "Examples\Data\atmospheric transmittance\Dark Environment 50km.mat";
         case inf
             file_path = "Examples\Data\atmospheric transmittance\Dark Environment clear.mat";
     end
     
     % Load the environment from the specified file
     env = environment.Environment.load(file_path);