function Beam_Width_Increase = long_term_gaussian_beam_width(Geometric_Beam_Size, ...
                                               L, ...
                                               wavenumber, ...
                                               atmospheric_turbulence)


%% input validation
assert(all(isequal(size(L),size(Geometric_Beam_Size),size(atmospheric_turbulence))),'All inputs (except wavenumber) must have the same dimensions')
    B = 2 * (((4.2 .* L) ./ (wavenumber .* atmospheric_turbulence)).^2);
    C_with_turbulence = Geometric_Beam_Size.^2 + B;
    width_with_turbulence = sqrt(C_with_turbulence);



    Beam_Width_Increase = width_with_turbulence./Geometric_Beam_Size;
    %width = sqrt((beam_waist .^ 2) .* (1 + ((L.^2) ./ (rayleigh_range .^ 2))));
end
