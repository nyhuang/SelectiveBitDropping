function I = idct_iquantization(J)

% clc,clear;
% I = imread('lena.jpg');
% I = double(rgb2gray(I));
% J = dct_quantization(I);

[M,N] = size(J);

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
        P = J(i:i+7,j:j+7).*a1;
        K = T'*P*T;
        K = round(K/1024/1024);
        J1(i:i+7,j:j+7) = K;
    end
  end

  I =J1;

  for i = 1 : M
      for j = 1 : N
          if J1(i,j) < 0
              I(i,j) = 0;
          elseif J1(i,j) > 255
              I(i,j) = 255;
          end
      end
  end
                  