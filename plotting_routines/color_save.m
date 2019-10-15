function col = color_save(idx)
if idx == 1
    col = [0.8500, 0.1250, 0.0480];
elseif idx == 2
    col = [0, 0.4470, 0.7410];
elseif idx == 3
    %col = 0.8*[0.4660, 0.6740, 0.1880];
    %col = [0.4940, 0.1840, 0.5560];
    col = 0.8*[0.4660, 0.6740, 0.1880];
    %col = [0.7, 0.7, 0.7];
elseif idx == 4
    col = [0.1, 0.1, 0.1];
elseif idx == 5
    col = [0.4940, 0.1840, 0.5560];
elseif idx == 6
    col = [0.4660, 0.6740, 0.1880];
end