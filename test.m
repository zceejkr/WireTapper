ptp = 1; %Peak-to-peak voltage of the signal
Fs= 1/(200e-6); %Sampling frequency

%Open exampleSignal.mat to get analogIn variable
signal = analogIn;

signal = remove_dc(signal);
tel_number = find_numbers(signal, Fs, ptp);

disp(tel_number);