unit uConsultaFuncbasProdutosVIEW;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uConsultaFuncoesbasicasVIEW,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Datasnap.Provider, Data.DB,
  Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, uProdutoControl, uEnumerado;

type
  TfrmConsFuncProdutos = class(TfrmConsultaFuncoesbasicas)
    TB_Produtos: TClientDataSet;
    TB_ProdutosID: TIntegerField;
    TB_ProdutosCODIGO_BAR: TStringField;
    TB_ProdutosDESCRICAO: TStringField;
    TB_ProdutosPRECO_COMPRA: TFMTBCDField;
    TB_ProdutosPRECO_VENDA: TFMTBCDField;
    TB_ProdutosQTD_ESTOQUE: TFMTBCDField;
    ds_CadProdutos: TDataSource;
    DSP_Produtos: TDataSetProvider;
    DBG_ConsProd: TDBGrid;
    procedure btnTodosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
  private
    { Private declarations }
    Produtos: TProdutoControl;
    ATipo: TAcao;
    procedure ConsultaTodosProdutos;
  public
    { Public declarations }
  end;

var
  frmConsFuncProdutos: TfrmConsFuncProdutos;

implementation

{$R *.dfm}

uses ManutencaoFbasprodutosVIEW;

procedure TfrmConsFuncProdutos.btnAlterarClick(Sender: TObject);
begin
  inherited;
  //Tabela está vazia
  if TB_Produtos.RecordCount = 0 then
  begin
    messagedlg('A consulta está vazia, selecione um registro!',mtError,[mbok],0);
    Exit;
  end
  else
  begin
    frmManutencaoFuncbasProdutos :=TfrmManutencaoFuncbasProdutos.create(Self);
    frmManutencaoFuncbasProdutos.pnl_ConsFiltro.Visible := False;
    frmManutencaoFuncbasProdutos.pnl_Client.Visible     := True;
    frmManutencaoFuncbasProdutos.sAcao := 'Edit';
    frmManutencaoFuncbasProdutos.Caption := 'Manutenção - Funções básicas - Produtos [Alterando]';
    frmManutencaoFuncbasProdutos.ConfiguraBotoes(False, True, True, True);
    frmManutencaoFuncbasProdutos.TB_Produtos.CreateDataSet;
    frmManutencaoFuncbasProdutos.TB_Produtos.Insert;
    frmManutencaoFuncbasProdutos.TB_ProdutosID.AsInteger         := TB_ProdutosID.AsInteger;
    frmManutencaoFuncbasProdutos.TB_ProdutosCODIGO_BAR.AsString  := TB_ProdutosCODIGO_BAR.AsString;
    frmManutencaoFuncbasProdutos.TB_ProdutosDESCRICAO.AsString   := TB_ProdutosDESCRICAO.AsString;
    frmManutencaoFuncbasProdutos.TB_ProdutosPRECO_COMPRA.AsFloat := TB_ProdutosPRECO_COMPRA.AsFloat;
    frmManutencaoFuncbasProdutos.TB_ProdutosPRECO_VENDA.AsFloat  := TB_ProdutosPRECO_VENDA.AsFloat;
    frmManutencaoFuncbasProdutos.TB_ProdutosQTD_ESTOQUE.AsFloat  := TB_ProdutosQTD_ESTOQUE.AsFloat;
    frmManutencaoFuncbasProdutos.TB_Produtos.Post;
    frmManutencaoFuncbasProdutos.TB_Produtos.Edit;
    frmManutencaoFuncbasProdutos.ShowModal;
  end;
end;

procedure TfrmConsFuncProdutos.btnConsultarClick(Sender: TObject);
begin
  inherited;
  if TB_Produtos.RecordCount = 0 then
  begin
    messagedlg('A consulta está vazia, selecione um registro!',mtError,[mbok],0);
    Exit;
  end
  else
  begin
    frmManutencaoFuncbasProdutos :=TfrmManutencaoFuncbasProdutos.create(Self);
    frmManutencaoFuncbasProdutos.pnl_ConsFiltro.Visible := False;
    frmManutencaoFuncbasProdutos.pnl_Client.Visible     := True;
    frmManutencaoFuncbasProdutos.sAcao := 'Consultar';
    frmManutencaoFuncbasProdutos.Caption := 'Manutenção - Funções básicas - Produtos [Consultando]';
    frmManutencaoFuncbasProdutos.ConfiguraBotoes(True, False, False, True);
    frmManutencaoFuncbasProdutos.ConfiguraCampos;
    frmManutencaoFuncbasProdutos.ShowModal;
  end;
end;

