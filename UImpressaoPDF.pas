unit UImpressaoPDF;

interface

uses
  AcroPDFLib_TLB,
  Winapi.ShellAPI,
  Winapi.Windows,
  Vcl.Printers,
  classes,
  UConfiguracoes,
  UFuncoes,
  System.SysUtils,
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdServerIOHandler,
  IdSSL,
  IdSSLOpenSSL,
  IdHTTP, Vcl.StdCtrls;

type
  TImpressaoPDF = class(TPersistent)
  private
    FIdHTTP: TIdHTTP;
    FHandler: TIdSSLIOHandlerSocketOpenSSL;
    FFuncoes: TFuncoes;
    FConfig: TConfiguracoes;
    FAcroPDF: TAcroPDF;
    FnomeImpressora: string;
    FImpressoraPadrao:string;
    FMemo: TMemo;
    procedure SetDefaultPrinter(PrinterName: String);
    function GetDefaultPrinterName: string;
    procedure PrintFile(aFile: TFileName);
    procedure VerificarDiretorio();
  published
    property nomeImpressora: string read FnomeImpressora write FnomeImpressora;
    property AcroPDF:TAcroPDF read FAcroPDF write FAcroPDF;
    property Memo: TMemo read FMemo write FMemo;
  public
    procedure Exibir(msg:string);
    procedure BaixarPDF();
    procedure Print();
    constructor Create();
    destructor Destroy; override;
  end;

implementation

uses
  Winapi.Messages, Vcl.Forms;

{ TImpressaoPDF }

procedure TImpressaoPDF.BaixarPDF;
var
  arquivo,caminho, destino, ext, request: string;
  MyFile: TFileStream;
  i,  i2,qtd: Integer;
begin
  VerificarDiretorio();
  destino:= GetCurrentDir +  '\PDF\';
  caminho:= FConfig.CaminhoServidor;
  qtd    := FConfig.quantidade_de_vias;
  ext    := '.pdf';
  for i := 0 to 10 do
  begin
    for i2 := 1 to qtd do
    begin
      arquivo:=  FConfig.CodigoCliente+ '_'+ IntToStr(FConfig.Sequencia);
      MyFile := TFileStream.Create(destino + arquivo + '_' +IntToStr(i2) + ext, fmCreate); // local no hd e nome do arquivo com a extensão, onde vai salvar.
      try
        try
          request:= caminho +'/'+ arquivo + ext;
          FIdHTTP.Get(request, MyFile); // fazendo o download do arquivo
        except on E: Exception do
          begin
            FFuncoes.GravarLog('BaixarPDF(): '+E.Message);
          end;
        end;
      finally
        MyFile.Free;
      end;
      if FIdHTTP.ResponseCode <> 200 then
      begin
        DeleteFile(destino + arquivo + '_' +IntToStr(i2) + ext);
        exit;
      end;
    end;
    FConfig.Sequencia := FConfig.Sequencia + 1;
    if FIdHTTP.ResponseCode = 200 then
    begin                                       
      Exibir('BaixarPDF(): ' + request);
      FConfig.Gravar();
    end
    else
      exit;
  end;
end;

constructor TImpressaoPDF.Create;
begin
  FFuncoes:= TFuncoes.Create;
  FConfig := TConfiguracoes.Create;
  FIdHTTP := TIdHTTP.Create(nil);
  FHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  FHandler.SSLOptions.Method := sslvTLSv1_2;
  FidHTTP.IOHandler := FHandler;
end;

destructor TImpressaoPDF.Destroy;
var i:integer;
begin
  if Assigned(FAcroPDF) then
    i:= FAcroPDF.ControlInterface._AddRef;
  FFuncoes.Free;
  FConfig.Free;
  FHandler.Free;
  FIdHTTP.Free;
  inherited;
end;

procedure TImpressaoPDF.Exibir(msg: string);
var data:string;
begin
  data:= FormatDateTime('hh:mm:ss',now);
  Memo.Lines.Add(data+ ' - ' + msg);
  Application.ProcessMessages;
