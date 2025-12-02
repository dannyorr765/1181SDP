% create funtion to initialize team scores to 0
function initialScores = teamScores(numTeams)
    for i = 1 : numTeams
        initialScores(i) = 0; % Initialize score for each team
    end
end