%% Merge open ephys recordings
%Inputs (strings): filename1, filename2.
%Can add more inputs if necessary.

filename1='TypeFileName1';
filename1='TypeFileName2';


NUM_HEADER_BYTES = 1024;

% load data from file 1
fid1 = fopen(filename1);
fseek(fid1,0,'eof');
filesize = ftell(fid1);
fseek(fid1,0,'bof');
hdr1 = fread(fid1, NUM_HEADER_BYTES, 'char*1');
samples1 = fread(fid1, 'int16');

% load data from file 2
fid2 = fopen(filename2);
fseek(fid2,0,'eof');
filesize = ftell(fid2);
fseek(fid2,0,'bof');
hdr2 = fread(fid2, NUM_HEADER_BYTES, 'char*1');
samples2 = fread(fid2, 'int16');
%%
% write data into new file
fid_final=fopen( '100_CH_merged.continuous', 'w');

fwrite(fid_final, hdr1, 'char*1'); %First header, expected by Kilosort 
fwrite(fid_final, samples1, 'int16');
fwrite(fid_final, samples2, 'int16');
fclose(fid1);
fclose(fid2);
fclose(fid_final);
