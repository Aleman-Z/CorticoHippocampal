function [x,y,z,w,h,q,l]=hfo_specs(si,timeasleep)

if ~isempty(si)

%Instantaneous frequency.
x=cellfun(@(equis) mean(instfreq(equis,1000)) ,si,'UniformOutput',false);
x=cell2mat(x);
x=median(x);
%fi_cortex(k)=x;
%Average frequency
y=cellfun(@(equis) (meanfreq(equis,1000)) ,si,'UniformOutput',false);
y=cell2mat(y);
y=median(y);
%fa_cortex(k)=y;

%Amplitude
z=cellfun(@(equis) max(abs(hilbert(equis))) ,si,'UniformOutput',false);
z=cell2mat(z);
z=median(z);
%amp_cortex(k)=z;
l=cell2mat(cellfun(@(equis) trapz((1:length(equis))./1000,abs(equis)),si,'UniformOutput',false));
l=median(l);

%Count
w=length(si);

%Rate
h=w/(timeasleep*(60));

%Duration
q=median(cellfun('length',si)/1000);


else
    
x=NaN;
y=NaN;
z=NaN;
w=NaN;
h=NaN;
q=NaN;
l=NaN;

end

end