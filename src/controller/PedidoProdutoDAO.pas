unit PedidoProdutoDAO;

interface

uses
  System.SysUtils, BaseDAO, PedidoProduto, FireDAC.Stan.Param, FireDAC.Comp.Client;

type
  TPedidoProdutoDAO = class(TBaseDAO)
  private
  public
    function Insert(const aObjeto: TObject): integer; override;
    procedure Update(const aObjeto: TObject); override;
    procedure Delete(const aId: integer); override;
    function Select(const aId: integer): TObject; override;
  end;

implementation

{ TPedidoProdutoDAO }

procedure TPedidoProdutoDAO.Delete(const aId: integer);
begin
  try
    FQuery.Close;
    FQuery.SQL.Text :=  'delete from pedido_produto where id = :id';
    FQuery.ParamByName('id').AsInteger  :=  aId;

    try
      FQuery.ExecSQL;
    except
      raise Exception.Create('Erro ao inserir o PedidoProduto');
    end;
  finally
    FQuery.Close;
  end;
end;

function TPedidoProdutoDAO.Insert(const aObjeto: TObject): integer;
var
  PedidoProduto: TPedidoProduto;
begin
  PedidoProduto  :=  aObjeto as TPedidoProduto;
  try
    FQuery.Close;
    FQuery.SQL.Text :=  'insert into pedido_produto(idpedido, idproduto, qtd, vlrunit, vlrtotal) ' +
                        'values (:idpedido, :idproduto, :qtd, :vlrunit, :vlrtotal)';
    FQuery.ParamByName('idpedido').AsInteger  :=  PedidoProduto.idpedido;
    FQuery.ParamByName('idproduto').AsInteger  :=  PedidoProduto.idproduto;
    FQuery.ParamByName('qtd').AsFloat  :=  PedidoProduto.qtd;
    FQuery.ParamByName('vlrunit').AsFloat  :=  PedidoProduto.vlrunit;
    FQuery.ParamByName('vlrtotal').AsFloat  :=  PedidoProduto.vlrtotal;

    try
      FQuery.ExecSQL;
      pedidoproduto.id  :=  GetLastId('id', 'pedido_produto');
    except
      raise Exception.Create('Erro ao inserir o PedidoProduto');
    end;

    Result  :=  PedidoProduto.id;
  finally
    FQuery.Close;
  end;
end;

function TPedidoProdutoDAO.Select(const aId: integer): TObject;
var
  PedidoProduto: TPedidoProduto;
begin
  Result  :=  nil;
  PedidoProduto  :=  TPedidoProduto.Create;
  try
    FQuery.Close;
    FQuery.SQL.Text :=  'select * from pedido_produto where id = :id';
    FQuery.ParamByName('id').AsInteger  :=  aId;
    FQuery.Open;

    if (FQuery.FieldByName('id').AsInteger > 0) then
    begin
      PedidoProduto.id :=  FQuery.FieldByName('id').AsInteger;
      PedidoProduto.idpedido :=  FQuery.FieldByName('idpedido').AsInteger;
      PedidoProduto.idproduto :=  FQuery.FieldByName('idproduto').AsInteger;
      PedidoProduto.qtd :=  FQuery.FieldByName('qtd').AsFloat;
      PedidoProduto.vlrunit :=  FQuery.FieldByName('vlrunit').AsFloat;
      PedidoProduto.vlrtotal :=  FQuery.FieldByName('vlrtotal').AsFloat;

      Result  :=  PedidoProduto;
    end;
  finally
    FQuery.Close;
  end;
end;

procedure TPedidoProdutoDAO.Update(const aObjeto: TObject);
var
  PedidoProduto: TPedidoProduto;
begin
  PedidoProduto  :=  aObjeto as TPedidoProduto;
  try
    FQuery.Close;
    FQuery.SQL.Text :=  'update pedido_produto set ' +
                        ' idpedido = :idpedido, ' +
                        ' idproduto = :idproduto, ' +
                        ' qtd = :qtd, ' +
                        ' vlrunit = :vlrunit, ' +
                        ' vlrtotal = :vlrtotal ' +
                        ' where id = :id';
    FQuery.ParamByName('id').AsInteger  :=  PedidoProduto.id;
    FQuery.ParamByName('idpedido').AsInteger  :=  PedidoProduto.idpedido;
    FQuery.ParamByName('idproduto').AsInteger  :=  PedidoProduto.idproduto;
    FQuery.ParamByName('qtd').AsFloat  :=  PedidoProduto.qtd;
    FQuery.ParamByName('vlrunit').AsFloat  :=  PedidoProduto.vlrunit;
    FQuery.ParamByName('vlrtotal').AsFloat  :=  PedidoProduto.vlrtotal;

    try
      FQuery.ExecSQL;
    except
      raise Exception.Create('Erro ao inserir o PedidoProduto');
    end;
  finally
    FQuery.Close;
  end;
end;

end.
