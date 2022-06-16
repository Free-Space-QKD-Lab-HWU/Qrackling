function [QBER,Loss,Loss_dB]=JitterPerformance(Histogram,Bin_Width,Repetition_Rate,Gate_Width)
%% return the QBER due to jitter and Loss due to out-of-window arrival from a detector with a given response histogram

%% input validation
%check that Histogram is a correctly computed histogram
if ~(numel(Histogram)>1)&&all(isreal(Histogram)&Histogram>0)
    error('Histogram must be a correctly computed count histogram, of many elements containing positive values')
end
%check that Bin_Width is a real scalar >0
if ~isscalar(Bin_Width)&&isreal(Bin_Width)&&Bin_Width>0
    error('Bin_Width must be a scalar real value >0')
end
%check that repetition rate is a real scalar >0
if ~isscalar(Repetition_Rate)&&isreal(Repetiton_Rate)&&Repetition_Rate>0
    error('Repetition_Rate must be a scalar real value >0')
end
%check that gate width is a real scalar >0
if ~isscalar(Gate_Width)&&isreal(Gate_Width)&&Gate_Width>0
    error('Gate_Width must be a scalar real value >0')
end

%% turn Histogram into a CDF
Total_Counts=sum(Histogram);
N=numel(Histogram);
CDF=zeros(1,N);
PDF=zeros(1,N);
%iterating over elements in the Histogram
PDF(1)=Histogram(1)/Total_Counts;
CDF(1)=0;
for i=2:N
    PDF(i)=Histogram(i)/Total_Counts;
    CDF(i)=sum(PDF(1:i));
end


%% turn time measures into index increments
Gate_Width_Index=2*round(Gate_Width/(2*Bin_Width));
Repetition_Period_Index=round(1/(Repetition_Rate*Bin_Width));
%check that rounding results in reasonable precision
if Gate_Width_Index<10
    warning('gate width is less than 10 histogram bins resulting in rounding errors')
end
if Repetition_Period_Index<10
        warning('repetition period is less than 10 histogram bins resulting in rounding errors')
end

%% compute mode point
[~,Mode_Time_Index]=max(PDF);

%% compute loss
Loss=-CDF(max(Mode_Time_Index-Gate_Width_Index/2,1))+CDF(min(Mode_Time_Index+Gate_Width_Index/2,N));
%convert to dB
Loss_dB=-10*log10(Loss);

%% compute QBER
QBER=0;

%iterating over previous pulses
Current_Shifted_Mode=Mode_Time_Index+Repetition_Period_Index;
while Current_Shifted_Mode<N
QBER=QBER+0.5*(CDF(min(Current_Shifted_Mode+Gate_Width_Index/2,N))-CDF(max(Current_Shifted_Mode-Gate_Width_Index/2,1)));
Current_Shifted_Mode=Current_Shifted_Mode+Repetition_Period_Index;
end

%iterating over forward pulses
Current_Shifted_Mode=Mode_Time_Index-Repetition_Period_Index;
while Current_Shifted_Mode>0
QBER=QBER+0.5*(CDF(min(Current_Shifted_Mode+Gate_Width_Index/2,N))-CDF(max(Current_Shifted_Mode-Gate_Width_Index/2,1)));
Current_Shifted_Mode=Current_Shifted_Mode-Repetition_Period_Index;
end

