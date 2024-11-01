unit UImpressaoTXT;

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
  Controller.Impressora,
  IdSSLOpenSSLHeaders,
  Vcl.StdCtrls;

type
  TImpressaoTXT = class(TPersistent)
  private
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
    procedure BaixarTXT();
    procedure Print();
    constructor Create();
    destructor Destroy; override;
  end;

implementation

uses
  Vcl.Forms,
  RESTRequest4D;

{ TImpressaoTXT }

procedure TImpressaoTXT.BaixarTXT;
var
  arquivo,caminho, destino, ext, request: string;
  MyFile: TFileStream;
  i,  i2,qtd: Integer;
begin
  VerificarDiretorio();
  destino:= GetCurrentDir +  '\TXT\';
  caminho:= FConfig.CaminhoServidor;
  qtd    := FConfig.quantidade_de_vias;
  ext    := '.txt';
  for i := 0 to 10 do
  begin
    for i2 := 1 to qtd do
    begin
      arquivo:=  FConfig.CodigoCliente+ '_'+ IntToStr(FConfig.SequenciaTXT);
      var lString := TStringList.Create();
      try
        try
          request:= caminho +'/'+ arquivo + ext;
          var resp := TRequest.New.BaseURL(request)
                    .Get;

          if resp.StatusCode <> 200 then
          begin
            DeleteFile(destino + arquivo + '_' +IntToStr(i2) + ext);
            exit;
          end
          else
          begin
            lString.Text := resp.Content;
            lString.SaveToFile(destino + arquivo + '_' +IntToStr(i2) + ext);
          end;
        except on E: Exception do
          begin
            FFuncoes.GravarLog('BaixarTXT(): '+E.Message);
          end;
        end;
      finally
        lString.Free;
      end;

    end;
    FConfig.SequenciaTXT := FConfig.SequenciaTXT + 1;
    if FIdHTTP.ResponseCode = 200 then
    begin
      Exibir('BaixarTXT(): ' + request);
      FConfig.Gravar();
    end;
  end;
end;

constructor TImpressaoTXT.Create;
begin
  FIdHTTP  := TIdHTTP.Create(nil);
  FHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  //IdSSLOpenSSLHeaders.OPENSSL_API_VERSION := opSSL_3_0;
  FHandler.SSLOptions.Method := sslvTLSv1_2;
  FidHTTP.IOHandler          := FHandler;
  FFuncoes                   := TFuncoes.Create;
  FConfig                    := TConfiguracoes.Create;
end;

destructor TImpressaoTXT.Destroy;
begin
  inherited;
  FHandler.Free;
  FIdHTTP.Free;
  FFuncoes.Free;
  FConfig.Free;
end;

procedure TImpressaoTXT.Exibir(msg: string);
var
  data:string;
begin
  data:= FormatDateTime('hh:mm:ss',now);
  Memo.Lines.Add(data+ ' - ' + msg);
  Application.ProcessMessages;
end;

procedure TImpressaoTXT.Print;
var
  sl:TStringList;
  caminho:string;
begin
  sl:= TStringList.Create;
  caminho:= GetCurrentDir + '\TXT\';
  try
    sl:= FFuncoes.ListarArquivos(caminho , true);
    if sl.Count>0 then
    begin
      Exibir('Enviando para Impress�o: '+caminho+ sl[0]);
      PrintFile(caminho+ sl[0]);
      DeleteFile(GetCurrentDir+'\IMPRESSO_TXT\' + sl[0]);
      MoveFile(PwideChar(caminho + sl[0]), PwideChar(GetCurrentDir+'\IMPRESSO_TXT\' + sl[0]));
      Exibir('Arquivo movido para: '+ GetCurrentDir+'\IMPRESSO_TXT\' + sl[0]);
    end;
  finally
    sl.Free;
  end;
end;

procedure TImpressaoTXT.PrintFile(aFile: TFileName);
var
 sl: TStringList;
 lNomeImpressora: string;
 lPosicaoInicial, lPosicaoFinal: Integer;
begin
  sl:= TStringList.Create;
  try
    sl.LoadFromFile(aFile);
    lNomeImpressora := sl[0];
    lPosicaoInicial := Pos('[',lNomeImpressora);
    lPosicaoFinal := Pos(']', lNomeImpressora);

    if lPosicaoInicial > 0  then
    begin
      sl.Delete(0);
      lNomeImpressora:= Copy(lNomeImpressora, lPosicaoInicial + 1, lPosicaoFinal - 2);
    end;

    sl.Insert(0,'</zera>');
    sl.Insert(sl.Count,'</corte_parcial>');

    FImpressao := TControllerImpressora.create(lNomeImpressora);
    try
      FImpressao.Imprimir(sl.Text);
    finally
      FImpressao.Free();
    end;
  finally
    sl.Free;
  end;
end;

procedure TImpressaoTXT.VerificarDiretorio;
var
  destino:string;
begin
  destino:= GetCurrentDir + '\TXT';
  if not DirectoryExists(destino) then
    ForceDirectories(destino);
  if not DirectoryExists(GetCurrentDir + '\IMPRESSO_TXT') then
    ForceDirectories(GetCurrentDir + '\IMPRESSO_TXT');
end;

end.
