clc
[spriteList] = getSprites();
[textureList] = getTextures(spriteList);
Scene2 = Scene([0,0,0], spriteList, 64,36);
% first row of blocks
Scene2.fillRect(6,6,10,14,textureList{1},[16,36,181]);
Scene2.fillRect(6,17,10,25,textureList{1},[16,36,181]);
Scene2.fillRect(6,28,10,36,textureList{1},[16,36,181]);
Scene2.fillRect(6,39,10,47,textureList{1},[16,36,181]);
Scene2.fillRect(6,50,10,58,textureList{1},[16,36,181]);
% second row of blocks
Scene2.fillRect(12,6,16,14,textureList{1},[16,36,181]);
Scene2.fillRect(12,17,16,25,textureList{1},[16,36,181]);
Scene2.fillRect(12,28,16,36,textureList{1},[16,36,181]);
Scene2.fillRect(12,39,16,47,textureList{1},[16,36,181]);
Scene2.fillRect(12,50,16,58,textureList{1},[16,36,181]);
% third row of blocks
Scene2.fillRect(18,6,22,14,textureList{1},[16,36,181]);
Scene2.fillRect(18,17,22,25,textureList{1},[16,36,181]);
Scene2.fillRect(18,28,22,36,textureList{1},[16,36,181]);
Scene2.fillRect(18,39,22,47,textureList{1},[16,36,181]);
Scene2.fillRect(18,50,22,58,textureList{1},[16,36,181]);
% fourth row of blocks
Scene2.fillRect(24,6,28,14,textureList{1},[16,36,181]);
Scene2.fillRect(24,17,28,25,textureList{1},[16,36,181]);
Scene2.fillRect(24,28,28,36,textureList{1},[16,36,181]);
Scene2.fillRect(24,39,28,47,textureList{1},[16,36,181]);
Scene2.fillRect(24,50,28,58,textureList{1},[16,36,181]);
% fifth row of blocks
Scene2.fillRect(30,6,34,14,textureList{1},[16,36,181]);
Scene2.fillRect(30,17,34,25,textureList{1},[16,36,181]);
Scene2.fillRect(30,28,34,36,textureList{1},[16,36,181]);
Scene2.fillRect(30,39,34,47,textureList{1},[16,36,181]);
Scene2.fillRect(30,50,34,58,textureList{1},[16,36,181]);
Scene2.renderScene();