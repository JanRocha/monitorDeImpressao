unit UFrmConfiguracoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.Printers,
  ACBrPosPrinter,
  Controller.Impressora,
  UConfiguracoes, Vcl.Samples.Spin, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  dxSkinsCore, dxSkinsDefaultPainters, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges,
  Data.DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, Datasnap.DBClient, ACBrBase, ACBrEnterTab;

type
  TfrmConfiguracoes = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    edtCaminhoServidor: TEdit;
    GroupBox2: TGroupBox;
    cmbImpressoras: TComboBox;
    GroupBox3: TGroupBox;
    edtCodCliente: TEdit;
    GroupBox4: TGroupBox;
    edtVias: TEdit;
    GroupBox5: TGroupBox;
    edtSequencia: TEdit;
    GroupBox6: TGroupBox;
    edtSequenciaTXT: TEdit;
    grp1: TGroupBox;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    seLargura: TSpinEdit;
    seFundo: TSpinEdit;
    seTopo: TSpinEdit;
    seEsquerda: TSpinEdit;
    seDireita: TSpinEdit;
    rgTipoComprovante: TRadioGroup;
    GroupBox7: TGroupBox;
    edtSequenciaXML: TEdit;
    Panel2: TPanel;
    Panel3: TPanel;
    BitBtn1: TBitBtn;
    Label2: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    cbxModeloDAV: TComboBox;
    cbxPortaDAV: TComboBox;
    seColunasDav: TSpinEdit;
    seEspLinhasDAV: TSpinEdit;
    cbxPagCodigoDAV: TComboBox;
    seLinhasBufferDav: TSpinEdit;
    seLinhasPularDAV: TSpinEdit;
    cbCortarPapelDAV: TCheckBox;
    Label1: TLabel;
    Panel4: TPanel;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    Panel5: TPanel;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Label9: TLabel;
    edtDescricao: TEdit;
    dsFilasTxt: TDataSource;
    CDSFilaTxt: TClientDataSet;
    CDSFilaTxtDescricao: TStringField;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    CDSFilaTxtModelo: TIntegerField;
    CDSFilaTxtPorta: TStringField;
    CDSFilaTxtDeviceParams: TStringField;
    CDSFilaTxtColunas: TIntegerField;
    CDSFilaTxtEspacoEntreLinhas: TIntegerField;
    CDSFilaTxtLinhasEntreCupons: TIntegerField;
    CDSFilaTxtLinhasBuffer: TIntegerField;
    CDSFilaTxtLinhasPular: TIntegerField;
    CDSFilaTxtCortarPapel: TIntegerField;
    CDSFilaTxtControlePorta: TIntegerField;
    CDSFilaTxtTraduzirTags: TIntegerField;
    CDSFilaTxtIgnorarTags: TIntegerField;
    CDSFilaTxtPaginaDeCodigo: TIntegerField;
    cxGrid1DBTableView1Column2: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    btnAdd: TBitBtn;
    ACBrEnterTab1: TACBrEnterTab;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure CDSFilaTxtAfterScroll(DataSet: TDataSet);
    procedure btnAddClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    FConf:TConfiguracoes;
    Fimpressao: TControllerImpressora;

    procedure CarregarSerial(Sender: TComboBox);
    procedure CarregarModelo(Sender: TComboBox);
    procedure CarregarPaginaCodigo(Sender: TComboBox);
    procedure CarregarFilasTxt;
  public
    { Public declarations }
  end;

var
  frmConfiguracoes: TfrmConfiguracoes;

implementation

uses
  System.TypInfo, System.IniFiles;


{$R *.dfm}

