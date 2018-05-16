
%ydisp = zeros(7,1);
%pro_obs = zeros(1,1)
%inj_obs = zeros(2,1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%q_SOR = zeros(4,1);
main_var = zeros(4000,100);
OBS = zeros(10,100);
MNT = zeros (10,1);
%Y = zeros (4010,100);
%Y_bar=zeros (4010,1);
delta_Y = zeros (4010,100);
%A = zeros(100,10);
H= [zeros(10,4000) eye(10)];
%K_e=zeros(4010,10);
Y_u=zeros(4010,100);


for ss=0:19
    
    % ------------- Import K and E Realization (first-time-only)+ convert

    a='all_data/all_';  
    c='.dat';
    var_file = sprintf('%s%d%s',a,ss,c);    
    main_var = dlmread (var_file);
    main_var(1:2000,1:100)= log(main_var(1:2000,1:100));
        
    % ============================================ ASSEMBLE Y MATRIX

    for rr=1:1:100   % --------------- Simulation Results, d matrix
        
        a='OBS/delh_';
        b='_';
        c='.out';
        ydisp_file = sprintf('%s%d%s%d%s',a,ss,b,rr,c);
        
        a='OBS/pro_';
        pro_file = sprintf('%s%d%s%d%s',a,ss,b,rr,c);

        a='OBS/inj_';
        inj_file = sprintf('%s%d%s%d%s',a,ss,b,rr,c);
        
        pro_obs = dlmread (pro_file);
        inj_obs = dlmread (inj_file);
        ydisp = 1000*dlmread (ydisp_file);

        OBS(1,rr)=pro_obs;
        OBS(2:3,rr)=inj_obs;
        OBS(4:10,rr)=ydisp;       
     
    end
    
    % ------------- K and E Realization + Prediction
    
    Y = [main_var;OBS];

    % =========================== ASSEMBLE Observation MATRIX + Noise COvar

    a='MNT/delh_';
    c='_11.out';
    ydisp_file = sprintf('%s%d%s',a,ss,c);
        
    a='MNT/pro_';
    pro_file = sprintf('%s%d%s',a,ss,c);

    a='MNT/inj_';
    inj_file = sprintf('%s%d%s',a,ss,c);

    pro_obs = dlmread (pro_file);
    inj_obs = dlmread (inj_file);
    ydisp = 1000*dlmread (ydisp_file);
    
    MNT(1,1)=pro_obs;
    MNT(2:3,1)=inj_obs;
    MNT(4:10,1)=ydisp;       

    MNT(1:2,1)=MNT(1:2,1)+ 0.05*randn(2,1);
    MNT(3,1)=MNT(3,1)+ 0.1*randn(1,1);
    MNT(4:10,1)=MNT(4:10,1)+ 10*randn(7,1);
    
    CD=5^2*eye(10);
    CD(1,1)=0.01^2;
    CD(2,2)=0.01^2;
    CD(3,3)=0.05^2;

    for ii=1:1:3
       if MNT(ii,1)<0
            MNT(ii,1)=0;
       end
    end
    

    % =============================== Deviation Matrix + A

    Y_bar = mean(Y,2);
    for ii=1:100
        delta_Y(1:4010,ii)= Y(1:4010,ii)- Y_bar(1:4010,1); 
    end
    
    % =============================== Kalman Gain matrix and Update

    A=delta_Y'*H';
    K_e = delta_Y*A / 24* (A'*A/24+CD)^-1;
    
    for jj=1:100
        Y_u(1:4010,jj)=Y(1:4010,jj)+K_e*(MNT-H*Y(1:4010,jj));
    end
    
    % ========================= Assemble the Final Results + Re-conversion

    main_var(1:2000,1:100)= exp(Y_u(1:2000,1:100));
    main_var(2001:4000,1:100)= Y_u(2001:4000,1:100);
    
    % ================== Export the Updated Realizations + Itreration Code

    for kk=1:2000
        for ll=1:100
            if (main_var(kk,ll)< 1)
                main_var(kk,ll)= 1;
            end
            if (main_var(kk,ll)> 50000)
                main_var(kk,ll)= 50000;
            end
        end
    end
    
    for kk=2001:4000
        for ll=1:100
            if (main_var(kk,ll)< 10)
                main_var(kk,ll)= 10;
            end
            if (main_var(kk,ll)> 5000)
                main_var(kk,ll)= 5000;
            end
        end
    end        
    
    dlmwrite('it_Code/code.dat',ss+1);
    a='all_data/all_';
    c='.dat';
    var_file = sprintf('%s%d%s',a,ss+1,c);
    dlmwrite(var_file, main_var);
    
    % ====================== Run Simulators
     
    status = dos('Linux.bat');
     
end