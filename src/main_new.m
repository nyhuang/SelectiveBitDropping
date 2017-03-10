format long g;
global number;
number = zeros(1,256);
number(1) = 0;
for i = 2:256
    number(i) = number(1+bitand(i-1,i-2)) + 1;
end
global xor_ans
xor_ans = zeros(256,256);
for i = 0:255
    for j = 0:255
        xor_ans(i+1, j+1) = bitxor(i, j, 'uint8');
    end
end


coerange = 8;
N = 10;
psnr_ori_arr = zeros(1,coerange);
psnr_cut_arr = zeros(1,coerange);
psnr_drop_arr = zeros(1,coerange);
alpha_ori_arr = zeros(1,coerange);
alpha_cut_arr = zeros(1,coerange);
alpha_drop_arr = zeros(1,coerange);
one_avg_ori_arr = zeros(1,coerange);
one_avg_cut_arr = zeros(1,coerange);
one_avg_drop_arr = zeros(1,coerange);
% pic
for size = 32
    for coe = 1:coerange
        disp(['k=',num2str(coe)]);
        [psnr_ori_arr(coe),psnr_cut_arr(coe),psnr_drop_arr(coe),alpha_ori_arr(coe),alpha_cut_arr(coe),...
            alpha_drop_arr(coe),one_avg_ori_arr(coe),one_avg_cut_arr(coe),one_avg_drop_arr(coe)] = mem2(N, coe, size);
    end
%     data_name = ['./data/DCT_PGM_', num2str(size), 'k'];
%     save(data_name);
%     mat2excel(data_name);
end
% video
% size = 32;
% for libnum = 1:5
%     for coe = 1:coerange
%         disp(['k=',num2str(coe)]);
%         [psnr_ori_arr(coe),psnr_cut_arr(coe),psnr_drop_arr(coe),alpha_ori_arr(coe),alpha_cut_arr(coe),...
%             alpha_drop_arr(coe),one_avg_ori_arr(coe),one_avg_cut_arr(coe),one_avg_drop_arr(coe)] = mem_video2(N, coe, size, libnum);
%     end
%     data_name = ['./data/MPEG_QCIF', num2str(libnum)];
%     save(data_name);
%     mat2excel(data_name);
% end



