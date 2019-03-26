function feature = createFeatureFromHistogram(img_split)
%CREATEFEATUREFROMHISTOGRAM Create feature histogram from image patch
%   Detailed explanation goes here

feature = [];
for p = 1:size(img_split,2)
    histogram_lbp = imhist(img_split(p));
    histogram_lbp = histogram_lbp';
    feature = [feature histogram_lbp];
end

end

