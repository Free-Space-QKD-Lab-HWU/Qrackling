function val = memberOfSet(thing, options)
    arguments
        thing double
        options.HV HufnagelValley
        options.AF AFGL_Plus
    end

    disp(options)

    disp(thing);
    val = 1;
end

function x = thisthing(type, object)
    arguments
        type {mustBeText, mustBeNonempty}
        object
    end

    x = isa(object, type);
end
