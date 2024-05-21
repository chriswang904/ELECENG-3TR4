tend = 10;
tbeg = -10;
N=100000;
tstep = (tend-tbeg)/N;
sampling_rate = 1/tstep;


tt = tbeg:tstep:tend-tstep;


yt1 = load('lab4_num_expt1.mat'); 

lag = [100, 200, 500];


fig = figure;
tiledlayout(2,3); % 2 rows for autocorrelation and PSD, 3 columns for each maxlag value

for i = 1:length(lag)
    maxlag = lag(i);
    Ry = xcorr(yt1.yt, yt1.yt, maxlag, 'unbiased'); % Calculate autocorrelation
    tau_vec = -(maxlagtstep):tstep:maxlagtstep; % tau vector

    % Calculate absolute PSD
    Sy = abs(fftshift(fft(fftshift(Ry))));

    % Define the frequency vector corresponding to tau_vec
    Ntau = length(tau_vec);
    fmax = sampling_rate / 2;
    freq = linspace(-fmax, fmax, Ntau);

    % Plot autocorrelation
    nexttile(i);
    plot(tau_vec, Ry);
    title(["Autocorrelation R_y", "maxlag = " + num2str(maxlag)]);
    xlabel("\tau (s)");
    ylabel("R_y");
    grid on;

    % Plot absolute PSD
    nexttile(i + 3); % Move to the second row
    plot(freq, Sy);
    title(["Absolute Power Spectral Density", "maxlag = " + num2str(maxlag)]);
    xlabel("Frequency (Hz)");
    ylabel("|S_y|");
    grid on;
end

fig.WindowState = 'maximized'; 