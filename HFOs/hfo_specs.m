function [x,y,z,w,h,q,l,p]=hfo_specs(si,timeasleep,print_hist)

    if ~isempty(si)

        %Instantaneous frequency.
        x=cellfun(@(equis) mean(instfreq(equis,1000)) ,si,'UniformOutput',false);
        x=cell2mat(x);
        if print_hist==1
            subplot(3,2,1)
            histogram(x,[100:10:250]); title('Instantaneous Frequencies');xlabel('Frequency (Hz)');ylabel('Count')
            xlim([100 250])
        end
        x=median(x);
        %fi_cortex(k)=x;
        %Average frequency
        y=cellfun(@(equis) (meanfreq(equis,1000)) ,si,'UniformOutput',false);
        y=cell2mat(y);
        if print_hist==1
            subplot(3,2,2)
            histogram(y,[100:10:250]); title('Average Frequencies');xlabel('Frequency (Hz)');ylabel('Count')
            xlim([100 250])
        end
        y=median(y);
        %fa_cortex(k)=y;

        %Amplitude
        z=cellfun(@(equis) max(abs(hilbert(equis))) ,si,'UniformOutput',false);
        z=cell2mat(z);
        if print_hist==1
            subplot(3,2,3)
            histogram(z,[0:2:30]); title('Amplitude');xlabel('Amplitude \muV');ylabel('Count')
            xlim([0 30])
        end
        z=median(z);
        %amp_cortex(k)=z;
        
        %Area under the curve
        l=cell2mat(cellfun(@(equis) trapz((1:length(equis))./1000,abs(equis)),si,'UniformOutput',false));
        if print_hist==1
            subplot(3,2,4)
            histogram(l,[0:0.025:0.5]); title('Area under the curve');xlabel('AUC');ylabel('Count')
            xlim([0 0.5])
        end
        l=median(l);

        %Count
        w=length(si);

        %Rate
        h=w/(timeasleep*(60));

        %Duration
        q=(cellfun('length',si)/1000);
        if print_hist==1
            subplot(3,2,5)
            histogram(q,[0:0.005:0.1]); title('Duration');xlabel('Duration (s)');ylabel('Count')
            xlim([0 0.1])
        end
        q=median(q);
        
        %Peak-to-peak distance
        p=cellfun(@peak2peak,si);
        if print_hist==1
            subplot(3,2,6)
            histogram(p,[0:2:45]); title('Peak-to-peak Amplitude');xlabel('P2P distance');ylabel('Count');
            xlim([0 45])
        end
        p=median(p);


    else

        x=NaN;
        y=NaN;
        z=NaN;
        w=NaN;
        h=NaN;
        q=NaN;
        l=NaN;
        p=NaN;

    end

end