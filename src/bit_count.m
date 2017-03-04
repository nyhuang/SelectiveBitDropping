function [real,appro] = bit_count(byte1, byte2, coe )

global number;

% real:真实翻转比特数 = 两个字节异或后1的个数
% appro：近似反转比特数 = 两个字节前面的比特按位异或后1的个数 + 1（如果后面至少存在1个需要反转的比特）
real = number(1+bitxor(byte1,byte2));
appro = number(1+bitxor(bitand(byte1,256-pow2(coe)),bitand(byte2,256-pow2(coe))));
if (bitand(byte1,pow2(coe)-1) ~= bitand(byte2,pow2(coe)-1))
    appro = appro + 1;
end

end

