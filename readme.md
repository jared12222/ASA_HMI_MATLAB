# ASA_HMI_MATLAB

## 簡介
　　本MATLAB巨集函式庫，包含，`fscanf()`、`fprint()`、`REMO_get()`, `REMOForm_get()`、`REMO_put()`、 `REMOForm_put()`，可以與M128之人機介面函式一對一配合，完成訊息操作，以及資料交換之動作。

## 函式呼叫介面
### [Port, error] = REMO_open( COM_number )
 開啟UART通訊埠巨集函式Function  
 簡介：呼叫本巨集，以開啟編號Com_number的UART串列通訊埠。  
 - 輸入變數：
   - COM_number : PC COM PORT編號  
 - 回傳結果：  
   - Port : 已開啟UART通訊埠之必要參數集合，存放於Port 型態之變數集合。
   - error : 錯誤代碼
     - 0 : 成功無誤。
     - 1 : COM_number錯誤。COM使用中或被占用。


### [error] = REMO_close( Port )
 關閉UART通訊埠巨集函式Function  
 簡介：呼叫本巨集函式以關閉佔用變數集合Port之UART通訊埠。  
 - 輸入變數：
   - Port : 由Port變數集合所代表之已開啟UART通訊埠。
 - 回傳結果：
   - error : 回傳錯誤代碼
     - 0 : 已完成關閉Port變數集合所代表之UART通訊埠。
     - 1 :  傳輸中關閉

### [data,error] = REMO_get(Port,Type,Bytes)
 由UART通訊埠讀回資料function  
 簡介：呼叫本巨集函式由Port 指定之UART通訊埠讀回DataType 所指定型態之資料。  
 - 輸入變數：
   - Port : 由Port變數集合所代表之已開啟UART通訊埠。
   - Type : 欲讀回之資料型態。可用之資料型態詳見DataType 表。
 - 回傳結果：
   - data  : 讀回資料矩陣。
   - error : 回傳錯誤代碼
     - 0 : 成功。
     - 1 :標頭封包錯誤。
     - 2 :接收Bytes與資料大小相異。
     - 3 : 檢查碼錯誤。通訊失敗。
     - 4 : 資料傳輸逾時

### [error] = REMO_put(Port, Type, Bytes, data)
 由UART通訊埠送出資料function  
 簡介：呼叫本巨集函式由Port 指定之UART通訊埠送出DataType 所指定型態之資料。  
 - 輸入變數：
   - Port  : 由Port變數集合所代表之已開啟UART通訊埠。
   - DataType : 欲送出之資料型態。可用之資料型態詳見DataType 表。
   - Bytes : 待發送資料Bytes數。
   - data  : 待發送資料矩陣。
 - 回傳結果：
   - error : 回傳錯誤代碼
     - 0 : 成功。
     - 1 : Bytes大於32bytes無法通訊。
     - 2 : 資料傳輸逾時

#### Type 資料型態對應表  
| 代碼 | 使用資料型態 | 說明 | AVR-C語言變數型態 |
| :-- | :------ |:------------- |:------------- |
| 0   | int8    |  8 bit 整數型態   | char、int8 |
| 1   | int16   | 16 bit 整數型態   | int、int16 |
| 2   | int32   | 32 bit 整數型態   | long int、int32 |
| 3   | int64   | 64 bit 整數型態   | int64 |
| 4   | uint8   |  8 bit 正整數型態 | unsigned char、uint8 |
| 5   | uint16  | 16 bit 正整數型態 | unsigned int、uint16 |
| 6   | uint32  | 32 bit 正整數型態 | unsigned long int、uint32 |
| 7   | uint64  | 64 bit 正整數型態 | uint64 |
| 8   | float32 | 32 bit 浮點數型態 | float、double |
| 9   | float64 | 64 bit 浮點數型態 | 無 |  

(AVR只提供32bit浮點數型態，float及double皆為32bit)

### [Data_struct, error] = REMOForm_get(Port,'FormatString')
 由UART通訊埠讀回指定格式之資料結構內容  
 簡介：呼叫本巨集函式由Port 指定之UART通訊埠讀回FormatString 所指定型態之資料結構內容。
 - 輸入變數：
   - Port : 由Port變數集合所代表之已開啟UART通訊埠。
   - FormatString : 欲讀回之資料結構組織字串。可用之資料型態詳見DataType 表。
 - 回傳結果：
   - Data_struct : 讀回資料結構內容。其內容由多個欄位資料組成，每欄名稱依先後順序(從1開始)加上其欄位型態為名，例如第2欄為整數，其欄名為f2i16,又如第1欄 為char, 其欄名為f1i8。
   - error : 回傳錯誤代碼
     - 0 : 成功。
     - 1 :標頭封包錯誤。
     - 2 :接收Bytes與資料大小相異。
     - 3 : 檢查碼錯誤。通訊失敗。
     - 4 : 資料傳輸逾時

