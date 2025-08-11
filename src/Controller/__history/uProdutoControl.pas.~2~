unit uProdutoControl;

interface

uses
  uProdutoModel, System.SysUtils, FireDAC.Comp.Client;

type
  TProdutoControl = class
  private
    FProdutoModel: TProdutoModel;

  public
    constructor Create;
    destructor Destroy; override;

    function Salvar: Boolean;
    function Obter(AorderBy: Integer;AValorparcial: string): TFDQuery;
    function ObterProdDesc(AValorpesquisa: string): TFDQuery;
    function ObterCodBarra(AValorpesquisa: string): TFDQuery;
    function MovimentaEstoque(AValor: Double; Operac: string; AId: string): TFDQuery;
    function GetId: Integer;

    property ProdutoModel: TProdutoModel read FProdutoModel write FProdutoModel;
  end;


implementation

{ TProdutoControl }
constructor TProdutoControl.Create;
begin
  FProdutoModel := TProdutoModel.Create;
end;

destructor TProdutoControl.Destroy;
begin
  FProdutoModel.Free;
  inherited;
end;

function TProdutoControl.GetId: Integer;
begin
  Result := FProdutoModel.GetId;
end;

function TProdutoControl.MovimentaEstoque(AValor: Double; Operac,
  AId: string): TFDQuery;
begin
  Result := FProdutoModel.MovimentaEstoque(AValor,Operac,AId);
end;

function TProdutoControl.Obter(AorderBy: Integer;AValorparcial: string): TFDQuery;
begin
  Result := FProdutoModel.Obter(AorderBy,AValorparcial);
end;

function TProdutoControl.ObterCodBarra(AValorpesquisa: string): TFDQuery;
begin
  Result := FProdutoModel.ObterCodBarra(AValorpesquisa);
end;

function TProdutoControl.ObterProdDesc(AValorpesquisa: string): TFDQuery;
begin
  Result := FProdutoModel.ObterProdDesc(AValorpesquisa);
end;

function TProdutoControl.Salvar: Boolean;
begin
  Result := FProdutoModel.Salvar;
end;

end.
