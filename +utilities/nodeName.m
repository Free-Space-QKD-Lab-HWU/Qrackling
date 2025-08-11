function name = nodeName(node)
% nodeName
%
% Returns a nicely formatted string naming a network node. The name includes
% the type of node (e.g., Satellite or Ground Station) and its assigned name.
%
% Syntax:
% name = namespace.utility.nodeName(node)
%
% Inputs:
% node – (1×N) nodes.Receiver or nodes.Transmitter, object(s) representing
%        network nodes such as satellites or ground stations.
%
% Outputs:
% name – (1×N) cell array of char vectors, formatted node names.

    arguments
        node {nodes.mustBeReceiverOrTransmitter(node)}
    end

    % Helper functions to extract descriptor from class name
    takeFirst = @(array) array{end};
    extractDescriptor = @(N) ...
        replace(takeFirst(strsplit(class(N), ".")), "_", " ");

    if isscalar(node)
        descriptor_string = extractDescriptor(node); % Node type
        name = [descriptor_string, ': ', char(node.Name)]; % Formatted name
        return
    end

    name = {}; % Preallocate output
    for i = 1:numel(node)
        descriptor_string = extractDescriptor(node(i));
        name{i} = [descriptor_string, ': ', char(node(i).Name)];
    end
end