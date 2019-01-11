function img_lbp = localBinaryPattern(img)
%LOCALBINARYPATTERN Summary of this function goes here
%   Detailed explanation goes here

if size(img,3) == 3
    img = rgb2gray(img);
end

% create black border in image using 0 value
height_border = zeros(size(img,1),1);
width_border = zeros(1,size(img,2)+2);
img_border = horzcat(height_border, img, height_border);
img_border = vertcat(width_border, img_border, width_border);

% operate Local Binary Pattern descriptor
for i = 2:size(img_border,1)-1
    for j = 2:size(img_border,2)-1
        neighborhood(1) = img_border(i-1,j-1);
        neighborhood(2) = img_border(i-1,j);
        neighborhood(3) = img_border(i-1,j+1);
        neighborhood(4) = img_border(i,j-1);
        neighborhood(5) = img_border(i,j+1);
        neighborhood(6) = img_border(i+1,j-1);
        neighborhood(7) = img_border(i+1,j);
        neighborhood(8) = img_border(i+1,j+1);
        
        % check every 8-pixel neighborhood
        threshold = img_border(i,j);
        
        for m = 1:size(neighborhood,2)
            if (neighborhood(m) >= threshold)
                binary_neighborhood(m) = 1;
            elseif (neighborhood(m) < threshold)
                binary_neighborhood(m) = 0;
            end
        end
        decimal = bi2de(binary_neighborhood);
        img_lbp(i,j) = decimal;
    end
end

img_lbp = img_lbp(2:size(img_lbp,1),2:size(img_lbp,2));

end