procedure TfrmConfiguracoes.BitBtn1Click(Sender: TObject);
begin
  FConf.NomeImpressora     := cmbImpressoras.Text;
  FConf.CodigoCliente      := edtCodCliente.Text;
  FConf.CaminhoServidor    := edtCaminhoServidor.Text;
  FConf.quantidade_de_vias := StrToInt(edtVias.Text);
  FConf.Sequencia          := StrToInt(edtSequencia.Text);
  FConf.SequenciaTXT       := StrToInt(edtSequenciaTXT.Text);
  FConf.SequenciaXML       := StrToInt(edtSequenciaXML.Text);

  FConf.top      := seTopo.Value;
  FConf.largura  := seLargura.Value;
  FConf.fundo    := seFundo.Value;
  FConf.direita  := seDireita.Value;
  FConf.esqueda  := seEsquerda.Value;
  FConf.tipo     := rgTipoComprovante.ItemIndex;
  FConf.Impressora := StringReplace(cbxPortaDAV.Text,'RAW:','',[rfReplaceAll]);
  FConf.Gravar();

  //Impressão dos txt
  FImpressao.Modelo            := cbxModeloDAV.ItemIndex;
  Fimpressao.Porta             := cbxPortaDAV.Text;
  Fimpressao.Colunas           := seColunasDav.Value;
  Fimpressao.EspacoEntreLinhas := seEspLinhasDAV.Value;
  Fimpressao.LinhasBuffer      := seLinhasBufferDav.Value;
  Fimpressao.LinhasPular       := seLinhasPularDAV.Value;
  Fimpressao.PaginaDeCodigo    := cbxPagCodigoDAV.ItemIndex;
  Fimpressao.CortarPapel       := cbCortarPapelDAV.Checked;
  Fimpressao.Gravar();

  Close();
end;

procedure TfrmConfiguracoes.CarregarModelo(Sender: TComboBox);
var
  I: TACBrPosPrinterModelo;
begin
  Sender.Items.Clear;
  For I := Low(TACBrPosPrinterModelo) to High(TACBrPosPrinterModelo) do
    Sender.Items.Add(GetEnumName(TypeInfo(TACBrPosPrinterModelo), integer(I)));
  Sender.ItemIndex:= 0;
end;

procedure TfrmConfiguracoes.CarregarPaginaCodigo(Sender: TComboBox);
var
  J: TACBrPosPaginaCodigo;
begin
  Sender.Items.Clear;
  For J := Low(TACBrPosPaginaCodigo) to High(TACBrPosPaginaCodigo) do
    Sender.Items.Add(GetEnumName(TypeInfo(TACBrPosPaginaCodigo),integer(J)));
  Sender.ItemIndex:= 0;
end;

procedure TfrmConfiguracoes.CarregarSerial(Sender: TComboBox);
begin
  Sender.Items.Clear;
  Fimpressao.ACBrPosPrinter.Device.AcharPortasSeriais(Sender.Items);
  {$IfDef MSWINDOWS}
  Fimpressao.ACBrPosPrinter.Device.AcharPortasUSB(Sender.Items);
  {$EndIf}
  Fimpressao.ACBrPosPrinter.Device.AcharPortasRAW(Sender.Items);
  {$IfDef HAS_BLUETOOTH}
  try
     Fimpressao.ACBrPosPrinter.Device.AcharPortasBlueTooth(Sender.Items);
  except
  end;
  {$EndIf}
  Sender.ItemIndex:= 0;
end;

procedure TfrmConfiguracoes.CDSFilaTxtAfterScroll(DataSet: TDataSet);
begin
  edtDescricao.Text := CDSFilaTxtDescricao.AsString;
  cbxPortaDAV.Text := CDSFilaTxtPorta.AsString;
  cbxModeloDAV.ItemIndex := CDSFilaTxtModelo.AsInteger;
  cbxPagCodigoDAV.ItemIndex := CDSFilaTxtPaginaDeCodigo.AsInteger;
  cbCortarPapelDAV.Checked := CDSFilaTxtCortarPapel.AsInteger = 1;
  seColunasDav.Value := CDSFilaTxtColunas.AsInteger;
  seEspLinhasDAV.Value := CDSFilaTxtEspacoEntreLinhas.AsInteger;
  seLinhasBufferDav.Value := CDSFilaTxtLinhasBuffer.AsInteger;
  seLinhasPularDAV.Value := CDSFilaTxtLinhasPular.AsInteger;
