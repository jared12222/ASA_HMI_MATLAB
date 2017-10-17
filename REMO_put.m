function [error] = REMO_put(Port,Type,Bytes,data)

error = 0;
if (Bytes > 32)
    error = 1;
    warning('資料過多bytes>32');
    return;
end

error = 0;

switch Type
    case 1  % int8
        type = 'int8';
        TypeSize = 1;
        Cdata = typecast(int8(data),'uint8');
    case 2  % int16
        type = 'int16';
        TypeSize = 2;
        Cdata = typecast(int16(data),'uint8');
    case 3  % int32
        type = 'int32';
        TypeSize = 4;
        Cdata = typecast(int32(data),'uint8');
    case 4  % uint8
        type = 'uint8';
        TypeSize = 1;
        Cdata = typecast(uint8(data),'uint8');
    case 5  % uint16
        type = 'uint16';
        TypeSize = 2;
        Cdata = typecast(uint16(data),'uint8');
    case 6  % uint32
        type = 'uint32';
        TypeSize = 4;
        Cdata = typecast(uint32(data),'uint8');
    case 7  % float32
        type = 'single';
        TypeSize = 4;
        Cdata = typecast(single(data),'uint8');
    case 8  % float64
        type = 'double';
        TypeSize = 8;
        Cdata = typecast(double(data),'uint8');
    otherwise
        warning('error type');
        return
end

fwrite(Port,hex2dec('AB'),'uint8');
fwrite(Port,hex2dec('AB'),'uint8');
fwrite(Port,hex2dec('AB'),'uint8');
fwrite(Port,Bytes,'uint8');

% get binary data in uint8 form ASA_PC
CheckSum = Bytes;
for i = 1:Bytes
    fwrite(Port,Cdata(i),'uint8');
    CheckSum = CheckSum + Cdata(i);
end

% get check value form ASA_PC
CheckSum = rem(CheckSum,256);
fwrite(Port,CheckSum,'uint8');


end
