function [psnr_ori_a,psnr_cut_a,psnr_dropped_a,alpha_ori,alpha_appro,one_avg_ori,one_avg_cut,one_avg_dropped] = mem(N, coe, size)

global number

ramsize = size * 1024; %bytes
arrsize = 256*256*N;
data = zeros(1,arrsize);
data_dropped = zeros(1,arrsize);
data_cut = zeros(1,arrsize);
str1 = '.\pgmlib\';
str2 = '.pgm';
real = 0;
appro = 0;

for i = 1:N
    str = [str1,num2str(i),str2];
    data_tmp = reshape(imread(str),[1,256*256]);    
    data((1+65536*(i-1)) : (65536*i)) = data_tmp;
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

dirname = './sample_pic/';

for i = 1:N
    img_ori = reshape(data((1+(i-1)*65536):i*65536),[256,256]);
    img_cut = reshape(data_cut((1+(i-1)*65536):i*65536),[256,256]);
    img_dropped = reshape(data_dropped((1+(i-1)*65536):i*65536),[256,256]);
    
    psnr_ori(i) = psnr(img_ori,idct_iquantization(dct_quantization(img_ori)));
    psnr_cut(i) = psnr(img_ori,idct_iquantization(dct_quantization(img_cut)));
    psnr_dropped(i) = psnr(img_ori,idct_iquantization(dct_quantization(img_dropped)));

%     figure;
%     subplot(1,3,1);imshow(uint8(img_ori));title('original');
%     subplot(1,3,2);imshow(uint8(img_cut));title('cut');
%     subplot(1,3,3);imshow(uint8(img_dropped));title('dropped'); 
    
    imwrite(uint8(img_ori), [dirname, 'p', num2str(i), 'k', num2str(coe), 'ori.jpg']);
    imwrite(uint8(img_cut), [dirname, 'p', num2str(i), 'k', num2str(coe), 'cut.jpg']);
    imwrite(uint8(img_dropped), [dirname, 'p', num2str(i), 'k', num2str(coe), 'drop.jpg']);
    
end
    
psnr_ori_a = mean(psnr_ori);
psnr_cut_a = mean(psnr_cut);
psnr_dropped_a = mean(psnr_dropped);
alpha_ori = real / (256*256*8*N);
alpha_appro = appro / (256*256*8*N);

end

