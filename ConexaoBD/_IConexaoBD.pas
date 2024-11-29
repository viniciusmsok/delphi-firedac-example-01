unit _IConexaoBD;

interface

uses
  System.Classes, _IQueryBD;

type
  IConexaoBD = interface
    procedure Conectar(
      const servidor: string;
      const porta: Integer;
      const banco: string;
      const usuario: string;
      const senha: string
    );

    function NovaQuery: IQueryBD;

    procedure AbrirTransacao(nome: string);
    procedure VoltarTransacao;
    procedure ConfirmarTransacao;
  end;

implementation

end.
