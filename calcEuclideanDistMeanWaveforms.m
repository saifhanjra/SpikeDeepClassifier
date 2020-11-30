function eDist = calcEuclideanDistMeanWaveforms(waveform1, waveform2)
v=waveform1 - waveform2;
eDist=sqrt(v*v');
end