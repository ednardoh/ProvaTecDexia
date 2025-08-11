unit uPrincipalVIEW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, Menus, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.ToolWin, VCLTee.TeCanvas, VCLTee.TeePenDlg, Vcl.ExtCtrls,
  System.ImageList, Vcl.ImgList;

type
  TfrmPrincipal = class(TForm)
    MainMenu_Principal: TMainMenu;
    Cadastros1: TMenuItem;
    Produtos1: TMenuItem;
    Vendas1: TMenuItem;
    PDV1: TMenuItem;
    Relatrios1: TMenuItem;
    Vendas2: TMenuItem;
    Sair1: TMenuItem;
    N2: TMenuItem;
    ReatriodeProdutos1: TMenuItem;
    pom_Relatorios: TPopupMenu;
    ReatriodeProdutos2: TMenuItem;
    N3: TMenuItem;
    RelatriodeVendasdirias1: TMenuItem;
    BalloonHint1: TBalloonHint;
    Panel1: TPanel;
    btnProdutos: TBitBtn;
    btnVendas: TBitBtn;
    btnSair: TBitBtn;
    btnRelatorios: TBitBtn;
    procedure Sair1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnRelatoriosClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure Produtos1Click(Sender: TObject);
    procedure btnProdutosClick(Sender: TObject);
    procedure PDV1Click(Sender: TObject);
    procedure btnVendasClick(Sender: TObject);
    procedure ReatriodeProdutos1Click(Sender: TObject);
    procedure ReatriodeProdutos2Click(Sender: TObject);
    procedure Vendas2Click(Sender: TObject);
    procedure RelatriodeVendasdirias1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    LCodigo,
    LNome,
    LCodBarra,
    LPrcProd : string;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses UConexaoBDpas, uConsultaFuncoesbasicasVIEW, uConsultaFuncbasprodutosVIEW,
  uConsultaFuncoesbasicasVendasVIEW, uRelProdutosVIEW, uRelVendasVIEW;

procedure TfrmPrincipal.btnProdutosClick(Sender: TObject);
begin
  Produtos1Click(Self);
end;

procedure TfrmPrincipal.btnRelatoriosClick(Sender: TObject);
begin
  pom_Relatorios.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

procedure TfrmPrincipal.btnSairClick(Sender: TObject);
begin
  close;
end;

procedure TfrmPrincipal.btnVendasClick(Sender: TObject);
begin
  PDV1Click(Self);
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Application.messageBox('Deseja Realmente sair do Sistema?','Confirmação',mb_YesNo+mb_IconInformation+mb_DefButton2) = IdYes then
    begin
      Application.Terminate;
    end
  else
    Action := canone;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  if not FileExists(pchar(ExtractFilePath(Application.ExeName) + 'ConfigDB.ini')) then
  begin
    frmConectaDB := TfrmConectaDB.create(Self);
    frmConectaDB.Showmodal;
    close;
  end;
end;

procedure TfrmPrincipal.PDV1Click(Sender: TObject);
begin
  frmConsultaFuncoesbasicasVendas := TfrmConsultaFuncoesbasicasVendas.create(Self);
  frmConsultaFuncoesbasicasVendas.ShowModal;
end;

procedure TfrmPrincipal.Produtos1Click(Sender: TObject);
begin
  frmConsFuncProdutos := TfrmConsFuncProdutos.create(Self);
  frmConsFuncProdutos.ShowModal;
end;

procedure TfrmPrincipal.ReatriodeProdutos1Click(Sender: TObject);
begin
  frmRelatorioDeProdutos := TfrmRelatorioDeProdutos.Create(Self);
  frmRelatorioDeProdutos.ShowModal;
end;

procedure TfrmPrincipal.ReatriodeProdutos2Click(Sender: TObject);
begin
  ReatriodeProdutos1Click(Self);
end;

procedure TfrmPrincipal.RelatriodeVendasdirias1Click(Sender: TObject);
begin
  Vendas2Click(Self);
end;

procedure TfrmPrincipal.Sair1Click(Sender: TObject);
begin
 close;
end;

procedure TfrmPrincipal.Vendas2Click(Sender: TObject);
begin
  frmRelatorioDeVendas :=TfrmRelatorioDeVendas.create(Self);
  frmRelatorioDeVendas.ShowModal;
end;

end.
