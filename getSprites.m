function [spriteList] = getSprites()

    sprite_height = 16;
    sprite_width  = 16;

    [sprites_image, ~, alpha] = imread('retro_pack.png');

    % Match the alpha shape to RGB (for easier per-channel math later)
    alpha = repmat(alpha, 1, 1, 3);

    sprites_size = size(sprites_image);
    sprite_row_max = floor((sprites_size(1) + 1) / (sprite_height + 1));
    sprite_col_max = floor((sprites_size(2) + 1) / (sprite_width + 1));

    % Preallocate both arrays
    totalSprites = sprite_row_max * sprite_col_max;
    spriteList = cell(totalSprites, 1);
    transparencyList = cell(totalSprites, 1);

    idx = 1;
    for r = 1:sprite_row_max
        for c = 1:sprite_col_max
            r_min = sprite_height * (r - 1) + r;
            r_max = sprite_height * r + r - 1;

            c_min = sprite_width * (c - 1) + c;
            c_max = sprite_width * c + c - 1;

            % Store both color data and corresponding alpha
            spriteList{idx} = sprites_image(r_min:r_max, c_min:c_max, :);
            transparencyList{idx} = alpha(r_min:r_max, c_min:c_max, :);

            idx = idx + 1;
        end
    end
end