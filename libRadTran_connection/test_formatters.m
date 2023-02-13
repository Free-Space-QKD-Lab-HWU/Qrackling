%% run
clear all

p = parameters();
cm = p.crs_model;
r = p.crs_model.rayleigh;
r.Value.Result = r.Value.Option{1};
format_tag(r)

% is OptionResult2Variable the missing link
% something like this?
temp = Variable(TagEnum.IsCondition, Value=r.Value.Result, Parent=r.Parent)
temp.setName(r.Name)

dm = p.deltam;
dm.Value = true;
format_tag(dm)

%% obj
po = parameterToObject(p.crs_model)
po.printOptions()

%% ..
ic = p.ic_properties
icc = parameterToObject(ic)


