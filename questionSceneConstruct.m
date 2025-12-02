function questionScene = questionSceneConstruct()
    % Now we will create the question screen using our engine
    [spriteList] = getSprites();
    [textureList] = getTextures(spriteList);
    questionScene = Scene([0,0,0], spriteList, 32,18);
    questionScene.fillRect(1,1,18,32,textureList{1},[16,36,181]);
    questionScene.fillRect(3,3,16,30,spriteList{1})
    %questionScene.fillRectHollow(25,30,30,36,textureList{1},[16,36,181]);
    questionScene.insertText(12,25,'1 2 3', [255,255,255]);
    questionScene.insertText(13,25,'4 5 6', [255,255,255]);
    questionScene.insertText(14,25,'7 8 9', [255,255,255]);
    questionScene.insertText(15,27,'0', [255,255,255]);
    questionScene.setTile(15,25,spriteList{672},[255,0,0]);
    questionScene.setTile(15,29,spriteList{670},[255,255,0]);
end