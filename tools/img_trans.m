function img_trans(dirname)

dirname = ['./', dirname, '/'];
listing = dir(dirname);
len = length(listing);
cnt = 1;
for i = 3:len
    filename = listing(i).name;
    img = imread([dirname, filename]);
    if size(img, 3) == 3
        img = rgb2gray(img);
    end
    if size(img, 1) < 256 || size(img, 2) < 256
        continue
    end
    img = img(1:256, 1:256);
    nname = [dirname, num2str(cnt), '.jpg'];
    cnt = cnt + 1;
    imwrite(img, nname);
end


end

