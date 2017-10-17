function [Format,TypeNum,StructSize,error] = FormatGet(FormatString)
% handle FormatString
error = 0;
StructSize = 0;
FormatBytes = length(FormatString);
TypeInfo = struct(...
'Name',{'lld'  ,'llu'   ,'bd'  ,'bu'   ,'ld'   ,'lu'    ,'lf'    ,'c'   ,'d'    ,'u'     ,'f'     ,'x'    },...
'Type',{'int64','uint64','int8','uint8','int32','uint32','double','int8','int16','uint16','single','uint8'},...
'Size',{ 8     , 8      , 1    , 1     , 4     , 4      , 8      , 1    , 2     , 2      , 4      , 1     });

TypeNum = 0;
i = 1;
while i <= FormatBytes-1
    for j = 1:11
        l = i+length(TypeInfo(j).Name)-1;
        if l > FormatBytes-1
            continue;
        end
        if strcmp( FormatString(i:l) , TypeInfo(j).Name )
            TypeNum = TypeNum + 1;
            Format(TypeNum).Name = strcat('type', num2str(TypeNum) );
            Format(TypeNum).Type = TypeInfo(j).Type;
            Format(TypeNum).TypeSize = TypeInfo(j).Size;
            Format(TypeNum).Num = 0;
            i = i +length(TypeInfo(j).Name);
            break;
        end
        if j==11
            error = 1;
            warning('FormatString error');
            return;
        end
    end
    [num,isnum] = str2num( FormatString(i) );
    while isnum && i <= FormatBytes
        Format(TypeNum).Num = Format(TypeNum).Num *10 +num;
        if i <= FormatBytes-1
            i = i+1;
            [num,isnum] = str2num( FormatString(i) );
        else
            break
        end
    end
    StructSize = StructSize + Format(TypeNum).TypeSize*Format(TypeNum).Num;
    if Format(TypeNum).Num == 0
        error = 1;
        warning('FormatString¿ù»~');
        return;
    end
end

end
