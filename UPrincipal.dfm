object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Monitoramento de Impress'#227'o'
  ClientHeight = 321
  ClientWidth = 915
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 18
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 915
    Height = 321
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 185
      Height = 321
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object Button1: TButton
        Left = 0
        Top = 0
        Width = 185
        Height = 40
        Align = alTop
        Caption = 'Teste'
        TabOrder = 0
        Visible = False
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 0
        Top = 40
        Width = 185
        Height = 40
        Align = alTop
        Caption = 'Configura'#231#245'es'
        TabOrder = 1
        OnClick = Button2Click
      end
    end
    object Memo1: TMemo
      Left = 185
      Top = 0
      Width = 730
      Height = 321
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 1
    end
    object AcroPDF1: TAcroPDF
      Left = 776
      Top = 280
      Width = 16
      Height = 24
      TabOrder = 2
      Visible = False
      ControlData = {000E0000A70100007B020000}
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 360
    Top = 160
  end
  object Timer2: TTimer
    Interval = 5000
    OnTimer = Timer2Timer
    Left = 432
    Top = 168
  end
  object TrayIcon1: TTrayIcon
    Animate = True
    Hint = 'Sistema Impress'#227'o'
    BalloonTitle = 'Sistema Impress'#227'o'
    Icon.Data = {
      0000010001002020000001002000A81000001600000028000000200000004000
      0000010020000000000080100000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000060000000F000000162020201F2020
      201F000000160000000F00000006000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000031F151518854A5C639D556AAAAA5A71D8AF5C74F5B15D75FEB15D
      75FEAF5C74F5AA5A71D89D556AAA854A5C631F15151800000003000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002C21
      211795526585AC5B72E9AE5871FFA94C66FFA4425EFFA13C59FFA03956FFA039
      56FFA13C59FFA4425EFFA94C66FFAE5871FFAC5B72E9955065852C1621170000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000037B465548AA5B
      72DDAD566FFFA4425EFF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E35
      53FF9E3553FF9E3553FF9E3553FF9E3553FFA4425EFFAD566FFFAA5B72DD7B46
      5548000000030000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000038E4E616BAF5C74F8A749
      64FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E35
      53FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FFA74964FFAF5C
      74F8904F626A0000000300000000000000000000000000000000000000000000
      00000000000000000000000000000000000191506369B05C73FCA3415DFF9E35
      53FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E35
      53FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FFA341
      5DFFB05C73FC9150636900000001000000000000000000000000000000000000
      0000000000000000000000000000874D5C42AF5C74F8A3415DFF9E3553FF9E35
      53FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E35
      53FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E35
      53FFA3415DFFAF5C74F887495C42000000000000000000000000000000000000
      000000000000000000004836360EAB5B72DCA74964FF9E3553FF9E3553FF9E35
      53FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E35
      53FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E35
      53FF9E3553FFA74964FFAC5B73DB4824360E0000000000000000000000000000
      00000000000000000000A0586C7CAD566FFF9E3553FF9E3553FF9E3553FF9E35
      53FF9E3553FF9D3452FF9D3452FF9D3452FF9D3352FF9D3352FF9D3352FF9D33
      52FF9D3352FF9D3352FF9D3452FF9D3352FF9D3452FF9E3553FF9E3553FF9E35
      53FF9E3553FF9E3553FFAD566FFFA0566C7C0000000000000000000000000000
      000000000000452E2E0BAE5C74E8A4425EFF9E3553FF9E3553FF9E3553FF9E35
      53FFB05A73FFFBF7F8FFFAF4F6FFEEDBE1FFFEFDFEFFFEFDFEFFFEFDFEFFFEFD
      FEFFFEFDFEFFFEFDFEFFE9D3D9FFFEFDFEFFFBF7F8FFB05A73FF9E3553FF9E35
      53FF9E3553FF9E3553FFA4425EFFAD5C73E8452E2E0B00000000000000000000
      000000000000A0586D54AE5871FF9E3553FF9E3553FF9E3553FF9E3553FF9E35
      53FFBC7489FFFFFFFFFFFEFEFEFFEBD6DDFFEAD3DBFFEAD3DBFFEAD3DBFFEAD3
      DBFFEAD3DBFFEAD3DBFFEEDBE1FFFFFFFFFFFFFFFFFFBC7489FF9E3553FF9E35
      53FF9E3553FF9E3553FF9E3553FFAE5871FF9D586D5400000000000000000000
      000000000000A95B729EA94C66FF9E3553FF9E3553FF9E3553FF9E3553FF9E35
      53FFBC7489FFFFFFFFFFF6EDEFFFEAD3DAFFEAD4DBFFEAD4DBFFEAD4DBFFEAD4
      DBFFEAD4DBFFEAD4DBFFEAD3DAFFF6EDF0FFFFFFFFFFBC7489FF9E3553FF9E35
      53FF9E3553FF9E3553FF9E3553FFA94C66FFA95B729E00000000000000000000
      000000000001AE5D74D3A4425EFF9E3553FF9E3553FF9E3553FF9E3553FF9E35
      53FFBC7489FFFFFFFFFFEAD3DAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFE9D2D9FFFFFFFFFFBC7489FF9E3553FF9E35
      53FF9E3553FF9E3553FF9E3553FFA4425EFFAE5D74D300000001000000000000
      000000000003B05E75F4A13C59FF9E3553FF9E3553FF9E3553FF9E3553FF9E35
      53FFBC7489FFFFFFFFFFECD7DDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFEBD5DBFFFFFFFFFFBC7489FF9E3553FF9E35
      53FF9E3553FF9E3553FF9E3553FFA13C59FFB05D75F400000003000000000000
      00006666660AB15D75FEA03956FF9E3553FF9E3553FF9E3553FF9E3553FF9E35
      53FFBC7489FFFFFFFFFFECD7DDFFF4E8EBFFECD8DEFFECD8DEFFECD8DEFFECD8
      DEFFECD8DEFFECD8DEFFF5EBEEFFEBD5DBFFFFFFFFFFBC7489FF9E3553FF9E35
      53FF9E3553FF9E3553FF9E3553FFA03956FFB15D75FE71717109000000000000
      000071717109B15D75FEA03956FF9E3553FF9E3553FF9E3553FF9E3553FF9E35
      53FFB15C75FFFCFAFBFFECD7DDFFE9D2D9FFFEFEFEFFFEFEFEFFFEFEFEFFFEFE
      FEFFFEFEFEFFFEFEFEFFE9D1D8FFEBD5DBFFFCFAFBFFB15C75FF9E3553FF9E35
      53FF9E3553FF9E3553FF9E3553FFA03956FFB15D75FE71717109000000000000
      000000000001B05E75F4A13C59FF9E3553FF9E3553FF9E3553FF9E3553FF9E35
      53FF9E3553FF9F3855FFA03956FFE5C9D0FFEAD3DAFFE1C2CAFFE1C2CAFFE1C2
      CAFFE1C2CAFFEDDAE0FFDAB1BDFFA03956FF9F3855FF9E3553FF9E3553FF9E35
      53FF9E3553FF9E3553FF9E3553FFA13C59FFB15D75F300000001000000000000
      000000000000B05E75D0A4425EFF9E3553FF9E3553FF9E3553FF9E3553FF9E35
      53FF9E3553FF9E3553FF9E3553FFE4C8D0FFF3E6EAFFEEDCE2FFEEDCE2FFEEDC
      E2FFEEDCE2FFF5EAEDFFD9B0BCFF9E3553FF9E3553FF9E3553FF9E3553FF9E35
      53FF9E3553FF9E3553FF9E3553FFA4425EFFB05E75D000000000000000000000
      000000000000B05F7798A84C66FF9E3553FF9E3553FF9E3553FF9E3553FF9E35
      53FF9E3553FF9E3553FF9E3553FFE4C8D0FFF5EBEEFFF1E3E7FFF1E3E7FFF1E3
      E7FFF1E3E7FFF7EEF1FFD9B0BCFF9E3553FF9E3553FF9E3553FF9E3553FF9E35
      53FF9E3553FF9E3553FF9E3553FFA94C66FFB05F779800000000000000000000
      000000000000B161784CAE5871FF9E3553FF9E3553FF9E3553FF9E3553FF9E35
      53FF9E3553FF9E3553FF9E3553FFE4C8D0FFEAD3D9FFE1C1CAFFE1C1CAFFE1C1
      CAFFE1C1CAFFEDDADFFFD9B0BCFF9E3553FF9E3553FF9E3553FF9E3553FF9E35
      53FF9E3553FF9E3553FF9E3553FFAE5871FFAE61784C00000000000000000000
      00000000000099666605B15D76E4A4425EFF9E3553FF9E3553FF9E3553FF9E35
      53FF9E3553FF9E3553FF9E3553FFDDB9C3FFFEFEFEFFFEFEFEFFFEFEFEFFFEFE
      FEFFFEFEFEFFFEFEFEFFD2A1AFFF9E3553FF9E3553FF9E3553FF9E3553FF9E35
      53FF9E3553FF9E3553FFA4425EFFB05D75E49966660500000000000000000000
      00000000000000000000B1617870AD566FFF9E3553FF9E3553FF9E3553FF9E35
      53FF9E3553FF9E3553FF9E3553FF9D3452FF9D3452FF9D3452FF9D3452FF9D34
      52FF9D3452FF9D3452FF9D3452FF9E3553FF9E3553FF9E3553FF9E3553FF9E35
      53FF9E3553FF9E3553FFAD566FFFB15F78700000000000000000000000000000
      00000000000000000000AA557F06B05E75D6A74964FF9E3553FF9E3553FF9E35
      53FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E35
      53FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E35
      53FF9E3553FFA74964FFB15E76D5AA557F060000000000000000000000000000
      0000000000000000000000000000B2667A32B05C74F7A3415DFF9E3553FF9E35
      53FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E35
      53FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E35
      53FFA3415DFFB05C74F7B2607A32000000000000000000000000000000000000
      000000000000000000000000000000000000B1617956B05C73FCA3415DFF9E35
      53FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E35
      53FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FFA341
      5DFFB05C73FCB161795600000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B1617956B05C74F7A749
      64FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E35
      53FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FFA74964FFB05C
      74F7B16179560000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B2667A32B05E
      75D6AD566FFFA4425EFF9E3553FF9E3553FF9E3553FF9E3553FF9E3553FF9E35
      53FF9E3553FF9E3553FF9E3553FF9E3553FFA4425EFFAD566FFFB15E76D5B260
      7A32000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000AA55
      7F06B15F7870B15D75E4AE5871FFA84C66FFA4425EFFA13C59FFA03956FFA039
      56FFA13C59FFA4425EFFA84C66FFAE5871FFB15D75E4B15F7870AA557F060000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000099666605B161784CB1607797B15E76CFB15E75F3B15C75FEB15C
      75FEB15E75F3B15E76CFB1607797B4627A4BBF7F7F0400000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000AAAAAA06AAAA
      AA06000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FFFFFFF00FFFFF8001FFFF0000FFFC00003FF800001FF000000FF000000FE000
      0007E0000007C0000003C0000003C00000038000000180000001800000018000
      000180000001C0000003C0000003C0000003C0000003E0000007E0000007F000
      000FF800001FFC00003FFE00007FFF0000FFFFC003FFFFFE7FFFFFFFFFFF}
    OnClick = TrayIcon1Click
    Left = 536
    Top = 176
  end
  object ApplicationEvents1: TApplicationEvents
    OnMinimize = ApplicationEvents1Minimize
    Left = 544
    Top = 8
  end
  object Timer3: TTimer
    Interval = 2000
    OnTimer = Timer3Timer
    Left = 232
    Top = 248
  end
end
