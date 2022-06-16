%% written to compare the outputs of this model to the work in Fig.1a of
%"Link loss analysis for a satellite quantum communication down"
%Zhang, C, Tello Castillo, A, Zanforlin, U, Buller, GS & Donaldson,R.


%first, Dr=1,Dt=0.3
T=BB84_Transmitter(780,0.3,1,0,0);
R=BB84_Receiver(780,1,0,0.6,0,0,10^-9,10);
S=BB84_Satellite('Stationed_at_N_Pole_500km.txt',T);
G=BB84_Ground_Station('ErrolWithMoon780nm.mat',R,'North Pole',[90,0,0]);

N_Points=100;
Distances=linspace(500000,1200000,N_Points);
Link_1_03=Link_Model(N_Points);
n=1;
for Distance=Distances
    Link_1_03=Compute_Link_Loss(Link_1_03,S,G,Distance,n);
    n=n+1;
end


%next, Dr=0.7,Dt=0.08
T=BB84_Transmitter(780,0.08,1,0,0);
R=BB84_Receiver(780,0.7,0,0.6,0,0,10^-9,10);
S=BB84_Satellite('Stationed_at_N_Pole_500km.txt',T);
G=BB84_Ground_Station('ErrolWithMoon780nm.mat',R,'North Pole',[90,0,0]);

N_Points=100;
Distances=linspace(500000,1200000,N_Points);
Link_07_008=Link_Model(N_Points);
n=1;
for Distance=Distances
    Link_07_008=Compute_Link_Loss(Link_07_008,S,G,Distance,n);
    n=n+1;
end


%next, Dr=0.4,Dt=0.08
T=BB84_Transmitter(780,0.08,1,0,0);
R=BB84_Receiver(780,0.4,0,0.6,0,10^-9,10);
S=BB84_Satellite('Stationed_at_N_Pole_500km.txt',T);
G=BB84_Ground_Station('ErrolWithMoon780nm.mat',R,'North Pole',[90,0,0]);

N_Points=100;
Distances=linspace(500000,1200000,N_Points);
Link_04_008=Link_Model(N_Points);
n=1;
for Distance=Distances
    Link_04_008=Compute_Link_Loss(Link_04_008,S,G,Distance,n);
    n=n+1;
end

%finally, Dr=0.28,Dt=0.3
T=BB84_Transmitter(780,0.3,1,0,0);
R=BB84_Receiver(780,0.28,0,0.6,0,0,10^-9,10);
S=BB84_Satellite('Stationed_at_N_Pole_500km.txt',T);
G=BB84_Ground_Station('ErrolWithMoon780nm.mat',R,'North Pole',[90,0,0]);

N_Points=100;
Distances=linspace(500000,1200000,N_Points);
Link_028_03=Link_Model(N_Points);
n=1;
for Distance=Distances
    Link_028_03=Compute_Link_Loss(Link_028_03,S,G,Distance,n);
    n=n+1;
end


plot(Distances,-Link_1_03.Geometric_Loss_dB,Distances,-Link_07_008.Geometric_Loss_dB,Distances,-Link_04_008.Geometric_Loss_dB,Distances,-Link_028_03.Geometric_Loss_dB);
xlabel('Distance (m)');
ylabel('Geometric Loss (dB)');
legend('D_r=1, D_t=0.3','D_r=0.7, D_t=0.08','D_r=0.4, D_t=0.08','D_r=0.28, D_t=0.3')
grid on