end;

procedure TfrmConfiguracoes.FormCreate(Sender: TObject);
begin
  FConf:= TConfiguracoes.Create;
  CarregarFilasTxt();
end;

procedure TfrmConfiguracoes.BitBtn2Click(Sender: TObject);
var
  lIni: TIniFile;
begin
  lIni := TIniFile.Create(GetCurrentDir + '/CONFIG.INI');
  try
    lIni.WriteInteger(edtDescricao.Text,'Modelo', cbxModeloDAV.ItemIndex);
    lIni.WriteString(edtDescricao.Text, 'Porta', cbxPortaDAV.Text);
    lIni.WriteInteger(edtDescricao.Text, 'Colunas', seColunasDav.Value);
    lIni.WriteInteger(edtDescricao.Text, 'EspacoEntreLinhas', seEspLinhasDAV.Value);
    lIni.WriteInteger(edtDescricao.Text, 'LinhasBuffer', seLinhasBufferDav.Value);
    lIni.WriteInteger(edtDescricao.Text, 'LinhasPular', seLinhasPularDAV.Value);
    lIni.WriteInteger(edtDescricao.Text, 'CortarPapel', cbCortarPapelDAV.Checked.ToInteger());
    lIni.WriteInteger(edtDescricao.Text, 'PaginaDeCodigo', cbxPagCodigoDAV.ItemIndex);
  finally
    lIni.Free();
  end;

  edtDescricao.Enabled := False;
  cbxPortaDAV.Enabled := False;
  cbxModeloDAV.Enabled := False;
  cbxPagCodigoDAV.Enabled := False;
  cbCortarPapelDAV.Enabled := False;
  seColunasDav.Enabled := False;
  seEspLinhasDAV.Enabled := False;
  seLinhasBufferDav.Enabled := False;
  seLinhasPularDAV.Enabled := False;
  cxGrid1.Enabled := True;
  CarregarFilasTxt();
end;

procedure TfrmConfiguracoes.BitBtn3Click(Sender: TObject);
var
  lIni: TIniFile;
begin
  lIni := TIniFile.Create(GetCurrentDir + '/CONFIG.INI');
  try
    lIni.EraseSection(edtDescricao.Text);
    CarregarFilasTxt();
  finally
    lIni.Free();
  end;
end;

procedure TfrmConfiguracoes.btnAddClick(Sender: TObject);
begin
  edtDescricao.Enabled := true;
  cbxPortaDAV.Enabled := true;
  cbxModeloDAV.Enabled := true;
  cbxPagCodigoDAV.Enabled := true;
  cbCortarPapelDAV.Enabled := true;
  seColunasDav.Enabled := true;
  seEspLinhasDAV.Enabled := true;
  seLinhasBufferDav.Enabled := true;
  seLinhasPularDAV.Enabled := true;
  cxGrid1.Enabled := False;

  edtDescricao.Text := EmptyStr;
  cbxPortaDAV.Text := EmptyStr;
  cbxModeloDAV.ItemIndex := 0;
  cbxPagCodigoDAV.ItemIndex := 0;
  cbCortarPapelDAV.Checked := True;
  seColunasDav.Value := 0;
  seEspLinhasDAV.Value := 0;
  seLinhasBufferDav.Value := 0;
  seLinhasPularDAV.Value := 0;
  edtDescricao.SetFocus();
end;

procedure TfrmConfiguracoes.CarregarFilasTxt();
var
  I: Integer;
  lIni: TIniFile;
  lChaveIni: TStringList;
