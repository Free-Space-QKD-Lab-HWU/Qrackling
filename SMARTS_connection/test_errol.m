%%test
clear all
close all
clc

ispr = sitePressure(spr=1013.25, altit=0, height=0);
ico2 = carbon_dioxide(amount=370);
sb = solar_background_errol('executable_path','C:\Git\SMARTS\','stub','C:\Git\QKD_Sat_Link\SMARTS_connection\SMARTS cache\','ispr', ispr);

% ispr2 = sitePressure(spr=1013.25, altit=0, height=0);

sb = sb.update({ispr,ispr, ico2});

test = {ispr, ispr, ico2}
ofType = cellfun(@(object) class(object), test, uniformoutput=false)
bins = unique(ofType)
find(contains(bins, class(ispr)) == 1)

ofType = cellfun(@(object) class(object), test, uniformoutput=false)
bins = unique(cellfun(@(object) class(object), test, uniformoutput=false))

%% hist
new_cards = test;
keys = unique( cellfun(@(object) class(object), ...
                      new_cards, uniformoutput=false) )
counts = zeros(1, numel(keys))
res = cellfun(@(nc) find(contains(keys, class(nc)) == 1), new_cards, uniformoutput=false)
res = [res{:}]

%%testing

card_types = {{'ispr',   'sitePressure'}, ...
              {'iatmos', 'atmosphere'}, ...
              {'ih20',   'water_vapour'}, ...
              {'i03',    'ozone'}, ...
              {'igas',   'carbon_dioxide'}, ...
              {'ico2',   'aerosol'}, ...
              {'iaeros', 'turbidity'}, ...
              {'iturb',  'far_field_albedo'}, ...
              {'ialbdx', 'far_field_albedo'}, ...
              {'isolar', 'extra_spectral'}, ...
              {'iprt',   'printing'}, ...
              {'icirc',  'circum_solar'}, ...
              {'iscan',  'scanning'}, ...
              {'illum',  'illuminance'}, ...
              {'iuv',    'broadband_uv'}, ...
              {'imass',  'solar_position_and_airmass'}};

contains(cellfun(@(pair) pair{2}, card_types, uniformoutput=false), 'sitePressure')
numel(cellfun(@(pair) pair{2}, card_types, uniformoutput=false))

%% indexing/masking
a = linspace(11, 20, 10)
b = mod(a, 2)
c = linspace(1, 10, 4)
a(sub2ind(size(a), c(:)))

a(c(:))

a(mod(a, 2) == 0)
