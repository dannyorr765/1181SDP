classdef Scene < handle
    properties
        sceneWidth
        sceneHeight
        sceneColor
        spriteList
        sceneData
        blankTile
    end

    methods
        function obj = Scene(color, spriteList, sceneWidth, sceneHeight)
            obj.sceneColor  = color;
            obj.sceneWidth  = sceneWidth;
            obj.sceneHeight = sceneHeight;
            obj.spriteList = spriteList
            obj.sceneData   = cell(sceneHeight, sceneWidth);
        
            % Force first sprite to RGBA
            base = spriteList{1};
            [h, w, channels] = size(base);
        
            if channels == 3
                rgba = uint8(zeros(h, w, 4));
                rgba(:,:,1:3) = base;
                rgba(:,:,4)   = 255;
            else
                rgba = base;
            end
        
            % Construct canonical blank tile (RGBA)
            blankTile = uint8(zeros(h, w, 4));
            for ch = 1:3
                blankTile(:,:,ch) = obj.sceneColor(ch);
            end
            blankTile(:,:,4) = 255;
        
            obj.blankTile = blankTile;
        
            % Fill entire sceneData with blank tiles
            for r = 1:sceneHeight
                for c = 1:sceneWidth
                    obj.sceneData{r,c} = blankTile;
                end
            end
        end


        function setTile(obj, r, c, sprite, spriteColor)

            % Extract channels
            rgb   = sprite(:,:,1:3);
            alpha = sprite(:,:,4) > 0;   % binary mask
        
            % Recolor visible pixels if color override provided
            if nargin == 5
                recolored = rgb;
                for ch = 1:3
                    chData = recolored(:,:,ch);
                    chData(alpha) = spriteColor(ch);
                    recolored(:,:,ch) = chData;
                end
                rgb = recolored;
            end
        
            % Apply transparency → composite against background
            out = obj.blankTile(:,:,1:3);    % background RGB
            for ch = 1:3
                chData = out(:,:,ch);
                chData(alpha) = rgb(:,:,ch);
                out(:,:,ch) = chData;
            end
        
            obj.sceneData{r,c} = out;
        end

        function fillRect(obj, r1, c1, r2, c2, sprite, spriteColor)

            rgb   = sprite(:,:,1:3);
            alpha = sprite(:,:,4) > 0;
        
            if nargin == 7
                recolored = rgb;
                for ch = 1:3
                    chData = recolored(:,:,ch);
                    chData(alpha) = spriteColor(ch);
                    recolored(:,:,ch) = chData;
                end
                rgb = recolored;
            end
        
            % composite against background tile
            out = obj.blankTile(:,:,1:3);
            for ch = 1:3
                chData = out(:,:,ch);
                tmp = rgb(:,:,ch);
                chData(alpha) = tmp(alpha);
                out(:,:,ch) = chData;
            end
        
            for r = r1:r2
                for c = c1:c2
                    obj.sceneData{r,c} = out;
                end
            end
        end

        function fillRectHollow(obj, r1, c1, r2, c2, sprite, spriteColor)
            obj.fillRect(r1, c1, r2, c2, sprite, spriteColor);
            obj.fillRect(r1+1,c1+1,r2-1,c2-1, obj.blankTile, spriteColor);
        end

        function renderScene(obj, zoom)
        
            if nargin < 2
                zoom = 4;
            end
        
            [rows, cols] = size(obj.sceneData);
            tile = obj.sceneData{1,1};
            [tileH, tileW, ~] = size(tile);
        
            img = zeros(rows*tileH, cols*tileW, 3, "uint8");
        
            for r = 1:rows
                for c = 1:cols
                    tileRGB = obj.sceneData{r,c};
        
                    rmin = (r-1)*tileH + 1;
                    rmax = rmin + tileH - 1;
                    cmin = (c-1)*tileW + 1;
                    cmax = cmin + tileW - 1;
        
                    img(rmin:rmax, cmin:cmax, :) = tileRGB;
                end
            end
        
            img = imresize(img, zoom, "nearest");
            imshow(img, "InitialMagnification", 100);
        end

        function insertText(obj, r, c, text, useTransparency, spriteColor)

            % Generate the sprite list using your existing function
            glyphs = textRender(text, obj.spriteList);  
            % glyphs is a 1xN cell array
        
            n = numel(glyphs);
        
            for i = 1:n
                tileCol = c + i - 1;   % horizontal index
        
                if nargin == 6
                    obj.setTile(r, tileCol, glyphs{i}, spriteColor);
                else
                    obj.setTile(r, tileCol, glyphs{i});
                end
            end
        end
    end
end