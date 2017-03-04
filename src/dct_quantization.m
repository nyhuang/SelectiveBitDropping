function J = dct_quantization (I)

% clc,clear;
% I = imread('·ç¾°.jpg');
% I = double(rgb2gray(I));

[M,N] = size(I);

rm = mode(M,8);
rn = mode(N,8);
if rm ~= 0
    for i = M + 1 : M + 8 - rm
        for j = 1 : N
            I(i,j) = 0;
        end
    end
end
if rn ~=0
    for i = 1 : M + 8 - rm
        for j = N + 1 : N + 8 - rn
            I(i,j) = 0;
        end
    end
end
[M,N] = size(I);

T = floor(dctmtx(8)*1024);

a1 = [16 11 10 16 24  40  51  61 ;
      12 12 14 19 26  58  60  55 ;
      14 13 16 24 40  57  69  56 ;
      14 17 22 29 51  87  80  62 ;
      18 22 37 56 68  109 103 77 ;
      24 35 55 64 81  104 113 92 ;
      49 64 78 87 103 121 120 101;
      72 92 95 98 112 100 103 99 ];
  
for i = 1 : 8 : M
    for j = 1 : 8 : N
        P = I(i:i+7,j:j+7);
        K = T*P*T';
        K = round(K/1024/1024);
        I2(i:i+7,j:j+7) = K;
        K = round(K./a1);
        I3(i:i+7,j:j+7) = K;
    end
end
  
% imshow(I2);
J = I3;
  