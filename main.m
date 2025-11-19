[spriteList] = getSprites();
textureList = getTextures(spriteList);
scene1 = Scene([255,255,255],spriteList, 64, 36);
scene1.fillRectHollow(5, 5, 31, 59, textureList{1}, 1, [0, 0, 255]);
scene1.fillRectHollow(25, 8, 28, 56, textureList{1}, 1, [255, 255, 255]);
%showSpritesSideBySide(textureList);
scene1.renderScene();