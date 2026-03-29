% ================================
% MODULACIÓN EN AMPLITUD (AM)
% ================================

clc; clear; close all;

% Parámetros de la señal de mensaje
Am = 1;              % Amplitud del mensaje
fm = 10;             % Frecuencia del mensaje (Hz)
Fs = 5000;           % Frecuencia de muestreo
t = 0:1/Fs:1;        % Vector de tiempo

% Señal de mensaje
m = Am * sin(2*pi*fm*t);

% Gráfica de la señal de mensaje
figure;
plot(t, m);
title('Señal de Mensaje (Baja Frecuencia)');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;


% Parámetros de la portadora
Ac = 2;              % Amplitud de la portadora
fc = 200;            % Frecuencia de la portadora (Hz)

% Señal portadora
c = Ac * cos(2*pi*fc*t);

% Señal modulada AM (AM con portadora)
s = (Ac + m) .* cos(2*pi*fc*t);

% Gráfica de la señal modulada
figure;
plot(t, s);
title('Señal Modulada en Amplitud (AM)');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;


% Transformada de Fourier
N = length(s);
S_f = fftshift(fft(s, N));

f = linspace(-Fs/2, Fs/2, N);

figure;
plot(f, abs(S_f)/N);
title('Espectro de Frecuencia de la Señal AM');
xlabel('Frecuencia (Hz)');
ylabel('Magnitud');
grid on;


% ================================
% Introducción de Ruido (SIN toolbox)
% ================================

SNR_dB = 10;                % Relación señal-ruido en dB
snr_linear = 10^(SNR_dB/10);

% Potencia de la señal original
P_signal = mean(s.^2);

% Potencia del ruido
P_noise = P_signal / snr_linear;

% Ruido blanco gaussiano
ruido = sqrt(P_noise) * randn(size(s));

% Señal con ruido
s_ruido = s + ruido;

% Gráfica
figure;
plot(t, s_ruido);
title('Señal AM con Ruido Blanco Gaussiano');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;


% Atenuación
factor_atenuacion = 0.5;
s_atenuada = factor_atenuacion * s;

figure;
plot(t, s_atenuada);
title('Señal AM Atenuada');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;


% Distorsión no lineal
s_distorsion = s.^2;

figure;
plot(t, s_distorsion);
title('Señal AM con Distorsión No Lineal');
xlabel('Tiempo (s)');
ylabel('Amplitud');
grid on;
