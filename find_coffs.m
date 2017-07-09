% Takes a slice of 205 samples around the middle 
% of the number and calls Goertzel for each of
% the desired frequencies.

function [coffs] = find_coffs (num_signal, Fs)
    
    middle = round (length(num_signal)/2);
    num_signal = num_signal((middle-102):(middle+103));
    
    f = [697, 770, 852, 941, 1209, 1336, 1447];
    Nt= 205;
    
    freq_indices = round(f/Fs*Nt) + 1;
    coffs = abs(goertzel(num_signal, freq_indices));
    
end