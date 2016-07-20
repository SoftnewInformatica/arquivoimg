program Arquivos;

uses
  Vcl.Forms,
  UFrmArquivos in 'UFrmArquivos.pas' {FrmArquivos};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmArquivos, FrmArquivos);
  Application.Run;
end.
