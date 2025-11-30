[spriteList] = getSprites();
[textureList] = getTextures(spriteList);
Scene1 = Scene([0,0,0], spriteList, 64,36);
Scene1.fillRect(1,1,36,64,textureList{1});
Scene1.fillRect(3,3,34,62,spriteList{1})
Scene1.fillRect(21,8,29,57, textureList{1})
Scene1.fillRect(22,9,28,56, spriteList{1})
Scene1.renderScene();