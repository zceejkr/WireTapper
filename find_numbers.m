function [tel_number] = find_numbers (signal, Fs, ptp)

sled_size = 80;
power_value = sled_size*0.1*((ptp/2)^2);
on_number = 0;
start_num = 1;
end_num = 1;
tel_number (1) = 0;
current_number = 1;

for i = 1:(length(signal)-(sled_size+5))
    sled = signal(i:(i+sled_size-1));
    if (sum((sled.^2)) > power_value) & (on_number == 0)
       start_num = i;
       on_number = 1;
    end
    
    if ((sum((sled.^2)) < power_value) & on_number == 1)
        end_num = (i+sled_size-1);
        on_number = 0;
        num_signal = signal(start_num:end_num);
        if (length(num_signal) > 205)
            coffs = find_coffs (num_signal, Fs);
            number = estimate (coffs);
            tel_number (current_number) = number;
            current_number = current_number + 1;
        end
    end
    
    if (i == (length(signal)-(sled_size+5)) & on_number==1)
        end_num = (i+sled_size-1);
        on_number = 0;
        num_signal = signal(start_num:end_num);
        if (length(num_signal) > 205)
            coffs = find_coffs (num_signal, Fs);
            number = estimate (coffs);
            tel_number (current_number) = number;
            current_number = current_number + 1;
        end
    end
end

end
