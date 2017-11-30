% Find optimal number of ripples. 
% 
% ti=(0:length(signal)-1)*(1/fn); %IN SECONDS
% sh=round(1.5*max(ti));
% xdist=100;
% Xdist=[];
% thr=200;
% 
function[thr,Xdist,Tdist]=opt_thr(signal,thr)
fn=1000;
ti=(0:length(signal)-1)*(1/fn); %IN SECONDS
sh=round(1.5*max(ti));
xdist=100;
Xdist=[1000 900 800]; %Initializing with random values. 
Tdist=thr;
tic


    while xdist>5  
        [S, E, M] = findRipplesLisa(signal, ti.', thr , (thr)*(1/3), []);
        if(length(M)<sh)
            thr=thr-5;
        end
        if (length(M)>sh)
            thr=thr+5;    
        end

        if  (length(M)==sh)
            break
        end
        
        xdist=abs(sh-length(M))
        Xdist=[Xdist xdist];
        Tdist=[Tdist thr];
        
        ttt=toc;
        
%         if ttt>5
%             break
%         end

          if Xdist(end-2)== Xdist(end)
             if Xdist(end-1)==min([Xdist(end) Xdist(end-1)])
                thr=Tdist(end-1);
             end
              break
          end

    end
    
    
end
    