clear 
format long e
set(0,'DefaultAxesFontSize',16);

tend = 10;
tbeg = -10;
N=100000;
tstep = (tend-tbeg)/N;
sampling_rate = 1/tstep;

% Time window
tt = tbeg:tstep:tend-tstep;

% Assuming yt2 is loaded from 'lab4_num_expt2.mat'
yt2 = load('lab4_num_expt2.mat'); % Placeholder, replace with actual loading code

lag = [100 200 20000];

% Create a new figure for the combined plots
fig = figure;
tiledlayout(3, 2); % 3 rows for 3 lag values, 2 columns for autocorrelation and PSD

for i = 1:length(lag)
    maxlag = lag(i);
    % Autocorrelation of yt
    Ry = xcorr(yt2.yt, yt2.yt, maxlag);
    % tau vector
    tau_vec = -(maxlag*tstep):tstep:maxlag*tstep;
    % Absolute PSD corresponding to yt
    Sy = abs(fftshift(fft(fftshift(Ry))));
    % Frequency vector
    Ntau = length(tau_vec);
    fmax = sampling_rate/2; 
    fmin = -fmax;
    fstep = (fmax-fmin)/Ntau;
    freq = fmin:fstep:fmax-fstep;

    % Plot autocorrelation
    nexttile;
    plot(tau_vec, Ry);
    title(["Autocorrelation R_y", "maxlag = " + num2str(maxlag)]);
    xlabel("\tau (s)", 'FontWeight', 'bold');
    ylabel("R_y", 'FontWeight', 'bold');
    ylim([min(Ry) max(Ry)]);
    yline(0);

    % Plot Absolute Power Spectral Density
    nexttile;
    plot(freq, Sy);
    title(["Absolute Power Spectral Density", "maxlag = " + num2str(maxlag)]);
    xlabel("Frequency (Hz)", 'FontWeight', 'bold');
    ylabel("|S_y|", 'FontWeight', 'bold');
end

fig.WindowState = 'maximized';


fig = figure(8);

Nyt = length(yt2.yt);
%Nyquist sampling rate
fmax = sampling_rate/2; 
fmax = sampling_rate/2; 
fmax = sampling_rate/2; 
fmin = -fmax;
fstep = (fmax-fmin)/Nyt;
%Frequency window
freq = fmin:fstep:fmax-fstep;

plot(freq, abs(fftshift(fft(fftshift(yt2.yt)))));
title("Signal yt(n): Magnitude Spectrum");
xlabel("Frequency (Hz)", 'FontWeight', 'bold');
ylabel("Magnitude", 'FontWeight', 'bold');

fig.WindowState = 'maximized';