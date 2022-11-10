unit PedidoDAO;

interface

uses
  System.SysUtils, BaseDAO, Pedido, FireDAC.Stan.Param, FireDAC.Comp.Client,
  PedidoProduto, PedidoProdutoDAO;

type
  TPedidoDAO = class(TBaseDAO)
  private
    procedure SelectProdutos(const aPedido: TPedido);
  public
    function Insert(const aObjeto: TObject): integer; override;
    procedure Update(const aObjeto: TObject); override;
    procedure Delete(const aId: integer); override;
    function Select(const aId: integer): TObject; override;
    procedure ClearPedidoProdutos(const aObjeto: TObject);
  end;

implementation

{ TPedidoDAO }

procedure TPedidoDAO.ClearPedidoProdutos(const aObjeto: TObject);
var
  pedido: TPedido;
  pedidoprodutodao: TPedidoProdutoDAO;
  idx: integer;
begin
  pedido  :=  aObjeto as TPedido;
  for idx := 0 to pedido.produtos.Count - 1 do
  begin
    pedidoprodutodao  :=  TPedidoProdutoDAO.Create;
    pedidoprodutodao.Delete(pedido.produtos.Items[idx].id);
  end;
  pedido.produtos.Clear;
end;

procedure TPedidoDAO.Delete(const aId: integer);
begin
  try
    if not FQuery.Connection.InTransaction then
      FQuery.Connection.StartTransaction;

    FQuery.Close;
    FQuery.SQL.Text :=  'delete from pedido where idpedido = :idpedido';
    FQuery.ParamByName('idpedido').AsInteger  :=  aId;

    try
      FQuery.ExecSQL;
      FQuery.Connection.Commit;
    except
      on e: Exception do
      begin
        FQuery.Connection.Rollback;
        raise Exception.Create('Ocorreu o seguinte erro:' + sLineBreak + e.Message);
      end;
    end;

  finally
    FQuery.Close;
  end;
end;

function TPedidoDAO.Insert(const aObjeto: TObject): integer;
var
  pedido: TPedido;
begin
  pedido  :=  aObjeto as TPedido;
  try
    if not FQuery.Connection.InTransaction then
      FQuery.Connection.StartTransaction;

    FQuery.Close;
    FQuery.SQL.Text :=  'insert into pedido(idpedido, idcliente, emissao, vlrtotal) ' +
                        'values (:idpedido, :idcliente, :emissao, :vlrtotal)';
    FQuery.ParamByName('idpedido').AsInteger  :=  pedido.idpedido;
    FQuery.ParamByName('idcliente').AsInteger  :=  pedido.idcliente;
    FQuery.ParamByName('emissao').AsDateTime  :=  pedido.emissao;
    FQuery.ParamByName('vlrtotal').AsFloat  :=  pedido.vlrtotal;

    try
      FQuery.ExecSQL;
      FQuery.Connection.Commit;
    except
      on e: Exception do
      begin
        FQuery.Connection.Rollback;
        raise Exception.Create('Ocorreu o seguinte erro:' + sLineBreak + e.Message);
      end;
    end;

    Result  :=  pedido.idpedido;
  finally
    FQuery.Close;
  end;
end;

function TPedidoDAO.Select(const aId: integer): TObject;
var
  pedido: TPedido;
begin
  pedido  :=  TPedido.Create;
  Result  :=  pedido;
  try
    FQuery.Close;
    FQuery.SQL.Text :=  'select * from pedido where idpedido = :idpedido';
    FQuery.ParamByName('idpedido').AsInteger  :=  aId;
    FQuery.Open;

    if (FQuery.FieldByName('idpedido').AsInteger > 0) then
    begin
      pedido.idpedido :=  FQuery.FieldByName('idpedido').AsInteger;
      pedido.idcliente :=  FQuery.FieldByName('idcliente').AsInteger;
      pedido.emissao :=  FQuery.FieldByName('emissao').AsDateTime;
      pedido.vlrtotal :=  FQuery.FieldByName('vlrtotal').AsFloat;
      SelectProdutos(pedido);
      Result  :=  pedido;
    end;
  finally
    FQuery.Close;
  end;
end;

procedure TPedidoDAO.SelectProdutos(const aPedido: TPedido);
var
  pedidoproduto: TPedidoProduto;
  pedidoprodutoDAO: TPedidoProdutoDAO;
begin
  try
    FQuery.Close;
    FQuery.SQL.Text :=  'select id from pedido_produto where idpedido = ' + aPedido.idpedido.ToString;
    FQuery.Open;
    while not FQuery.Eof do
    begin
      pedidoprodutoDAO  :=  TPedidoProdutoDAO.Create;
      pedidoproduto :=  pedidoprodutodao.Select(FQuery.FieldByName('id').AsInteger) as TPedidoProduto;

      if assigned(pedidoproduto) and (pedidoproduto.id > 0) then
        aPedido.produtos.Add(pedidoproduto);

      FQuery.Next;
    end;
  finally

  end;
end;

procedure TPedidoDAO.Update(const aObjeto: TObject);
var
  pedido: TPedido;
begin
  pedido  :=  aObjeto as TPedido;
  try
    if not FQuery.Connection.InTransaction then
      FQuery.Connection.StartTransaction;

    FQuery.Close;
    FQuery.SQL.Text :=  'update pedido set ' +
                        ' idcliente = :idcliente, ' +
                        ' emissao = :emissao, ' +
                        ' vlrtotal = :vlrtotal ' +
                        ' where idpedido = :idpedido';
    FQuery.ParamByName('idpedido').AsInteger  :=  pedido.idpedido;
    FQuery.ParamByName('idcliente').AsInteger  :=  pedido.idcliente;
    FQuery.ParamByName('emissao').AsDateTime  :=  pedido.emissao;
    FQuery.ParamByName('vlrtotal').AsFloat  :=  pedido.vlrtotal;

    try
      FQuery.ExecSQL;
      FQuery.Connection.Commit;
    except
      on e: Exception do
      begin
        FQuery.Connection.Rollback;
        raise Exception.Create('Ocorreu o seguinte erro:' + sLineBreak + e.Message);
      end;
    end;
  finally
    FQuery.Close;
  end;
end;

end.