### [error] = REMOForm_put(Port, 'FormatString',  Data_struct)
由UART通訊埠送出指定格式之資料結構內容  
簡介：呼叫本巨集函式由Port 指定之UART通訊埠送出FormatString 所指定型態之資料結構內容。
- 輸入變數：
  - Port : 由Port變數集合所代表之已開啟UART通訊埠。
  - FormatString : 欲送出之資料結構組織字串。可用之資料型態詳見DataType 表。
  - Data_struct : 欲送出資料結構內容。
- 回傳結果：
  - error : 回傳錯誤代碼
    - 0 : 成功。
    - 1 :  FormatString錯誤
    - 2 : 資料傳輸逾時

#### FormatString 說明
　　由資料代碼及筆數所組成之字串，其中每一欄位，代表依總資料型態，由**Type 資料型態對應表**中的代碼表示，後接英文字母"`x`"及一個數字指其筆數。形態文字代碼。各欄間以"`,`"隔開。
##### Type 資料型態對應表  
 | 代碼 | 使用資料型態 | 說明 | AVR-C語言變數型態 |
 | :-- | :------ |:------------- |:------------- |
 | i8   | int8    |  8 bit 整數型態   | char、int8 |
 | i16  | int16   | 16 bit 整數型態   | int、int16 |
 | i32  | int32   | 32 bit 整數型態   | long int、int32 |
 | i64  | int64   | 64 bit 整數型態   | int64 |
 | ui8  | uint8   |  8 bit 正整數型態 | unsigned char、uint8 |
 | ui16 | uint16  | 16 bit 正整數型態 | unsigned int、uint16 |
 | ui32 | uint32  | 32 bit 正整數型態 | unsigned long int、uint32 |
 | ui64 | uint64  | 64 bit 正整數型態 | uint64 |
 | f32  | float32 | 32 bit 浮點數型態 | float、double |
 | f64  | float64 | 64 bit 浮點數型態 | 無 |  

(AVR只提供32bit浮點數型態，float及double皆為32bit)

##### 使用範例：
C語言結構若為
``` c
int data1[5];
char data2[6];
float data3[7];
unsigned int data4[8];
```
則對應之FirmatString 為 `i16x5,i8x6,f32x7,ui16x8`

## 使用範例
#### 1. MATLAB由UART通訊埠接收資料範例
- MATLAB端(接收資料)   
    ``` matlab
    clear;clc;

    % 開啟UART通訊埠
    COM_NUM = 3;
    Port = REMO_open(COM_NUM);

    % 由UART通訊埠接收資料
    Type  = 8;
    Bytes = 20;
    Data = REMO_get(Port,Type,Bytes)

    % 關閉UART通訊埠
    REMO_close(Port)
    ```
- ASA_M128端(發送資料)  
    ``` C
    #include "ASA_LIB.h"

    int main() {
        ASA_M128_set();

        //生成資料
        float Data[5]={1.1,-1,0,1,-2.1};
        char num = 5;
        char Bytes = num*sizeof(float); // float is 4 bytes =>Bytes = 20
        char Type  = 8;

        // 由UART通訊送出資料
        HMI_put(Bytes,Type,Data);

        return 0;
    }
    ```
#### 2. MATLAB由UART通訊埠發送資料範例
- MATLAB端(發送資料)   
    ``` matlab
    clear;clc;
    % 開啟UART通訊埠
    COM_NUM = 3;
    Port = REMO_open(COM_NUM);

    % 生成資料
    data = int8([1 2 3 4 5]);

    % 由UART通訊送出資料
    Type  = 5;
    Bytes = 5;
    [error] = REMO_put(Port,Type,data)

    % 關閉UART通訊埠
    REMO_close(Port)
    ```
- ASA_M128端(接收資料)  
    ``` C
    #include "ASA_LIB.h"

    int main() {
        ASA_M128_set();

        // 生成矩陣以存放資料
        int8_t Data[5];
        char num = 5;
        char Bytes = num*sizeof(int8_t);

        // 由UART通訊接收資料
        HMI_get(Bytes,Data);

        return 0;
    }
    ```

## TODOLIST

- 補齊範例程式
- 加入單元測試
- Source 加入matlab格式的說明
