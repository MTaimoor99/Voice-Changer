# Voice-Changer
A GUI voice changer application written in MATLAB. The GUI was written using GUIDE.

This is a voice changer application written in MATLAB. It is capable of detecting the speaker's voice in real time, and 
also allows one to upload pre-existing voice samples to the program. It uses the speaker's pitch to identify the gender,
and once that is done, it shifts the voice accordingly.

The algorithm used is as described below:
1. The voice sample is first inputted, either by uploading a .wav file, or by recording one's voice in real time. In case of real-time recording,
the voice sample will always be stored in a 'OriginalVoice.wav' file.
2. The pitch() function is used on this voice sample to identify it's gender. The pitch() function returns an array, of which we take the mean.
3. If the mean falls in the range of 85-155 Hz (characteristic male frequency), we consider the voice sample male.
4. If the mean falls in the range of 165-255 Hz (characteristic female frequency) we consider the voice sample female.
5. Once the gender is determined, we simply shift the voice using the shiftPitch() function. 
6. If the voice is male, we shift it enough to make it fall in the characteristic female frequency range, and viceversa.
7. The changed voice will always be stored in a 'ShiftedVoice.wav' file.
