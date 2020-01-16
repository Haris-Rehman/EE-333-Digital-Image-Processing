clear all, close all, clc

%% Image read, length and width of Image etc...
inp = imread('asd.png');
BW = im2bw(inp,0.5);

subplot(2, 2, 1), imshow(BW)
xlabel('Original Image')

new = uint8(BW);
new(1:end) = 0;

sz = size(new);
L = sz(1);
W = sz(2);

%% Calculating maximum value of the title in table
title = 0;
for i = 1:L
    if i == 1
        for j = 1:W
            if j == 1
                if BW(i, j) == 1
                    title = title + 1;
                end
            elseif j == W
                if BW(i, j) == 1
                    if BW(i, j-1) == 0
                        title = title + 1;
                    end
                end
            else
                if BW(i, j) == 1
                    if BW(i, j-1) == 0
                        title = title + 1;
                    end
                end
            end
        end
        
    elseif i == L
        for j = 1:W
            if j == 1
                if BW(i, j) == 1
                    if BW(i-1, j) == 0 && BW(i-1, j+1) == 0
                        title = title + 1;
                    end
                end
            elseif j == W
                if BW(i, j) == 1
                    if BW(i, j-1) == 0 && BW(i-1, j-1) == 0 && BW(i-1, j) == 0
                        title = title + 1;
                    end
                end
            else
                if BW(i, j) == 1
                    if BW(i, j-1) == 0 && BW(i-1, j-1) == 0 && BW(i-1, j) == 0 && BW(i-1, j+1) == 0
                        title = title + 1;
                    end
                end
            end
        end
        
    else
        for j = 1:W
            if j == 1
                if BW(i, j) == 1
                    if BW(i-1, j) == 0 && BW(i-1, j+1) == 0
                        title = title + 1;
                    end
                end
            elseif j == W
                if BW(i, j) == 1
                    if BW(i, j-1) == 0 && BW(i-1, j-1) == 0 && BW(i-1, j) == 0
                        title = title + 1;
                    end
                end
            else
                if BW(i, j) == 1
                    if BW(i, j-1) == 0 && BW(i-1, j-1) == 0 && BW(i-1, j) == 0 && BW(i-1, j+1) == 0
                        title = title + 1;
                    end
                end
            end
        end
    end
end

table = zeros(title*title);

