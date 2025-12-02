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
fifthRowAnswers = {7; 12; 8; 172; 2};
% Combine all the questions into one structure
questions = {firstRow, firstRowAnswers, 100; secondRow, secondRowAnswers, 200; thirdRow, thirdRowAnswers, 300; fourthRow, fourthRowAnswers, 400; fifthRow, fifthRowAnswers, 500};

% Initialize some other important data and create all the scenes
points = {'200','200','200','200','200';'400','400','400','400','400';'600','600','600','600','600';'800','800','800','800','800';'1000','1000','1000','1000','1000'}; % Initialize grid
pointsInitial = {'200','200','200','200','200';'400','400','400','400','400';'600','600','600','600','600';'800','800','800','800','800';'1000','1000','1000','1000','1000'};
scores = {0,0,0,0};
spriteList = getSprites();
questionScene = questionSceneConstruct();
scoreScene = scoreSceneConstruct(scores, false);


% First make the welcome screen using Simple Game Engine
sSize = 16; % 16x16 pixel-sprites
zFactor = 4; % magnification = 4
BGC = [16,36,181]; % royal blue background
welcome_scene = simpleGameEngine('retro_pack.png',sSize,sSize,zFactor,BGC);
welcomeTitle = [1, 1, 1, 1, 1021, 984, 991, 982, 1013, 992, 984, 1, 1, 1, 1];
teamPrompt = [982, 991, 988, 982, 990, 1, 1012, 1019, 992, 1, 1018, 984, 980, 992, 1017];
box1 = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
box2 = [1, 1, 1, 949, 1, 950, 1, 951, 1, 952, 1, 670, 1, 1, 1];

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
        if row == 5 && col == 4
            numTeams = 1;
        elseif row == 5 && col == 6
            numTeams = 2;
        elseif row == 5 && col == 8
            numTeams = 3;
        elseif row == 5 && col == 10
            numTeams = 4;
        elseif row == 5 && col == 12 && numTeams ~= 0
            break;
        end
    end

    close(welcome_scene.my_figure);
    % Initialize the score for each team using the teamScores function
    scores = teamScores(numTeams);
    teamSelected = 0;
    % Now we are onto the main screen

    mainScene = mainSceneConstruct(points);

    while ~all(strcmp(points(:), ''))
        % Team selection rotation
        teamSelected = teamSelected + 1;
        if teamSelected > size(scores)
            teamSelected = 1;
        end

        scoreScene.closeScene();
        scoreScene = scoreSceneConstruct(scores, false);
        scoreScene.renderScene();
        mainScene.renderScene();
        rectangleSelected = [0,0];
        while (rectangleSelected(1) == 0 || rectangleSelected(2) == 0 || points(rectangleSelected(1),rectangleSelected(2)) == "")
            [row, col] = mainScene.getMouseInput();
            rectangleSelected = findQuestionBox(row, col);
        end
    
        % Display the correlating question
        questionScene.insertText(5, 5, questions{rectangleSelected(2), 1}{rectangleSelected(1)});
        questionScene.renderScene();
        mainScene.closeScene();

        % Keypad System
        userInput = "";
        while true
            [rows, cols] = questionScene.getMouseInput();

            if strlength(userInput) < 19
                if isequal([rows, cols], [12, 25])
                    userInput = userInput + '1';
                elseif isequal([rows, cols], [12, 27])
                    userInput = userInput + '2';
                elseif isequal([rows, cols], [12,29])
                    userInput = userInput + '3';
                elseif isequal([rows, cols], [13, 25])
                    userInput = userInput + '4';
                elseif isequal([rows, cols], [13, 27])
                    userInput = userInput + '5';
                elseif isequal([rows, cols], [13, 29])
                    userInput = userInput + '6';
                elseif isequal([rows, cols], [14, 25])
                    userInput = userInput + '7';
                elseif isequal([rows, cols], [14, 27])
                    userInput = userInput + '8';
                elseif isequal([rows, cols], [14, 29])
                    userInput = userInput + '9';
                elseif isequal([rows, cols], [15, 27])
                    userInput = userInput + '0';
                elseif isequal([rows, cols], [15, 29])
                    break;
                end
            end
            if isequal([rows, cols], [15, 25])
                if strlength(userInput) > 0
                    questionScene.fillRect(15, 5, 15, 24, spriteList{1}, [0,0,0]);
                    userInput = extractBefore(userInput, strlength(userInput));
                end
            end

            questionScene.insertText(15, 5, char(userInput), [255,255,255]);
            questionScene.renderScene();
            pause(0.1);
        end
        if userInput == string(questions{rectangleSelected(2), 2}{rectangleSelected(1)})
            scores(teamSelected) = scores(teamSelected) + str2double(points{rectangleSelected(1), rectangleSelected(2)});
            [s_click, fs_click] = audioread('correct-choice-43861.mp3');
            sound(s_click, fs_click);
        else
            [s_click, fs_click] = audioread('error-mistake-sound-effect-incorrect-answer-437420.mp3');
            sound(s_click, fs_click);
        end

        points{rectangleSelected(1), rectangleSelected(2)} = '';

        questionScene.closeScene();
        % Reset the question scene
        questionScene = questionSceneConstruct();

        % Reset mainScene
        mainScene = mainSceneConstruct(points);
    end

    % creates the scores scene and lets the user decide to play again
    scoreScene.closeScene();
    scoreScene = scoreSceneConstruct(scores, true);
    scoreScene.renderScene();

    while (true)
        [r,c] = scoreScene.getMouseInput;
        if r == 25 && c == 14
            points = pointsInitial;
        break;
        elseif r == 25 && c == 17
            replay = false;
            break;
        end
    end
end