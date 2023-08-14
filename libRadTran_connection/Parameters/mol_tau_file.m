classdef mol_tau_file
    properties (SetAccess = protected)
        Kind
        File
    end
    methods
        function mol = mol_tau_file(kind, file)
            arguments
                kind {mustBeMember(kind, {'sca', 'abs'})}
                file {mustBeFile}
            end
            mol.Kind = kind;
            mol.File = file;
        end
    end
end
