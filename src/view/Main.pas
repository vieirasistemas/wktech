unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    lbProduto: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lbCliente: TLabel;
    lbTotalPedido: TLabel;
    Label7: TLabel;
    btInserir: TButton;
    edProduto: TEdit;
    edQtd: TEdit;
    edVlrUnit: TEdit;
    edCliente: TEdit;
    Panel1: TPanel;
    btGravar: TButton;
    btLocalizar: TButton;
    btCancelar: TButton;
    grid: TStringGrid;
    Label5: TLabel;
    lbPedido: TLabel;
    procedure edClienteExit(Sender: TObject);
    procedure edProdutoExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btInserirClick(Sender: TObject);
    procedure btGravarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btLocalizarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure gridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    Fidpedido: integer;
    procedure MontarGrid;
    function ValidarDadosProduto: boolean;
    function ValidarDadosPedido: boolean;
    function TotalPedido: double;
    procedure LimparTela;
  public
    { Public declarations }
  end;

const
  idxColIdProduto = 0;
  idxColDescricao = 1;
  idxColQtd = 3;
  idxColVlrUnit = 2;
  idxColVlrTotal = 4;
  idxColId = 5;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses Pedido, PedidoDAO, DataMain, PedidoProduto, PedidoProdutoDAO;

procedure TForm1.btInserirClick(Sender: TObject);
var
  rowcount: integer;
begin
  if ValidarDadosProduto then
  begin
    rowcount  :=  grid.RowCount;
    grid.RowCount :=  grid.RowCount + 1;
    grid.Cells[idxColIdProduto, rowcount] :=  edProduto.Text;
    grid.Cells[idxColDescricao, rowcount] :=  lbProduto.Caption;
    grid.Cells[idxColQtd, rowcount]       :=  edQtd.Text;
    grid.Cells[idxColVlrUnit, rowcount]   :=  formatfloat('#,##0.00',StrToFloat(edVlrUnit.Text));
    grid.Cells[idxColVlrTotal, rowcount]  :=  formatfloat('#,##0.00',StrToFloat(edQtd.Text) * StrToFloat(edVlrUnit.Text));
    lbTotalPedido.Caption                 :=  formatfloat('#,##0.00',TotalPedido);
    edProduto.Text    := '';
    lbProduto.Caption := '';
    edQtd.Text        := '';
    edVlrUnit.Text    := '';
    edProduto.SetFocus;
  end
  else
    ShowMessage('Preencha os dados do produto corretamente');
end;

procedure TForm1.btCancelarClick(Sender: TObject);
var
  pedido: TPedido;
  pedidodao: TPedidoDAO;
begin
  Fidpedido  :=  StrToIntDef(InputBox('Localizar Pedido', 'Informe o numero do pedido', ''), 0);
  if Fidpedido > 0 then
  begin
    pedidodao :=  TPedidoDAO.Create;
    pedido  :=  pedidodao.Select(Fidpedido) as TPedido;

    if assigned(pedido) and (pedido.idpedido > 0) then
    begin
      if Application.MessageBox('Confirma Operação?','Cancelar Pedido',MB_YESNO)=ID_YES  then
        try
          pedidodao :=  TPedidoDAO.Create;
          pedido  :=  pedidodao.Select(Fidpedido) as TPedido;

          if assigned(pedido) and (pedido.idpedido > 0) then
          begin
            pedidodao.Delete(pedido.idpedido);
            LimparTela;
          end;
        finally
          pedidodao.Free;
          pedido.Free;
        end;
    end
    else
      ShowMessage('Pedido nao encontrado.');

    edClienteExit(self);
  end;
end;

procedure TForm1.btGravarClick(Sender: TObject);
var
  pedido: TPedido;
  pedidodao: TPedidoDAO;
  idx: integer;
  pedidoproduto: TPedidoProduto;
  pedidoprodutodao: TPedidoProdutoDAO;

  procedure DadosComunsPedido;
  begin
    pedido.idcliente  :=  StrToInt(edCliente.Text);
    pedido.emissao  :=  Date;
    pedido.vlrtotal :=  TotalPedido;
  end;
