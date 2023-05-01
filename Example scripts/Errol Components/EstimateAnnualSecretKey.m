%% use a simulation of HOGS over the year to estimate how much key we should expect per year

%% an example script demonstrating how to simulate the current HOGS model and Quantum comms hub satellite
%{
%% assumptions:
2 channels (785 and 808nm) with roughly equal SKR

asymptotic key rate approximation (not valid for short and poor passes)

%key is only available during clear or mostly clear days as defined by:
2020_05 cloudless and partially cloudy days.xlsx

%key is also only available during twilight or night, as defined by 
https://www.timeanddate.com/sun/@2638360

visibility is held constant at average value of 10km
%}
Num_Channels = 2;
VisString = '10km';
Sky_Clearness = [0.26,0.29,0.31,0.37,0.48,0.47,0.55,0.52,0.46,0.37,0.3,0.27];
Day_Time_Proportion = [7+42/60,9+55/60,12+12/60,14+29/60,16+33/60,17+37/60,16+44/60,15,12+29/60,10+16/60,8+9/60,6+57/60]/24;
Night_Time_Proportion = 1-Day_Time_Proportion;
%which channel should be modelled?
Wavelength = 785;   
Protocol = decoyBB84_Protocol;
%how granular is the modelling?
SampleTime = seconds(10);
Monthly_Key_Estimate = zeros(1,12);
%% model HOGS
OGS=HOGS(Wavelength);%current HOGS model

%% model hub satellite
%iterating over months
for i=1:12
StartTime = datetime(2023,i,1,0,0,0);
StopTime = datetime(2023,i,eomday(2023,i),0,0,0);
Sat=NOTQUARC(Wavelength,StartTime,StopTime,SampleTime);
Pass=PassSimulation(Sat,Protocol,OGS,'Visibility',VisString);
Pass=Simulate(Pass);
Monthly_Key_Estimate(i) = Pass.Total_Sifted_Key*Sky_Clearness(i)*Night_Time_Proportion(i)*Num_Channels;
end


%% print to console
fprintf('Annual secret key estimate = %3.2e bits\n',sum(Monthly_Key_Estimate));
yyaxis left
Months = datetime(2023,1,15,0,0,0):years(1/12):datetime(2023,12,16,0,0,0);
plot(Months,Monthly_Key_Estimate)
ylabel('Secret key estimate per month')
yyaxis right
plot(Months,Sky_Clearness,Months,Night_Time_Proportion)
xlabel('Month')
ylabel('Proportion of access')
legend('','cloudless sky proportion','night-time proportion')