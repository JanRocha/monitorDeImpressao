object frmConfiguracoes: TfrmConfiguracoes
  Left = 0
  Top = 0
  Caption = 'Configura'#231#245'es'
  ClientHeight = 561
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Courier New'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 784
    Height = 561
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 2
      Top = 11
      Width = 465
      Height = 52
      Caption = 'Endere'#231'o da Pasta Externa'
      TabOrder = 0
      object edtCaminhoServidor: TEdit
        Left = 3
        Top = 20
        Width = 458
        Height = 24
        TabOrder = 0
      end
    end
    object GroupBox2: TGroupBox
      Left = 372
      Top = 68
      Width = 406
      Height = 52
      Caption = 'Selecione a Impressora '
      TabOrder = 6
      object cmbImpressoras: TComboBox
        Left = 5
        Top = 20
        Width = 397
        Height = 24
        TabOrder = 0
      end
    end
    object GroupBox3: TGroupBox
      Left = 470
      Top = 11
      Width = 147
      Height = 52
      Caption = 'C'#243'digo do cliente'
      TabOrder = 1
      object edtCodCliente: TEdit
        Left = 2
        Top = 20
        Width = 142
        Height = 24
        TabOrder = 0
      end
    end
    object GroupBox4: TGroupBox
      Left = 620
      Top = 11
      Width = 158
      Height = 52
      Caption = 'Quantidade de Vias'
      TabOrder = 2
      object edtVias: TEdit
        Left = 2
        Top = 20
        Width = 152
        Height = 24
        TabOrder = 0
      end
    end
    object GroupBox5: TGroupBox
      Left = 2
      Top = 68
      Width = 120
      Height = 52
      Caption = 'Sequencia PDF'
      TabOrder = 3
      object edtSequencia: TEdit
        Left = 5
        Top = 20
        Width = 111
        Height = 24
        TabOrder = 0
      end
    end
    object GroupBox6: TGroupBox
      Left = 125
      Top = 68
      Width = 120
      Height = 52
      Caption = 'Sequencia TXT'
      TabOrder = 4
      object edtSequenciaTXT: TEdit
        Left = 3
        Top = 20
        Width = 110
        Height = 24
        TabOrder = 0
      end
    end
    object grp1: TGroupBox
      Left = 2
      Top = 122
      Width = 388
      Height = 71
      Caption = 'Margens'
      TabOrder = 7
      object lbl1: TLabel
        Left = 7
        Top = 22
        Width = 56
        Height = 16
        Caption = 'Largura'
      end
      object lbl2: TLabel
        Left = 79
        Top = 22
        Width = 40
        Height = 16
        Caption = 'Fundo'
      end
      object lbl3: TLabel
        Left = 147
        Top = 22
        Width = 32
        Height = 16
        Caption = 'Topo'
      end
      object lbl4: TLabel
        Left = 220
        Top = 22
        Width = 64
        Height = 16
        Caption = 'Esquerda'
      end
      object lbl5: TLabel
        Left = 296
        Top = 22
        Width = 56
        Height = 16
        Caption = 'Direita'
      end
      object seLargura: TSpinEdit
        Left = 8
        Top = 38
        Width = 64
        Height = 26
        MaxValue = 0
        MinValue = 0
        TabOrder = 0
        Value = 0
      end
      object seFundo: TSpinEdit
        Left = 78
        Top = 38
        Width = 64
        Height = 26
        MaxValue = 0
        MinValue = 0
        TabOrder = 1
        Value = 0
      end
      object seTopo: TSpinEdit
        Left = 148
        Top = 38
        Width = 64
        Height = 26
        MaxValue = 0
        MinValue = 0
        TabOrder = 2
        Value = 0
      end
      object seEsquerda: TSpinEdit
        Left = 221
        Top = 38
        Width = 64
        Height = 26
        MaxValue = 0
        MinValue = 0
        TabOrder = 3
        Value = 0
      end
      object seDireita: TSpinEdit
        Left = 295
        Top = 38
        Width = 64
        Height = 26
        MaxValue = 0
        MinValue = 0
        TabOrder = 4
        Value = 0
      end
    end
    object rgTipoComprovante: TRadioGroup
      Left = 397
      Top = 122
      Width = 381
      Height = 71
      Caption = 'Tipo de Comprovante'
      Items.Strings = (
        'Detalhado (com os itens)'
        'Resumido (sem os itens)')
      TabOrder = 8
    end
    object GroupBox7: TGroupBox
      Left = 247
      Top = 68
      Width = 120
      Height = 52
      Caption = 'Sequencia XML'
      TabOrder = 5
      object edtSequenciaXML: TEdit
        Left = 3
        Top = 20
        Width = 110
        Height = 24
        TabOrder = 0
      end
    end
    object Panel2: TPanel
      Left = 0
      Top = 520
      Width = 784
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 9
      object BitBtn1: TBitBtn
        Left = 680
        Top = 0
        Width = 104
        Height = 41
        Align = alRight
        Caption = 'Gravar'
        TabOrder = 0
        OnClick = BitBtn1Click
      end
    end
    object Panel3: TPanel
      Left = 0
      Top = 192
      Width = 784
      Height = 328
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 10
      object Label2: TLabel
        Left = 24
        Top = 95
        Width = 48
        Height = 16
        Caption = 'Modelo'
        Color = clBtnFace
        ParentColor = False
      end
      object Label4: TLabel
        Left = 24
        Top = 141
        Width = 40
        Height = 16
        Caption = 'Porta'
        Color = clBtnFace
        ParentColor = False
      end
      object Label3: TLabel
        Left = 24
        Top = 196
        Width = 56
        Height = 16
        Caption = 'Colunas'
        Color = clBtnFace
        ParentColor = False
      end
      object Label5: TLabel
        Left = 94
        Top = 196
        Width = 56
        Height = 16
        Caption = 'Espa'#231'os'
        Color = clBtnFace
        ParentColor = False
      end
      object Label6: TLabel
        Left = 257
        Top = 95
        Width = 80
        Height = 16
        Caption = 'Pag.codigo'
        Color = clBtnFace
        ParentColor = False
      end
      object Label7: TLabel
        Left = 165
        Top = 196
        Width = 48
        Height = 16
        Caption = 'Buffer'
        Color = clBtnFace
        ParentColor = False
      end
      object Label8: TLabel
        Left = 230
        Top = 194
        Width = 88
        Height = 16
        Caption = 'Pular Linha'
        Color = clBtnFace
        ParentColor = False
      end
      object Label1: TLabel
        Left = 10
        Top = 32
        Width = 304
        Height = 16
        Caption = 'Configura'#231#245'es de fila de impress'#227'o TXT'
      end
      object Label9: TLabel
        Left = 24
        Top = 56
        Width = 48
        Height = 16
        Caption = 'Modelo'
        Color = clBtnFace
        ParentColor = False
      end
      object cbxModeloDAV: TComboBox
        Left = 24
        Top = 111
        Width = 227
        Height = 24
        Style = csDropDownList
        Enabled = False
        TabOrder = 5
      end
      object cbxPortaDAV: TComboBox
        Left = 24
        Top = 155
        Width = 350
        Height = 24
        Enabled = False
        TabOrder = 7
      end
      object seColunasDav: TSpinEdit
        Left = 24
        Top = 211
        Width = 68
        Height = 26
        Enabled = False
        MaxValue = 999
        MinValue = 1
        TabOrder = 8
        Value = 48
      end
      object seEspLinhasDAV: TSpinEdit
        Left = 94
        Top = 211
        Width = 69
        Height = 26
        Enabled = False
        MaxValue = 255
        MinValue = 0
        TabOrder = 9
        Value = 0
      end
      object cbxPagCodigoDAV: TComboBox
        Left = 257
        Top = 110
        Width = 117
        Height = 24
        Hint = 'Pagina de c'#243'digo usada pela Impressora POS'
        Style = csDropDownList
        Enabled = False
        TabOrder = 6
      end
      object seLinhasBufferDav: TSpinEdit
        Left = 165
        Top = 211
        Width = 51
        Height = 26
        Enabled = False
        MaxValue = 255
        MinValue = 0
        TabOrder = 10
        Value = 0
      end
      object seLinhasPularDAV: TSpinEdit
        Left = 219
        Top = 211
        Width = 95
        Height = 26
        Enabled = False
        MaxValue = 255
        MinValue = 0
        TabOrder = 11
        Value = 0
      end
      object cbCortarPapelDAV: TCheckBox
        Left = 316
        Top = 216
        Width = 58
        Height = 19
        Hint = 
          'Conecta a Porta Serial a cada comando enviado'#13#10'Desconecta da Por' +
          'ta Serial ap'#243's o envio'
        Caption = 'Corte'
        Checked = True
        Enabled = False
        State = cbChecked
        TabOrder = 0
      end
      object Panel4: TPanel
        Left = 9
        Top = 49
        Width = 770
        Height = 1
        BevelInner = bvLowered
        BevelOuter = bvLowered
        Color = clBtnShadow
        ParentBackground = False
        TabOrder = 1
      end
      object cxGrid1: TcxGrid
        Left = 377
        Top = 96
        Width = 404
        Height = 232
        TabOrder = 2
        object cxGrid1DBTableView1: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dsFilasTxt
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsSelection.MultiSelect = True
          OptionsView.ScrollBars = ssVertical
          OptionsView.GroupByBox = False
          Styles.ContentEven = cxStyle1
          object cxGrid1DBTableView1Column1: TcxGridDBColumn
            DataBinding.FieldName = 'Descricao'
          end
          object cxGrid1DBTableView1Column2: TcxGridDBColumn
            DataBinding.FieldName = 'Porta'
          end
        end
        object cxGrid1Level1: TcxGridLevel
          GridView = cxGrid1DBTableView1
        end
      end
      object Panel5: TPanel
        Left = 377
        Top = 70
        Width = 407
        Height = 25
        BevelOuter = bvNone
        TabOrder = 3
        object BitBtn2: TBitBtn
          Left = 56
          Top = 0
          Width = 113
          Height = 25
          Align = alLeft
          Caption = 'Gravar Fila'
          TabOrder = 1
          OnClick = BitBtn2Click
        end
        object BitBtn3: TBitBtn
          Left = 351
          Top = 0
          Width = 56
          Height = 25
          Align = alRight
          Caption = '-'
          TabOrder = 2
          OnClick = BitBtn3Click
        end
        object btnAdd: TBitBtn
          Left = 0
          Top = 0
          Width = 56
          Height = 25
          Align = alLeft
          Caption = '+'
          TabOrder = 0
          OnClick = btnAddClick
        end
      end
      object edtDescricao: TEdit
        Left = 24
        Top = 71
        Width = 350
        Height = 24
        Enabled = False
        TabOrder = 4
      end
    end
  end
  object dsFilasTxt: TDataSource
    DataSet = CDSFilaTxt
    Left = 684
    Top = 100
  end
  object CDSFilaTxt: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterScroll = CDSFilaTxtAfterScroll
    Left = 680
    Top = 168
    object CDSFilaTxtDescricao: TStringField
      FieldName = 'Descricao'
    end
    object CDSFilaTxtModelo: TIntegerField
      FieldName = 'Modelo'
    end
    object CDSFilaTxtPorta: TStringField
      FieldName = 'Porta'
      Size = 50
    end
    object CDSFilaTxtDeviceParams: TStringField
      FieldName = 'DeviceParams'
      Size = 50
    end
    object CDSFilaTxtColunas: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'Colunas'
      Calculated = True
    end
    object CDSFilaTxtEspacoEntreLinhas: TIntegerField
      FieldName = 'EspacoEntreLinhas'
    end
    object CDSFilaTxtLinhasEntreCupons: TIntegerField
      FieldName = 'LinhasEntreCupons'
    end
    object CDSFilaTxtLinhasBuffer: TIntegerField
      FieldName = 'LinhasBuffer'
    end
    object CDSFilaTxtLinhasPular: TIntegerField
      FieldName = 'LinhasPular'
    end
    object CDSFilaTxtCortarPapel: TIntegerField
      FieldName = 'CortarPapel'
    end
    object CDSFilaTxtControlePorta: TIntegerField
      FieldName = 'ControlePorta'
    end
    object CDSFilaTxtTraduzirTags: TIntegerField
      FieldName = 'TraduzirTags'
    end
    object CDSFilaTxtIgnorarTags: TIntegerField
      FieldName = 'IgnorarTags'
    end
    object CDSFilaTxtPaginaDeCodigo: TIntegerField
      FieldName = 'PaginaDeCodigo'
    end
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 240
    Top = 24
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = cl3DLight
    end
    object cxStyle2: TcxStyle
      AssignedValues = [svColor]
      Color = clAppWorkSpace
    end
  end
  object ACBrEnterTab1: TACBrEnterTab
    EnterAsTab = True
    Left = 660
    Top = 76
  end
end