begin
  if ValidarDadosPedido then
  begin
    pedido  :=  TPedido.Create;
    pedidodao :=  TPedidoDAO.Create;
    try
      pedidoproduto :=  TPedidoProduto.Create;
      pedidoprodutodao  :=  TPedidoProdutoDAO.Create;

      if Fidpedido > 0 then
      begin
        pedido  :=  pedidodao.Select(Fidpedido) as TPedido;
        DadosComunsPedido;
        pedidodao.Update(pedido);
      end
      else
      begin
        pedido.idpedido :=  dmMain.GetIdPedido;
        DadosComunsPedido;
        pedidodao.Insert(pedido);
      end;

      pedidodao.ClearPedidoProdutos(pedido);

      if pedido.idpedido > 0 then
      begin
        Fidpedido :=  pedido.idpedido;
        lbPedido.Caption  :=  pedido.idpedido.ToString;

        for idx := 1 to grid.RowCount - 1 do
        begin
          try
            pedidoproduto :=  TPedidoProduto.Create;
            pedidoprodutodao  :=  TPedidoProdutoDAO.Create;
            pedidoproduto.idpedido  :=  pedido.idpedido;
            pedidoproduto.idproduto :=  StrToInt(grid.Cells[idxColIdProduto, idx]);
            pedidoproduto.qtd :=  StrToFloat(grid.Cells[idxColQtd, idx]);
            pedidoproduto.vlrunit :=  StrToFloat(grid.Cells[idxColVlrUnit, idx]);
            pedidoproduto.vlrtotal  :=  StrToFloat(grid.Cells[idxColVlrTotal, idx]);
            pedidoprodutodao.Insert(pedidoproduto);
          finally
            pedidoprodutodao.Free;
            pedidoproduto.Free;
          end;
        end;
      end
      else
        ShowMessage('Informe um numero de pedido valido.');
    finally
      pedidodao.Free;
      pedido.Free;
    end;
  end
  else
    ShowMessage('Informe os dados do pedido');
end;

procedure TForm1.btLocalizarClick(Sender: TObject);
var
  pedido: TPedido;
  pedidodao: TPedidoDAO;
  idx, rowcount: integer;
  descricao: string;
  vlr: double;
begin
  Fidpedido  :=  StrToIntDef(InputBox('Localizar Pedido', 'Informe o numero do pedido', ''), 0);
  pedidodao :=  TPedidoDAO.Create;
  pedido  :=  pedidodao.Select(Fidpedido) as TPedido;
  try
    if assigned(pedido) and (pedido.idpedido > 0)then
    begin
      lbPedido.Caption  :=  pedido.idpedido.ToString;
      edCliente.Text  :=  pedido.idcliente.ToString;
      edClienteExit(self);

      for idx := 0 to pedido.produtos.Count - 1 do
      begin
        rowcount  :=  grid.RowCount;
        grid.RowCount :=  grid.RowCount + 1;
        grid.Cells[idxColIdProduto, rowcount] :=  pedido.produtos.Items[idx].idproduto.ToString;
        dmMain.DadosProduto(pedido.produtos.Items[idx].idproduto, descricao, vlr);
        grid.Cells[idxColDescricao, rowcount] :=  descricao;
        grid.Cells[idxColQtd, rowcount] :=  FloatToStr(pedido.produtos.Items[idx].qtd);
        grid.Cells[idxColVlrUnit, rowcount] :=  formatfloat('#,##0.00',pedido.produtos.Items[idx].vlrunit);
        grid.Cells[idxColVlrTotal, rowcount] :=  formatfloat('#,##0.00',pedido.produtos.Items[idx].vlrtotal);
        lbTotalPedido.Caption :=  formatfloat('#,##0.00',TotalPedido);
      end;
    end
    else
    begin
      Fidpedido :=  0;
      ShowMessage('Pedido nao encontrado');
    end;
  finally
    pedidodao.Free;
    pedido.Free;
  end;
end;

procedure TForm1.edClienteExit(Sender: TObject);
begin
  btLocalizar.Visible :=  edCliente.Text = '';
  btCancelar.Visible :=  edCliente.Text = '';

  if edCliente.Text <> '' then
  begin
    lbCliente.Caption :=  dmMain.GetNomeCliente(StrToIntDef(edCliente.Text, 0));
    if lbCliente.Caption = '' then
      ShowMessage('Cliente nao cadastrado');
  end
  else
    lbCliente.Caption :=  '';
end;

procedure TForm1.edProdutoExit(Sender: TObject);
var
  descricao: string;
  vlr: double;
begin
  if edProduto.Text <> '' then
  begin
    dmMain.DadosProduto(StrToIntDef(edProduto.Text, 0), descricao, vlr);
    if descricao <> '' then
    begin
      lbProduto.Caption :=  descricao;
      edQtd.Text        :=  '1';
      edVlrUnit.Text    :=  FloatToStr(vlr);
    end
    else
      ShowMessage('Produto nao encontrado');
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  MontarGrid;
  Fidpedido :=  0;
