function video_slice(name, frame_num)

v = VideoReader(name);
path = ['./', name, '_dir/'];
mkdir(path);
for i = 1:frame_num
    video = read(v, i);
    img = video(:,:,1);
    imwrite(img, [path, num2str(i),'.jpg']);
end

end