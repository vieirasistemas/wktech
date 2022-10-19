unit Pedido;

interface

uses
  System.SysUtils, System.Generics.Collections, PedidoProduto;

type
  TPedido = class
  private
    Fvlrtotal: double;
    Femissao: TDate;
    Fidpedido: integer;
    Fidcliente: integer;
    Fprodutos: TList<TPedidoProduto>;
  public
    property idpedido: integer read Fidpedido write Fidpedido;
    property idcliente: integer read Fidcliente write Fidcliente;
    property emissao: TDate read Femissao write Femissao;
    property vlrtotal: double read Fvlrtotal write Fvlrtotal;
    property produtos: TList<TPedidoProduto> read Fprodutos write Fprodutos;

    constructor Create; overload;
    constructor create(const aIdPedido: integer;
      const aIdCliente: integer; const aEmissao: TDate;
      const aVlrTotal: double ); overload;
    destructor Destroy; override;
  end;

implementation

{ TPedido }

constructor TPedido.Create(const aIdPedido, aIdCliente: integer;
  const aEmissao: TDate; const aVlrTotal: double);
begin
  Create;
  Fvlrtotal :=  aVlrTotal;
  Femissao  :=  aEmissao;
  Fidpedido :=  aIdPedido;
  Fidcliente  := aIdCliente;
end;

destructor TPedido.Destroy;
begin
  Fprodutos.Free;
  inherited;
end;

{ TPedido }

constructor TPedido.Create;
begin
  Fvlrtotal :=  0;
  Femissao  :=  Date;
  Fidpedido :=  0;
  Fidcliente  := 0;
  Fprodutos :=  TList<TPedidoProduto>.Create;
end;

end.
