clc; clear; clf;
%
% ... Read the data file ...
%
fileID = fopen('forceCoeffs_2.dat','r');
formatSpec = '%f %f %f %f %f %f';
sizeCoeffs = [6 Inf];
Coeffs = fscanf(fileID,formatSpec,sizeCoeffs);
n = length(Coeffs(4,:));
%
% ... Plot the drag and lift coefficients ...
%
figure(1)
plot(Coeffs(1,:),Coeffs(3,:))
hold on;
plot(Coeffs(1,:),Coeffs(4,:))
xlabel('Time')
ylabel('Force Coefficients')
legend('C_D','C_L')
axis([0 Coeffs(1,n) -1 2])
hold off
%
% ... Fast Fourier Transform ...
%
y1 = fft(Coeffs(3,:));
y2 = fft(Coeffs(4,:));
%
% ... Calculate the associate frequencies and the amplitudes ...
%
fs = 1/(Coeffs(1,2)-Coeffs(1,1));
f = (0:n-1) * (fs/n);
amp1 = abs(y1) / n;
amp2 = abs(y2) / n;
%
% ... Plot the amplitude spectrum ...
%
figure(2)
plot(f(1:floor(n)),amp1(1:floor(n)),f(1:floor(n)),amp2(1:floor(n)))
xlabel('Frequency (Hz)')
ylabel('Amplitude')
legend('C_D','C_L')
axis([0 1 0 0.5])
%
% ... Evaluate the frequency and the preiod of lift force ...
%
[Max_C,Max_I] = max(amp2);
Fq = f(Max_I);
Period = 1/Fq;
fprintf('The frequency of the oscillation of lift is %f\n', Fq);
fprintf('The preiod of the oscillation of lift is %f\n', Period);

