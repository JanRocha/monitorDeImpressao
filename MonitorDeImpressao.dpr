program MonitorDeImpressao;

uses
  Vcl.Forms,
  UPrincipal in 'UPrincipal.pas' {frmPrincipal},
  UImpressaoPDF in 'UImpressaoPDF.pas',
  UFrmConfiguracoes in 'UFrmConfiguracoes.pas' {frmConfiguracoes},
  UConfiguracoes in 'UConfiguracoes.pas',
  UFuncoes in 'UFuncoes.pas',
  Controller.Impressora in 'Controller.Impressora.pas',
  UImpressaoTXT in 'UImpressaoTXT.pas',
  Winapi.Windows,
  UImpressaoXML in 'UImpressaoXML.pas';

{$R *.res}

begin
  CreateMutex(NIL,False,'MonitorDeImpressora');
  If GetLastError = ERROR_ALREADY_EXISTS Then
  Begin
    SendMessage(HWND_BROADCAST,
    RegisterWindowMessage('MonitorDeImpressora'),0,0);
    Halt(0);
  End;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
