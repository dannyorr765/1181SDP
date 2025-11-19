classdef Scene < handle
    properties
        sceneWidth
        sceneHeight
        sceneColor
        sceneData
    end

    methods
        function obj = Scene(color, spriteList)
            obj.sceneColor = color;
            obj.sceneWidth = 64;
            obj.sceneHeight = 36;
            obj.sceneData = cell(obj.sceneHeight, obj.sceneWidth);
        
            % Get proper tile size: assume sprites are RGBA (HxWx4)
            base = spriteList{1};
            [h, w, channels] = size(base);
        
            % Ensure RGBA output
            if channels == 3
                % Promote to RGBA with full opacity
                baseRGBA = uint8(zeros(h, w, 4));
                baseRGBA(:,:,1:3) = base;
                baseRGBA(:,:,4) = 255;
                sampleTile = baseRGBA;
            else
                sampleTile = base;
            end
        
            % Initialize background tiles
            for r = 1:obj.sceneHeight
                for c = 1:obj.sceneWidth
        
                    % Start with full tile
                    tile = uint8(zeros(h, w, 4));
        
                    % Set RGB to sceneColor
                    for ch = 1:3
                        tile(:,:,ch) = obj.sceneColor(ch);
                    end
        
                    % FULLY OPAQUE background tile
                    tile(:,:,4) = 255;
        
                    obj.sceneData{r,c} = tile;
                end
            end
        end

        function setTile(obj, r, c, sprite, useTransparency, spriteColor)

            rgb   = sprite(:,:,1:3);
            alpha = sprite(:,:,4);

            % First check if spriteColor has been inputted
            % Defaults to the color of the original sprite otherwise
            if nargin == 6
                mask = alpha > 0;
                recolor = uint8(zeros(size(rgb)));
                for ch = 1:3
                    chData = rgb(:,:,ch);
                    chData(mask) = spriteColor(ch);
                    recolor(:,:,ch) = chData;
                end
                rgb = recolor;
            end
        
            % Next we handle transparency
            % If useTransparency is false, then we set finalTile to the
            % colored value created in the previous section
            if useTransparency == 0
                obj.sceneData{r,c} = rgb;
                return;
            else
                bg = repmat(reshape(obj.sceneColor,1,1,3), size(rgb,1), size(rgb,2));
                mask = alpha > 0;
            
                out = bg;
                for ch = 1:3
                    chData = out(:,:,ch);
                    chData(mask) = rgb(:,:,ch);
                    out(:,:,ch) = chData;
                end
            
                obj.sceneData{r,c} = out;
            end
        end

        function fillRect(obj, r1, c1, r2, c2, sprite, useTransparency, spriteColor)
        
            rgb   = sprite(:,:,1:3);
            alpha = sprite(:,:,4);
            mask  = alpha > 0;
            % First check if spriteColor has been inputted
            % Defaults to the color of the original sprite otherwise
            if nargin == 8
                colored = rgb;

                mask = rgb(:,:,1) | rgb(:,:,2) | rgb(:,:,3);
        
                for ch = 1:3
                    tmp = colored(:,:,ch);
                    tmp(mask) = spriteColor(ch);
                    colored(:,:,ch) = tmp;
                end
            else
                colored = rgb;
            end
        
            % Next we handle transparency
            % If useTransparency is false, then we set finalTile to the
            % colored value created in the previous section
            if useTransparency == 0
                finalTile = colored;
        
                % Otherwise, we then apply alpha data to each pixel, then
                % set finalTile to the color defined in the last section
            else
                a = double(alpha) / 255;
        
                bg = repmat(reshape(obj.sceneColor,1,1,3), size(colored,1), size(colored,2));

                finalTile = uint8( a .* double(colored) + (1 - a) .* double(bg) );
            end

            for r = r1:r2
                for c = c1:c2
                    obj.sceneData{r,c} = finalTile;
                end
            end
        
        end



        function renderScene(obj, zoom)

            if nargin < 2
                zoom = 4;
            end
        
            [rows, cols] = size(obj.sceneData);
        
            % Detect tile size from first tile
            tile = obj.sceneData{1,1};
            [tileH, tileW, tileC] = size(tile);
        
            % Canvas always stores RGB only (final output)
            img = zeros(rows*tileH, cols*tileW, 3, 'uint8');
        
            % Build final image tile-by-tile
            for r = 1:rows
                for c = 1:cols
                    tile = obj.sceneData{r,c};
        
                    % Extract RGB
                    if size(tile,3) >= 3
                        rgb = tile(:,:,1:3);
                    else
                        error("Tile at (%d,%d) has <3 channels", r, c);
                    end
        
                    % Extract alpha or assume fully opaque
                    if size(tile,3) == 4
                        alpha = double(tile(:,:,4)) / 255;     % HxW double
                    else
                        alpha = ones(tileH, tileW);            % fully opaque
                    end
        
                    % Compute canvas region
                    rmin = (r-1)*tileH + 1;
                    rmax = rmin + tileH - 1;
                    cmin = (c-1)*tileW + 1;
                    cmax = cmin + tileW - 1;
        
                    % Grab background
                    bg = double(img(rmin:rmax, cmin:cmax, :));
        
                    % Perform alpha blending
                    blended = zeros(tileH, tileW, 3, 'uint8');
                    for ch = 1:3
                        fg = double(rgb(:,:,ch));
                        blended(:,:,ch) = uint8(alpha .* fg + (1-alpha) .* bg(:,:,ch));
                    end
        
                    img(rmin:rmax, cmin:cmax, :) = blended;
                end
            end
        
            % Scale it
            img = imresize(img, zoom, "nearest");
        
            % Display
            imshow(img, "InitialMagnification", 100);
        
        end
    end
end