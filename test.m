[spriteList] = getSprites();
[textureList] = getTextures(spriteList);
testScene = Scene([0,0,0], spriteList, 20, 30);

testScene.fillRect(1, 1, 3, 3, textureList{1}, [0,0,255]);
testScene.insertText(10, 1, "Poopy butt", [255,0,0]);
testScene.renderScene();