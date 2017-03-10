function [psnr_ori_a,psnr_cut_a,psnr_drop_a,alpha_ori,alpha_cut,alpha_drop,...
one_avg_ori,one_avg_cut,one_avg_drop] = mem_video2(N, coe, size, libnum)

global number

libnum = num2str(libnum);
str1 = ['.\videolib',libnum,'\'];
str2 = '.jpg';

ramsize = size * 1024; %bytes
picl = 144; 
pich = 176;
picsize = picl*pich;
arrsize = picsize*N;
data_ori = zeros(1,arrsize);
data_drop = zeros(1,arrsize);
data_cut = zeros(1,arrsize);
flip_ori = 0;
flip_drop = 0;
flip_cut = 0;
write_num = arrsize-ramsize;

for i = 1:N
    str = [str1,num2str(i),str2];
    data_tmp = reshape(imread(str),[1,picsize]);    
    data_ori((1+picsize*(i-1)) : (picsize*i)) = data_tmp;
end

for i = 1:arrsize
    data_cut(i) = bitand(data_ori(i), 256-pow2(coe));
    data_drop(i) = bit_drop2(data_ori(i), coe);
end

for i = (1 + ramsize):arrsize
    j = i - ramsize;
    flip_ori = flip_ori + number(1+bitxor(data_ori(i), data_ori(j), 'uint8'));
    flip_cut = flip_cut + number(1+bitxor(data_cut(i), data_cut(j), 'uint8'));    
    flip_drop = flip_drop + number(1+bitxor(data_drop(i), data_drop(j), 'uint8'));
end

one_total_ori = 0;
one_total_cut = 0;
one_total_drop = 0;

for i = 1:arrsize
    one_total_ori = one_total_ori+number(1+data_ori(i));
    one_total_cut = one_total_cut+number(1+data_cut(i));
    one_total_drop = one_total_drop+number(1+data_drop(i));
end

one_avg_ori = one_total_ori/arrsize;
one_avg_cut = one_total_cut/arrsize;
one_avg_drop = one_total_drop/arrsize;

psnr_ori = zeros(1,N);
psnr_cut = zeros(1,N);
psnr_drop = zeros(1,N);

% write video
vname = [str1, 'v',libnum,'k',num2str(coe)];
vori = VideoWriter([vname,'ori.mp4'], 'MPEG-4');
vcut = VideoWriter([vname,'cut.mp4'], 'MPEG-4');
vdrop = VideoWriter([vname,'drop.mp4'], 'MPEG-4');
open(vori); open(vcut); open(vdrop); 

for i = 1:N
    img_ori = reshape(data_ori((1+(i-1)*picsize):i*picsize),[picl,pich]);
    img_cut = reshape(data_cut((1+(i-1)*picsize):i*picsize),[picl,pich]);
    img_drop = reshape(data_drop((1+(i-1)*picsize):i*picsize),[picl,pich]);

	writeVideo(vori, uint8(img_ori))
	writeVideo(vcut, uint8(img_cut))
	writeVideo(vdrop, uint8(img_drop))
    
%     fprintf('ori=%f;cut=%f;drop=%f\n', psnr(img_ori,img_ori), psnr(img_ori,img_cut), psnr(img_ori,img_drop)); 
end
close(vori); close(vcut); close(vdrop);

% read video
vori = VideoReader([vname,'ori.mp4']);
vcut = VideoReader([vname,'cut.mp4']);
vdrop = VideoReader([vname,'drop.mp4']);

for i = 1:N
    img_ori = reshape(data_ori((1+(i-1)*picsize):i*picsize),[picl,pich]);

	video_ori = read(vori, i);
	img_ori_mpeg = double(video_ori(:,:,1));
	video_cut = read(vcut, i);
	img_cut_mpeg = double(video_cut(:,:,1));
	video_drop = read(vdrop, i);
	img_drop_mpeg = double(video_drop(:,:,1));
    
	psnr_ori(i) = psnr(img_ori, img_ori_mpeg);
	psnr_cut(i) = psnr(img_ori, img_cut_mpeg);
	psnr_drop(i) = psnr(img_ori, img_drop_mpeg);

%     fprintf('pic%d:ori=%f;cut=%f;drop=%f\n', i, psnr(img_ori,img_ori_mpeg), psnr(img_ori,img_cut_mpeg), psnr(img_ori,img_drop_mpeg)); 

end

psnr_ori_a = mean(psnr_ori);
psnr_cut_a = mean(psnr_cut);
psnr_drop_a = mean(psnr_drop);
alpha_ori = flip_ori / (write_num*8);
alpha_cut = flip_cut / (write_num*8);
alpha_drop = flip_drop / (write_num*8);

end

