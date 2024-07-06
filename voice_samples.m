clear all
close all
clc

num_users = 3; 
num_samples = 5; 

data_dir = '/home/interstellar/DSP_proj/voice/'; % Add your file path where the audio file is getting stored.

function record_sample(file_path)
    recObj = audiorecorder;
    disp('Start speaking.');
    recordblocking(recObj, 5); 
    disp('End of Recording.');
    y = getaudiodata(recObj);
    audiowrite(file_path, y, recObj.SampleRate);
end

for i = 1:num_users
    user_features = [];
    for j = 1:num_samples
        file_path = [data_dir 'user' num2str(i) '_sample' num2str(j) '.wav'];
        if ~exist(file_path, 'file')
            disp(['Recording sample: ' file_path]);
            record_sample(file_path);
        end

        % Extract features from the recorded sample
        if exist(file_path, 'file')
            [y, Fs] = audioread(file_path);
            coeffs = mfcc(y, Fs);
            meanCoeffs = mean(coeffs, 1);
            user_features = [user_features; meanCoeffs];
        else
            disp(['File not found: ' file_path]);
        end
    end

    writematrix(user_features, [data_dir 'user' num2str(i) '_features.csv']);
end