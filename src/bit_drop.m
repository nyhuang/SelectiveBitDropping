function byte_dropped = bit_drop(byte_ori,byte_new,coe)
% byte_ori��ԭʼ�ֽ�
% byte_new��׼��д������ֽ�
if (coe > 8)
    fprintf('Out of range! k should be smaller than 9 \n');
    return;
end

% תΪ������
% byte_dropped��ѡ����������д����ֽ�
byte_ori = dec2bin(byte_ori,8);
byte_new = dec2bin(byte_new,8);
byte_dropped = byte_ori;
% ǰ��ı����ճ�д��
byte_dropped(1:(8-coe)) = byte_new(1:(8-coe));
flag = 0;
m = 9 - coe;
% Ѱ�ҵ�һ����һ���ı��أ�д���µı���ֵ������ѭ��
while (m < 9)
    if flag == 0
        if (byte_ori(m) ~= byte_new(m))
            byte_dropped(m) = byte_new(m);
            flag = 1;
        end
    else
        byte_dropped(m) = '0';
    end
    m = m + 1;
end

byte_dropped = bin2dec(byte_dropped);

end

