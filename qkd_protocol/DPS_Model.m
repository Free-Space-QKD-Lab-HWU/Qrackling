function [Secret_Key_Rate, QBER, Sifted_Key_Rate] = DPS_Model( ...
    Source, prob_dark_counts, loss, prot_eff, Detector)

    rep_rate = Source.Repetition_Rate;
    eta = Detector.Detection_Efficiency;
    V = Detector.Visibility;
    mu = Source.Mean_Photon_Number;
    f=1.2;%error correction efficiency

    losses 	= 10.^(-loss/10);

    T = losses * eta;
    Sifted_Key_Rate = rep_rate *(mu * T + prob_dark_counts);

    QBER_Visibility = (1 - V)/2;
    QBER_dark = 0.5 * prob_dark_counts;
    QBER_encoding = 0.012;

    QBER = min(QBER_dark + QBER_encoding + QBER_Visibility, 0.5);

    % Privacy amplification compression factor
    % tau = (1 - 2*mu)*log2(1 - QBER.^2 - (1 - 6*QBER).^2/2); % 2007 formula
    tau = QBER + (1 - QBER).*h((1 + eps(mu, V)/2)); % 2008 formula
    % tau = h((3 + sqrt(5))*QBER); % 2009 formula

    % Secret key rate
    % SKR = R_sif.*(-fe*h(QBER) - tau); % 2007 analysis
    Secret_Key_Rate = Sifted_Key_Rate.*(1 -f*h(QBER) - real(tau)); % 2008 and 2009 analysis

    %{
    if point
        tau = QBERp + (1 - QBERp).*h((1 + eps(mu, Vp)/2));
        SKRp = siftedP.*(1 -fe*h(QBERp) - real(tau));
    end
    %}
end

function [V_] = eps(mu,V)
    V_ = (2*V - 1).*exp(-mu) - 2*sqrt(V.*(1 - V))*sqrt(1 - exp(-2*mu));
end

function y = h(x)
%the binary entropy function
y = x.*log2(x) + (1-x).*log2(1-x);
end