procedure TfrmConsFuncProdutos.btnExcluirClick(Sender: TObject);
begin
  inherited;
  if TB_Produtos.RecordCount = 0 then
  begin
    messagedlg('A consulta está vazia, selecione um registro!',mtError,[mbok],0);
    Exit;
  end
  else
  begin
    frmManutencaoFuncbasProdutos :=TfrmManutencaoFuncbasProdutos.create(Self);
    frmManutencaoFuncbasProdutos.pnl_ConsFiltro.Visible := False;
    frmManutencaoFuncbasProdutos.pnl_Client.Visible     := True;
    frmManutencaoFuncbasProdutos.sAcao := 'Delete';
    frmManutencaoFuncbasProdutos.Caption := 'Manutenção - Funções básicas - Produtos [Excluindo]';
    frmManutencaoFuncbasProdutos.ConfiguraBotoes(False, False, True, True);
    frmManutencaoFuncbasProdutos.TB_Produtos.CreateDataSet;
    frmManutencaoFuncbasProdutos.TB_Produtos.Insert;
    frmManutencaoFuncbasProdutos.TB_ProdutosID.AsInteger         := TB_ProdutosID.AsInteger;
    frmManutencaoFuncbasProdutos.TB_ProdutosCODIGO_BAR.AsString  := TB_ProdutosCODIGO_BAR.AsString;
    frmManutencaoFuncbasProdutos.TB_ProdutosDESCRICAO.AsString   := TB_ProdutosDESCRICAO.AsString;
    frmManutencaoFuncbasProdutos.TB_ProdutosPRECO_COMPRA.AsFloat := TB_ProdutosPRECO_COMPRA.AsFloat;
    frmManutencaoFuncbasProdutos.TB_ProdutosPRECO_VENDA.AsFloat  := TB_ProdutosPRECO_VENDA.AsFloat;
    frmManutencaoFuncbasProdutos.TB_ProdutosQTD_ESTOQUE.AsFloat  := TB_ProdutosQTD_ESTOQUE.AsFloat;
    frmManutencaoFuncbasProdutos.TB_Produtos.Post;
    frmManutencaoFuncbasProdutos.ShowModal;
  end;
end;

procedure TfrmConsFuncProdutos.btnFiltrarClick(Sender: TObject);
begin
  inherited;
  frmManutencaoFuncbasProdutos :=TfrmManutencaoFuncbasProdutos.create(Self);
  frmManutencaoFuncbasProdutos.pnl_ConsFiltro.Visible := True;
  frmManutencaoFuncbasProdutos.pnl_Client.Visible     := False;
  frmManutencaoFuncbasProdutos.sAcao := 'Filtrar';
  frmManutencaoFuncbasProdutos.Caption := 'Manutenção - Funções básicas - Produtos [Filtrando]';
  frmManutencaoFuncbasProdutos.ConfiguraBotoes(False, False, True, True);
  frmManutencaoFuncbasProdutos.TB_Produtos.CreateDataSet;
  frmManutencaoFuncbasProdutos.ShowModal;
end;

procedure TfrmConsFuncProdutos.btnIncluirClick(Sender: TObject);
begin
  inherited;
  frmManutencaoFuncbasProdutos :=TfrmManutencaoFuncbasProdutos.create(Self);
  frmManutencaoFuncbasProdutos.pnl_ConsFiltro.Visible := False;
  frmManutencaoFuncbasProdutos.pnl_Client.Visible     := True;
  frmManutencaoFuncbasProdutos.sAcao := 'Insert';
  frmManutencaoFuncbasProdutos.Caption := 'Manutenção - Funções básicas - Produtos [Inserindo]';
  frmManutencaoFuncbasProdutos.ConfiguraBotoes(False, False, True, True);
  frmManutencaoFuncbasProdutos.TB_Produtos.CreateDataSet;
  frmManutencaoFuncbasProdutos.TB_Produtos.Insert;
  frmManutencaoFuncbasProdutos.ShowModal;
end;

procedure TfrmConsFuncProdutos.btnTodosClick(Sender: TObject);
begin
  inherited;
  ConsultaTodosProdutos;
end;

procedure TfrmConsFuncProdutos.ConsultaTodosProdutos;
begin
  try
    TB_Produtos.Close;
    Produtos:= TProdutoControl.Create;
    DSP_Produtos.DataSet := Produtos.Obter(1,'');
    TB_Produtos.close;
    TB_Produtos.Open;
  finally
    Produtos.Free;
  end;
end;

procedure TfrmConsFuncProdutos.FormCreate(Sender: TObject);
begin
  inherited;
  TB_Produtos.CreateDataSet;
end;

end.
