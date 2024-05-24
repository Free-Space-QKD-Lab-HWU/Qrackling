function name = node_name(node)
% return a nicely formatted string naming a network node
    arguments
        % node {mustBeA(node, ["nodes.Satellite", "nodes.Ground_Station"])}
        node {nodes.mustBeReceiverOrTransmitter(node)}
    end

    TakeFirst = @(array) array{end};
    ExtractDescriptor = @(N) replace(TakeFirst(strsplit(class(N), ".")), "_", " ");

    if isscalar(node)
        descriptor_string = ExtractDescriptor(node);
        name = [descriptor_string, ': ' char(node.Name)];
        return
    end

    name = {};
    for i = 1:numel(node)
        descriptor_string = ExtractDescriptor(node(i));
        name{i} = [descriptor_string, ': ', char(node(i).Name)];
    end
end
