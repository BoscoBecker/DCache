![image](https://github.com/user-attachments/assets/65b918d8-ede9-4771-9961-77c89336f6bb)

## 📖 Description
Idea found here https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/If-None-Match

The purpose of using DCache is to perform queries on the database only if there is a change in the data set.
Explanation: every time the information "Not modified" is displayed, it means that there was no search in the database, and when it displays "Modified", it actually performed the search in the database.
As shown below

![image](https://github.com/user-attachments/assets/4fcb93e4-33f2-4413-b4e9-a154202e8829)

## 🛠️ The Class

``` pascal
Type
  TCache = class
  strict private
    class var Cache: TCache;
  private
    FModified: boolean;
    FHashData: String;
    FHashCache: String;
    procedure SetModified(const Value: boolean);
    procedure SetHashData(const Value: String);
  public
    function CalculatetHash(DataSet: TDataSet): String;
    function IsModified: boolean;
    class function SetDataSet(Const StoreHash: Boolean; DataSet: TDataSet) :TCache;
    class function Compare(DataSet: TDataSet) :TCache;
    class function GetInstance : TCache;
    property Modified: boolean read IsModified write SetModified default False;
    property HashData: String read FHashData write SetHashData;
  end;
```

### ✅ Starting and SetDataSet 
``` pascal
Begin
  TCache.GetInstance.SetDataSet(True,QueryGrid);
End;

```
### ✅ Checking if there was a change in the data set, if there was, perform the query, otherwise, it does nothing.
``` pascal

   if TCache.GetInstance
        .Compare(QueryGrid)
          .IsModified then

```
 

## 💬 Contributions / Ideas / Bug Fixes
To submit a pull request, follow these steps:

1. 🍴 Fork the project.
2. 🌿 Create a new branch (`git checkout -b my-new-feature`).
3. 🛠️ Make your changes.
4. 💾 Commit your changes (`git commit -am 'Add new feature or fix bug'`).
5. 📤 Push the branch (`git push origin my-new-feature`).
6. 🔄 Open a pull request.

Give me a Star ⭐⭐⭐⭐⭐.
