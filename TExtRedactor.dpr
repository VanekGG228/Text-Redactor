program TExtRedactor;

uses
  Vcl.Forms,
  Redactor in 'Redactor.pas' {Form2},
  HashTable in 'HashTable.pas',
  Compare in 'Compare.pas' {Form3},
  Window in 'Window.pas' {Form4},
  ReplaceUnit in 'ReplaceUnit.pas' {ReplaceForm},
  INfo in 'INfo.pas' {InfoForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TReplaceForm, ReplaceForm);
  Application.CreateForm(TInfoForm, InfoForm);
  Application.Run;
end.
