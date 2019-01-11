function img_split = createImagePatch(img, patch_size)
%CREATEIMAGEPATCH Create patch from image in N x N size
%   Detailed explanation goes here

if nargin < 2
    patch_size = [16 16];
end

img_size = size(img);

% split image with N x N patch
sc = img_size ./ patch_size;
img_split = mat2cell(img, patch_size(1) * ones(sc(1),1), patch_size(2) * ones(sc(2),1));
img_split = reshape(img_split,1,[]);

end

