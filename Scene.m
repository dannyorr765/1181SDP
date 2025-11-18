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

            % Initialize the scene as a 64x36 grid of blank squares
            for r = 1:obj.sceneHeight
                for c = 1:obj.sceneWidth
                    blank = uint8(zeros(size(spriteList{1})));
                    for ch = 1:3
                        blank(:,:,ch) = obj.sceneColor(ch);
                    end
                    obj.sceneData{r, c} = blank;
                end
            end
        end
        function setTile(obj, r, c, sprite, useTransparency, spriteColor)

            % If a color override is provided (6 arguments)
            if nargin == 6
                colored = uint8(zeros(size(sprite)));
        
                % Replace ONLY non-black pixels (your transparency rule)
                mask = sprite(:,:,1) | sprite(:,:,2) | sprite(:,:,3);
        
                for ch = 1:3
                    tmp = sprite(:,:,ch);
                    tmp(mask) = spriteColor(ch);
                    colored(:,:,ch) = tmp;
                end
        
                obj.sceneData{r,c} = colored;
        
            else
                % No override → use original sprite
                obj.sceneData{r,c} = sprite;
            end
        end

        function fillRect(obj, r1, c1, r2, c2, sprite, useTransparency, spriteColor)

            % Apply color override if provided
            if nargin == 8
                colored = uint8(zeros(size(sprite)));
        
                % Replace only *visible* (non-black) pixels
                mask = sprite(:,:,1) | sprite(:,:,2) | sprite(:,:,3);
        
                for ch = 1:3
                    tmp = sprite(:,:,ch);
                    tmp(mask) = spriteColor(ch);
                    colored(:,:,ch) = tmp;
                end
            else
                colored = sprite;
            end
        
            % Fill region
            for r = r1:r2
                for c = c1:c2
                    obj.sceneData{r,c} = colored;
                end
            end
        end


        function renderScene(obj, zoom)

            if nargin < 2
                zoom = 4;    % default magnification
            end
        
            [rows, cols] = size(obj.sceneData);
        
            tile = obj.sceneData{1,1};
            [tileH, tileW, ~] = size(tile);
        
            % Preallocate canvas
            img = zeros(rows*tileH, cols*tileW, 3, 'uint8');
        
            % Build the final image
            for r = 1:rows
                for c = 1:cols
                    sprite = obj.sceneData{r,c};
        
                    rmin = (r-1)*tileH + 1;
                    rmax = rmin + tileH - 1;
                    cmin = (c-1)*tileW + 1;
                    cmax = cmin + tileW - 1;
        
                    img(rmin:rmax, cmin:cmax, :) = sprite;
                end
            end
        
            % Apply zoom
            img = imresize(img, zoom, "nearest");
        
            % Display
            imshow(img, "InitialMagnification", 100);
        
        end
    end
end