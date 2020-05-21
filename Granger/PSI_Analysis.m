%%
function psi_val=PSI_Analysis(cwt_sig_area_1,cwt_sig_area_2,F)
 
% Phase-slope index for two signals 
 
%Initialize
% F is the vector of frequencies used to decompose the signal in the
% analytical signal 
S_12=zeros(numel(F),1);
S_11=zeros(numel(F),1);
S_22=zeros(numel(F),1);
 
C_12=zeros(numel(F),1);
C_12_jk=zeros(numel(F),4);
 
% Here cwt_sig_are 1 and 2 are the two analytical signals FxT (F are the frequencies used and T is time bins)
 
tb=size(cwt_sig_area_1,2);
 
for ff=1:numel(F)
  
  % Definition (2) in the paper
  S_11(ff)=mean(cwt_sig_area_1(ff,:).*conj(cwt_sig_area_1(ff,:)));
  S_22(ff)=mean(cwt_sig_area_2(ff,:).*conj(cwt_sig_area_2(ff,:)));
  S_12(ff)=mean(cwt_sig_area_1(ff,:).*conj(cwt_sig_area_2(ff,:)));
   
  % Complex coherency used to compute (3)
  C_12(ff)=S_12(ff)/sqrt(S_11(ff)*S_22(ff));
   
end
 
% Same as above but for subsets of data, here I use 4-drop-1 bootstrapping  
for jk=1:4
    
    cwt_sig_area_1_jk=cwt_sig_area_1;
    cwt_sig_area_2_jk=cwt_sig_area_2;
     
    cwt_sig_area_1_jk(:,floor(tb/4)*(jk-1)+1:floor(tb/4)*(jk))=[];
    cwt_sig_area_2_jk(:,floor(tb/4)*(jk-1)+1:floor(tb/4)*(jk))=[];
     
  for ff=1:numel(F)
  S_11(ff)=mean(cwt_sig_area_1_jk(ff,:).*conj(cwt_sig_area_1_jk(ff,:)));
  S_22(ff)=mean(cwt_sig_area_2_jk(ff,:).*conj(cwt_sig_area_2_jk(ff,:)));
  S_12(ff)=mean(cwt_sig_area_1_jk(ff,:).*conj(cwt_sig_area_2_jk(ff,:)));
   
   
  C_12_jk(ff,jk)=S_12(ff)/sqrt(S_11(ff)*S_22(ff));
   
   
   
  end
   
   
   
end
 
% DoLim=[20 50 90 150];
% UpLim=[50 90 150 300];
DoLim=[0 20];
UpLim=[20 300];
 
% Here I compute the Phase Slope Index for different frequency ranges (you can change this)
 
for cc=1:length(DoLim)
 
[~,F1]=min(abs(F-DoLim(cc)));
[~,F2]=min(abs(F-UpLim(cc)));
 
% Compute quantity psi-tilde of (4) in the paper 
%Psi_12=sum(conj(C_12(F1+1:F2)).*C_12(F1:F2-1));
Psi_12=sum(conj(C_12(F1:F2-1)).*C_12(F1+1:F2));
Psi_12=imag(Psi_12);
 
% Compute the normalization factor 
for jk=1:4
  
 %Psi_12_jk(jk)=sum(conj(C_12_jk(F2+1:F1,jk)).*C_12_jk(F2:F1-1,jk));  
%  Psi_12_jk(jk)=sum(conj(C_12_jk(F1+1:F2,jk)).*C_12_jk(F1:F2-1,jk));  
 Psi_12_jk(jk)=sum(conj(C_12_jk(F1:F2-1,jk)).*C_12_jk(F1+1:F2,jk));  
   
end
 
% Compute std(psi-tilde) - See text for details of the formula (sqrt(k)*std_set)
sigma=2*std(imag(Psi_12_jk));
 
 
% Print the resulting normalized PSI (Phase Slope Index)
psi_val(cc)=Psi_12/sigma;

 
end


end