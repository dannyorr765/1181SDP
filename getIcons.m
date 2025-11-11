function iconList = getIcons(spriteList)

    sideLength = 32; % retro pack fixed layout

    % Rows 1–11, Columns 25–32 → 11 * 8 = 88 icons
    totalIcons = 11 * 8;

    % Preallocate output
    iconList = cell(totalIcons, 1);

    writeIdx = 1;

    for r = 1:11
        rowIDs = (r-1)*sideLength + (25:32);  % IDs for this row

        for id = rowIDs
            iconList{writeIdx} = spriteList{id};
            writeIdx = writeIdx + 1;
        end

    end
end