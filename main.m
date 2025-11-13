[spriteList] = getSprites();
textureList = getTextures(spriteList);
scene1 = Scene([255, 255, 255],spriteList);
scene1.fillRect(1, 1, 5, 5, textureList{2}, 1);
scene1.renderScene();