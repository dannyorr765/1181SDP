function spriteList = getSprites()

    sprite_height = 16;
    sprite_width  = 16;

    % Read RGB + alpha (if alpha exists)
    [rgbImage, ~, alpha] = imread('retro_pack.png');

    % If no alpha was present in the PNG, create full opacity
    if isempty(alpha)
        alpha = 255 * ones(size(rgbImage,1), size(rgbImage,2), 'uint8');
    end

    sprites_size = size(rgbImage);
    sprite_row_max = floor((sprites_size(1) + 1) / (sprite_height + 1));
    sprite_col_max = floor((sprites_size(2) + 1) / (sprite_width + 1));

    totalSprites = sprite_row_max * sprite_col_max;
    spriteList = cell(totalSprites, 1);

    idx = 1;

    for r = 1:sprite_row_max
        for c = 1:sprite_col_max

            r_min = sprite_height * (r - 1) + r;
            r_max = sprite_height * r + r - 1;

            c_min = sprite_width * (c - 1) + c;
            c_max = sprite_width * c + c - 1;

            % Extract RGB (HxWx3)
            rgb = rgbImage(r_min:r_max, c_min:c_max, :);

            % Extract alpha as 1-channel (HxWx1)
            a = alpha(r_min:r_max, c_min:c_max);

            % Build RGBA sprite (HxWx4)
            rgba = uint8(zeros(size(rgb,1), size(rgb,2), 4));
            rgba(:,:,1:3) = rgb;
            rgba(:,:,4)   = a;

            spriteList{idx} = rgba;

            idx = idx + 1;
        end
    end
end