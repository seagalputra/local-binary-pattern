function blocks = createImagePatch(img, rows, cols)
%CREATEIMAGEPATCH Create patch from image in N x N size
%   Detailed explanation goes here

img_size = size(img);

% split image with N x N patch
blocks = mat2tiles(img, ceil(img_size(1:2)./[rows cols]))';
blocks = reshape(blocks,1,[]);
end

