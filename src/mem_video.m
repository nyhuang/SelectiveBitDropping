function [psnr_ori_a,psnr_cut_a,psnr_dropped_a,alpha_ori,alpha_appro,one_avg_ori,one_avg_cut,one_avg_dropped] = mem_video(N, coe, size)

global number

ramsize = size * 1024; %bytes
libnum = '5';
picl = 144; 
pich = 176;
picsize = picl*pich;
arrsize = picsize*N;
data = zeros(1,arrsize);
data_dropped = zeros(1,arrsize);
data_cut = zeros(1,arrsize);
str1 = ['.\videolib',libnum,'\'];
str2 = '.jpg';
real = 0;
appro = 0;

for i = 1:N
    str = [str1,num2str(i),str2];
    data_tmp = reshape(imread(str),[1,picsize]);    
    data((1+picsize*(i-1)) : (picsize*i)) = data_tmp;
end

data_cut(1:ramsize) = data(1:ramsize);
data_dropped(1:ramsize) = data(1:ramsize);

for i = (1 + ramsize):arrsize
    j = i - ramsize;
    data_cut(i) = bitand(data(i), 256 - pow2(coe));
    data_dropped(i) = bit_drop(data(j),data(i),coe);
    [r,a] = bit_count(data(j),data(i),coe);
    real = real + r;
    appro = appro + a;
%     fprintf(['ori=',dec2bin(data(i),8),'\ncut=',dec2bin(data_cut(i),8),'\ndrop=',dec2bin(data_dropped(i),8),'\n']);
end

one_total_ori = 0;
one_total_cut = 0;
one_total_dropped = 0;

for i = 1:arrsize
    one_total_ori = one_total_ori+number(1+data(i));
    one_total_cut = one_total_cut+number(1+data_cut(i));
    one_total_dropped = one_total_dropped+number(1+data_dropped(i));
end

one_avg_ori = one_total_ori/arrsize;
one_avg_cut = one_total_cut/arrsize;
one_avg_dropped = one_total_dropped/arrsize;

psnr_ori = zeros(1,N);
psnr_cut = zeros(1,N);
psnr_dropped = zeros(1,N);

% write video
vname = [str1, 'v',libnum,'k',num2str(coe)];
vori = VideoWriter([vname,'ori.mp4'], 'MPEG-4');
vcut = VideoWriter([vname,'cut.mp4'], 'MPEG-4');
vdrop = VideoWriter([vname,'drop.mp4'], 'MPEG-4');
open(vori); open(vcut); open(vdrop); 

for i = 1:N
    img_ori = reshape(data((1+(i-1)*picsize):i*picsize),[picl,pich]);
    img_cut = reshape(data_cut((1+(i-1)*picsize):i*picsize),[picl,pich]);
    img_dropped = reshape(data_dropped((1+(i-1)*picsize):i*picsize),[picl,pich]);

	writeVideo(vori, uint8(img_ori))
	writeVideo(vcut, uint8(img_cut))
	writeVideo(vdrop, uint8(img_dropped))
    
%     fprintf('ori=%f;cut=%f;drop=%f\n', psnr(img_ori,img_ori), psnr(img_ori,img_cut), psnr(img_ori,img_dropped)); 
end
close(vori); close(vcut); close(vdrop);

% read video
vori = VideoReader([vname,'ori.mp4']);
vcut = VideoReader([vname,'cut.mp4']);
vdrop = VideoReader([vname,'drop.mp4']);

for i = 1:N
    img_ori = reshape(data((1+(i-1)*picsize):i*picsize),[picl,pich]);

	video_ori = read(vori, i);
	img_ori_mpeg = double(video_ori(:,:,1));
	video_cut = read(vcut, i);
	img_cut_mpeg = double(video_cut(:,:,1));
	video_drop = read(vdrop, i);
	img_dropped_mpeg = double(video_drop(:,:,1));
    
	psnr_ori(i) = psnr(img_ori, img_ori_mpeg);
	psnr_cut(i) = psnr(img_ori, img_cut_mpeg);
	psnr_dropped(i) = psnr(img_ori, img_dropped_mpeg);

%     fprintf('pic%d:ori=%f;cut=%f;drop=%f\n', i, psnr(img_ori,img_ori_mpeg), psnr(img_ori,img_cut_mpeg), psnr(img_ori,img_dropped_mpeg)); 

end

psnr_ori_a = mean(psnr_ori);
psnr_cut_a = mean(psnr_cut);
psnr_dropped_a = mean(psnr_dropped);
alpha_ori = real / (picsize*8*N);
alpha_appro = appro / (picsize*8*N);

end

