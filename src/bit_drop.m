function byte_dropped = bit_drop(byte_ori,byte_new,coe)
% byte_ori：原始字节
% byte_new：准备写入的新字节
if (coe > 8)
    fprintf('Out of range! k should be smaller than 9 \n');
    return;
end

% 转为二进制
% byte_dropped：选择丢弃后，最终写入的字节
byte_ori = dec2bin(byte_ori,8);
byte_new = dec2bin(byte_new,8);
byte_dropped = byte_ori;
% 前面的比特照常写入
byte_dropped(1:(8-coe)) = byte_new(1:(8-coe));
flag = 0;
m = 9 - coe;
% 寻找第一个不一样的比特，写入新的比特值，结束循环
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

