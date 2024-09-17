unit DCache;

interface

uses System.Hash, Data.DB, System.SysUtils, System.Variants, System.Classes;

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
    class function SetDataSet(Const StoreHash: Boolean; DataSet: TDataSet) :TCache;
    function IsModified: boolean;
    class function Compare(DataSet: TDataSet) :TCache;
    class function GetInstance : TCache;
    property Modified: boolean read IsModified write SetModified default False;
    property HashData: String read FHashData write SetHashData;
  end;

implementation

{ TCache }

function TCache.CalculatetHash(DataSet: TDataSet): String;
begin
  if not DataSet.Active  then raise Exception.Create('Dataset is not active');
  if DataSet.IsEmpty  then Exit;
  var DataString:= TStringBuilder.Create;
  try
    DataString.Clear;
    DataSet.DisableControls;
    try
      DataSet.First;
      while not DataSet.Eof do
      begin
        for var i := 0 to DataSet.FieldCount - 1 do
          DataString.Append(DataSet.Fields[i].AsString);
        DataSet.Next;
      end;
    finally
      DataSet.EnableControls;
    end;

    Result :=  THashSHA2.GetHashString(DataString.ToString,SHA224);
    FHashCache:= Result;
  finally
    DataString.Free;
  end;
end;

class function TCache.Compare(DataSet: TDataSet): TCache;
begin
  if Cache.HashData.Equals('') then
  begin
    Cache.SetModified(False)
  end else
  begin
    if Cache.GetInstance.CalculatetHash(DataSet) <> Cache.FHashData then
    begin
      Cache.SetModified(True);
      Cache.SetHashData(Cache.GetInstance.FHashCache);
    end
    else
      Cache.SetModified(False)
  end;
  result := Cache;
end;

class function TCache.GetInstance: TCache;
begin
  if Cache =  nil then
    Cache:= TCache.Create;
  result:= Cache;
end;

function TCache.IsModified: boolean;
begin
  result:= FModified;
end;

class function TCache.SetDataSet(Const StoreHash: Boolean; DataSet: TDataSet):TCache;
begin
  case StoreHash of
    True:  Cache.SetHashData(Cache.CalculatetHash(DataSet));
    False:  Cache.CalculatetHash(DataSet);
  end;
  result:= Cache;
end;

procedure TCache.SetHashData(const Value: String);
begin
  FHashData := Value;
end;

procedure TCache.SetModified(const Value: boolean);
begin
  FModified := Value;
end;

initialization

finalization
  if TCache <> nil then
     TCache.GetInstance.Free;


end.