%% First pass with generation of table
title = 1;
for i = 1:L
    if i == 1
        for j = 1:W
            if j == 1
                if BW(i, j) == 1
                    new(i, j) = title;
                    table(1, 1) = title;
                end
            elseif j == W
                if BW(i, j) == 1
                    if new(i, j-1) ~= 0
                        new(i, j) = new(i, j-1);
                    else
                        new(i, j) = title;
                        for q = 1:length(table)
                            if table(q, 1) == 0
                                break
                            end
                        end
                        table(q, 1) = title;
                        title = title + 1;
                    end
                end
            else
                if BW(i, j) == 1
                    if new(i, j-1) ~= 0
                        new(i, j) = new(i, j-1);
                    else
                        new(i, j) = title;
                        for q = 1:length(table)
                            if table(q, 1) == 0
                                break
                            end
                        end
                        table(q, 1) = title;
                        title = title + 1;
                    end
                end
            end
        end
        
    elseif i == L
        for j = 1:W
            if j == 1
                if BW(i, j) == 1
                    if BW(i-1, j) == 1
                        new(i, j) = new(i-1, j);
                    end
                    if BW(i-1, j+1) == 1
                        new(i, j) = new(i-1, j+1);
                    end
                    if BW(i-1, j) == 1 && BW(i-1, j+1) == 1
                        if new(i-1, j) ~= new(i-1, j+1)
                            test = 0;
                            for q = 1:length(table)
                                for w = 1:length(table)
                                    if new(i-1, j) == table(q, w)
                                        test = 1;
                                        break
                                    end
                                    if table(q, w) == 0
                                        break
                                    end
                                end
                                if test == 1
                                    break
                                end
                                if table(q, 1) == 0
                                    break
                                end
                            end
                            while table(q, w) ~= 0
                                w = w + 1;
                            end
                            table(q, w) = new(i-1, j);
                            table(q, w+1) = new(i-1, j+1);
                        end
                    end
                    if BW(i-1, j) == 0 && BW(i-1, j+1) == 0
                        new(i, j) = title;
                        for q = 1:length(table)
                            if table(q, 1) == 0
                                break
                            end
                        end
                        table(q, 1) = title;
                        title = title + 1;
                    end
                end
            elseif j == W
                if BW(i, j) == 1
                    if BW(i, j-1) == 1
                        new(i, j) = new(i, j-1);
                    end
                    if BW(i-1, j-1) == 1
                        new(i, j) = new(i-1, j-1);
                    end
                    if BW(i-1, j) == 1
                        new(i, j) = new(i-1, j);
                    end
                    if BW(i, j-1) == 1 && BW(i-1, j-1) == 1
                        if new(i, j-1) ~= new(i-1, j-1)
                            test = 0;
                            for q = 1:length(table)
                                for w = 1:length(table)
                                    if new(i, j-1) == table(q, w)
                                        test = 1;
                                        break
                                    end
                                    if table(q, w) == 0
                                        break
                                    end
                                end
                                if test == 1
                                    break
                                end
                                if table(q, 1) == 0
                                    break
                                end
                            end
                            while table(q, w) ~= 0
                                w = w + 1;
                            end
                            table(q, w) = new(i, j-1);
                            table(q, w+1) = new(i-1, j-1);
                        end
                    end
                    if BW(i-1, j-1) == 1 && BW(i-1, j) == 1
                        if new(i-1, j) ~= new(i-1, j-1)
                            test = 0;
                            for q = 1:length(table)
                                for w = 1:length(table)
                                    if new(i-1, j) == table(q, w)
                                        test = 1;
                                        break
                                    end
                                    if table(q, w) == 0
                                        break
                                    end
                                end
                                if test == 1
                                    break
                                end
                                if table(q, 1) == 0
                                    break
                                end
                            end
                            while table(q, w) ~= 0
                                w = w + 1;
                            end
                            table(q, w) = new(i-1, j);
                            table(q, w+1) = new(i-1, j-1);
                        end
                    end
                    if BW(i, j-1) == 1 && BW(i-1, j) == 1
                        if new(i, j) ~= new(i-1, j-1)
                            test = 0;
                            for q = 1:length(table)
                                for w = 1:length(table)
                                    if new(i-1, j) == table(q, w)
                                        test = 1;
                                        break
                                    end
                                    if table(q, w) == 0
                                        break
                                    end
                                end
                                if test == 1
                                    break
                                end
                                if table(q, 1) == 0
                                    break
                                end
                            end
                            while table(q, w) ~= 0
                                w = w + 1;
                            end
                            table(q, w) = new(i-1, j);
                            table(q, w+1) = new(i, j-1);
                        end
                    end
                    if BW(i, j-1) == 0 && BW(i-1, j-1) == 0 && BW(i-1, j) == 0
                        new(i, j) = title;
                        for q = 1:length(table)
                            if table(q, 1) == 0
                                break
                            end
                        end
                        table(q, 1) = title;
                        title = title + 1;
                    end
                end
            else
                if BW(i, j) == 1
                    if BW(i, j-1) == 1
                        new(i, j) = new(i, j-1);
                    end
                    if BW(i-1, j-1) == 1
                        new(i, j) = new(i-1, j-1);
                    end
                    if BW(i-1, j) == 1
                        new(i, j) = new(i-1, j);
                    end
                    if BW(i-1, j+1) == 1
                        new(i, j) = new(i-1, j+1);
                    end
                    
                    if BW(i, j-1) == 1 && BW(i-1, j-1) == 1
                        if new(i, j-1) ~= new(i-1, j-1)
                            test = 0;
                            for q = 1:length(table)
                                for w = 1:length(table)
                                    if new(i, j-1) == table(q, w)
                                        test = 1;
                                        break
                                    end
                                    if table(q, w) == 0
                                        break
                                    end
                                end
                                if test == 1
                                    break
                                end
                                if table(q, 1) == 0
                                    break
                                end
                            end
                            while table(q, w) ~= 0
                                w = w + 1;
                            end
                            table(q, w) = new(i, j-1);
                            table(q, w+1) = new(i-1, j-1);
                        end
                    end
                    if BW(i-1, j-1) == 1 && BW(i-1, j) == 1
                        if new(i-1, j-1) ~= new(i-1, j)
                            test = 0;
                            for q = 1:length(table)
                                for w = 1:length(table)
                                    if new(i-1, j-1) == table(q, w)
                                        test = 1;
                                        break
                                    end
                                    if table(q, w) == 0
                                        break
                                    end
                                end
                                if test == 1
                                    break
                                end
                                if table(q, 1) == 0
                                    break
                                end
                            end
                            while table(q, w) ~= 0
                                w = w + 1;
                            end
                            table(q, w) = new(i-1, j);
                            table(q, w+1) = new(i-1, j-1);
                        end
                    end
                    if BW(i-1, j) == 1 && BW(i-1, j+1) == 1
                        if new(i-1, j) ~= new(i-1, j+1)
                            test = 0;
                            for q = 1:length(table)
                                for w = 1:length(table)
                                    if new(i-1, j) == table(q, w)
                                        test = 1;
                                        break
                                    end
                                    if table(q, w) == 0
                                        break
                                    end
                                end
                                if test == 1
                                    break
                                end
                                if table(q, 1) == 0
                                    break
                                end
                            end
                            while table(q, w) ~= 0
                                w = w + 1;
                            end
                            table(q, w) = new(i-1, j);
                            table(q, w+1) = new(i-1, j+1);
                        end
                    end
                    if BW(i, j) == 1 && BW(i, j-1) == 1
                        if new(i, j) ~= new(i, j-1)
                            test = 0;
                            for q = 1:length(table)
                                for w = 1:length(table)
                                    if new(i, j) == table(q, w)
                                        test = 1;
                                        break
                                    end
                                    if table(q, w) == 0
                                        break
                                    end
                                end
                                if test == 1
                                    break
                                end
                                if table(q, 1) == 0
                                    break
                                end
                            end
                            while table(q, w) ~= 0
                                w = w + 1;
                            end
                            table(q, w) = new(i, j);
                            table(q, w+1) = new(i, j-1);
                        end
                    end
                    if BW(i, j-1) == 0 && BW(i-1, j-1) == 0 && BW(i-1, j) == 0 && BW(i-1, j+1) == 0
                        new(i, j) = title;
                        for q = 1:length(table)
                            if table(q, 1) == 0
                                break
                            end
                        end
                        table(q, 1) = title;
                        title = title + 1;
                    end
                end
            end
        end
    
    else
        for j = 1:W
            if j == 1
                if BW(i, j) == 1
                    if BW(i-1, j) == 1
                        new(i, j) = new(i-1, j);
                    end
                    if BW(i-1, j+1) == 1
                        new(i, j) = new(i-1, j+1);
                    end
                    if BW(i-1, j) == 1 && BW(i-1, j+1) == 1
                        if new(i-1, j) ~= new(i-1, j+1)
                            test = 0;
                            for q = 1:length(table)
                                for w = 1:length(table)
                                    if new(i-1, j) == table(q, w)
                                        test = 1;
                                        break
                                    end
                                    if table(q, w) == 0
                                        break
                                    end
                                end
                                if test == 1
                                    break
                                end
                                if table(q, 1) == 0
                                    break
                                end
                            end
                            while table(q, w) ~= 0
                                w = w + 1;
                            end
                            table(q, w) = new(i-1, j);
                            table(q, w+1) = new(i-1, j+1);
                        end
                    end
                    if BW(i-1, j) == 0 && BW(i-1, j+1) == 0
                        new(i, j) = title;
                        for q = 1:length(table)
                            if table(q, 1) == 0
                                break
                            end
                        end
                        table(q, 1) = title;
                        title = title + 1;
                    end
                end
            elseif j == W
                if BW(i, j) == 1
                    if BW(i, j-1) == 1
                        new(i, j) = new(i, j-1);
                    end
                    if BW(i-1, j-1) == 1
                        new(i, j) = new(i-1, j-1);
                    end
                    if BW(i-1, j) == 1
                        new(i, j) = new(i-1, j);
                    end
                    if BW(i, j-1) == 1 && BW(i-1, j-1) == 1
                        if new(i, j-1) ~= new(i-1, j-1)
                            test = 0;
                            for q = 1:length(table)
                                for w = 1:length(table)
                                    if new(i, j-1) == table(q, w)
                                        test = 1;
                                        break
                                    end
                                    if table(q, w) == 0
                                        break
                                    end
                                end
                                if test == 1
                                    break
                                end
                                if table(q, 1) == 0
                                    break
                                end
                            end
                            while table(q, w) ~= 0
                                w = w + 1;
                            end
                            table(q, w) = new(i, j-1);
                            table(q, w+1) = new(i-1, j-1);
                        end
                    end
                    if BW(i-1, j-1) == 1 && BW(i-1, j) == 1
                        if new(i-1, j) ~= new(i-1, j-1)
                            test = 0;
                            for q = 1:length(table)
                                for w = 1:length(table)
                                    if new(i-1, j) == table(q, w)
                                        test = 1;
                                        break
                                    end
                                    if table(q, w) == 0
                                        break
                                    end
                                end
                                if test == 1
                                    break
                                end
                                if table(q, 1) == 0
                                    break
                                end
                            end
                            while table(q, w) ~= 0
                                w = w + 1;
                            end
                            table(q, w) = new(i-1, j);
                            table(q, w+1) = new(i-1, j-1);
                        end
                    end
                    if BW(i, j-1) == 1 && BW(i-1, j) == 1
                        if new(i, j) ~= new(i-1, j-1)
                            test = 0;
                            for q = 1:length(table)
                                for w = 1:length(table)
                                    if new(i-1, j) == table(q, w)
                                        test = 1;
                                        break
                                    end
                                    if table(q, w) == 0
                                        break
                                    end
                                end
                                if test == 1
                                    break
                                end
                                if table(q, 1) == 0
                                    break
                                end
                            end
                            while table(q, w) ~= 0
                                w = w + 1;
                            end
                            table(q, w) = new(i-1, j);
                            table(q, w+1) = new(i, j-1);
                        end
                    end
                    if BW(i, j-1) == 0 && BW(i-1, j-1) == 0 && BW(i-1, j) == 0
                        new(i, j) = title;
                        for q = 1:length(table)
                            if table(q, 1) == 0
                                break
                            end
                        end
                        table(q, 1) = title;
                        title = title + 1;
                    end
                end
            else
                if BW(i, j) == 1
                    if BW(i, j-1) == 1
                        new(i, j) = new(i, j-1);
                    end
                    if BW(i-1, j-1) == 1
                        new(i, j) = new(i-1, j-1);
                    end
                    if BW(i-1, j) == 1
                        new(i, j) = new(i-1, j);
                    end
                    if BW(i-1, j+1) == 1
                        new(i, j) = new(i-1, j+1);
                    end
                    if BW(i-1, j) == 1 && BW(i-1, j+1) == 1
                        if new(i-1, j) ~= new(i-1, j+1)
                            test = 0;
                            for q = 1:length(table)
                                for w = 1:length(table)
                                    if new(i-1, j) == table(q, w)
                                        test = 1;
                                        break
                                    end
                                    if table(q, w) == 0
                                        break
                                    end
                                end
                                if test == 1
                                    break
                                end
                                if table(q, 1) == 0
                                    break
                                end
                            end
                            while table(q, w) ~= 0
                                w = w + 1;
                            end
                            table(q, w) = new(i-1, j);
                            table(q, w+1) = new(i-1, j+1);
                        end
                    end
                    if BW(i, j-1) == 1 && BW(i-1, j-1) == 1
                        if new(i, j-1) ~= new(i-1, j-1)
                            test = 0;
                            for q = 1:length(table)
                                for w = 1:length(table)
                                    if new(i, j-1) == table(q, w)
                                        test = 1;
                                        break
                                    end
                                    if table(q, w) == 0
                                        break
                                    end
                                end
                                if test == 1
                                    break
                                end
                                if table(q, 1) == 0
                                    break
                                end
                            end
                            while table(q, w) ~= 0
                                w = w + 1;
                            end
                            table(q, w) = new(i, j-1);
                            table(q, w+1) = new(i-1, j-1);
                        end
                    end
                    if BW(i-1, j-1) == 1 && BW(i-1, j) == 1
                        if new(i-1, j-1) ~= new(i-1, j)
                            test = 0;
                            for q = 1:length(table)
                                for w = 1:length(table)
                                    if new(i-1, j-1) == table(q, w)
                                        test = 1;
                                        break
                                    end
                                    if table(q, w) == 0
                                        break
                                    end
                                end
                                if test == 1
                                    break
                                end
                                if table(q, 1) == 0
                                    break
                                end
                            end
                            while table(q, w) ~= 0
                                w = w + 1;
                            end
                            table(q, w) = new(i-1, j);
                            table(q, w+1) = new(i-1, j-1);
                        end
                    end
                    
                    if BW(i, j) == 1 && BW(i, j-1) == 1
                        if new(i, j) ~= new(i, j-1)
                            test = 0;
                            for q = 1:length(table)
                                for w = 1:length(table)
                                    if new(i, j) == table(q, w)
                                        test = 1;
                                        break
                                    end
                                    if table(q, w) == 0
                                        break
                                    end
                                end
                                if test == 1
                                    break
                                end
                                if table(q, 1) == 0
                                    break
                                end
                            end
                            while table(q, w) ~= 0
                                w = w + 1;
                            end
                            table(q, w) = new(i, j);
                            table(q, w+1) = new(i, j-1);
                        end
                    end
                    
                    if BW(i, j-1) == 1 && BW(i-1, j+1) == 1
                        if new(i, j-1) ~= new(i-1, j+1)
                            test = 0;
                            for q = 1:length(table)
                                for w = 1:length(table)
                                    if new(i-1, j+1) == table(q, w)
                                        test = 1;
                                        break
                                    end
                                    if table(q, w) == 0
                                        break
                                    end
                                end
                                if test == 1
                                    break
                                end
                                if table(q, 1) == 0
                                    break
                                end
                            end
                            while table(q, w) ~= 0
                                w = w + 1;
                            end
                            table(q, w) = new(i, j-1);
                            table(q, w+1) = new(i-1, j+1);
                        end
                    end
                    
                    if BW(i, j-1) == 0 && BW(i-1, j-1) == 0 && BW(i-1, j) == 0 && BW(i-1, j+1) == 0
                        new(i, j) = title;
                        for q = 1:length(table)
                            if table(q, 1) == 0
                                break
                            end
                        end
                        table(q, 1) = title;
                        title = title + 1;
                    end
                end
            end
        end
    end
