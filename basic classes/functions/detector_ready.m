function pReady = detector_ready(pEmit, eta)

    % syms a b;
    % prob_emit_poisson = @(mpn, n) ((mpn^n) * exp(-mpn)) / factorial(n);
    % % disp(arrayfun(@(mpn) prob_emit_poisson(mpn, 1), MPN));
    % prob_detect_k = @(eta, n, k) (1 - symsum(...
    %                                 nchoosek(n, a)*(eta^a)*((1-eta)^(n-a)), ...
    %                                 a, 0, k-1)) + prob_dark_counts;

    % eta = 10.^(-loss/10).*det_eff;

    % pDetReady = arrayfun( @(mpn) sum(arrayfun( @(n) ...
    %                            (prob_emit_poisson(mpn, n) + prob_dark_counts) ...
    %                            * double(prob_detect_k(1-eta, n, n)), ...
    %                     linspace(0,10,11) )) , MPN .* State_p);

    

end
