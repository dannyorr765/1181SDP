clear
clc

% ------------------------------------------------------------------------
%                            Initialize Everything
% ------------------------------------------------------------------------

% Write out all the questions and combine them into a struct
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
fourthRow = {'What is 12 divided by 3?';'What is 36 divided by 12?';'What is 64 divided by 16?';'What is 100 divided\by 30 ignoring remainders?';'What is left over\when 172 is divided\by 82?'};
fourthRowAnswers = {4; 3; 4; 3; 8};
% fifth row questions
fifthRow = {'Sally has three apples\and four oranges.\How much fruit does\she have?';'Jacob has three sets of\4 playing cards.\How many cards does\he have?';'Mary has 24 slices of\pie and each guest eats\3 slices.\How many guests ate?';'Jack has fourty hotwheel\cars with 4 wheels each\and 12 of them have a\spare tire. How many\wheels are there overall?';'Bill has 8 slices of pie\and 3 guests eat 2 each.\How many does Bill\have left?'};
fifthRowAnswers = {7; 12; 8; 2};
% Combine all the questions into one structure
questions = {firstRow, firstRowAnswers, 100; secondRow, secondRowAnswers, 200; thirdRow, thirdRowAnswers, 300; fourthRow, fourthRowAnswers, 400; fifthRow, fifthRowAnswers, 500};

% Initialize some other important data and create all the scenes
points = {'200','200','200','200','200';'400','400','400','400','400';'600','600','600','600','600';'800','800','800','800','800';'1000','1000','1000','1000','1000'}; % Initialize grid of false booleans for the game grid
scores = {0,0,0,0};
mainScreen = mainScene(points);
questionScene = questionScene();
scoreScene = scoreScene(scores);


% First make the welcome screen using Simple Game Engine
sSize = 16; % 16x16 pixel-sprites
zFactor = 4; % magnification = 4
BGC = [16,36,181]; % royal blue background
welcome_scene = simpleGameEngine('retro_pack.png',sSize,sSize,zFactor,BGC);
welcomeTitle = [1, 1, 1, 1, 1021, 984, 991, 982, 1013, 992, 984, 1, 1, 1, 1];
teamPrompt = [982, 991, 988, 982, 990, 1, 1012, 1019, 992, 1, 1018, 984, 980, 992, 1017];
box1 = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
box2 = [1, 1, 949, 1, 950, 1, 951, 1, 952, 1, 953, 1, 670, 1, 1];

% Now the main game loop
replay = true;
while replay
    % First draw the welcome scene
    drawScene(welcome_scene, [welcomeTitle; box1; teamPrompt; box1; box2; box1;])

    % depending on where the user picks, assign a different number to numTeams
    % Loop until team is selected and then enter
    numTeams = 0;
    while (true)
        [row, col] = getMouseInput(welcome_scene);
        if row == 5 && col == 3
            numTeams = 1;
        elseif row == 5 && col == 5
            numTeams = 2;
        elseif row == 5 && col == 7
            numTeams = 3;
        elseif row == 5 && col == 9
            numTeams = 4;
        elseif row == 5 && col == 11
            numTeams = 5;
        elseif row == 5 && col == 13 && numTeams ~= 0
            break;
        end
    end

    % Initialize the score for each team using the teamScores function
    scores = teamScores(numTeams);

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

    % creates the scores scene and lets the user decide to play again
    scoreScene.renderScene();
    [r,c] = scoreScene.getMouseInput;
    while row == 35 && col == 20 && row == 35 && col == 24
        if [r,c] == [35,20]
        % set all scores equal to 0
        scores = teamScores(numTeams);
        replay = true;
        elseif [r,c] == [35, 24]
            replay = false;
        end
    end
end