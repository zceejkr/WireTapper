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

end