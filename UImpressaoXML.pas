unit UImpressaoXML;

interface
uses
  Winapi.Windows,
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
  IdHTTP,
  ACBrBase, ACBrDFe, ACBrNFe, ACBrNFeDANFeESCPOS,ACBrPosPrinter,ACBrDANFCeFortesFr,
  pcnConversao,
  Controller.Impressora,
  IdSSLOpenSSLHeaders,
  Vcl.StdCtrls, Vcl.Forms;

type
  TImpressaoXML = class(TPersistent)
  private
    FACBrNFe: TACBrNFe;
    FImpressao:TControllerImpressora;
    FFuncoes: TFuncoes;
    FConfig: TConfiguracoes;
    FIdHTTP: TIdHTTP;
    FHandler: TIdSSLIOHandlerSocketOpenSSL;
    FMemo: TMemo;
    procedure VerificarDiretorio();
    procedure PrintFile(aFile: TFileName);
  published
    property Memo: TMemo read FMemo write FMemo;
  public
    procedure Exibir(msg:string);
    procedure BaixarXML();
    procedure Print();
    constructor Create();
    destructor Destroy; override;
  end;

implementation

{ TImpressaoXML }

procedure TImpressaoXML.BaixarXML;
var
  arquivo,caminho, destino, ext, request: string;
  MyFile: TFileStream;
  i,  i2,qtd: Integer;
begin
  VerificarDiretorio();
  destino:= GetCurrentDir +  '\XML\';
  caminho:= FConfig.CaminhoServidor;
  qtd    := FConfig.quantidade_de_vias;
  ext    := '.xml';
  for i := 0 to 10 do
  begin
    for i2 := 1 to qtd do
    begin
      arquivo:=  FConfig.CodigoCliente+ '_'+ IntToStr(FConfig.SequenciaXML);
      //arquivo:= '51210724040700000178650020000005991228587719';
      MyFile := TFileStream.Create(destino + arquivo + '_' +IntToStr(i2) + ext, fmCreate); // local no hd e nome do arquivo com a extensão, onde vai salvar.
      try
        try
          request:= caminho +'/'+ arquivo + ext;
          FIdHTTP.Get(request, MyFile); // fazendo o download do arquivo
        except on E: Exception do
          begin
            FFuncoes.GravarLog('BaixarXML(): '+E.Message);
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
    FConfig.SequenciaXML   := FConfig.SequenciaXML + 1;
    if FIdHTTP.ResponseCode = 200 then
    begin
      Exibir('BaixarXML(): ' + request);
      FConfig.Gravar();
    end;
  end;
end;

constructor TImpressaoXML.Create;
begin
  FIdHTTP  := TIdHTTP.Create(nil);
  FHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  IdSSLOpenSSLHeaders.OPENSSL_API_VERSION := opSSL_3_0;
  FHandler.SSLOptions.Method := sslvTLSv1_3;
  FidHTTP.IOHandler          := FHandler;
  FImpressao                 := TControllerImpressora.create;
  FFuncoes                   := TFuncoes.Create;
  FConfig                    := TConfiguracoes.Create;
end;

destructor TImpressaoXML.Destroy;
begin
  inherited;
  FHandler.Free;
  FIdHTTP.Free;
  FImpressao.Free;
  FFuncoes.Free;
  FConfig.Free;
end;

procedure TImpressaoXML.Exibir(msg: string);
var
  data:string;
begin
  data:= FormatDateTime('hh:mm:ss',now);
  Memo.Lines.Add(data+ ' - ' + msg);
  Application.ProcessMessages;
end;

procedure TImpressaoXML.Print;
var
  sl:TStringList;
  caminho:string;
begin
  sl:= TStringList.Create;
  caminho:= GetCurrentDir + '\XML\';
  try
    sl:= FFuncoes.ListarArquivos(caminho , true);
    if sl.Count>0 then
    begin
      Exibir('Enviando para Impressão: '+caminho+ sl[0]);
      PrintFile(caminho+ sl[0]);
      DeleteFile(GetCurrentDir+'\IMPRESSO_XML\' + sl[0]);
      MoveFile(PwideChar(caminho + sl[0]), PwideChar(GetCurrentDir+'\IMPRESSO_XML\' + sl[0]));
      Exibir('Arquivo movido para: '+ GetCurrentDir+'\IMPRESSO_XML\' + sl[0]);
    end;
  finally
    sl.Free;
  end;

end;

procedure TImpressaoXML.PrintFile(aFile: TFileName);
var
  ACBrNFeDANFeESCPOS: TACBrNFeDANFeESCPOS;
  PosPrinter: TACBrPosPrinter;
  ACBrNFeDANFCeFortes: TACBrNFeDANFCeFortes;
begin
  FACBrNFe:= TACBrNFe.Create(nil);
  ACBrNFeDANFCeFortes:= TACBrNFeDANFCeFortes.Create(nil);
 // FImpressao.ConfigurarPosPrinter();
 // PosPrinter        := FImpressao.ACBrPosPrinter;
  //ACBrNFeDANFeESCPOS.PosPrinter:= PosPrinter;

  FACBrNFe.DANFE := ACBrNFeDANFCeFortes;
  try
    FACBrNFe.DANFE.TipoDANFE      := tiRetrato;
    FACBrNFe.DANFE.MostraPreview  := false;
    FACBrNFe.DANFE.MargemInferior := FConfig.fundo;
    FACBrNFe.DANFE.MargemSuperior := FConfig.top;
    FACBrNFe.DANFE.MargemEsquerda := FConfig.esqueda;
    FACBrNFe.DANFE.MargemDireita  := FConfig.direita;
    FACBrNFe.DANFE.Sistema        := '';
    FACBrNFe.DANFE.Impressora     := FConfig.Impressora;
    FACBrNFe.NotasFiscais.LoadFromFile(aFile);
    if FConfig.tipo = 0 then
      FACBrNFe.DANFE.ImprimirDANFE
    else
      FACBrNFe.DANFE.ImprimirDANFEResumido;
  finally
    FACBrNFe.Free;
  end;
end;

procedure TImpressaoXML.VerificarDiretorio;
var
  destino:string;
begin
  destino:= GetCurrentDir + '\XML';
  if not DirectoryExists(destino) then
    ForceDirectories(destino);
  if not DirectoryExists(GetCurrentDir + '\IMPRESSO_XML') then
    ForceDirectories(GetCurrentDir + '\IMPRESSO_XML');
end;

end.