end;

function TImpressaoPDF.GetDefaultPrinterName: string;
begin
 Result:= '';
 if (Printer.PrinterIndex >= 0) then
  begin
    Result := Printer.Printers[Printer.PrinterIndex];
  end;
end;

procedure TImpressaoPDF.Print;
var sl:TStringList;
  caminho:string;
begin
  sl:= TStringList.Create;
  caminho:= GetCurrentDir + '\PDF\';
  try
    sl:= FFuncoes.ListarArquivos(caminho , true);
    if sl.Count>0 then
    begin
      Exibir('Enviando para Impressão: '+caminho+ sl[0]);
      PrintFile(caminho+ sl[0]);
      DeleteFile(GetCurrentDir+'\IMPRESSO\' + sl[0]);
      MoveFile(PwideChar(caminho + sl[0]), PwideChar(GetCurrentDir+'\IMPRESSO\' + sl[0]));
      Exibir('Arquivo movido para: '+ GetCurrentDir+'\IMPRESSO\' + sl[0]);
    end;
  finally
    sl.Free;
  end;
end;

procedure TImpressaoPDF.PrintFile(aFile: TFileName);
begin
  FImpressoraPadrao:= GetDefaultPrinterName();
  if nomeImpressora <> FImpressoraPadrao then
    SetDefaultPrinter(nomeImpressora);


  FAcroPDF.Visible := False; // deixa o componente invisível
  FAcroPDF.src     :=aFile; // carrega o arquivo PDF
  FAcroPDF.printAll; // abre a janela de impressão
  FAcroPDF.src     := '';
 { for i := 0 to Printer.Printers.Count - 1 do
  begin
    if Printer.printers[i] = nomeImpressora then
    begin
      //vPrinter              := TPrinter.Create;
      Printer.PrinterIndex := i;
      //vPrinter.PrinterIndex := i;
      Printer.GetPrinter(Device,Driver,Port,hDeviceMode);
      S                     := Format('"%s" "%s" "%s"',[Device,Driver,Port]);
      //http://www.activedelphi.com.br/forum/viewtopic.php?t=78886&sid=aba552cdad3333e440f10d5aa12de810
      FAcroPDF.Visible := False; // deixa o componente invisível
      FAcroPDF.src     :=aFile; // carrega o arquivo PDF
      FAcroPDF.printAll; // abre a janela de impressão
      FAcroPDF.src     := '';

     // vPrinter.Free;
    end;
  end;   }
end;

procedure TImpressaoPDF.SetDefaultPrinter(PrinterName: String);
var
  I: Integer;
  Device : PChar;
  Driver : Pchar;
  Port : Pchar;
  HdeviceMode: Thandle;
  aPrinter : TPrinter;
begin
  Printer.PrinterIndex := -1;
  getmem(Device, 255);
  getmem(Driver, 255);
  getmem(Port, 255);
  aPrinter := TPrinter.create;
  for I := 0 to Printer.printers.Count-1 do
  begin
  if Printer.printers[i] = PrinterName then
  begin
  aprinter.printerindex := i;
  aPrinter.getprinter(device, driver, port, HdeviceMode);
  StrCat(Device, ',');
  StrCat(Device, Driver );
  StrCat(Device, Port );
  WriteProfileString('windows', 'device', Device);
  StrCopy( Device, 'windows' );
  SendMessage(HWND_BROADCAST, WM_WININICHANGE, 0, Longint(@Device));
  end;
  end;
  Freemem(Device, 255);
  Freemem(Driver, 255);
  Freemem(Port, 255);
  aPrinter.Free;


end;

procedure TImpressaoPDF.VerificarDiretorio;
var destino:string;
begin
  destino:= GetCurrentDir + '\PDF';
  if not DirectoryExists(destino) then
    ForceDirectories(destino);
  if not DirectoryExists(GetCurrentDir + '\IMPRESSO') then
    ForceDirectories(GetCurrentDir + '\IMPRESSO');
end;

end.
