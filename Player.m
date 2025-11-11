classdef Player < handle
    properties
        name
        icon
        score = 0
    end

    methods
        function obj = Player(name, icon)
            obj.name = name;
            obj.icon = icon;
        end

        function addScore(obj, amount)
            obj.score = obj.score + amount;
        end

        function displayIcon(obj, iconList)
            showSpritesSideBySide(iconList(obj.icon));
        end

        function displayScore(obj, spriteList)
            displayText = obj.name + ": " + string(obj.score) + " points";
            textList = textRender(displayText, spriteList);
            showSpritesSideBySide(textList);
        end
    end
end