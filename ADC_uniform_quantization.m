% Jack Langille 2023
% This codes simulates an analog to digital convertor that takes an input
% signal 'y' and converts it to a binary encoded digital signal using basic
% uniform quantization. Control parameters include sampling frequency 'fs',
% converter bit count 'n', input voltage range 'Vmin' and 'Vmax' 

clc; clear all;
Tmax = 1; % Seconds

% Signal Parameters
Vmin = 0; % Volts
Vmax = 10; % Volts
f = 10; % Input frequency (Hz)
x = linspace(0,Tmax,10000);
s = Vmax+Vmax*sin(2*pi*f*x-(pi/2));

% Converter Parameters
n = 8; % Converter bit count
r = 2^n; % Converter resolution
fs = 50; % Sampling frequency (Hz)

% Simulation/Misc
Ts = 1/fs; % Sampling time (s)
D = abs(Vmax-Vmin)/r; % Converter quantization size
num_rows = Tmax/Ts; 

% Step 1: Sampling
t = 0:Ts:Tmax-Ts; 
y = Vmax+Vmax*sin(2*pi*f*t-(pi/2));

% Step 2: Quantization
k = round((y-Vmin)/D);
q = k*D + Vmin;

% Step 3: Encoding
encoded = dec2bin(k);

% Plot the sampled signal
figure(1)
set(gcf,'color','w');
stem(t,y)
xlabel('Time (s)')
ylabel('Volts (V)')
title('Sampled Signal')
saveas(gcf,'sampled_signal.jpg')

% Plot the quantized and analog signals
figure(2)
set(gcf,'color','w');
subplot(3,1,1)
stem(t,q,'filled','r')
xlabel('Time (s)')
ylabel('Volts (V)')
title('Quantized Signal')

subplot(3,1,2)
plot(x,s,'k--')
xlabel('Time (s)')
ylabel('Volts (V)')
title('Original Signal')

subplot(3,1,3)
E = y - q;
plot(t,E)
xlabel('Time (s)')
ylabel('Quantization Error (V)')
title('Quantization Error')
saveas(gcf,'signals_error.jpg')

% Plot the encoded signal
figure(3)
set(gcf,'color','w');
stem(t, k, 'm')  
xlabel('Time (s)')
ylabel('Quantization Index (decimal)')
title('Quantization Index vs. Time')
saveas(gcf,'encoded_signal.jpg')

% Create table of data
data = table(t', y', k', encoded);
data.Properties.VariableNames = ["Time (s)","Input Voltage (V)","Quantization Index","Digital Signal"];
% Display table
disp(data);