function textureList = getTextures(spriteList)
    % Since we might end up selecting new textures and they're kind of all
    % over the place in the pack, I'm just going to manually pull these
    ids = [17, 625, 626, 627, 657, 659, 670, 689, 690, 691];

    textureList = spriteList(ids);
end