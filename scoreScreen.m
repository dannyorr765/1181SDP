[spriteList] = getSprites();
[textureList] = getTextures(spriteList);
scoreScene = Scene([0,0,0], spriteList, 64,36);
% create border around screen
scoreScene.fillRectHollow(1,1,36,64,textureList{1},[16,36,181]);
% create borders to split screen in half
scoreScene.fillRectHollow(2,2,35,31,textureList{1},[16,36,181]);
scoreScene.fillRectHollow(2,32,35,63,textureList{1},[16,36,181]);
% create right side borders to split the sections into teams
scoreScene.fillRectHollow(3,2,11,31,textureList{1},[16,36,181]);
scoreScene.fillRectHollow(11,2,19,31, textureList{1},[16,36,181]);
scoreScene.fillRectHollow(19,2,27,31, textureList{1},[16,36,181]);
scoreScene.fillRectHollow(27,2,35,31, textureList{1},[16,36,181]);
% create left side borders to split the sections into teams
scoreScene.fillRectHollow(3,32,11,63,textureList{1},[16,36,181]);
scoreScene.fillRectHollow(11,32,19,63,textureList{1},[16,36,181]);
scoreScene.fillRectHollow(19,32,27,63,textureList{1},[16,36,181]);
scoreScene.fillRectHollow(27,32,35,63,textureList{1},[16,36,181]);
scoreScene.renderScene();

% just need to add text