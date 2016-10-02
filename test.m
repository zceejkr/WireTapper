ptp = 1; %find from graph for test data
signal = analogIn;
Fs= 1/(200e-6);

signal = remove_dc(signal);
tel_number = find_numbers(signal, Fs, ptp);
disp(tel_number);