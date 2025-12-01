% This is a really stupid way to do this but I don't know how to do it
% properly
function [x,y] = findQuestionBox(tileX, tileY)
    if tileX >= 6  && tileX <= 14
        x = 1;
    elseif tileX >= 17 && tileX <= 25
        x = 2;
    elseif tileX >= 28 && tileX <= 36
        x = 3;
    elseif tileX >= 39 && tileX <= 47
        x = 4;
    elseif tileX >= 50 && tileX <= 58
        x = 5;
    else
        x = 0; % clicked outside question columns
    end

    if tileY >= 6  && tileY <= 10
        y = 1;
    elseif tileY >= 12 && tileY <= 16
        y = 2;
    elseif tileY >= 18 && tileY <= 22
        y = 3;
    elseif tileY >= 24 && tileY <= 28
        y = 4;
    elseif tileY >= 30 && tileY <= 34
        y = 5;
    else
        y = 0; % clicked outside question rows
    end
