unit uVendasDAO;

interface

uses
  FireDAC.Comp.Client, uConexao, uVendasModel, System.SysUtils, uSistemaControl;

type
  TVendasDAO = class
    private
      FConexao: TConexao;
    public
      constructor Create;

      function Incluir(AVendasModel: TVendasModel): Boolean;
      function Alterar(AVendasModel: TVendasModel): Boolean;
      function Excluir(AVendasModel: TVendasModel): Boolean;
      function GetId: Integer;
      function Obter(AValorpesquisa: string): TFDQuery;
      function ObterComFiltro(AIndice: Integer; ACampo: string; AValorpesquisa: string): TFDQuery;

  end;

implementation

{ TVendasDAO }

constructor TVendasDAO.Create;
begin
  FConexao := TSistemaControl.GetInstance().Conexao;
end;

function TVendasDAO.GetId: Integer;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CriarQuery();
  try
    vQry.Open('SELECT coalesce(MAX(ID_VENDA),0)+1 AS ID_VENDA FROM TB_VENDAS');
    try
      Result := vQry.Fields[0].AsInteger;
    finally
      vQry.Close;
    end;
  finally
    vQry.Free;
  end;
end;

function TVendasDAO.Incluir(
  AVendasModel: TVendasModel): Boolean;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();
  try
    VQry.ExecSQL('insert into TB_VENDAS (ID_VENDA, ID_PRODUTO, NUM_VENDA, DATA_VENDA, QUANTIDADE, VALOR_UNITARIO, VALOR_TOTAL) values (:ID_VENDA, :ID_PRODUTO, :NUM_VENDA, :DATA_VENDA, :QUANTIDADE, :VALOR_UNITARIO, :VALOR_TOTAL)',
                  [
                    AVendasModel.ID,
                    AVendasModel.CODPRODUTO,
                    AVendasModel.NUMVENDA,
                    AVendasModel.DATAVENDA,
                    AVendasModel.QUANTIDADE,
                    AVendasModel.VALORUNITARIO,
                    AVendasModel.VALORTOTAL
                   ]
                  );

    Result := True;
  finally
    VQry.Free;
  end;
end;

function TVendasDAO.Alterar(
  AVendasModel: TVendasModel): Boolean;
var
  vQry: TFDQuery;
  sSql: string;
begin
  vQry := FConexao.CriarQuery();
  sSql :='';
  try
    sSql := 'UPDATE TB_VENDAS                                        '+
            'SET NUM_VENDA  = :NUM_VENDA                             '+
            '   ,DATA_VENDA = :DATA_VENDA                            '+
            '   ,QUANTIDADE = :QUANTIDADE                            '+
            '   ,VALOR_UNITARIO = :VALOR_UNITARIO                    '+
            '   ,VALOR_TOTAL = :VALOR_TOTAL                          '+
            'WHERE ID_VENDA = :ID_VENDA AND ID_PRODUTO = :ID_PRODUTO ';
    vQry.SQL.Add(sSql);
    vQry.Params.ParamByName('NUM_VENDA').AsInteger    := AVendasModel.NUMVENDA;
    vQry.Params.ParamByName('DATA_VENDA').AsDateTime  := AVendasModel.DATAVENDA;
    vQry.Params.ParamByName('QUANTIDADE').AsFloat     := AVendasModel.QUANTIDADE;
    vQry.Params.ParamByName('VALOR_UNITARIO').AsFloat := AVendasModel.VALORUNITARIO;
    vQry.Params.ParamByName('VALOR_TOTAL').AsFloat    := AVendasModel.VALORTOTAL;
    vQry.Params.ParamByName('ID_VENDA').AsInteger     := AVendasModel.ID;
    vQry.Params.ParamByName('ID_PRODUTO').AsString    := AVendasModel.CODPRODUTO;
    vQry.ExecSQL;
    Result := True;
  finally
    vQry.Free;
  end;
end;

function TVendasDAO.Excluir(
  AVendasModel: TVendasModel): Boolean;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();
  try
    VQry.ExecSQL('delete from TB_VENDAS where ID_VENDA=:ID AND ID_PRODUTO = :CODPRODUTO',
                  [AVendasModel.ID, AVendasModel.CODPRODUTO]);

    Result := True;
  finally
    VQry.Free;
  end;
end;

function TVendasDAO.Obter(AValorpesquisa: string): TFDQuery;
var
  VQry: TFDQuery;
begin
  VQry := FConexao.CriarQuery();
  VQry.Open('SELECT TV.ID_VENDA,                                '+
            '        TV.ID_PRODUTO,                             '+
            '        PR.DESCRICAO AS PRODUTO,                   '+
            '        TV.NUM_VENDA,                              '+
            '        TV.DATA_VENDA,                             '+
            '        TV.QUANTIDADE,                             '+
            '        TV.VALOR_UNITARIO,                         '+
            '        TV.VALOR_TOTAL                             '+
            'from TB_VENDAS TV                                  '+
            'INNER JOIN TB_PRODUTOS PR ON PR.ID = TV.ID_PRODUTO '+
            'ORDER BY 1');
  Result := VQry;
end;

function TVendasDAO.ObterComFiltro(AIndice: Integer; ACampo,
  AValorpesquisa: string): TFDQuery;
var
  vQry: TFDQuery;
  sSql: string;
begin
  vQry := FConexao.CriarQuery();
  sSql := '';
  sSql := sSql + 'SELECT TV.ID_VENDA,                                 '+
                 '       TV.ID_PRODUTO,                               '+
                 '	     PR.DESCRICAO AS PRODUTO,                     '+
                 '	     TV.NUM_VENDA,                                '+
                 '	     TV.DATA_VENDA,                               '+
                 '	     TV.QUANTIDADE,                               '+
                 '	     TV.VALOR_UNITARIO,                           '+
                 '	     TV.VALOR_TOTAL                               '+
                 'from TB_VENDAS TV                                   '+
                 'INNER JOIN TB_PRODUTOS PR ON PR.ID = TV.ID_PRODUTO  '+
                 'WHERE TV.'+ ACampo + ' ';


  case AIndice of
    0: sSql := sSql + '> '+ QuotedStr(AValorpesquisa);
    1: sSql := sSql + '< '+ QuotedStr(AValorpesquisa);
    2: sSql := sSql + '= '+ QuotedStr(AValorpesquisa);
    3: sSql := sSql + '>= '+ QuotedStr(AValorpesquisa);
    4: sSql := sSql + '<= '+ QuotedStr(AValorpesquisa);
    5: sSql := sSql + 'LIKE ' + QuotedStr(AValorpesquisa + '%');
    6: sSql := sSql + 'LIKE ' + QuotedStr('%' + AValorpesquisa);
    7: sSql := sSql + 'LIKE ' + QuotedStr('%' + AValorpesquisa + '%');
  end;

  vQry.SQL.Add(sSql);
  vQry.Open();

  Result := vQry;
end;

end.
