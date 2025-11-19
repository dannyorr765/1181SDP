function showSpritesSideBySide(spriteList)

    n = numel(spriteList);

    % Strip alpha if present
    first = spriteList{1};
    if size(first,3) == 4
        first = first(:,:,1:3);
    end

    [h, w, ~] = size(first);
    canvas = zeros(h, w*n, 3, 'uint8');

    for i = 1:n
        s = spriteList{i};
        if size(s,3) == 4
            s = s(:,:,1:3); % ignore alpha
        end

        colStart = (i-1)*w + 1;
        canvas(:, colStart:colStart+w-1, :) = s;
    end

    imshow(canvas, 'InitialMagnification', 200);
end