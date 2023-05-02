% Jack Langille 2023
% This codes simulates an analog to digital convertor that takes an input
% signal 'y' and converts it to a binary encoded digital signal using basic
% uniform quantization. Control parameters include sampling frequency 'fs',
% converter bit count 'n', input voltage range 'Vmin' and 'Vmax' 

clc; clear all;
Tmax = 1; % Seconds

% Input Signal Parameters
Vmin = 0; % Minimum voltage (Volts)
Vmax = 10; % Maximum voltage (Volts)
A = Vmax/2; % Signal amplitude 
f = 10; % Signal frequency (Hz)
x = linspace(0,Tmax,10000); % Time axis for analog signal
s = A+A*sin(2*pi*f*x-(pi/2)); % Input analog signal

% Converter Parameters
n = 8; % Converter bit count
r = 2^n; % Converter resolution
fs = 100; % Sampling frequency (Hz)

% Simulation/Misc
Ts = 1/fs; % Sampling time (s)
D = abs(Vmax-Vmin)/(r-1); % Converter quantization size
num_rows = Tmax/Ts; % Number of rows 

% Step 1: Sampling
t = 0:Ts:Tmax-Ts; % Sampling time range
y = A+A*sin(2*pi*f*t-(pi/2)); % Sampled frequency

% Step 2: Quantization
k = round((y-Vmin)/D); % Shift and scale sampled signal function and round to nearest integer
q = k*D + Vmin; % Scale k by quantization size and shift up to original signal position 

% Step 3: Encoding
encoded = dec2bin(k); % Create array of binary quantization values

% Plot 
figure(1)
set(gcf,'color','w');
subplot(4,1,1)
stem(t,y)
xlabel('Time (s)')
ylabel('Volts (V)')
title('Sampled Signal')

subplot(4,1,2)
plot(x,s,'k--')
xlabel('Time (s)')
ylabel('Volts (V)')
title('Original Signal')

subplot(4,1,3)
E = y - q;
plot(t,E)
xlabel('Time (s)')
ylabel('Quantization Error (V)')
title('Quantization Error')

subplot(4,1,4)
stem(t, k, 'm')  
xlabel('Time (s)')
ylabel('Quantization Index')
title('Quantization Value (decimal)')

saveas(gcf,'signals.jpg')

% Create table of data
data = table(t', y', k', encoded);
data.Properties.VariableNames = ["Time (s)","Input Voltage (V)","Quantization Index","Digital Signal"];
% Display table
disp(data);