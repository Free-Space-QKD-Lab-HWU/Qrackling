function ghv = generalised_hufnagel_valley(ghv_args, h)
    ghv = (ghv_args.A .* exp(-h ./ ghv_args.HA)) ...
           + (ghv_args.B .* exp(-h ./ ghv_args.HB)) ...
           + (ghv_args.C .* (h.^10) .* exp(-h ./ ghv_args.HC));
end
