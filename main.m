[spriteList] = getSprites();
textureList = getTextures(spriteList);
scene1 = Scene([0,0,0],spriteList, 64, 36);
scene1.fillRectHollow(5, 5, 31, 59, textureList{1}, [0, 0, 255]);
scene1.fillRectHollow(24, 8, 28, 56, textureList{1}, [255, 255, 255]);
scene1.insertText(26, 10, "This is the", 1, [255,255,255]);
%showSpritesSideBySide(textureList);
scene1.renderScene();