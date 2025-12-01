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
            obj.spriteList  = spriteList;
            obj.sceneData   = cell(sceneHeight, sceneWidth);

            % Assume spriteList{1} is RGBA-sized reference tile
            base = spriteList{1};
            [h, w, ~] = size(base);

            % Construct canonical blank tile (RGBA)
            blankTile = uint8(zeros(h, w, 4));
            for ch = 1:3
                blankTile(:,:,ch) = obj.sceneColor(ch);
            end
            blankTile(:,:,4) = 255;

            obj.blankTile = blankTile;

            % Fill sceneData with blank tiles
            for r = 1:sceneHeight
                for c = 1:sceneWidth
                    obj.sceneData{r,c} = blankTile(:,:,1:3);   % store RGB only
                end
            end
        end


        %--------------------------------------------------------------
        % Set a single tile in the grid
        %--------------------------------------------------------------
        function setTile(obj, r, c, sprite, spriteColor)

            rgb   = sprite(:,:,1:3);
            alpha = sprite(:,:,4) > 0;   % boolean mask (16x16 logical)
        
            % Recolor visible pixels if a spriteColor was supplied
            if nargin == 5
                recolored = rgb;
                for ch = 1:3
                    tmp = recolored(:,:,ch);
                    tmp(alpha) = spriteColor(ch);
                    recolored(:,:,ch) = tmp;
                end
                rgb = recolored;
            end
        
            % Get the tile already in the scene (background)
            out = obj.sceneData{r,c};
        
            % Boolean alpha compositing (only overwrite where alpha=1)
            for ch = 1:3
                tmpBG = out(:,:,ch);
                tmpFG = rgb(:,:,ch);
        
                % overwrite only opaque pixels
                tmpBG(alpha) = tmpFG(alpha);
        
                out(:,:,ch) = tmpBG;
            end
        
            obj.sceneData{r,c} = out;
        end


        %--------------------------------------------------------------
        % Fill rectangle of tiles
        %--------------------------------------------------------------
        function fillRect(obj, r1, c1, r2, c2, sprite, spriteColor)

            rgb   = sprite(:,:,1:3);
            alpha = sprite(:,:,4) > 0;

            if nargin == 7
                recolored = rgb;
                for ch = 1:3
                    tmp = recolored(:,:,ch);
                    tmp(alpha) = spriteColor(ch);
                    recolored(:,:,ch) = tmp;
                end
                rgb = recolored;
            end

            % Composite once, reuse tile for all cells
            out = obj.blankTile(:,:,1:3);
            for ch = 1:3
                tmpBG = out(:,:,ch);
                tmpFG = rgb(:,:,ch);

                tmpBG(alpha) = tmpFG(alpha);
                out(:,:,ch) = tmpBG;
            end

            for r = r1:r2
                for c = c1:c2
                    obj.sceneData{r,c} = out;
                end
            end
        end


        %--------------------------------------------------------------
        % Hollow rectangle
        %--------------------------------------------------------------
        function fillRectHollow(obj, r1, c1, r2, c2, sprite, spriteColor)
            obj.fillRect(r1, c1, r2, c2, sprite, spriteColor);
            obj.fillRect(r1+1, c1+1, r2-1, c2-1, obj.blankTile, spriteColor);
        end


        %--------------------------------------------------------------
        % Render scene to screen
        %--------------------------------------------------------------
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


        %--------------------------------------------------------------
        % Insert text as glyph tiles
        %--------------------------------------------------------------
        function insertText(obj, r, c, text, spriteColor)

            glyphs = textRender(text, obj.spriteList);
            n = numel(glyphs);

            for i = 1:n
                tileCol = c + i - 1;

                if nargin == 5
                    obj.setTile(r, tileCol, glyphs{i}, spriteColor);
                else
                    obj.setTile(r, tileCol, glyphs{i});
                end
            end
        end

        function [row, col] = getMouseInput(obj, zoom)
            if nargin < 2
                zoom = 4;
            end
        
            % Ensure a figure exists and show the current frame
            fig = gcf;
            figure(fig);
        
            % Wait for a single click
            [x, y] = ginput(1);
            [s_click, fs_click] = audioread('correct-choice-43861.mp3');
            sound(s_click, fs_click);
        
            % Calculate tile size
            tile = obj.sceneData{1,1};
            [tileH, tileW, ~] = size(tile);
        
            % Convert pixel click to tile index
            col = ceil( x / (tileW * zoom) );
            row = ceil( y / (tileH * zoom) );
        
            % Clamp to valid grid
            row = max(1, min(obj.sceneHeight, row));
            col = max(1, min(obj.sceneWidth,  col));
        end
    end
end