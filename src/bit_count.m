function [real,appro] = bit_count(byte1, byte2, coe )

global number;

% real:��ʵ��ת������ = �����ֽ�����1�ĸ���
% appro�����Ʒ�ת������ = �����ֽ�ǰ��ı��ذ�λ����1�ĸ��� + 1������������ٴ���1����Ҫ��ת�ı��أ�
real = number(1+bitxor(byte1,byte2));
appro = number(1+bitxor(bitand(byte1,256-pow2(coe)),bitand(byte2,256-pow2(coe))));
if (bitand(byte1,pow2(coe)-1) ~= bitand(byte2,pow2(coe)-1))
    appro = appro + 1;
end

end