begin
  Fimpressao:= TControllerImpressora.create;
  CarregarSerial(cbxPortaDAV);
  CarregarModelo(cbxModeloDAV);
  CarregarPaginaCodigo(cbxPagCodigoDAV);

  lIni := TIniFile.Create(GetCurrentDir + '/CONFIG.INI');
  lChaveIni := TStringList.Create();
  try
    lIni.ReadSections(lChaveIni);
    lChaveIni.Delete(lChaveIni.IndexOf('CONFIG'));
    CDSFilaTxt.close;
    CDSFilaTxt.CreateDataSet;
    for I := 0 to lChaveIni.Count -1 do
    begin
      CDSFilaTxt.Append();
      CDSFilaTxtDescricao.AsString := lChaveIni[I];
      CDSFilaTxtModelo.AsString := lIni.ReadString(lChaveIni[I], 'Modelo', '');
      CDSFilaTxtPorta.AsString := lIni.ReadString(lChaveIni[I], 'Porta', '');
      CDSFilaTxtDeviceParams.AsString := lIni.ReadString(lChaveIni[I], 'DeviceParams', '');
      CDSFilaTxtColunas.AsString := lIni.ReadString(lChaveIni[I], 'Colunas', '');
      CDSFilaTxtEspacoEntreLinhas.AsString := lIni.ReadString(lChaveIni[I], 'EspacoEntreLinhas', '');
      CDSFilaTxtLinhasEntreCupons.AsString := lIni.ReadString(lChaveIni[I], 'LinhasEntreCupons', '');
      CDSFilaTxtLinhasBuffer.AsString := lIni.ReadString(lChaveIni[I], 'LinhasBuffer', '');
      CDSFilaTxtLinhasPular.AsString := lIni.ReadString(lChaveIni[I], 'LinhasPular', '');
      CDSFilaTxtCortarPapel.AsString := lIni.ReadString(lChaveIni[I], 'CortarPapel', '');
      CDSFilaTxtControlePorta.AsString := lIni.ReadString(lChaveIni[I], 'ControlePorta', '');
      CDSFilaTxtTraduzirTags.AsString := lIni.ReadString(lChaveIni[I], 'TraduzirTags', '');
      CDSFilaTxtIgnorarTags.AsString:= lIni.ReadString(lChaveIni[I], 'IgnorarTags', '');
      CDSFilaTxtPaginaDeCodigo.AsString := lIni.ReadString(lChaveIni[I], 'PaginaDeCodigo', '');
      CDSFilaTxt.Post();
    end;

  finally
    lChaveIni.Free();
    lIni.Free();
  end;
end;

procedure TfrmConfiguracoes.FormDestroy(Sender: TObject);
begin
  FConf.Free;
  Fimpressao.Free;
end;

procedure TfrmConfiguracoes.FormShow(Sender: TObject);
var i:integer;
begin
  for i := 0 to Printer.Printers.Count - 1  do
  begin
    cmbImpressoras.Items.Add(Printer.Printers[i]);
  end;

  for i := 0 to cmbImpressoras.Items.Count do
  begin
    if cmbImpressoras.Items[i] = FConf.NomeImpressora then
    begin
      cmbImpressoras.ItemIndex := i;
      continue;
    end;
  end;
  edtCaminhoServidor.Text:= FConf.CaminhoServidor;
  edtCodCliente.Text     := FConf.CodigoCliente;
  edtVias.Text           := IntToStr(FConf.quantidade_de_vias);
  edtSequencia.Text      := IntToStr(FConf.Sequencia);
  edtSequenciaTXT.Text   := IntToStr(FConf.SequenciaTXT);
  edtSequenciaXML.Text   := IntToStr(FConf.SequenciaXML);
  seLargura.Value        := FConf.largura;
  seFundo.Value          := FConf.fundo;
  seTopo.Value           := FConf.top;
  seEsquerda.Value       := FConf.esqueda;
  seDireita.Value        := FConf.direita;
  rgTipoComprovante.ItemIndex := FConf.tipo;
end;

end.
