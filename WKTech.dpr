program WKTech;

uses
  Vcl.Forms,
  Main in 'src\view\Main.pas' {Form1},
  DataMain in 'src\controller\DataMain.pas' {dmMain: TDataModule},
  Pedido in 'src\model\Pedido.pas',
  PedidoProduto in 'src\model\PedidoProduto.pas',
  PedidoDAO in 'src\controller\PedidoDAO.pas',
  BaseDAO in 'src\model\BaseDAO.pas',
  PedidoProdutoDAO in 'src\controller\PedidoProdutoDAO.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TdmMain, dmMain);
  Application.Run;
end.
