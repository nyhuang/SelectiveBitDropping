function byte_dropped = bit_drop2(byte_ori, coe)
if (coe > 8)
    fprintf('Out of range! k should be smaller than 9 \n');
    return;
end

byte_dropped = '00000000';
byte_ori = dec2bin(byte_ori, 8);
byte_dropped(1:(8-coe)) = byte_ori(1:(8-coe));
m = 9 - coe;
while (m < 9)
    if byte_ori(m) == '1'
        byte_dropped(m) = '1';
        break
    end
    m = m + 1;
end

byte_dropped = bin2dec(byte_dropped);

end

