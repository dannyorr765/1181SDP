% coding the game
clc
clear
% Prompt user for the number of teams
numTeams = input('Enter the number of teams: ');
% Initialize team scores
for i = 1 : numTeams
    teamScore(i) = 0; % Initialize score for each team
    fprintf('team %i score: %i\n', i, teamScore(i)) % checks to see if it worked
end
% create array of questions
questions = {'What is 5 + 7?', 'What is 10 - 4?', 'What is 3 x 8?', 'What is 10 / 2?', 'Sally has 2 dimes, how many cents does she have?'};
% create array of answers
answers = {'12', '6', '24', '5', '10'};

% need to increment scores each time they get a correct answer
% start with team 1
playAgain = 0;
% Loop to continue the game until the blocks run out
while playAgain <= 25
    % allow user to select a block until all blocks are used
    % Prompt user to select a block
    blockNumber = input('Select a block number (1-25): ');
    playAgain = playAgain + 1; % Increment the play counter

    % Ask the selected team the question corresponding to the block number
    questionIndex = blockNumber; % Assuming blockNumber corresponds to the question index
    userAnswer = input(questions{questionIndex}, 's'); % Prompt for answer as a string

    % Check if the answer is correct
    if strcmp(userAnswer, answers{questionIndex})
        fprintf('Correct answer!\n');
        correctTeam = input('Enter the team number that answered correctly: ');
        teamScore(correctTeam) = teamScore(correctTeam) + 100;
        fprintf('Updated score for team %i: %i\n', correctTeam, teamScore(correctTeam));
    else
        fprintf('Incorrect answer. The correct answer was: %s\n', answers{questionIndex});
    end
    
end