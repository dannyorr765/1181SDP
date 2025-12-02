function scoreScene = scoreSceneConstruct(scores, gameEnd)
    % now we will create the score screen using our engine
    [spriteList] = getSprites();
    [textureList] = getTextures(spriteList);
    scoreScene = Scene([0,0,0], spriteList, 20,26);
    % create border around screen
    scoreScene.fillRectHollow(1,1,23,20,textureList{1},[16,36,181]);
    % create borders to split screen in half
    scoreScene.fillRectHollow(2,2,21,18,textureList{1},[16,36,181]);
    % create right side borders to split the sections into teams
    scoreScene.fillRectHollow(2,2,7,19,textureList{1},[16,36,181]);
    scoreScene.insertText(3,8,'Team 1:');
    scoreScene.insertText(5, 10, string(scores(1)));
    scoreScene.fillRectHollow(7,2,12,19, textureList{1},[16,36,181]);
    scoreScene.fillRectHollow(12,2,17,19, textureList{1},[16,36,181]);
    scoreScene.fillRectHollow(17,2,22,19, textureList{1},[16,36,181]);
    if numel(scores) > 1
        scoreScene.insertText(8,8,'Team 2:');
        scoreScene.insertText(10, 10, string(scores(2)));
    end
    if numel(scores) > 2
        scoreScene.insertText(13,8,'Team 3:');
        scoreScene.insertText(15, 10, string(scores(3)));
    end
    if numel(scores) > 3
        scoreScene.insertText(18,8,'Team 4:');
        scoreScene.insertText(20, 10, string(scores(4)));
    end
    % create left side borders to split the sections into teams
    % create question asking to play again
    if gameEnd
        scoreScene.fillRect(24,2,26,18,spriteList{1},[0,0,0]);
        scoreScene.insertText(25, 2, 'Play again?  Y  N', [255,255,255]);
        scoreScene.setTile(25,14,spriteList{824},[0,255,0]);
        scoreScene.setTile(25,17,spriteList{825},[255,0,0]);
    end
end