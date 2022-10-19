unit BaseDAO;

interface

uses
  System.SysUtils, DataMain, FireDAC.Comp.Client;

type
  TBaseDAO = class
  private
  protected
    FQuery: TFDQuery;
  public
    function Insert(const aObjeto: TObject): integer; virtual; abstract;
    procedure Update(const aObjeto: TObject); virtual; abstract;
    procedure Delete(const aId: integer); virtual; abstract;
    function Select(const aId: integer): TObject; virtual; abstract;
    function GetLastId(const aField: string; aTable: string): integer;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TBaseDAO }

constructor TBaseDAO.Create;
begin
  FQuery  :=  TFDQuery.Create(nil);
  FQuery.Connection :=  dmMain.fdcWKTech;
end;

destructor TBaseDAO.Destroy;
begin
  FQuery.Close;
  FQuery.Free;
  inherited;
end;

function TBaseDAO.GetLastId(const aField: string; aTable: string): integer;
begin
  try
    FQuery.Close;
    FQuery.SQL.Text :=  'select max('+ aField +') as id from ' + aTable;
    FQuery.Open;
    try
      Result  :=  FQuery.FieldByName('id').AsInteger;
    except
      on e: Exception do
        raise Exception.Create(e.Message);
    end;
  finally

  end;
end;

end.
