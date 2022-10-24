%{ Dead Time Correction of Single-Photon Detectors

Laundy, D., Tang, C., et al. (2004), 
Modelling Detector Deadtime with the Pulse Overlap Model, 10.1063/1.1757960

https://doi.org/10.1063/1.1757960

As the emission rate of a single-photon source increases it becomes possible 
to saturate the detector. The effect of detector saturation becomes noticeable 
the closer the rate of photons arriving at the detector gets to the detectors 
(reset) dead time. The result of saturating the detector is to "drop" (lose) 
photons as the arrive for detection. The effect of this is typically ignored 
in a large number of cases as the sources are operated at rates where this 
effect is either negligible or not worth considering. However, given that we 
want to fully explore the parameter space the detectors cover and include 
features that model as many of their effects as possible we include it within 
this model.

The effect of detector saturation can be simply seen as in interaction between 
the repetition rate of a source and the (reset) dead time of the detector. For 
this effect we have to consider its behaviour under two different operating 
regimes, firstly, the pulsed case where a single-photon source is pumped by a 
pulsed laser and so all emitted photons have a minimum time that will separate 
them. Secondly, the continuous wave (c.w.) case where the single-photon source 
is pumped by a c.w. laser and so the photons are emitted at random times. In 
both of these cases the emission properties in time will still follow a 
Poissonian distribution. Of key importance when discussing the emission of 
single-photon sources in this context is what we mean when we state the 
repetition rate, for a pulsed source this is the clock rate of the pump laser 
whereas for a c.w. source this is the measured or expected average rate of 
photons emitted directly from the source after accounting for loss and non-
unit detector efficiency. A complication arises in how these two cases should 
consider the effects of saturation and here we outline the method for the c.w. 
case.

Using the "Pulse Overlap Model" from [Laundy, D., Tang, C., et al. (2004)], 
specifically eq.6 we can calculate the number of photons that should have 
arrived at the detector according to a Poissonian distribution and from that 
the average number that have been detected given the random nature of their 
arrival times. The reasoning behind what we are seeing as saturation or "lost" 
counts at the detector is that due to the Poissonian temporal structure of the 
emitted photons as the average period (= 1 / emission rate) of the emission 
gets closer to the (reset) dead time there is an increased probability that a 
photon will have already been detected and so the next photon arriving is 
ignored by the detector.

Usage:
count_rate: rate of photons arriving at detector in units of integration_time
dead_time: detector (reset) dead time in seconds
integration_time: amount of time refered to by count_rate. NOTE: this must be
                    in seconds

Example usage for a lossy channel where the repetition rate is in Hz, 
detected_rate = dead_time_corrected_count_rate(repetition_rate * loss, ...
                                               detector_reset_time, ..
                                               1);

Implementation note:
At the time of writing this the model has been simplified to some extent to 
set the pair of time constants used to describe the falling and rising edges 
(tau_1 and tau_2 from the referenced paper) equal to each other. This will be 
addressed with further detector characterisation to better accomodate for the
typically assymetric detector responses.
%}

function mu = dead_time_corrected_count_rate(count_rate, dead_time, ...
                                             integration_time)
    % tau = dead_time;
    T = 1; % / rep_rate;
    tauT = dead_time / integration_time;
    tauPrime = dead_time / 2;
    rate = count_rate * tauT;
    ratePrime = count_rate * (tauPrime / integration_time);

    m = count_rate * exp(-count_rate * tauT);

    mu = ( ((1 - rate) ^ 2) * m ) ...
         / ( 1 + (2*exp(-ratePrime)) - (2*exp(-rate) * (1 + rate)) );
end
