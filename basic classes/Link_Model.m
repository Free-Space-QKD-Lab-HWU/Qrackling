% TODO
% this is being used to later define data in an Array-of-Structs formalism, 
% seems nice on paper but would like to change to Struct-of-Arrays since its
% easier to work with plus data oriented design is just preferable
classdef (Abstract=true) Link_Model
    %%LINK_MODEL Class for computing and storing link loss

    properties (SetAccess=protected,Abstract=true)
        N                                                                  %number of timestamps modelled. Equal to the number of columns and number of elements of each loss vector

        %all losses are recorded in a row vector with N elements
        Link_Loss;                                                         %link loss in absolute terms
        Link_Loss_dB;                                                      %link loss measured in dB
    end

    methods (Access=public,Abstract=true)
        [Link_Model,Link_Loss_dB] = Compute_Link_Loss(Link_Model,Located_Obj_1,Located_Obj_2)
        %%COMPUTE_LINK_LOSS compute loss between transmitter and
        %receiver

        [Link_Model,Total_Loss_dB]=SetTotalLoss(Link_Model)
        %%SETTOTALLOSSupdate total loss to reflect internal stored computations

        [Link_Model] = SetNumSteps(Link_Model,N)
        %set the number of time steps a link model computes for

        Plot(Link_Model,X_Axis)
        %%PLOT plot link loss over a given x axis
    end

    methods (Access=public,Abstract=false)
        function Link_Loss_dB=GetLinkLossdB(Link_Model)
            %%GETLINKLOSSDB return an array of link losses in dB

            %% output Link loss db array
            Link_Loss_dB = Link_Model.Link_Loss_dB;
        end

        function Link_Loss=GetLinkLoss(Link_Model)
            %%GETLINKLOSS return an array of link losses
            
            %% output Link loss db array
            Link_Loss = Link_Model.Link_Loss;
        end
    end

end
