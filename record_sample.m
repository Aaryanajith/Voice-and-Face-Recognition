clear all
close all
clc

data_dir = '/home/interstellar/DSP_proj/';

function recordSample(file_path)
    recObj = audiorecorder;
    disp('Start speaking.');
    recordblocking(recObj, 5); 
    disp('End of Recording.');
    y = getaudiodata(recObj);
    audiowrite(file_path, y, recObj.SampleRate);
end

test_sample_path = [data_dir 'test_sample.wav'];


if exist(test_sample_path, 'file')
    delete(test_sample_path);
end


disp('Recording test sample:');
recordSample(test_sample_path);


[y, Fs] = audioread(test_sample_path);
coeffs = mfcc(y, Fs);
meanCoeffs = mean(coeffs, 1);

writematrix(meanCoeffs, [data_dir 'test_sample_features.csv']);
disp('Test sample features saved to CSV file.');
