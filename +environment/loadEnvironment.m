function env = loadEnvironment(filename)
            % loadEnvironment
            %
            % Create an Environment object from a .mat file at a specified
            % file location (note, this is a wrapped for Environment.load
            % for the purposes of PyQrackling operation
            %
            % Syntax:
            % env = loadEnvironment(filename)
            %
            % Inputs:
            % filename - (1x1) string or char, path to .mat file containing environment data
            %
            % Outputs:
            % env – (1x1) environment.Environment object

     env = environment.Environment.load(filename);