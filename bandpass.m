filename='OriginalVoice.wav';
recordblocking(recorder,5);
myrec=getaudiodata(recorder);
audiowrite(filename, myrec,8000); %Writes our audio data in .wav file
clear y Fs;
[y,Fs] = audioread(filename);
Y=fft(y);
MaleBandpass=load('MaleBandpass.mat');
C=struct2cell(MaleBandpass);
A=cell2mat(C);
FemaleBandpass=load('FemaleBandpass.mat');
C1=struct2cell(FemaleBandpass);
A1=cell2mat(C1);
RMS_Male=rms(abs(Y).*A)
RMS_Female=rms((abs(Y).*A1))
if RMS_Male>RMS_Female
    fprintf('Male voice\n');
else
    fprintf('Female voice\n');
end

% filename='FemaleVoice.wav';
% recordblocking(recorder,5);
% myrec=getaudiodata(recorder);
% audiowrite(filename, myrec,8000); %Writes our audio data in .wav file
% clear y Fs;
% [y,Fs] = audioread(filename);
% f0=pitch(y,Fs); %Get the frequency array of the sound signal.
% b=mean(f0) %Take mean of all values in the frequency array
% if b>165
%     fprintf('This is a female voice');
% else
%    fprintf('This is a male voice');
% end
% sound(y,Fs); %Play the data
% info=audioinfo(filename); %Provides us info about the .wav file