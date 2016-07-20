unit UFrmArquivos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, System.ImageList,
  Vcl.ImgList, Vcl.StdCtrls, Vcl.FileCtrl, FlCtrlEx, System.Actions,
  Vcl.ActnList, Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan, Vcl.ComCtrls,
  Vcl.ToolWin,System.StrUtils,IniFiles;

type
  TFrmArquivos = class(TForm)
    ScrollBox1: TScrollBox;
    ScrollBox2: TScrollBox;
    ActionManager: TActionManager;
    AcClose: TAction;
    EdCodigo: TEdit;
    EdNome: TEdit;
    edlab: TLabel;
    Label1: TLabel;
    FileListBoxEx: TFileListBoxEx;
    ImgPrincipal: TImageList;
    EdTexto: TEdit;
    Label2: TLabel;
    SpeedButton6: TSpeedButton;
    AcArquivo: TAction;
    AcDelete: TAction;
    ToolBar: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton4: TToolButton;
    ToolButton3: TToolButton;
    OpenDialog: TOpenDialog;
    ToolButton5: TToolButton;
    AcSalvar: TAction;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    AcAtualizar: TAction;
    procedure AcCloseExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AcArquivoExecute(Sender: TObject);
    procedure AcSalvarExecute(Sender: TObject);
    procedure AcAtualizarExecute(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    ConfigIni  : TIniFile;
    vCaminho  :string;
    ArquivoOriginal,vMontarC  :string;
  end;

var
  FrmArquivos: TFrmArquivos;

implementation

{$R *.dfm}

procedure TFrmArquivos.AcArquivoExecute(Sender: TObject);
begin
 if OpenDialog.Execute then Begin
     ArquivoOriginal:=OpenDialog.FileName;
  End;
end;

procedure TFrmArquivos.AcAtualizarExecute(Sender: TObject);
begin
 try
  //FileListBoxEx.Mask:='*.DOCX';
  FileListBoxEx.Directory:= vMontarC;
 Except
   ShowMessage('Houve um erro. O caminho não existe, verifique o diretório > '+vCaminho);
 end;
end;

procedure TFrmArquivos.AcCloseExecute(Sender: TObject);
begin
 Close;
end;

procedure TFrmArquivos.AcSalvarExecute(Sender: TObject);
var
 //ArqOrig,ArqDest  : PWideChar;
 vNomeArq:string;
begin

 vMontarC :=vCaminho+'Arquivos\'+EdCodigo.Text+'\';
 ShowMessage(vMontarC);
 vNomeArq :=ExtractFileName(ArquivoOriginal);
 ShowMessage(vNomeArq);

 if not DirectoryExists(vMontarC) then
        ForceDirectories(vMontarC);

 vMontarC:=vMontarC+vNomeArq;

 try
  //CopyFile(pc ArqOrig,ArqDest, True);
  CopyFile(pChar(ArquivoOriginal),pChar(vMontarC),True);
 except on E: Exception do
   ShowMessage(e.Message);
 end;

end;

procedure TFrmArquivos.FormShow(Sender: TObject);
begin
  try
    ConfigIni := TIniFile.Create(ExtractFilePath(ParamStr(0))+'Config.ini');
    vCaminho  :=  ConfigIni.ReadString('ATUALIZACAO','PATH','');
    vCaminho :=Copy(vCaminho,1,Length(vCaminho)-11);
    ShowMessage(vCaminho);
    if not DirectoryExists(vCaminho+'Arquivos') then
           ForceDirectories(vCaminho+'Arquivos');
  except on E: Exception do
    ShowMessage('erro ao abrir config.ini');
  end;
end;

end.
