% This function takes two values and determines if the first is better
% than the second. If it is, it returns true, else, false. More postive 
% numbers are better. NaNs are given the value 0.

function yes = isBetterThan(first, second)
    if isnan(first)
        first=0;
    end
    if isnan(second)
        second=0;
    end
    if first>second
        yes=true;
    else
        yes=false;
    end
end