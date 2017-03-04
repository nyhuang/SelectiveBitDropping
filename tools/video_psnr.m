function psnr_a = video_psnr(vname1, vname2, N)

v1 = VideoReader(vname1);
v2 = VideoReader(vname2);
psnr_sum = 0;
for i = 1:N
	vdo1 = read(v1, i);
	img1 = double(vdo1(:,:,1));
	vdo2 = read(v2, i);
	img2 = double(vdo2(:,:,1));
	psnr_sum = psnr_sum+psnr(img1, img2);
end
psnr_a = psnr_sum/N;

end



	