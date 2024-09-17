unit SampleMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Vcl.StdCtrls, Vcl.Mask,
  Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.DataSet,
  Vcl.Imaging.pngimage;

type
  TForm3 = class(TForm)
    Connection: TFDConnection;
    dsGrid: TDataSource;
    QueryGrid: TFDQuery;
    DBGrid: TDBGrid;
    DBNavigator: TDBNavigator;
    DBName: TDBEdit;
    Nome: TLabel;
    btnOpenQuery: TButton;
    lblInfo: TLabel;
    ImgDataSet: TImage;
    Label1: TLabel;
    ImgRAD: TImage;
    Label2: TLabel;
    Label3: TLabel;
    procedure btnOpenQueryClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses DCache;

procedure TForm3.btnOpenQueryClick(Sender: TObject);
begin
  if TCache.GetInstance
      .SetDataSet(False,QueryGrid)
        .Compare(QueryGrid)
          .IsModified then
    begin
      lblInfo.Caption:= 'Modified';
      lblInfo.Font.Color:= clRed;
      lblInfo.Repaint;
      QueryGrid.Open();
    end else
    begin
      lblInfo.Caption:= 'Not Modified';
      lblInfo.Font.Color:= clBlack;
      lblInfo.Repaint;
    end;
end;


procedure TForm3.FormCreate(Sender: TObject);
begin
  if not FileExists(ExtractFilePath(ParamStr(0))+ 'Data/DB.db') then  raise Exception.Create('DataBase not Found');

  Connection.Params.Database:= ExtractFilePath(ParamStr(0))+ 'Data/DB.db';
  Connection.Connected:= True;
  QueryGrid.Open();

  TCache.GetInstance.SetDataSet(True,QueryGrid);
end;

end.