end

subplot(2, 2, 2), imshow(new*2)
xlabel('Image after First Pass')

%% Managing table
for q = 2:length(table)
    for w = 1:length(table)
        if table(q, w) == 0
            break
        end
        if table(q, w) < q
            dummy = table(q, w);
            for e = 1:length(table)
                if table(dummy, e) == 0
                    table(dummy, e) = q;
                    break
                end
            end
        end
    end
end

%% Second pass
for p = 1:3
for i = 1:L
    for j = 1:W
        if new(i, j) ~= 0
            found = 0;
            for q = 1:length(table)
                for w = 1:length(table)
                    if table(q, w) == 0
                        break
                    end
                    if new(i, j) == table(q, w)
                        new(i, j) = q;
                        found = 1;
                        break
                    end
                end
                if found == 1
                    break
                end
            end
        end
    end
end
end

subplot(2, 2, 3), imshow(new*2)
xlabel('Image after Second Pass')

%% Colouring the output image

for q = 1:length(table)
    if table(q, 1) == 0
        break
    end
    table(q, 1) = round(255*rand(1));
    table(q, 2) = round(255*rand(1));
    table(q, 3) = round(255*rand(1));
    
end

new1 = new;
new2 = new;
new3 = new;

for i = 1:L
    for j = 1:W
        if new(i, j) ~= 0
            new1(i, j) = table(new(i, j), 1);
            new2(i, j) = table(new(i, j), 2);
            new3(i, j) = table(new(i, j), 3);
        end
    end
end

rgbImage = cat(3, new1, new2, new3);

subplot(2, 2, 4), imshow(rgbImage)
xlabel('Coloured Image')