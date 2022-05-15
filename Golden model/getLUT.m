function [LUTout,concat,sign] = getLUT(LUTin,constants,s)
    
    concat = '';
    
    % Generate the bit of sign (0 for +;1 for -)
    % All the constants in a look-up-table have the same sign
    if s == 1
        if constants(2,1) > 0
            sign = 0;
        else
            sign = 1;
        end
    end
    
    % Remove the dot
    id = strfind(LUTin(1,:),".");
    LUTin(:,id)=[];
        
    while(1)
        for j=1:size(LUTin,2)
            aux = LUTin(1,j);           % Save the first bit
            bool = 1;                   % Establish a condition
            for i=1:size(LUTin,1)
                if LUTin(i,j) ~= aux    % Compare the bits of the all columns
                    bool = 0;           % If they are different, the condition changes
                endif
            endfor
            if bool == 1                % If confdition does not change, the bits can be concatenated
                concat = strcat(concat,LUTin(1:j));    % Save the bit to concatenate
                LUTin(:,j)=[];          % Remove the bit from the look-up-table
                break
            endif
        end
        
        if bool == 0                    % If all the bits in a column are not equal, break the loop
            break
        endif
    end
    
    % Remove first 0
    cond = 0;
    for i=1:size(concat,2)
      if concat(i)=="1"
        cond = 1;
        break
      endif
    endfor
	
    if cond == 1
        while(1)
            bool = 1;
            for i=1:size(concat,2)
                if concat(i) == '0'
                    concat(i) = [];
                    break
                else
                    bool = 0;
                    break
                end
            end

            if bool == 0
                break
            end
        end
    else
        concat = [];
    end
    
    LUTout = LUTin;
end