end;

procedure TForm1.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = CHR(13) Then
     Begin
        try
          perform(WM_NextDlgCtl,0,0);
          Key := CHR(0);
        except
        end;
     End;
end;

procedure TForm1.gridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  idx, row, col: integer;
  atualizar_total: boolean;
  valor: double;
begin
  if (key = VK_DELETE) and (grid.RowCount > 1) then
  begin
    if Application.MessageBox('Confirma Operação?','Excluir Item',MB_YESNO) <> ID_YES  then
      exit;

    row :=  grid.Row;

    for idx := row to Grid.RowCount - 2 do
      Grid.Rows[idx].Assign(Grid.Rows[idx + 1]);

    Grid.RowCount := Grid.RowCount - 1;
    lbTotalPedido.Caption :=  FloatToStr(TotalPedido);
  end;

  if (key = VK_RETURN) and (grid.RowCount > 1) then
  begin
    row :=  grid.Row;
    col :=  grid.Col;

    atualizar_total :=  false;
    if col = idxColQtd then
    begin
      valor :=  StrToFloatDef(InputBox('Atualizar produto', 'Informe a quantidade', grid.Cells[idxColQtd, row]), 0);
      if valor > 0 then
      begin
        atualizar_total :=  true;
        grid.Cells[idxColQtd, row]  :=  FloatToStr(valor);
      end;
    end
    else
    if col = idxColVlrUnit then
    begin
      valor :=  StrToFloatDef(InputBox('Atualizar produto', 'Informe o valor unitario', grid.Cells[idxColVlrUnit, row]), 0);
      if valor > 0 then
      begin
        atualizar_total :=  true;
        grid.Cells[idxColVlrUnit, row]  :=  FloatToStr(valor);
      end;
    end;

    if atualizar_total then
      grid.Cells[idxColVlrTotal, row]  := FloatToStr(StrToFloat(grid.Cells[idxColQtd, row]) * StrToFloat(grid.Cells[idxColVlrUnit, row]));

    lbTotalPedido.Caption :=  FloatToStr(TotalPedido);
  end;
end;

procedure TForm1.LimparTela;
begin
  Fidpedido :=  0;
  lbPedido.Caption  :=  '';
  edCliente.Text  :=  '';
  lbCliente.Caption :=  '';
  edProduto.Text  :=  '';
  lbProduto.Caption :=  '';
  edQtd.Text  :=  '';
  edVlrUnit.Text  :=  '';
  lbTotalPedido.Caption :=  '0,00';
  MontarGrid;
end;

procedure TForm1.MontarGrid;
begin
  grid.RowCount :=  1;

  grid.Cells[idxColIdProduto, 0] :=  'Codigo';
  grid.ColWidths[idxColIdProduto]  :=  50;

  grid.Cells[idxColDescricao, 0] :=  'Descricao';
  grid.ColWidths[idxColDescricao]  :=  350;

  grid.Cells[idxColVlrUnit, 0] :=  'VlrUnit';
  grid.ColWidths[idxColVlrUnit]  :=  70;

  grid.Cells[idxColQtd, 0] :=  'Qtd';
  grid.ColWidths[idxColQtd]  :=  50;

  grid.Cells[idxColVlrTotal, 0] :=  'VlrTotal';
  grid.ColWidths[idxColVlrTotal]  :=  90;

  grid.Cells[idxColId, 0] :=  '';
  grid.ColWidths[idxColId]  :=  0;
end;

function TForm1.TotalPedido: double;
var
  idx: integer;
begin
  Result :=  0;
  for idx := 1 to grid.RowCount - 1 do
    Result  :=  Result + StrToFloat(grid.Cells[idxColVlrTotal, idx]);
end;

function TForm1.ValidarDadosPedido: boolean;
begin
  Result  :=  (StrToIntDef(edCliente.Text, 0) > 0) and (lbCliente.Caption <> '');
end;

function TForm1.ValidarDadosProduto: boolean;
begin
  Result  :=  (StrToIntDef(edProduto.Text, 0) > 0) and
              (lbProduto.Caption <> '') and
              (StrToFloatDef(edQtd.Text, 0) > 0) and
              (StrToFloatDef(edVlrUnit.Text, 0) > 0);
end;

end.
