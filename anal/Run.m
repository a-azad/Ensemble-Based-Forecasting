
for rr=1:100;

    % ============================================ ASSEMBLE Y MATRIX

            
        a='pr/prod_';
        c='.pro';
        pro_file = sprintf('%s%d%s',a,rr,c);
        
        a='pr/prod_';
        c='.inj';
        inj_file = sprintf('%s%d%s%d%s',a,rr,c);

        a='dh/delh_11_';
        c='.out';
        delh_file = sprintf('%s%d%s%d%s',a,rr,c);

        pro_ = dlmread (pro_file);
        inj_ = dlmread (inj_file);
        dh_= dlmread (delh_file);
        coor_= dlmread ('coor.grd');
                
        [m,n]=size(pro_);
        [p,q]=size(inj_);
        [s,t]=size(dh_);
        
        time_p(1:m,1)=pro_(1:m,1);
        time_i(1:p,1)=inj_(1:p,1);
                        
        Oil_1(1:m,rr)=pro_(1:m,2);
        Water_1(1:p,rr)=inj_(1:p,2);
        CSOR(1:p,rr)=inj_(1:p,3);
        dh_vector(1:s,rr)=dh_(1:s,1);


end
  
pro_file='truth/prod.pro';
inj_file='truth/prod.inj';
delh_file='truth/delh.out';

pro_10 = dlmread (pro_file);
inj_10 = dlmread (inj_file);
dh_10= dlmread (delh_file);


% ====================== Run Simulators

subplot(4,1,1); plot(time_p(1:m,1),Oil_1(1:m,1:100),'-g')
hold on; 
subplot(4,1,1); plot(time_p(1:m,1),pro_10(1:m,2),'-k')
hold off;


subplot(4,1,2); plot(time_i(1:p,1),Water_1(1:p,1:100),'-g')
hold on; 
subplot(4,1,2); plot(time_i(1:p,1),inj_10(1:p,2),'-k')
hold off;


subplot(4,1,3); plot(time_p(1:m,1),CSOR(1:p,1:100),'-g')
hold on; 
subplot(4,1,3); plot(time_p(1:m,1),inj_10(1:p,3),'-k')
hold off;


subplot(4,1,4); plot(coor_(1:s,1),dh_vector(1:s,1:25)*100,'-g')
hold on; 
subplot(4,1,4); plot(coor_(1:s,1),dh_10(1:s,1)*100,'-k')
hold off;
  
    

