unit uConsultaFuncoesbasicasVendasVIEW;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uConsultaFuncoesbasicasVIEW,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Datasnap.Provider, Datasnap.DBClient, uVendasControl, uEnumerado;

type
  TfrmConsultaFuncoesbasicasVendas = class(TfrmConsultaFuncoesbasicas)
    DBG_ConsVenda: TDBGrid;
    TB_Vendas: TClientDataSet;
    DSP_Vendas: TDataSetProvider;
    ds_CadVendas: TDataSource;
    TB_VendasID_VENDA: TIntegerField;
    TB_VendasID_PRODUTO: TIntegerField;
    TB_VendasPRODUTO: TStringField;
    TB_VendasNUM_VENDA: TIntegerField;
    TB_VendasDATA_VENDA: TSQLTimeStampField;
    TB_VendasQUANTIDADE: TIntegerField;
    TB_VendasVALOR_UNITARIO: TFMTBCDField;
    TB_VendasVALOR_TOTAL: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
    procedure btnTodosClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
  private
    { Private declarations }
    Vendas: TVendasControl;
    ATipo: TAcao;
    procedure ConsultaTodasVendas;
  public
    { Public declarations }
  end;

var
  frmConsultaFuncoesbasicasVendas: TfrmConsultaFuncoesbasicasVendas;

implementation

{$R *.dfm}

uses ManutencaoFcoesbasicasVendasVIEW;

procedure TfrmConsultaFuncoesbasicasVendas.btnAlterarClick(Sender: TObject);
begin
  inherited;
  //Tabela está vazia
  if TB_Vendas.RecordCount = 0 then
  begin
    messagedlg('A consulta está vazia, selecione um registro!',mtError,[mbok],0);
    Exit;
  end
  else
  begin
    frmManutencaoFuncoesbasicasVendas :=TfrmManutencaoFuncoesbasicasVendas.create(Self);
    frmManutencaoFuncoesbasicasVendas.pnl_ConsFiltro.Visible := False;
    frmManutencaoFuncoesbasicasVendas.pnl_Client.Visible     := True;
    frmManutencaoFuncoesbasicasVendas.sAcao := 'Edit';
    frmManutencaoFuncoesbasicasVendas.Caption := 'Manutenção - Funções básicas - Vendas [Alterando]';
    frmManutencaoFuncoesbasicasVendas.ConfiguraBotoes(False, True, True, True);
    frmManutencaoFuncoesbasicasVendas.TB_Vendas.CreateDataSet;
    frmManutencaoFuncoesbasicasVendas.TB_Vendas.Insert;
    frmManutencaoFuncoesbasicasVendas.TB_VendasID_VENDA.AsInteger     := TB_VendasID_VENDA.AsInteger;
    frmManutencaoFuncoesbasicasVendas.TB_VendasID_PRODUTO.AsString    := TB_VendasID_PRODUTO.AsString;
    frmManutencaoFuncoesbasicasVendas.TB_VendasNUM_VENDA.AsString     := TB_VendasNUM_VENDA.AsString;
    frmManutencaoFuncoesbasicasVendas.TB_VendasDATA_VENDA.AsDateTime  := TB_VendasDATA_VENDA.AsDateTime;
    frmManutencaoFuncoesbasicasVendas.TB_VendasQUANTIDADE.AsFloat     := TB_VendasQUANTIDADE.AsFloat;
    frmManutencaoFuncoesbasicasVendas.TB_VendasVALOR_UNITARIO.AsFloat := TB_VendasVALOR_UNITARIO.AsFloat;
    frmManutencaoFuncoesbasicasVendas.TB_VendasVALOR_TOTAL.AsFloat    := TB_VendasVALOR_TOTAL.AsFloat;
    frmManutencaoFuncoesbasicasVendas.TB_Vendas.Post;
    frmManutencaoFuncoesbasicasVendas.TB_Vendas.Edit;
    frmManutencaoFuncoesbasicasVendas.ShowModal;
  end;
end;

procedure TfrmConsultaFuncoesbasicasVendas.btnConsultarClick(Sender: TObject);
begin
  inherited;
  if TB_Vendas.RecordCount = 0 then
  begin
    messagedlg('A consulta está vazia, selecione um registro!',mtError,[mbok],0);
    Exit;
  end
  else
  begin
    frmManutencaoFuncoesbasicasVendas :=TfrmManutencaoFuncoesbasicasVendas.create(Self);
    frmManutencaoFuncoesbasicasVendas.pnl_ConsFiltro.Visible := False;
    frmManutencaoFuncoesbasicasVendas.pnl_Client.Visible     := True;
    frmManutencaoFuncoesbasicasVendas.sAcao := 'Consultar';
    frmManutencaoFuncoesbasicasVendas.Caption := 'Manutenção - Funções básicas - Vendas [Consultando]';
    frmManutencaoFuncoesbasicasVendas.ConfiguraBotoes(True, False, False, True);
    frmManutencaoFuncoesbasicasVendas.ConfiguraCampos;
    frmManutencaoFuncoesbasicasVendas.ShowModal;
  end;
end;

