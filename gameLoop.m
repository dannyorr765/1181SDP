clear
clc

% First I'll make the welcome screen using Simple Game Engine
sSize = 16; % 16x16 pixel-sprites
zFactor = 4; % magnification = 4
BGC = [16,36,181]; % royal blue background
welcome_scene = simpleGameEngine('retro_pack.png',sSize,sSize,zFactor,BGC);
welcomeTitle = [1, 1, 1, 1, 1021, 984, 991, 982, 1013, 992, 984, 1, 1, 1, 1];
teamPrompt = [984, 1012, 1018, 984, 1016, 1, 1012, 1019, 992, 1, 1018, 984, 980, 992, 1017];
box1 = [1, 1, 1, 1, 1, 1, 625, 626, 627, 1, 1, 1, 1, 1, 1];
box2 = [1, 1, 1, 1, 1, 1, 657, 1, 659, 1, 670, 1, 1, 1, 1];
box3 = [1, 1, 1, 1, 1, 1, 689, 690, 691, 1, 1, 1, 1, 1, 1];

% first row questions
firstRow = {'What is 9 plus 3?';'What is 14 plus 3?';'What is 53 plus 32?';'What is 235 plus 53?';'What is 563 plus 446?'};
firstRowAnswers = {12; 17; 85; 288; 1009};
% second row questions
secondRow = {'What is 7 minus 4?';'What is 64 minus 10?';'What is 34 minus 21?';'What is 523 minus 32?'; 'What is 529 minus 837?'};
secondRowAnswers = {3; 54; 13; 491; -308};
% third row questions
thirdRow = {'What is 4 x 3?';'What is 12 x 3?';'What is 12 x 12?';'What is 32 x 10?';'What is 17 x 32?'};
thirdRowAnswers = {12; 36; 144; 320; 544};
% fourth row questions
fourthRow = {'What is 12 divided by 3?';'What is 36 divided by 12?';'What is 64 divided by 16?';'What is 100 divided by 30 ignoring remainders?';'What is left over when 172 is divided by 82?'};
fourthRowAnswers = {4; 3; 4; 3; 8};
% fifth row questions
fifthRow = {'Sally has three apples and four oranges. How much fruit does she have?';'Jacob has three sets of 4 playing cards. How many cards does he have?';'Mary has 24 slices of pie and each guest eats 3 slices. How many guests ate?';'Jack has fourty hotwheels cars with 4 wheels each and 12 of them have a spare tire. How many wheels are there in total?';'Bill has 8 slices of pie and 3 guests eat 2 slices. How many does Bill have left?'};
fifthRowAnswers = {7; 12; 8; 2};
% Combine all the questions into one structure
questions = {firstRow, firstRowAnswers, 100; secondRow, secondRowAnswers, 200; thirdRow, thirdRowAnswers, 300; fourthRow, fourthRowAnswers, 400; fifthRow, fifthRowAnswers, 500};

points = {'200','200','200','200','200';'','400','400','400','400';'600','600','600','600','600';'800','800','800','800','800';'1000','1000','1000','1000','1000'}; % Initialize grid of false booleans for the game grid
mainScreen = mainScreenRender(points);

% Now we will create the question screen using our engine
[spriteList] = getSprites();
[textureList] = getTextures(spriteList);
questionScene = Scene([0,0,0], spriteList, 32,18);
questionScene.fillRect(1,1,18,32,textureList{1},[16,36,181]);
questionScene.fillRect(3,3,16,30,spriteList{1})
%questionScene.fillRectHollow(25,30,30,36,textureList{1},[16,36,181]);
questionScene.insertText(12,25,'1 2 3', [255,255,255]);
questionScene.insertText(13,25,'4 5 6', [255,255,255]);
questionScene.insertText(14,25,'7 8 9', [255,255,255]);
questionScene.insertText(15,27,'0', [255,255,255]);
questionScene.setTile(15,25,spriteList{672},[255,0,0]);
questionScene.setTile(15,29,spriteList{670},[255,255,0]);
questionScene.renderScene();

% now we will create the score screen using our engine
[spriteList] = getSprites();
[textureList] = getTextures(spriteList);
scoreScene = Scene([0,0,0], spriteList, 64,36);
% create border around screen
scoreScene.fillRectHollow(1,1,36,64,textureList{1},[16,36,181]);
% create borders to split screen in half
scoreScene.fillRectHollow(2,2,35,31,textureList{1},[16,36,181]);
scoreScene.fillRectHollow(2,32,35,63,textureList{1},[16,36,181]);
% create right side borders to split the sections into teams
scoreScene.fillRectHollow(1,2,9,31,textureList{1},[16,36,181]);
scoreScene.fillRectHollow(9,2,17,31, textureList{1},[16,36,181]);
scoreScene.fillRectHollow(17,2,25,31, textureList{1},[16,36,181]);
scoreScene.fillRectHollow(25,2,33,31, textureList{1},[16,36,181]);
% create left side borders to split the sections into teams
scoreScene.fillRectHollow(1,32,9,63,textureList{1},[16,36,181]);
scoreScene.fillRectHollow(9,32,17,63,textureList{1},[16,36,181]);
scoreScene.fillRectHollow(17,32,25,63,textureList{1},[16,36,181]);
scoreScene.fillRectHollow(25,32,33,63,textureList{1},[16,36,181]);
% create question asking to play again
scoreScene.fillRect(34,3,34,62,spriteList{1},[0,0,0]);
scoreScene.insertText(34, 10, 'Play again?     1 for YES     0 for NO', [255,255,255]);
scoreScene.renderScene();

% Now we will connect all the scenes together in a loop
replay = true;
while replay
    drawScene(welcome_scene, [welcomeTitle; teamPrompt; box1; box2; box3;])
    getKeyboardInput(welcome_scene);

    % Now we are onto the main screen

    while ~all(strcmp(points(:), '0'))
        mainScreen.renderScene();
        rectangleSelected = [0,0];
        while (rectangleSelected(1) == 0 || rectangleSelected(2) == 0 && ~points(rectangleSelected(1),rectangleSelected(2)).equals(''))
            [row, col] = mainScreen.getMouseInput();
            rectangleSelected = findQuestionBox(row, col);
        end
        points{rectangleSelected(1), rectangleSelected(2)} = '';
        [s_click, fs_click] = audioread('correct-choice-43861.mp3');
        sound(s_click, fs_click);
    
        % Display the correlating question
        questionScene.insertText(5, 5, questions{rectangleSelected(2), 1}{rectangleSelected(1)});
        questionScene.renderScene();
        questionScene.getMouseInput();
        mainScreen.fillRect();
    end

    scoreScene.renderScene();
    getKeyboardInput(scoreScene);
    if getKeyboardInput(scoreScene) == 0
        replay = false; % Exit the loop if a specific key is pressed
    elseif getKeyboardInput(scoreScene) == 1
        clear;
        replay = true;
    end
end