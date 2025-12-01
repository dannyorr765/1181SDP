function textList = textRender(stringInput, spriteList)

    stringInput = lower(stringInput);   % Set all letters to lower case
    stringInput = char(stringInput);
    n = strlength(stringInput);

    % Get all the letters
    ids = [32*30+20:32*30+32,32*31+20:32*31+32];
    letterList = spriteList(ids);

    % Get all the numbers
    numberList = spriteList(32*29+20:32*29+29);

    % Preallocate assuming worst case (all characters valid)
    textList = cell(n, 1);
    outIdx = 1;

    for i = 1:n
        ch = stringInput(i);

        % Letters
        if ch == 'a'
            textList{outIdx} = letterList{1};
        elseif ch == 'b'
            textList{outIdx} = letterList{2};
        elseif ch == 'c'
            textList{outIdx} = letterList{3};
        elseif ch == 'd'
            textList{outIdx} = letterList{4};
        elseif ch == 'e'
            textList{outIdx} = letterList{5};
        elseif ch == 'f'
            textList{outIdx} = letterList{6};
        elseif ch == 'g'
            textList{outIdx} = letterList{7};
        elseif ch == 'h'
            textList{outIdx} = letterList{8};
        elseif ch == 'i'
            textList{outIdx} = letterList{9};
        elseif ch == 'j'
            textList{outIdx} = letterList{10};
        elseif ch == 'k'
            textList{outIdx} = letterList{11};
        elseif ch == 'l'
            textList{outIdx} = letterList{12};
        elseif ch == 'm'
            textList{outIdx} = letterList{13};
        elseif ch == 'n'
            textList{outIdx} = letterList{14};
        elseif ch == 'o'
            textList{outIdx} = letterList{15};
        elseif ch == 'p'
            textList{outIdx} = letterList{16};
        elseif ch == 'q'
            textList{outIdx} = letterList{17};
        elseif ch == 'r'
            textList{outIdx} = letterList{18};
        elseif ch == 's'
            textList{outIdx} = letterList{19};
        elseif ch == 't'
            textList{outIdx} = letterList{20};
        elseif ch == 'u'
            textList{outIdx} = letterList{21};
        elseif ch == 'v'
            textList{outIdx} = letterList{22};
        elseif ch == 'w'
            textList{outIdx} = letterList{23};
        elseif ch == 'x'
            textList{outIdx} = letterList{24};
        elseif ch == 'y'
            textList{outIdx} = letterList{25};
        elseif ch == 'z'
            textList{outIdx} = letterList{26};

        % Numbers
        elseif ch == '0'
            textList{outIdx} = numberList{1};
        elseif ch == '1'
            textList{outIdx} = numberList{2};
        elseif ch == '2'
            textList{outIdx} = numberList{3};
        elseif ch == '3'
            textList{outIdx} = numberList{4};
        elseif ch == '4'
            textList{outIdx} = numberList{5};
        elseif ch == '5'
            textList{outIdx} = numberList{6};
        elseif ch == '6'
            textList{outIdx} = numberList{7};
        elseif ch == '7'
            textList{outIdx} = numberList{8};
        elseif ch == '8'
            textList{outIdx} = numberList{9};
        elseif ch == '9'
            textList{outIdx} = numberList{10};

        elseif ch == ' '
            textList{outIdx} = spriteList{1};
        elseif ch == ':'
            textList{outIdx} = spriteList{32*29+30};
        elseif ch == '?'
            textList{outIdx} = spriteList{32 * 25 + 22};
        elseif ch == '!'
            textList{outIdx} = spriteList{32 * 25 + 20};
        elseif ch == '\'
            textList{outIdx} = 0;
        else
            continue   % ignore unsupported characters
        end

        outIdx = outIdx + 1;
    end

    % Trim off any unused cells (e.g., spaces)
    textList = textList(1:outIdx-1);
end