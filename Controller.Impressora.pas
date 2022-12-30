unit Controller.Impressora;

interface

uses
  Generics.Collections,
  Rest.Json,
  classes,
  System.SysUtils,
  ACBrPosPrinter,
  UFuncoes;

type
  TControllerImpressora = class(TPersistent)
  private
    FFuncoes: TFuncoes;
    FIni: string;
    FLinhasPular: integer;
    FLinhasBuffer: integer;
    FModelo: integer;
    FCortarPapel: boolean;
    FDeviceParams: string;
    FColunas: integer;
    FControlePorta: boolean;
    FEspacoEntreLinhas: integer;
    FIgnorarTags: boolean;
    FPorta: string;
    FTraduzirTags: boolean;
    FPaginaDeCodigo: integer;
    FLinhasEntreCupons: integer;
    FArqLog: string;
    FACBrPosPrinter: TACBrPosPrinter;
  published
    property ACBrPosPrinter: TACBrPosPrinter read FACBrPosPrinter write FACBrPosPrinter;
    property Modelo: integer read FModelo write FModelo;
    property Porta: string read FPorta write FPorta;
    property DeviceParams: string read FDeviceParams write FDeviceParams;
    property Colunas:integer read FColunas write FColunas;
    property EspacoEntreLinhas: integer  read FEspacoEntreLinhas write FEspacoEntreLinhas;
    property LinhasEntreCupons: integer read FLinhasEntreCupons write FLinhasEntreCupons;
    property LinhasBuffer: integer read FLinhasBuffer write FLinhasBuffer;
    property LinhasPular: integer read FLinhasPular write FLinhasPular;
    property CortarPapel: boolean read FCortarPapel write FCortarPapel;
    property ControlePorta: boolean read FControlePorta write FControlePorta;
    property TraduzirTags: boolean read FTraduzirTags write FTraduzirTags;
    property IgnorarTags: boolean read FIgnorarTags write FIgnorarTags;
    property PaginaDeCodigo:integer read FPaginaDeCodigo write FPaginaDeCodigo;
    property ArqLog:string read FArqLog write FArqLog;
  public
    procedure ConfigurarPosPrinter();
    procedure Imprimir(texto:string);

    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TControllerImpressora;
    procedure Gravar();
    constructor create(pNomeImpressora: string = 'PRINTER');
    destructor Destroy; override;
  end;

implementation

{ TControllerImpressora }

procedure TControllerImpressora.ConfigurarPosPrinter;
begin
  if not(Assigned(FACBrPosPrinter)) then
    FACBrPosPrinter:= TACBrPosPrinter.Create(nil);

  FACBrPosPrinter.Porta              := Porta;
  FACBrPosPrinter.Modelo             := TACBrPosPrinterModelo(Modelo);
  FACBrPosPrinter.ArqLOG             := ArqLog;
  FACBrPosPrinter.LinhasBuffer       := LinhasBuffer;
  FACBrPosPrinter.LinhasEntreCupons  := LinhasEntreCupons;
  FACBrPosPrinter.EspacoEntreLinhas  := EspacoEntreLinhas;
  FACBrPosPrinter.ColunasFonteNormal := Colunas;
  FACBrPosPrinter.ControlePorta      := ControlePorta;
  FACBrPosPrinter.CortaPapel         := CortarPapel;
  FACBrPosPrinter.TraduzirTags       := TraduzirTags;
  FACBrPosPrinter.IgnorarTags        := IgnorarTags;
  FACBrPosPrinter.PaginaDeCodigo     := TACBrPosPaginaCodigo(PaginaDeCodigo);
end;

constructor TControllerImpressora.create(pNomeImpressora: string);
begin
  FFuncoes        := TFuncoes.Create;
  FACBrPosPrinter:= TACBrPosPrinter.Create(nil);
  Fini:= GetCurrentDir + '/CONFIG.INI';
  FFuncoes.SerializarINI(Fini,pNomeImpressora, Self)
end;

destructor TControllerImpressora.Destroy;
begin
  FFuncoes.Free;
  FACBrPosPrinter.Free;
  inherited;
end;

class function TControllerImpressora.FromJsonString(
  AJsonString: string): TControllerImpressora;
begin
  Result := TJson.JsonToObject<TControllerImpressora>(AJsonString);
end;

procedure TControllerImpressora.Gravar;
begin
  Fini:= GetCurrentDir + '/CONFIG.INI';
  IgnorarTags  := false;
  TraduzirTags := true;
  ControlePorta:= true;
  FFuncoes.GravarINI(Fini,'PRINTER', Self)
end;

procedure TControllerImpressora.Imprimir(texto: string);
begin
  try
    ConfigurarPosPrinter();
    if not FACBrPosPrinter.Ativo then
      FACBrPosPrinter.Ativar ;
    FACBrPosPrinter.Buffer.Text := texto;
    FACBrPosPrinter.Imprimir;
  except on E: Exception do
    FFuncoes.GravarLog(E.Message);
  end;

end;

function TControllerImpressora.ToJsonString: string;
begin
  Result := TJson.ObjectToJsonString(Self);
end;

end.
