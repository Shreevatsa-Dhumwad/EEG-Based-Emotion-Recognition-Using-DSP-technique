%% ==========================================================
%  EEG-BASED EMOTION FEATURE EXTRACTION USING DSP TECHNIQUES
% ==========================================================
clear; clc; close all;

%% ------------------ USER SETTINGS ------------------
fs = 250;              % Sampling frequency (Hz)
N  = 256;              % FFT / DFT length
showPlots = true;

%% ------------------ SELECT EEG FILE ----------------
[fileName, filePath] = uigetfile('*.csv','Select EEG CSV File');
if isequal(fileName,0)
    error('No file selected. Program terminated.');
end
fullFilePath = fullfile(filePath, fileName);
fprintf('\nSelected File:\n%s\n', fullFilePath);

%% ------------------ LOAD DATA -----------------------
data = readtable(fullFilePath,'VariableNamingRule','preserve');
disp('Column Names:');
disp(data.Properties.VariableNames);

% Extract EEG channels
eeg_data = table2array(data(:, contains(data.Properties.VariableNames,'EEG')));
fprintf('EEG Data Size: %d samples × %d channels\n', ...
        size(eeg_data,1), size(eeg_data,2));

%% ------------------ PREPROCESSING ------------------
eeg_data = detrend(eeg_data);   % Remove DC & baseline drift

%% ------------------ RAW EEG (TIME DOMAIN) ------------------
if showPlots
    figure;
    plot(eeg_data(1:min(2000,end),1));
    title('Preprocessed Raw EEG Signal (Channel 1)');
    xlabel('Samples'); ylabel('\muV');
    grid on;
end

%% ------------------ BUTTERWORTH BANDPASS FILTER (4–45 Hz) ------------------
lowCut  = 4;     
highCut = 45;    
order   = 6;     

Wn = [lowCut highCut] / (fs/2);
[b,a] = butter(order, Wn, 'bandpass');

eeg_filt = filtfilt(b, a, eeg_data);

%% ------------------ RAW vs FILTERED (TIME DOMAIN) ------------------
if showPlots
    figure;
    plot(eeg_data(1:2000,1),'r'); hold on;
    plot(eeg_filt(1:2000,1),'b');
    legend('Raw (Detrended)','Butterworth Filtered');
    title('Raw vs Butterworth Bandpass Filtered EEG');
    xlabel('Samples'); ylabel('\muV');
    grid on;
end

%% ==========================================================
%  AMPLITUDE SPECTRUM (N = 256)
% ==========================================================
x_raw  = eeg_data(:,1);
x_filt = eeg_filt(:,1);

% Truncate or zero-pad to N
x_raw  = x_raw(1:min(end,N));
x_filt = x_filt(1:min(end,N));

if length(x_raw) < N
    x_raw  = [x_raw;  zeros(N-length(x_raw),1)];
    x_filt = [x_filt; zeros(N-length(x_filt),1)];
end

f = (0:N-1)*(fs/N);

RAW_AMP  = abs(fft(x_raw,N)) / N;
FILT_AMP = abs(fft(x_filt,N)) / N;

RAW_AMP  = RAW_AMP(1:N/2);
FILT_AMP = FILT_AMP(1:N/2);
f = f(1:N/2);

figure;
subplot(2,1,1);
plot(f, RAW_AMP);
xlim([0 60]);
title('Amplitude Spectrum of RAW EEG (N = 256)');
xlabel('Frequency (Hz)');
ylabel('Amplitude (\muV)');
grid on;

subplot(2,1,2);
plot(f, FILT_AMP);
xlim([0 60]);
title('Amplitude Spectrum AFTER Butterworth Filter (4–45 Hz)');
xlabel('Frequency (Hz)');
ylabel('Amplitude (\muV)');
grid on;

sgtitle('Amplitude Spectrum Verification (FFT Length = 256)');

%% ==========================================================
%  DFT vs FFT COMPARISON (N = 256)
% ==========================================================
x = x_filt;
k = 0:N-1;

% -------- Manual DFT --------
tic;
X_dft = zeros(N,1);
for p = 1:N
    for n = 1:N
        X_dft(p) = X_dft(p) + ...
            x(n)*exp(-1j*2*pi*(p-1)*(n-1)/N);
    end
end
t_dft = toc;

% -------- FFT --------
tic;
X_fft = fft(x,N);
t_fft = toc;

fprintf('\nDFT Time  = %.4f seconds\n', t_dft);
fprintf('FFT Time  = %.6f seconds\n', t_fft);
fprintf('Speed-up  = %.2fx\n', t_dft/t_fft);

%% ------------------ DFT vs FFT PLOTS ------------------
figure;
subplot(3,1,1);
plot(x);
title('Filtered EEG Signal (N = 256)');
xlabel('Sample Index'); ylabel('\muV');
grid on;

subplot(3,1,2);
stem(k,abs(X_dft),'filled');
title('|X(k)| using Manual DFT');
xlabel('k'); ylabel('|X(k)|');
grid on;

subplot(3,1,3);
stem(k,abs(X_fft),'filled');
title('|X(k)| using FFT');
xlabel('k'); ylabel('|X(k)|');
grid on;

sgtitle('DFT vs FFT Analysis (N = 256)');

fprintf('\n✅ EEG DSP Processing Completed Successfully\n');