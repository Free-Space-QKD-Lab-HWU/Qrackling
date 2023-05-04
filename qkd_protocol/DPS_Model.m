function [SKR, QBER, R_sif, SKRp] = DPS_Model(t_dB, mu, V, eta_D, eta_B, freq, R_dark, fe, point, Vp, QBERp, siftedP)

function [secret_key_rate, qber, sifted_key_rate] = DPS_Model( ...
    Source, prob_dark_counts, loss, prot_eff, Detector)

    rep_rate = Source.Repetiton_Rate;
    eta = Detector.Efficiency;

    losses 	= 10.^(-loss/10);

    T = losses * eta_D * eta_B;
    R_sif = rep_rate * mu * T + R_dark;

    e = (1 - V)/2;
    QBER_dark = 0.5 * R_dark ./ R_sif + e;
    QBER_jitter = Detector.QBER_Jitter;
    QBER_encoding = 0.012;
    QBER = min(QBER_dark + QBER_jitter + QBER_encoding, 0.5);

    % Privacy amplification compression factor
    % tau = (1 - 2*mu)*log2(1 - QBER.^2 - (1 - 6*QBER).^2/2); % 2007 formula
    tau = QBER + (1 - QBER).*h((1 + eps(mu, V)/2)); % 2008 formula
    % tau = h((3 + sqrt(5))*QBER); % 2009 formula

    % Secret key rate
    % SKR = R_sif.*(-fe*h(QBER) - tau); % 2007 analysis
    SKR = R_sif.*(1 -fe*h(QBER) - real(tau)); % 2008 and 2009 analysis

    if point
        tau = QBERp + (1 - QBERp).*h((1 + eps(mu, Vp)/2));
        SKRp = siftedP.*(1 -fe*h(QBERp) - real(tau));
    end

end

function [V_] = eps(mu,V)
    V_ = (2*V - 1)*exp(-mu) - 2*sqrt(V*(1 - V))*sqrt(1 - exp(-2*mu));
end
