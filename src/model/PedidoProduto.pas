unit PedidoProduto;

interface

uses
  System.SysUtils;

type
  TPedidoProduto = class
  private
    Fvlrtotal: double;
    Fqtd: double;
    Fidproduto: integer;
    Fid: integer;
    Fidpedido: integer;
    Fvlrunit: double;
  public
    property id: integer read Fid write Fid;
    property idpedido: integer read Fidpedido write Fidpedido;
    property idproduto: integer read Fidproduto write Fidproduto;
    property qtd: double read Fqtd write Fqtd;
    property vlrunit: double read Fvlrunit write Fvlrunit;
    property vlrtotal: double read Fvlrtotal write Fvlrtotal;

    constructor Create; overload;
    constructor Create(const aId: integer; const aIdPedido: integer;
      const aIdProduto: integer; const aQtd: double;
      const aVlrUnit: double; const aVlrTotal: double); overload;
  end;

implementation

{ TPedidoProduto }

constructor TPedidoProduto.Create(const aId, aIdPedido, aIdProduto: integer;
  const aQtd, aVlrUnit, aVlrTotal: double);
begin
  Create;
  Fvlrtotal := aVlrTotal;
  Fqtd := aQtd;
  Fidproduto := aIdProduto;
  Fid := aId;
  Fidpedido := aIdPedido;
  Fvlrunit := aVlrUnit;
end;

constructor TPedidoProduto.Create;
begin
  Fvlrtotal := 0;
  Fqtd := 0;
  Fidproduto := 0;
  Fid := 0;
  Fidpedido := 0;
  Fvlrunit := 0;
end;

end.
