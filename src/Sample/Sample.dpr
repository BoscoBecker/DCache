program Sample;

uses
  Vcl.Forms,
  SampleMain in 'SampleMain.pas' {Form3},
  DCache in '..\Source\DCache.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:= True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
