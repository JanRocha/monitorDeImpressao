unit UPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls,
  UImpressaoPDF,
  Vcl.OleCtrls,
  AcroPDFLib_TLB,
  Vcl.ExtCtrls,
  UFrmConfiguracoes,
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  UImpressaoTXT,
  UImpressaoXML,
  IdHTTP, Vcl.AppEvnts
  ;

type
  TfrmPrincipal = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    Timer1: TTimer;
    Timer2: TTimer;
    TrayIcon1: TTrayIcon;
    ApplicationEvents1: TApplicationEvents;
    Timer3: TTimer;
    AcroPDF1: TAcroPDF;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Imprimir();
    procedure Baixar();
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  Vcl.Printers;

{$R *.dfm}

procedure TfrmPrincipal.ApplicationEvents1Minimize(Sender: TObject);
begin
  Self.Hide();
  //Self.WindowState := wsMinimized;
  TrayIcon1.Visible := True;
  TrayIcon1.Animate := True;
  TrayIcon1.ShowBalloonHint;
end;

procedure TfrmPrincipal.Baixar;
var
  oImpressao:TImpressaoPDF;
  oImpressaoTxt: TImpressaoTXT;
  oImpressaoXML: TImpressaoXML;
begin
  oImpressao           := TImpressaoPDF.Create();
  oImpressaoTxt        := TImpressaoTXT.Create();
  oImpressaoXML         := TImpressaoXML.Create();
  try
    oImpressao.Memo    := Memo1;
    oImpressao.BaixarPDF();
    oImpressaoTxt.Memo := Memo1;
    oImpressaoTxt.BaixarTXT();
    oImpressaoXML.Memo:= Memo1;
    oImpressaoXML.BaixarXML();
  finally
    oImpressao.Free;
    oImpressaoTxt.Free;
    oImpressaoXML.Free;
  end;
end;

procedure TfrmPrincipal.Button1Click(Sender: TObject);
begin
  Timer1.Enabled:= false;
  Timer2.Enabled:= false;
  baixar();
  Imprimir();
  Timer1.Enabled:= true;
  Timer2.Enabled:= true;
end;

procedure TfrmPrincipal.Button2Click(Sender: TObject);
var
  oFRM: TfrmConfiguracoes;
begin
  Timer1.Enabled:= false;
  Timer2.Enabled:= false;
  oFRM:= TfrmConfiguracoes.Create(nil);
  try
    oFRM.ShowModal();
  finally
    oFRM.Free;
  end;
  Timer1.Enabled:= true;
  Timer2.Enabled:= true;
end;

procedure TfrmPrincipal.Imprimir;
var
  oImpressao:TImpressaoPDF;
  oImpressaoTXT: TImpressaoTXT;
  oImpressaoXML: TImpressaoXML;
begin
  oImpressao           := TImpressaoPDF.Create();
  oImpressaoTXT        := TImpressaoTXT.Create();
  oImpressaoXML        := TImpressaoXML.Create();
  try
    oImpressao.AcroPDF := AcroPDF1;
    oImpressao.Memo    := Memo1;
    oImpressao.Print();

    oImpressaoTXT.Memo := Memo1;
    oImpressaoTXT.Print();

    oImpressaoXML.Memo:= Memo1;
    oImpressaoXML.Print();
  finally
    oImpressao.Free;
    oImpressaoTXT.Free;
    oImpressaoXML.Free;
  end;
end;

procedure TfrmPrincipal.Timer1Timer(Sender: TObject);
begin
  //Timer1.Enabled:= false;
  //Timer2.Enabled:= false;
 // Imprimir();
 // Timer1.Enabled:= true;
 // Timer2.Enabled:= true;
end;

procedure TfrmPrincipal.Timer2Timer(Sender: TObject);
begin
  Timer1.Enabled:= false;
  Timer2.Enabled:= false;
  baixar();
  Imprimir();
  Timer1.Enabled:= true;
  Timer2.Enabled:= true;
end;

procedure TfrmPrincipal.Timer3Timer(Sender: TObject);
begin
  Timer3.Enabled := False;
  Application.Minimize;
  Timer1.Enabled := true;
  Timer2.Enabled := true;
end;

procedure TfrmPrincipal.TrayIcon1Click(Sender: TObject);
begin
  TrayIcon1.Visible := False;
  Show();
  self.BringToFront;
end;

end.
