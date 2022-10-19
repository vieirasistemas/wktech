unit DataMain;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TdmMain = class(TDataModule)
    fdcWKTech: TFDConnection;
    fdpMySQL: TFDPhysMySQLDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    function GetNomeCliente(const idcliente: integer): string;
    procedure DadosProduto(const idproduto: integer; var descricao: string;
      var vlr: double);
    function GetIdPedido: integer;
  end;

var
  dmMain: TdmMain;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmMain.DadosProduto(const idproduto: integer; var descricao: string;
  var vlr: double);
var
  query: TFDQuery;
begin
  query :=  TFDQuery.Create(nil);
  try
    query.Connection  :=  fdcWKTech;
    query.SQL.Text  :=  'select descricao, precovenda from produto where id_produto = ' + idproduto.ToString;
    query.Open;
    descricao :=  query.FieldByName('descricao').AsString;
    vlr :=  query.FieldByName('precovenda').AsFloat;
  finally
    query.Close;
    query.Free;
  end;
end;

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  fdpMySQL.VendorLib  :=  ExtractFilePath(ParamStr(0)) + 'libmySQL50.dll';
  fdcWKTech.LoginPrompt     := false;
  fdcWKTech.Params.DriverID := 'MySQL';
  fdcWKTech.Params.Values['Server'] := 'localhost';
  fdcWKTech.Params.Database := 'wktech';
  fdcWKTech.Params.UserName := 'root';
  fdcWKTech.Params.Password := '123456';
  fdcWKTech.Connected :=  true;
end;

function TdmMain.GetIdPedido: integer;
var
  query: TFDQuery;
begin
  query :=  TFDQuery.Create(nil);
  try
    query.Connection  :=  fdcWKTech;
    query.SQL.Text  :=  'select max(idpedido) as idpedido from pedido';
    query.Open;
    Result  :=  query.FieldByName('idpedido').AsInteger + 1;
  finally
    query.Close;
    query.Free;
  end;
end;

function TdmMain.GetNomeCliente(const idcliente: integer): string;
var
  query: TFDQuery;
begin
  query :=  TFDQuery.Create(nil);
  try
    query.Connection  :=  fdcWKTech;
    query.SQL.Text  :=  'select nome from cliente where codigo = ' + idcliente.ToString;
    query.Open;
    Result  :=  query.FieldByName('nome').AsString;
  finally
    query.Close;
    query.Free;
  end;
end;

end.
