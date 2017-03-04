function psnr = psnr(pic1,pic2)
pic1 = double(pic1);
pic2 = double(pic2);
% º∆À„PSNR
[m,n] = size(pic1);
mse = 0;
for i = 1:m
    for j = 1:n
      mse = mse + (pic1(i,j)-pic2(i,j))^2;
    end
end

mse = mse/(m*n);
if mse == 0
    mse = 1e20;
else
    mse = 255^2/mse;
end

psnr = 10*log10(double(mse));     