function [number] = estimate (coffs)
    conditions = [1,1;1,2;1,3;2,1;2,2;2,3;3,1;3,2;3,3;4,1;4,2;4,3];
    
    present = [0,0];
    max = 0;
    number = -1;
    
    for a = 1:4
        if (coffs(a)>max)
            present(1)=a;
            max=coffs(a);
        end
    end
    
    max = 0;
    
    for a = 5:7
        if (coffs(a)>max)
            present(2)=a-4;
            max=coffs(a);
        end
    end
    
    for a = 1:9
         if (isequal(present, conditions(a,:)))
             number=a;
         end
    end
    
    if (isequal(present, conditions(11,:)))
        number=0;
    end
    
    if (or(isequal(present, conditions(10,:)), isequal(present, conditions(12,:))))
        number=-1;
    end

end