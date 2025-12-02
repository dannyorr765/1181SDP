function scoreScene = scoreScene(scores)
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
    scoreScene.fillRectHollow(7,2,12,19, textureList{1},[16,36,181]);
    scoreScene.fillRectHollow(12,2,17,19, textureList{1},[16,36,181]);
    scoreScene.fillRectHollow(17,2,22,19, textureList{1},[16,36,181]);
    % create left side borders to split the sections into teams
    % create question asking to play again
    scoreScene.fillRect(24,2,26,18,spriteList{1},[0,0,0]);
    scoreScene.insertText(25, 2, 'Play again?  Y  N', [255,255,255]);
    scoreScene.setTile(25,14,spriteList{824},[0,255,0]);
    scoreScene.setTile(25,17,spriteList{825},[255,0,0]);
    scoreScene.renderScene();
end