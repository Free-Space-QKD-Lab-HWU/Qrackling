%% a script which illustrates the frequency of access between SPOQC and HOGS

% link ends
hogs = HOGS();
spoqc = SPOQC();

%how long do we want to simulate?
start_time = datetime(2022,11,1,6,0,0);
stop_time = datetime(2022,12,30,6,0,0);
sample_time = seconds(10);

% determine access
access = nodes.AccessPassSimulation(spoqc,hogs,...
                                    "start_time",start_time,...
                                    "stop_time",stop_time,...
                                    "sample_time",sample_time);