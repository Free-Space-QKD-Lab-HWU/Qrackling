%% test
clear all
clc

atmosphere_file("Default", "midlatitude_summer")

la = ck_lowtran_absorption("O4", "on")

crs_model_tetraoxygen.

crs_model.Molina

mc_backward("start_x", 1, "start_y", 1, "stop_x", 10, "stop_y", 10)

ic_habit("rough-aggregate")
ic_habit_yang2013("plate_5elements")

mcb = mc_backward_output("edn", "eup", "exp", "edn") ...
    .Absorption("W_per_m3") ...
    .Emission("K_per_day") ...
    .Heating("W_per_m2_and_dz")

mc_escape("on")

mc_forward_output("emission", "unit", "W_per_m2_and_dz")

ic_properties_func(), ...

z_interpolate_func(), ...
zout_func(), ...
zout_interpolate_func(), ...
zout_sea_func(), ...

