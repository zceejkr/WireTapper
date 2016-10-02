function [signal, Fs] = daq ()

% %audrino communication
clear all;

%create serial object specify the seial port and the baud rate
serialOb = serial('COM3','BAUD',9600);   
set(serialOb, 'terminator', 'LF');       %define the terminator for println
fopen(serialOb); %connect to the device

try
    
    %Establish connection
    out = fscanf(serialOb, '%d');
    input = 1;
    fprintf(serialOb, '%d\n',input);
    while(out~=input)
        out=fscanf(serialOb, '%d');
    end    
    disp('Connection Established...');
    
    %get number of samples and sampleTime 
    nsamples = fscanf(serialOb, '%d');
    sampleTime = fscanf(serialOb, '%d')*1e-6; %in seconds
    analogIn = zeros(nsamples,1);
    
    %acquireData
    fprintf(serialOb, '%s\n','a');
    
    for i=1:nsamples
        analogIn(i) = fscanf(serialOb, '%d');
    end    
    time = time - time(1);
    
    fclose(serialOb);
    
catch me
    fclose(serialOb);
end
disp('Connection Closed ...');

delete(serialOb);
clear serialOb

analogIn = analogIn*5/1023; % convert in to Volts

signal = analogIn;
Fs = round(1/sampleTime);

% %fourier transform
% Fs = 1/sampleTime; %sample frequency
% nsamples = numel(analogIn); %number of samples
% freqs = (0:nsamples/2 -1)*Fs/nsamples;
% yfft = abs(fft(analogIn)); yfft = yfft(1:nsamples/2);
% yfft(yfft==0) = 1e-20; 
% logyfft = 20*log10(yfft);
% 
% %get dominant frequency
% dominantf = freqs(logyfft == max(logyfft));
% disp(['dominant frequncy = ', num2str(dominantf), 'Hz']);
% 
% %plot spectrum
% figure (1), clf reset;
% plot(freqs, logyfft , 'color', 'b', 'Marker', '.', 'Linewidth' , 2, 'Linestyle', '-');
% ylabel('|Amplitude| (dB)', 'Fontsize',14);
% xlabel('Frequncy (Hz)', 'Fontsize',14);
% ylim([-50, 65]);
% grid on;
% set(gca,'Fontsize',12)
% set (gcf,'Position', [427  150   650   500])
% print('-dpng', 'arduino-spectrum.png');
% hold off;
% 
% %plot time base
% figure (2), clf reset;
% plot(time(1:25)*1e-3, analogIn(1:25), 'color', 'b', 'Marker', '.', 'Linewidth' , 2, 'Linestyle', '-');
% ylabel('Amplitude (V)', 'Fontsize',14);
% xlabel('Time (ms)', 'Fontsize',14);
% grid on;
% set(gca,'Fontsize',12)
% set (gcf,'Position', [427   150   650   500])
% print('-dpng', 'arduino-timebase.png');
% hold off;

end