function [signal] = remove_dc (signal)

    S=round(sum(signal)/length(signal));
    signal = signal - S;
    
end