procedure TfrmConsultaFuncoesbasicasVendas.btnExcluirClick(Sender: TObject);
begin
  inherited;
  //Tabela está vazia
  if TB_Vendas.RecordCount = 0 then
  begin
    messagedlg('A consulta está vazia, selecione um registro!',mtError,[mbok],0);
    Exit;
  end
  else
  begin
    frmManutencaoFuncoesbasicasVendas :=TfrmManutencaoFuncoesbasicasVendas.create(Self);
    frmManutencaoFuncoesbasicasVendas.pnl_ConsFiltro.Visible := False;
    frmManutencaoFuncoesbasicasVendas.pnl_Client.Visible     := True;
    frmManutencaoFuncoesbasicasVendas.sAcao := 'Delete';
    frmManutencaoFuncoesbasicasVendas.Caption := 'Manutenção - Funções básicas - Vendas [Excluindo]';
    frmManutencaoFuncoesbasicasVendas.ConfiguraBotoes(False, False, True, True);
    frmManutencaoFuncoesbasicasVendas.TB_Vendas.CreateDataSet;
    frmManutencaoFuncoesbasicasVendas.TB_Vendas.Insert;
    frmManutencaoFuncoesbasicasVendas.TB_VendasID_VENDA.AsInteger     := TB_VendasID_VENDA.AsInteger;
    frmManutencaoFuncoesbasicasVendas.TB_VendasID_PRODUTO.AsString    := TB_VendasID_PRODUTO.AsString;
    frmManutencaoFuncoesbasicasVendas.TB_VendasNUM_VENDA.AsString     := TB_VendasNUM_VENDA.AsString;
    frmManutencaoFuncoesbasicasVendas.TB_VendasDATA_VENDA.AsDateTime  := TB_VendasDATA_VENDA.AsDateTime;
    frmManutencaoFuncoesbasicasVendas.TB_VendasQUANTIDADE.AsFloat     := TB_VendasQUANTIDADE.AsFloat;
    frmManutencaoFuncoesbasicasVendas.TB_VendasVALOR_UNITARIO.AsFloat := TB_VendasVALOR_UNITARIO.AsFloat;
    frmManutencaoFuncoesbasicasVendas.TB_VendasVALOR_TOTAL.AsFloat    := TB_VendasVALOR_TOTAL.AsFloat;
    frmManutencaoFuncoesbasicasVendas.TB_Vendas.Post;
    frmManutencaoFuncoesbasicasVendas.ShowModal;
  end;
end;

procedure TfrmConsultaFuncoesbasicasVendas.btnFiltrarClick(Sender: TObject);
begin
  inherited;
  frmManutencaoFuncoesbasicasVendas :=TfrmManutencaoFuncoesbasicasVendas.create(Self);
  frmManutencaoFuncoesbasicasVendas.pnl_ConsFiltro.Visible := True;
  frmManutencaoFuncoesbasicasVendas.pnl_Client.Visible     := False;
  frmManutencaoFuncoesbasicasVendas.sAcao := 'Filtrar';
  frmManutencaoFuncoesbasicasVendas.Caption := 'Manutenção - Funções básicas - Vendas [Filtrando]';
  frmManutencaoFuncoesbasicasVendas.ConfiguraBotoes(False, False, True, True);
  frmManutencaoFuncoesbasicasVendas.TB_Vendas.CreateDataSet;
  frmManutencaoFuncoesbasicasVendas.ShowModal;
end;

procedure TfrmConsultaFuncoesbasicasVendas.btnIncluirClick(Sender: TObject);
begin
  inherited;
  frmManutencaoFuncoesbasicasVendas :=TfrmManutencaoFuncoesbasicasVendas.create(Self);
  frmManutencaoFuncoesbasicasVendas.pnl_ConsFiltro.Visible := False;
  frmManutencaoFuncoesbasicasVendas.pnl_Client.Visible     := True;
  frmManutencaoFuncoesbasicasVendas.sAcao := 'Insert';
  frmManutencaoFuncoesbasicasVendas.Caption := 'Manutenção - Funções básicas - Vendas [Inserindo]';
  frmManutencaoFuncoesbasicasVendas.ConfiguraBotoes(False, False, True, True);
  frmManutencaoFuncoesbasicasVendas.TB_Vendas.CreateDataSet;
  frmManutencaoFuncoesbasicasVendas.TB_Vendas.Insert;
  frmManutencaoFuncoesbasicasVendas.ShowModal;
end;

procedure TfrmConsultaFuncoesbasicasVendas.btnTodosClick(Sender: TObject);
begin
  inherited;
  ConsultaTodasVendas;
end;

procedure TfrmConsultaFuncoesbasicasVendas.ConsultaTodasVendas;
begin
  try
    TB_Vendas.Close;
    Vendas:= TVendasControl.Create;
    DSP_Vendas.DataSet := Vendas.Obter('');
    TB_Vendas.close;
    TB_Vendas.Open;
  finally
    Vendas.Free;
  end;
end;

procedure TfrmConsultaFuncoesbasicasVendas.FormCreate(Sender: TObject);
begin
  inherited;
  TB_Vendas.CreateDataSet;
end;

end.
