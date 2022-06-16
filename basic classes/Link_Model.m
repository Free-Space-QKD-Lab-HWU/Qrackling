classdef (Abstract=true) Link_Model
    %Link_Model Class for computing link loss
    %   Detailed explanation goes here

    properties (SetAccess=protected,Abstract=true)
        Link_Loss;                                                     %link loss in absolute terms
        Link_Loss_dB;                                                       %link loss measured in dB
    end

    methods (Access=public,Abstract=true)
         [Link_Model,Link_Loss_dB] = Compute_Link_Loss(Link_Model,Located_Obj_1,Located_Obj_2)
            %COMPUTE_LINK_LOSS compute loss between transmitter and
            %receiver

        [Link_Model,Total_Loss_dB]=SetTotalLoss(Link_Model)
        %update total loss to reflect internal stored computations
        
        Plot(Link_Model,X_Axis)
            %% plot link loss
    end

    methods (Access=public,Abstract=false)
        function Link_Loss_dB=GetLinkLossdB(Link_Model)
            %%GETLINKLOSSDB return an array of link losses the same
            %%dimensions as the link model array

            %% measure size of link model and prepare memory
            sz=size(Link_Model);
            Link_Loss_dB=nan(sz);

            %% iterate over the link model
            for i=1:sz(1)
                for j=1:sz(2)
                    Link_Loss_dB(i,j)=Link_Model(i,j).Link_Loss_dB;
                end
            end
        end

       function Link_Loss=GetLinkLoss(Link_Model)
            %%GETLINKLOSS return an array of link losses the same
            %%dimensions as the link model array

            %% measure size of link model and prepare memory
            sz=size(Link_Model);
            Link_Loss=nan(sz);

            %% iterate over the link model
            for i=1:sz(1)
                for j=1:sz(2)
                    Link_Loss(i,j)=Link_Model(i,j).Link_Loss;
                end
            end
        end
    end

end
