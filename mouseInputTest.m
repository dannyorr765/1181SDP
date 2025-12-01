clc; clear;

% -------------------------------------------------------
% 1. Load your sprite list (RGBA)
% -------------------------------------------------------
spriteList = getSprites();   % however you load them

% -------------------------------------------------------
% 2. Create a Scene object (64x36 example)
% -------------------------------------------------------
scene = Scene([0 0 0], spriteList, 64, 36);

% -------------------------------------------------------
% 3. Draw something so you can *see* where to click
% -------------------------------------------------------
scene.fillRect(5, 5, 10, 10, spriteList{20}, [0 128 255]);  % Example tile
scene.insertText(2, 2, "CLICK THE BOX", [255 255 0]);

% -------------------------------------------------------
% 4. Render the scene
% -------------------------------------------------------
zoom = 4;
scene.renderScene(zoom);

% -------------------------------------------------------
% 5. Main click loop
% -------------------------------------------------------
while true
    fprintf("Waiting for click...\n");

    % returns [row, col, button]
    [r, c, b] = scene.getMouseInput(zoom);

    fprintf("You clicked tile row=%d, col=%d (button=%d)\n", r, c, b);

    % ---------------------
    % Example action logic
    % ---------------------
    if r >= 5 && r <= 10 && c >= 5 && c <= 10
        fprintf(">>> You clicked inside the blue box!\n");

        % Draw confirmation text
        scene.insertText(15, 2, "You clicked it!", [0 255 0]);
        scene.renderScene(zoom);

    elseif r == 1 && c == 1
        fprintf("Exiting.\n");
        break;
    end
end