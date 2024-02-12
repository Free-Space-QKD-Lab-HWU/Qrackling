function ex_path = locate_examples()
    loc = which("nodes.Satellite");
    [path, ~, ~] = fileparts(loc);
    elems = strsplit(path, filesep);
    ex_path = string(join(elems(1:end-2), filesep)) + filesep + "Examples" + filesep;
end
