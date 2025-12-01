function mainScreen = mainScreenRender(points)
    % Now we will draw the main game screen using our engine
    [spriteList] = getSprites();
    [textureList] = getTextures(spriteList);
    mainScreen = Scene([0,0,0], spriteList, 64,36);
    % titles for each column
    mainScreen.insertText(3,9,'ADD',[255,255,255]);
    mainScreen.insertText(3,20,'SUB',[255,255,255]);
    mainScreen.insertText(3,29,'MULTIPLY',[255,255,255]);
    mainScreen.insertText(3,41,'DIVIDE',[255,255,255]);
    mainScreen.insertText(3,52,'WORD',[255,255,255]);
    % first row of blocks
    mainScreen.fillRect(6,6,10,14,textureList{1},[16,36,181]);
    mainScreen.insertText(8,9,points(1,1),[255,255,255]);
    mainScreen.fillRect(6,17,10,25,textureList{1},[16,36,181]);
    mainScreen.insertText(8,20,points(1,2),[255,255,255]);
    mainScreen.fillRect(6,28,10,36,textureList{1},[16,36,181]);
    mainScreen.insertText(8,31,points(1,3),[255,255,255]);
    mainScreen.fillRect(6,39,10,47,textureList{1},[16,36,181]);
    mainScreen.insertText(8,42,points(1,4),[255,255,255]);
    mainScreen.fillRect(6,50,10,58,textureList{1},[16,36,181]);
    mainScreen.insertText(8,53,points(1,5),[255,255,255]);
    
    % second row of blocks
    mainScreen.fillRect(12,6,16,14,textureList{1},[16,36,181]);
    mainScreen.insertText(14,9,points(2,1),[255,255,255]);
    mainScreen.fillRect(12,17,16,25,textureList{1},[16,36,181]);
    mainScreen.insertText(14,20,points(2,2),[255,255,255]);
    mainScreen.fillRect(12,28,16,36,textureList{1},[16,36,181]);
    mainScreen.insertText(14,31,points(2,3),[255,255,255]);
    mainScreen.fillRect(12,39,16,47,textureList{1},[16,36,181]);
    mainScreen.insertText(14,42,points(2,4),[255,255,255]);
    mainScreen.fillRect(12,50,16,58,textureList{1},[16,36,181]);
    mainScreen.insertText(14,53,points(2,5),[255,255,255]);
    
    % third row of blocks
    mainScreen.fillRect(18,6,22,14,textureList{1},[16,36,181]);
    mainScreen.insertText(20,9,points(3,1),[255,255,255]);
    mainScreen.fillRect(18,17,22,25,textureList{1},[16,36,181]);
    mainScreen.insertText(20,20,points(3,2),[255,255,255]);
    mainScreen.fillRect(18,28,22,36,textureList{1},[16,36,181]);
    mainScreen.insertText(20,31,points(3,3),[255,255,255]);
    mainScreen.fillRect(18,39,22,47,textureList{1},[16,36,181]);
    mainScreen.insertText(20,42,points(3,4),[255,255,255]);
    mainScreen.fillRect(18,50,22,58,textureList{1},[16,36,181]);
    mainScreen.insertText(20,53,points(3,5),[255,255,255]);
    
    % fourth row of blocks
    mainScreen.fillRect(24,6,28,14,textureList{1},[16,36,181]);
    mainScreen.insertText(26,9,points(4,1),[255,255,255]);
    mainScreen.fillRect(24,17,28,25,textureList{1},[16,36,181]);
    mainScreen.insertText(26,20,points(4,2),[255,255,255]);
    mainScreen.fillRect(24,28,28,36,textureList{1},[16,36,181]);
    mainScreen.insertText(26,31,points(4,3),[255,255,255]);
    mainScreen.fillRect(24,39,28,47,textureList{1},[16,36,181]);
    mainScreen.insertText(26,42,points(4,4),[255,255,255]);
    mainScreen.fillRect(24,50,28,58,textureList{1},[16,36,181]);
    mainScreen.insertText(26,53,points(4,5),[255,255,255]);
    
    % fifth row of blocks
    mainScreen.fillRect(30,6,34,14,textureList{1},[16,36,181]);
    mainScreen.insertText(32,9,points(5,1),[255,255,255]);
    mainScreen.fillRect(30,17,34,25,textureList{1},[16,36,181]);
    mainScreen.insertText(32,20,points(5,2),[255,255,255]);
    mainScreen.fillRect(30,28,34,36,textureList{1},[16,36,181]);
    mainScreen.insertText(32,31,points(5,3),[255,255,255]);
    mainScreen.fillRect(30,39,34,47,textureList{1},[16,36,181]);
    mainScreen.insertText(32,42,points(5,4),[255,255,255]);
    mainScreen.fillRect(30,50,34,58,textureList{1},[16,36,181]);
    mainScreen.insertText(32,53,points(5,5),[255,255,255]);
end