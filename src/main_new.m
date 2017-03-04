format long g;
global number;
number = zeros(1,256);
number(1) = 0;
for i = 2:256
    number(i) = number(1+bitand(i-1,i-2)) + 1;
end

coerange = 7;
N = 7;
size = 32; %32kB£¬64£¬128
psnr_ori_arr = zeros(1,coerange);
psnr_cut_arr = zeros(1,coerange);
psnr_dropped_arr = zeros(1,coerange);
alpha_real_arr = zeros(1,coerange);
alpha_appro_arr = zeros(1,coerange);
one_avg_ori_arr = zeros(1,coerange);
one_avg_cut_arr = zeros(1,coerange);
one_avg_dropped_arr = zeros(1,coerange);

for coe = 1:coerange
    disp(['k=',num2str(coe)]);
    [psnr_ori_arr(coe),psnr_cut_arr(coe),psnr_dropped_arr(coe),alpha_real_arr(coe),...
        alpha_appro_arr(coe),one_avg_ori_arr(coe),one_avg_cut_arr(coe),one_avg_dropped_arr(coe)] = mem(N, coe, size);
end




