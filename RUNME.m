ptp = 3; %enter p-p value of number signal (can be decimal)
%user instructions (how to read number, graphs, enter variables)
%TIMEOUT ISSUE, maybe change COM

for i = 1:10

data = daq();

signal = data(1);
Fs= data(2);

signal = remove_dc(signal);
plot (signal);
tel_number = find_numbers(signal, Fs, ptp);
disp(tel_number);
telephone(i) = tel_number;

end

disp(telephone);