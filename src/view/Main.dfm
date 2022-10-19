object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Form1'
  ClientHeight = 438
  ClientWidth = 703
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 80
    Width = 38
    Height = 13
    Caption = 'Produto'
  end
  object lbProduto: TLabel
    Left = 79
    Top = 98
    Width = 362
    Height = 13
    AutoSize = False
  end
  object Label2: TLabel
    Left = 447
    Top = 80
    Width = 56
    Height = 13
    Caption = 'Quantidade'
  end
  object Label3: TLabel
    Left = 519
    Top = 80
    Width = 56
    Height = 13
    Caption = 'Vlr. Unit'#225'rio'
  end
  object Label4: TLabel
    Left = 16
    Top = 35
    Width = 33
    Height = 13
    Caption = 'Cliente'
  end
  object lbCliente: TLabel
    Left = 79
    Top = 53
    Width = 362
    Height = 13
    AutoSize = False
  end
  object lbTotalPedido: TLabel
    Left = 568
    Top = 406
    Width = 81
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = '0,00'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 481
    Top = 406
    Width = 81
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Total . . . :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btInserir: TButton
    Left = 588
    Top = 93
    Width = 75
    Height = 25
    Caption = '&Inserir'
    TabOrder = 4
    OnClick = btInserirClick
  end
  object edProduto: TEdit
    Left = 16
    Top = 95
    Width = 57
    Height = 21
    TabOrder = 1
    OnExit = edProdutoExit
  end
  object edQtd: TEdit
    Left = 447
    Top = 95
    Width = 57
    Height = 21
    TabOrder = 2
  end
  object edVlrUnit: TEdit
    Left = 520
    Top = 95
    Width = 57
    Height = 21
    TabOrder = 3
  end
  object edCliente: TEdit
    Left = 16
    Top = 50
    Width = 57
    Height = 21
    TabOrder = 0
    OnExit = edClienteExit
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 703
    Height = 33
    Align = alTop
    TabOrder = 5
    ExplicitWidth = 693
    object Label5: TLabel
      Left = 8
      Top = 1
      Width = 32
      Height = 13
      Caption = 'Pedido'
    end
    object lbPedido: TLabel
      Left = 8
      Top = 15
      Width = 121
      Height = 16
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btGravar: TButton
      Left = 588
      Top = 4
      Width = 75
      Height = 25
      Hint = 'Gravar Pedido'
      Caption = 'Gravar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btGravarClick
    end
    object btLocalizar: TButton
      Left = 507
      Top = 4
      Width = 75
      Height = 25
      Hint = 'Localizar Pedido'
      Caption = 'Localizar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btLocalizarClick
    end
    object btCancelar: TButton
      Left = 426
      Top = 4
      Width = 75
      Height = 25
      Hint = 'Cancelar Pedido'
      Caption = 'Cancelar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btCancelarClick
    end
  end
  object grid: TStringGrid
    Left = 16
    Top = 120
    Width = 647
    Height = 273
    ColCount = 6
    DefaultRowHeight = 20
    RowCount = 1
    FixedRows = 0
    TabOrder = 6
    OnKeyDown = gridKeyDown
  end
end
