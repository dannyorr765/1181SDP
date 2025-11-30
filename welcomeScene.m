clc
[spriteList] = getSprites();
[textureList] = getTextures(spriteList);
entryScene = Scene([0,0,0], spriteList, 64,36);
% need to make box where they can enter number of teams
entryScene.fillRectHollow(21,24,29,40, textureList{1},[16,36,181])
entryScene.renderScene();