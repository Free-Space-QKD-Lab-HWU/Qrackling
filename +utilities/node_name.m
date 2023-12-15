function name = node_name(node)
%return a nicely formatted string naming a network node

arguments
    node {mustBeA(node, ["nodes.Satellite", "nodes.Ground_Station"])}
end

takeFirst = @(array) array{end};
descriptor_string = replace(takeFirst(strsplit(class(node), ".")), "_", " ");

name = [descriptor_string, ': ' char(node.Location_Name)];
