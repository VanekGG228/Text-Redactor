unit ReplaceUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TReplaceForm = class(TForm)
    FindEditRep: TEdit;
    Label1: TLabel;
    ReplaceEdit: TEdit;
    Label2: TLabel;
    SelTExtCheckBox: TCheckBox;
    ReplaceButton: TButton;
    procedure ReplaceButtonClick(Sender: TObject);
    procedure ClearEdits;
  private
    { Private declarations }
  public
    Find: string;
    ReplaceStr: string;
    Check: boolean;
  end;

var
  ReplaceForm: TReplaceForm;

implementation

{$R *.dfm}

procedure TReplaceForm.ClearEdits;
begin
  FindEditRep.Clear;
  ReplaceEdit.Clear;
end;

procedure TReplaceForm.ReplaceButtonClick(Sender: TObject);
begin
  if FindEditRep.Text <> '' then
  begin
    Find := FindEditRep.Text;
    ReplaceStr := ReplaceEdit.Text;
    Check:=SelTExtCheckBox.Checked;
    ModalResult := mrYes;
  end
  else
    ShowMessage('Поле найти должно быть заполнено');
end;

end.
