function [psnr_ori_a,psnr_cut_a,psnr_drop_a,alpha_ori,alpha_cut,alpha_drop, ...
    one_avg_ori,one_avg_cut,one_avg_drop] = mem(N, coe, size)

global number
global xor_ans

str1 = '.\pgmlib\';
str2 = '.pgm';

ramsize = size * 1024; %bytes
arrsize = 256*256*N;
data_ori = zeros(1,arrsize);
data_cut = zeros(1,arrsize);
data_drop = zeros(1,arrsize);
flip_ori = 0;
flip_drop = 0;
flip_cut = 0;
write_num = arrsize-ramsize;

for i = 1:N
    str = [str1,num2str(i),str2];
    data_tmp = reshape(imread(str),[1,256*256]);    
    data_ori((1+65536*(i-1)) : (65536*i)) = data_tmp;
end

for i = 1:arrsize
    data_cut(i) = bitand(data_ori(i), 256-pow2(coe));
    data_drop(i) = bit_drop2(data_ori(i), coe);
end

for i = (1 + ramsize):arrsize
    j = i - ramsize;
    flip_ori = flip_ori + number(1+xor_ans(1+data_ori(i), 1+data_ori(j)));
    flip_cut = flip_cut + number(1+xor_ans(1+data_cut(i), 1+data_cut(j)));    
    flip_drop = flip_drop + number(1+xor_ans(1+data_drop(i), 1+data_drop(j)));
end

one_total_ori = 0;
one_total_cut = 0;
ont_total_drop = 0;
if size == 32
    for i = 1:arrsize
        one_total_ori = one_total_ori+number(1+data_ori(i));
        one_total_cut = one_total_cut+number(1+data_cut(i));
        ont_total_drop = ont_total_drop+number(1+data_drop(i));
    end
end
one_avg_ori = one_total_ori/arrsize;
one_avg_cut = one_total_cut/arrsize;
one_avg_drop = ont_total_drop/arrsize;

psnr_ori = zeros(1,N);
psnr_cut = zeros(1,N);
psnr_drop = zeros(1,N);
%dirname = './sample_pic/';
if size == 32
    for i = 1:N
        img_ori = reshape(data_ori((1+(i-1)*65536):i*65536),[256,256]);
        img_cut = reshape(data_cut((1+(i-1)*65536):i*65536),[256,256]);
        img_drop = reshape(data_drop((1+(i-1)*65536):i*65536),[256,256]);

        psnr_ori(i) = psnr(img_ori,idct_iquantization(dct_quantization(img_ori)));
        psnr_cut(i) = psnr(img_ori,idct_iquantization(dct_quantization(img_cut)));
        psnr_drop(i) = psnr(img_ori,idct_iquantization(dct_quantization(img_drop)));
    %     figure;
    %     subplot(1,3,1);imshow(uint8(img_ori));title('original');
    %     subplot(1,3,2);imshow(uint8(img_cut));title('cut');
    %     subplot(1,3,3);imshow(uint8(img_drop));title('drop'); 

        %imwrite(uint8(img_ori), [dirname, 'p', num2str(i), 'k', num2str(coe), 'ori', num2str(psnr_ori(i)),'.jpg']);
        %imwrite(uint8(img_cut), [dirname, 'p', num2str(i), 'k', num2str(coe), 'cut', num2str(psnr_cut(i)),'.jpg']);
        %imwrite(uint8(img_drop), [dirname, 'p', num2str(i), 'k', num2str(coe), 'drop', num2str(psnr_drop(i)),'.jpg']);

    end
end

psnr_ori_a = mean(psnr_ori);
psnr_cut_a = mean(psnr_cut);
psnr_drop_a = mean(psnr_drop);
alpha_ori = flip_ori / (write_num*8);
alpha_cut = flip_cut / (write_num*8);
alpha_drop = flip_drop / (write_num*8);

end

