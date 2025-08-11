unit ManutencaoFcoesbasicasVIEW;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.DBCtrls;

type
  TfrmManutencaoFuncoesbasicas = class(TForm)
    pnl_Client: TPanel;
    pnl_Right: TPanel;
    btnRestaurar: TBitBtn;
    btnSalvar: TBitBtn;
    btnSair: TBitBtn;
    dbn_Dados: TDBNavigator;
    procedure btnSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmManutencaoFuncoesbasicas: TfrmManutencaoFuncoesbasicas;

implementation

{$R *.dfm}

procedure TfrmManutencaoFuncoesbasicas.btnSairClick(Sender: TObject);
begin
  close;
end;

procedure TfrmManutencaoFuncoesbasicas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := cafree;
end;

end.
