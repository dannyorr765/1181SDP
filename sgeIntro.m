% Create a scene using the retro pack
% I will only be using this pack throughout my game design today.

% First I'll make the welcome screen
sSize = 16; % 16x16 pixel-sprites
zFactor = 4; % magnification = 4
BGC = [105, 14, 75]; % dark magenta background
welcome_scene = simpleGameEngine('retro_pack.png',sSize,sSize,zFactor,BGC);
welcomeTitle = [1, 1, 1, 1, 1021, 984, 991, 982, 1013, 992, 984, 1, 1, 1, 1];
teamPrompt = [984, 1012, 1018, 984, 1016, 1, 1012, 1019, 992, 1, 1018, 984, 980, 992, 1017];
box1 = [1, 1, 1, 1, 1, 1, 625, 626, 627, 1, 1, 1, 1, 1, 1];
box2 = [1, 1, 1, 1, 1, 1, 657, 1, 659, 1, 670, 1, 1, 1, 1];
box3 = [1, 1, 1, 1, 1, 1, 689, 690, 691, 1, 1, 1, 1, 1, 1];
drawScene(welcome_scene, [welcomeTitle; teamPrompt; box1; box2; box3;])
title('This is the welcome screen of the game, and will be where the user starts the game and enters teams.')
getMouseInput(welcome_scene);

% Now I will make the main game screen.
% I will be using the same dimensions for sprites as before
background = [16,36,181]; % royal blue background
mainScreen_scene = simpleGameEngine('retro_pack.png',sSize,sSize,zFactor,background);
title1 = [657, 980, 983, 983];
title2 = [657, 1017, 1019, 981, 1018, 1016, 980, 982, 1018];
title3 = [657, 992, 1019, 991, 1018, 988, 1014, 991, 1023];
title4 = [657, 983, 988, 1020, 988, 983, 984];
title5 = [657, 1021, 1013, 1016, 983, 659];
% Because of my titles, each line must have 35 sprites
num100 = [1, 1, 949, 948, 948, 1, 1];
num200 = [1, 1, 950, 948, 948, 1, 1];
num300 = [1, 1, 951, 948, 948, 1, 1];
num400 = [1, 1, 952, 948, 948, 1, 1];
drawScene(mainScreen_scene, [title1, title2, title3, title4, title5; num100, num100, num100, num100, num100; num200, num200, num200, num200, num200; num300, num300, num300, num300, num300; num400, num400, num400, num400, num400])
title('This is the main screen of the game, and will be where the user goes through the entire game.')
getMouseInput(mainScreen_scene);

% Now I will create the final scoreboard for the game
color = [15,125,65]; % green background
scoreboard_scene = simpleGameEngine('retro_pack.png', sSize, sSize, zFactor, color);
teamTitle = [1018, 984, 980, 992];
scoreTitle = [1017, 982, 1013, 1016, 984];
team1 = [1, 1, 949, 1];
team2 = [1, 1, 950, 1];
team3 = [1, 1, 951, 1];
team4 = [1, 1, 952, 1];
score1 = [1, 951, 948, 948, 1];
score2 = [1, 953, 948, 948, 1];
score3 = [1, 950, 948, 948, 1];
score4 = [1, 956, 948, 948, 1];
drawScene(scoreboard_scene, [teamTitle, 1, 657, scoreTitle; team1, 1, 657, score1; team2, 1, 657, score2; team3, 1, 657, score3; team4, 1, 657, score4;])
title('This is the final scene of the game, and displays all the teams and their totaled scores after playing.')

% Display the question screen
color = [16,36,181]; % royal blue background
question_scene = simpleGameEngine('retro_pack.png', sSize, sSize, zFactor, color);
% Prepare the question layout and display it
boxLine1 = [1, 1, 1, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 1, 1, 1];
questionText= [1, 1, 1, 17, 1, 1015, 1019, 984, 1017, 1018, 988, 1013, 1012, 1, 17, 1, 1, 1];
answerLine = [1, 1, 1, 17, 1, 1, 980, 1012, 1017, 1021, 984, 1016, 1, 1, 17, 1, 1, 1];
blankLine = [1, 1, 1, 17, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 17, 1, 1, 1];
drawScene(question_scene, [boxLine1; questionText; blankLine; answerLine; blankLine; boxLine1])
title('This is the question screen where players will answer questions during the game.');