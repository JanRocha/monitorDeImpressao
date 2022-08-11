unit UConfiguracoes;

interface
uses
  System.SysUtils,
  classes,
  UFuncoes;

type
  TConfiguracoes = class(TPersistent)
  private
    FFuncoes: TFuncoes;
    FIni:string;
    FNomeImpressora: string;
    FCaminhoServidor: string;
    FCodigoCliente: string;
    Fquantidade_de_vias: integer;
    FSequencia: integer;
    FSequenciaTXT: integer;
    FSequenciaXML: integer;
    Fesqueda: integer;
    Flargura: integer;
    Ftop: integer;
    Fdireita: integer;
    Ffundo: integer;
    Ftipo: integer;
    FImpressora: string;
  published
    property NomeImpressora: string read FNomeImpressora write FNomeImpressora;
    property CaminhoServidor: string read FCaminhoServidor write FCaminhoServidor;
    property CodigoCliente:string read FCodigoCliente write FCodigoCliente;
    property quantidade_de_vias:integer read Fquantidade_de_vias write Fquantidade_de_vias;
    property Sequencia:integer read FSequencia write FSequencia;
    property SequenciaTXT:integer read FSequenciaTXT write FSequenciaTXT;
    property SequenciaXML:integer read FSequenciaXML write FSequenciaXML;
    property largura:integer read Flargura write Flargura;
    property fundo:integer read Ffundo write Ffundo;
    property top:integer read Ftop write Ftop;
    property direita:integer read Fdireita write Fdireita;
    property esqueda:integer read Fesqueda write Fesqueda;
    property tipo:integer read Ftipo write Ftipo;
    property Impressora: string read FImpressora write FImpressora;

  public
    procedure Gravar();
    constructor Create();
    destructor Destroy; override;
  end;

implementation

constructor TConfiguracoes.Create;
begin
  Fini:= GetCurrentDir + '/CONFIG.INI';
  FFuncoes:= TFuncoes.Create;
  FFuncoes.SerializarINI(Fini,'CONFIG', Self);
end;

destructor TConfiguracoes.Destroy;
begin
  FFuncoes.Free;
  inherited;
end;

procedure TConfiguracoes.Gravar;
begin
  FFuncoes.GravarINI(Fini, 'CONFIG', Self);
end;

end.
