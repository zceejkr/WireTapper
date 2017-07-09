% Removes the DC bias in the signal

function [signal] = remove_dc (signal)

    mean =round(sum(signal)/length(signal));
    signal = signal - mean;
    
end