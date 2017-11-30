% Find optimal number of ripples. 
% 
% ti=(0:length(signal)-1)*(1/fn); %IN SECONDS
% sh=round(1.5*max(ti));
% xdist=100;
% Xdist=[];
% thr=200;
% 
function[thr]=opt_thr(signal,thr)
fn=1000;
ti=(0:length(signal)-1)*(1/fn); %IN SECONDS
sh=round(1.5*max(ti));
xdist=100;
Xdist=[];
tic


    while xdist>5  
        [S, E, M] = findRipplesLisa(signal, ti.', thr , (thr)*(1/3), []);
        if(length(M)<sh)
            thr=thr-5;
        else
            thr=thr+5;    
        end

        xdist=abs(sh-length(M));
        Xdist=[Xdist xdist];
        ttt=toc;
        
        if ttt>5
            break
        end
    end
    
    
end
    