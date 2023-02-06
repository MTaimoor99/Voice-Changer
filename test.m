recorder=audiorecorder(8000,16,1); %Had to change Fs to 8000 
% because it didn't work otherwise
filename='Abdullah.wav';
pause(2);
fprintf('Start recording....\n')
recordblocking(recorder,5);
fprintf('Stopped recording....\n')
myrec=getaudiodata(recorder);
audiowrite(filename, myrec,8000); %Writes our audio data in .wav file
clear y Fs;