% This is a really stupid way to do this but I don't know how to do it
% properly
function boxSelected = findQuestionBox(tileX, tileY)
    if tileY >= 6  && tileY <= 14
        y = 1;
    elseif tileY >= 17 && tileY <= 25
        y = 2;
    elseif tileY >= 28 && tileY <= 36
        y = 3;
    elseif tileY >= 39 && tileY <= 47
        y = 4;
    elseif tileY >= 50 && tileY <= 58
        y = 5;
    else
        y = 0; % clicked outside question columns
    end

    if tileX >= 6  && tileX <= 10
        x = 1;
    elseif tileX >= 12 && tileX <= 16
        x = 2;
    elseif tileX >= 18 && tileX <= 22
        x = 3;
    elseif tileX >= 24 && tileX <= 28
        x = 4;
    elseif tileX >= 30 && tileX <= 34
        x = 5;
    else
        x = 0; % clicked outside question rows
    end
    boxSelected = [x, y]; % Return the selected box coordinates
end
