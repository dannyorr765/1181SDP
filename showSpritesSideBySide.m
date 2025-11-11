% Debug function. This will not be used by the final project
function showSpritesSideBySide(spriteList, bgColor)
    % spriteList : cell array of RGB sprite images
    % bgColor    : [R G B] background (0–255)

    if nargin < 2
        bgColor = [0 0 0]; % default black
    end

    n = numel(spriteList);

    % All sprites assumed same size
    [h, w, ~] = size(spriteList{1});

    % Create blank canvas
    canvas = uint8(zeros(h, w*n, 3));
    for ch = 1:3
        canvas(:,:,ch) = bgColor(ch);
    end

    % Copy each sprite into position
    for i = 1:n
        colStart = (i-1)*w + 1;
        canvas(:, colStart:colStart+w-1, :) = spriteList{i};
    end

    % Display result
    imshow(canvas, 'InitialMagnification', 200);
end