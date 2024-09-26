unit Window;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm4 = class(TForm)
    SAveButton: TButton;
    UndoF4Button: TButton;
    NotSaveButton: TButton;
    SAveLabel: TLabel;
    procedure SAveButtonClick(Sender: TObject);
    procedure NotSaveButtonClick(Sender: TObject);
    procedure UndoF4ButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    Click: integer;
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

procedure TForm4.NotSaveButtonClick(Sender: TObject);
begin
  Click := 1;
  ModalResult := mrOk;
end;

procedure TForm4.SAveButtonClick(Sender: TObject);
begin
  Click := 2;
  ModalResult := mrOk;
end;

procedure TForm4.UndoF4ButtonClick(Sender: TObject);
begin
  Click := 3;
  ModalResult := mrOk;
end;

end.
