% create funtion to initialize team scores to 0
function initialScores = teamScores(numTeams)
    for i = 1 : numTeams
        initialScores(i) = 0; % Initialize score for each team
        fprintf('team %i score: %i\n', i, initialScores(i)) % checks to see if it worked
    end
end