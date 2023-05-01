function [Complete_Jamming_Range, Incomplete_Jamming_Range] = JammingRange(H,Receiver_Elevation_Limit,Jammer_Elevation_Limit)
%% JAMMINGRANGE return the threat range of a line-of-sight limited reflective jamming system

%INPUTS
%H altitude in m
%Receiver_Elevation_Limit in deg above horizon
%Jammer_Elevation_Limit in deg above horizon

%OUTPUTS
%Complete_Jamming_Range range in m between receiver and jammer where jamming can be garuanteed for any satellite position
%Incomplete_Jamming_Range range in m between receiver and jammer where jamming becomes possible

%% compute comms radius
%max ground distance between transmitter and receiver- function of altitude and
%elevation limit
R_receiver = earthRadius*ComputeLOSWindow(H,Receiver_Elevation_Limit);

%% compute jamming radius
%max ground distance between transmitter and jammer- function of altitude and
%jammer elevation limit
R_jammer = earthRadius*ComputeLOSWindow(H,Jammer_Elevation_Limit);

%% complete jamming radius is the range between receiver and jammer at which the whole of the comms area around the receiver is covered by jamming
Complete_Jamming_Range = R_jammer-R_receiver;

%% Incomplete jamming range is the range between receiver and jammer at which the edge of the comms and jamming areas touch
Incomplete_Jamming_Range = R_jammer + R_receiver;