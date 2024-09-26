unit Redactor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ExtCtrls, System.Generics.Collections, Vcl.Buttons, HashTable, Compare,
  Window, ReplaceUnit, Math, Info,
  System.ImageList, Vcl.ImgList, Vcl.ToolWin, System.Actions, Vcl.ActnList;

type
  TForm2 = class(TForm)
    MainMenu1: TMainMenu;
    FileProp: TMenuItem;
    OpenBtn: TMenuItem;
    SaveAS: TMenuItem;
    ExitButton: TMenuItem;
    N5: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    FontDialog1: TFontDialog;
    Undo: TMenuItem;
    CompareUnitButton: TMenuItem;
    panelForFunctions: TPanel;
    resultShingles: TLabel;
    ColorBox1: TColorBox;
    FontSizeEdit1: TEdit;
    UpDown1: TUpDown;
    FontButton1: TButton;
    NumberSignsEdit1: TEdit;
    UpDown2: TUpDown;
    SignsNumber: TButton;
    ToolBar1: TToolBar;
    BoldButton1: TButton;
    ItalicButton1: TButton;
    UnderlineButton1: TButton;
    ImageListBtn: TImageList;
    ToolBar3: TToolBar;
    LeftJustifyButton1: TButton;
    CenterJustifyButton1: TButton;
    RightJustifyButton1: TButton;
    CreateNew: TMenuItem;
    Save: TMenuItem;
    CopyBtn: TMenuItem;
    InsertBtn: TMenuItem;
    CutBtn: TMenuItem;
    SelectAllBtn: TMenuItem;
    FindLabel: TLabel;
    FindEdit: TEdit;
    FindButton: TButton;
    ToolBar2: TToolBar;
    ActionList1: TActionList;
    Action1: TAction;
    UndoButton1: TButton;
    CopyButton1: TButton;
    PasteButton: TButton;
    CutButton: TButton;
    SelectButton: TButton;
    RichEdit1: TRichEdit;
    RulerPanel: TPanel;
    SizePanel2: TPanel;
    sizepanel: TPanel;
    Splitter1: TSplitter;
    LeftIndentPanel: TPanel;
    Splitter2: TSplitter;
    SizeRightPanel: TPanel;
    SizePanelLeft: TPanel;
    RightIndentPanel: TPanel;
    RightSplitter: TSplitter;
    ReplaceButton: TButton;
    PlagButton: TButton;
    ForFileRichEdit: TRichEdit;
    SettingsButton: TButton;
    ComboShingles: TComboBox;
    iNFOBtn: TMenuItem;
    procedure OpenBtnClick(Sender: TObject);
    procedure SaveASClick(Sender: TObject);
    procedure BoldButton1Click(Sender: TObject);
    procedure ItalicButton1Click(Sender: TObject);
    procedure UnderlineButton1Click(Sender: TObject);
    procedure LeftJustifyButton1Click(Sender: TObject);
    procedure CenterJustifyButton1Click(Sender: TObject);
    procedure RightJustifyButton1Click(Sender: TObject);
    procedure FontButton1Click(Sender: TObject);
    procedure UndoClick(Sender: TObject);
    procedure SignsNumberClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CompareUnitButtonClick(Sender: TObject);
    procedure ColorBox1Select(Sender: TObject);
    procedure CreateNewClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure SaveClick(Sender: TObject);
    procedure CopyBtnClick(Sender: TObject);
    procedure InsertBtnClick(Sender: TObject);
    procedure SelectAllBtnClick(Sender: TObject);
    procedure CutBtnClick(Sender: TObject);
    procedure SAveFile;
    procedure FontSizeEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure UpDown1Changing(Sender: TObject; var AllowChange: Boolean);
    procedure NumberSignsEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure FindButtonClick(Sender: TObject);
    procedure FindEditKeyPress(Sender: TObject; var Key: Char);
    procedure Splitter1Moved(Sender: TObject);
    procedure RichEdit1SelectionChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ReplaceButtonClick(Sender: TObject);
    procedure PlagButtonClick(Sender: TObject);
    procedure SettingsButtonClick(Sender: TObject);
    procedure ComboShinglesSelect(Sender: TObject);
    procedure iNFOBtnClick(Sender: TObject);
  private
    F: string;
    LeftInden: integer;
    firstInden: integer;
    PlagFile: string;
  public
    { Public declarations }
  end;

Type
  DinMAss = array of integer;
  ArrOfStr = array of string;
  ArrOfNUms = array of integer;
  Matrix = array of array of integer;

var
  Form2: TForm2;

implementation

{$R *.dfm}

const
  Special = ['"', '"', ',', '.', ':', '$', '#', '(', ')', ' ', '-', ':', ';'];

procedure TForm2.BoldButton1Click(Sender: TObject);
begin
  if not(fsbold in RichEdit1.SelAttributes.Style) then
  begin
    RichEdit1.SelAttributes.Style := RichEdit1.SelAttributes.Style + [fsbold];
    BoldButton1.ImageIndex := 1;
  end
  else
  begin
    RichEdit1.SelAttributes.Style := RichEdit1.SelAttributes.Style - [fsbold];
    BoldButton1.ImageIndex := -1;
  end;

end;

procedure TForm2.UnderlineButton1Click(Sender: TObject);
begin
  if not(fsUnderLine in RichEdit1.SelAttributes.Style) then
  begin
    RichEdit1.SelAttributes.Style := RichEdit1.SelAttributes.Style +
      [fsUnderLine];
    UnderlineButton1.ImageIndex := 1;
  end
  else
  begin
    RichEdit1.SelAttributes.Style := RichEdit1.SelAttributes.Style -
      [fsUnderLine];
    UnderlineButton1.ImageIndex := -1;
  end;
end;

procedure TForm2.CenterJustifyButton1Click(Sender: TObject);
begin
  RichEdit1.Paragraph.Alignment := taCenter;
end;

procedure TForm2.FindButtonClick(Sender: TObject);
var
  posit: integer;
  s1, pattern: string;
begin
  s1 := RichEdit1.Text;
  pattern := FindEdit.Text;
  posit := RichEdit1.FindText(pattern, 1, length(s1), [stMatchCase]);
  if posit <> -1 then
  begin
    RichEdit1.SelStart := posit;
    RichEdit1.SelLength := length(FindEdit.Text);
    RichEdit1.SetFocus;
  end
  else
    ShowMessage('Данных слов не найдено');
end;

procedure TForm2.FindEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    FindButtonClick(Sender);
  end;
end;

procedure TForm2.FontButton1Click(Sender: TObject);
begin
  if FontDialog1.Execute then
    RichEdit1.SelAttributes.Assign(FontDialog1.Font);
  RichEdit1.SetFocus;
end;

procedure TForm2.FontSizeEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    RichEdit1.SelAttributes.Size := StrToInt(FontSizeEdit1.Text);
  end;
end;

procedure TForm2.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin

  if RichEdit1.Modified then
  begin
    Form4.ShowModal;
    CanClose := true;
    if Form4.CLick = 2 then
      SAveFile;
    if Form4.CLick = 3 then
    begin
      CanClose := false;
    end;
  end
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  RichEdit1.Font.Size := 14;
  firstInden := Splitter1.Left;
  LeftInden := sizepanel.Width - Splitter2.Left;
  RichEdit1.Paragraph.FirstIndent := 3 * firstInden div 5;
  RichEdit1.Paragraph.LeftIndent := -3 * LeftInden div 5;
  RichEdit1.Paragraph.RightIndent := 3 * (RichEdit1.Width - RightSplitter.Left)
    div 5 + 1;
  OpenDialog1.Filter := 'RTF Files |*.rtf';
  SaveDialog1.Filter := 'RTF Files |*.rtf';
  RichEdit1.Modified := false;
  PlagFile := ExtractFilePath(Application.ExeName) + 'ForPlagiat.rtf';
end;

procedure TForm2.iNFOBtnClick(Sender: TObject);
begin
  Infoform.Show;
end;

procedure TForm2.InsertBtnClick(Sender: TObject);
begin
  RichEdit1.PasteFromClipboard;
end;

procedure TForm2.ItalicButton1Click(Sender: TObject);
begin
  if not(fsItalic in RichEdit1.SelAttributes.Style) then
  begin
    RichEdit1.SelAttributes.Style := RichEdit1.SelAttributes.Style + [fsItalic];
    ItalicButton1.ImageIndex := 1;
  end
  else
  begin
    RichEdit1.SelAttributes.Style := RichEdit1.SelAttributes.Style - [fsItalic];
    ItalicButton1.ImageIndex := -1;
  end;
end;

procedure TForm2.LeftJustifyButton1Click(Sender: TObject);
begin
  RichEdit1.Paragraph.Alignment := taLEftjustify;
end;

procedure TForm2.NumberSignsEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    SignsNumberClick(Sender);
  end;
end;

procedure TForm2.OpenBtnClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    RichEdit1.Lines.LoadFromFile(OpenDialog1.Filename);
    F := OpenDialog1.Filename;
  end;
  RichEdit1.Modified := false;

end;

procedure TForm2.PlagButtonClick(Sender: TObject);
var
  res: extended;
  str: ansistring;
begin
  ForFileRichEdit.Lines.LoadFromFile(PlagFile);
  str := ForFileRichEdit.Text;
  res := Form3.Count(Form3.Shingles(RichEdit1.Text, Form3.NumberShingles), str,
    Form3.NumberShingles);
  ShowMessage(FloatToStr(RoundTo(100 - res, -2)));
end;

procedure TForm2.SaveASClick(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    RichEdit1.Lines.SaveToFile(SaveDialog1.Filename + 'rtf');
    F := SaveDialog1.Filename + 'rtf';
    RichEdit1.Modified := false;
  end;

end;

procedure TForm2.SAveFile;
begin
  if F = '' then
  begin
    if SaveDialog1.Execute then
    begin
      RichEdit1.Lines.SaveToFile(SaveDialog1.Filename + '.rtf');
      F := SaveDialog1.Filename + '.rtf';
      RichEdit1.Modified := false;
    end
    else
    begin
      Form4.CLick := 3;
    end;
  end
  else
  begin
    RichEdit1.Lines.SaveToFile(F);
    RichEdit1.Modified := false;
  end;
end;

procedure TForm2.SaveClick(Sender: TObject);
begin
  SAveFile;
end;

procedure TForm2.SelectAllBtnClick(Sender: TObject);
begin
  RichEdit1.SelectALl;
  RichEdit1.SetFocus;
end;

procedure TForm2.SettingsButtonClick(Sender: TObject);
begin
  ComboShingles.visible := not ComboShingles.visible;
end;

procedure TForm2.ExitButtonClick(Sender: TObject);
begin
  Form2.CLose;
  ReplaceForm.CLose;
  Form3.CLose;
  Form4.CLose;
end;

procedure TForm2.UndoClick(Sender: TObject);
begin
  RichEdit1.Undo;
end;

procedure TForm2.UpDown1Changing(Sender: TObject; var AllowChange: Boolean);
begin
  RichEdit1.SelAttributes.Size := StrToInt(FontSizeEdit1.Text);
end;

procedure TForm2.ComboShinglesSelect(Sender: TObject);
begin
  Form3.NumberShingles := StrToInt(ComboShingles.Text);
end;

procedure TForm2.CompareUnitButtonClick(Sender: TObject);
begin
  Form3.Left := Self.Left;
  Form3.Top := Self.Top;
  Form3.Width := Width;
  Form3.Height := Height;
  Form3.RichEdit1.Clear;
  Form3.RichEdit2.Clear;
  Form3.RichEdit3.Clear;
  Form3.ShowModal;
end;

procedure TForm2.CopyBtnClick(Sender: TObject);
begin
  RichEdit1.CopyToClipboard;
end;

procedure TForm2.ColorBox1Select(Sender: TObject);
begin
  RichEdit1.SelAttributes.Color := ColorBox1.Selected;
  RichEdit1.SetFocus;
end;

procedure TForm2.CreateNewClick(Sender: TObject);
begin
  if RichEdit1.Modified then
  begin
    Form4.ShowModal;
    if Form4.CLick = 2 then
      SAveFile;
  end;
  RichEdit1.Clear;
  F := '';
end;

procedure TForm2.CutBtnClick(Sender: TObject);
begin
  RichEdit1.CutToClipboard;
end;

procedure TForm2.ReplaceButtonClick(Sender: TObject);
var
  start, len, posit: integer;
begin
  start := RichEdit1.SelStart;
  len := RichEdit1.SelLength;
  ReplaceForm.ClearEdits;
  ReplaceForm.ShowModal;

  posit := 0;
  if ReplaceForm.ModalResult = mrYes then
  begin
    if not ReplaceForm.Check then
    begin
      start := 0;
      len := length(RichEdit1.Text);
    end;
    while posit <> -1 do
    begin
      posit := RichEdit1.FindText(ReplaceForm.Find, start, len, [stMatchCase]);
      if posit <> -1 then
      begin
        RichEdit1.SelStart := posit;
        RichEdit1.SelLength := length(ReplaceForm.Find);
        RichEdit1.SelText := ReplaceForm.ReplaceStr;
      end;
      Inc(len, length(ReplaceForm.ReplaceStr) - length(ReplaceForm.Find) -
        posit + start);
      len := len - length(ReplaceForm.ReplaceStr);
      start := posit + length(ReplaceForm.ReplaceStr);
    end;
  end;

end;

procedure TForm2.RichEdit1SelectionChange(Sender: TObject);
begin
  if fsbold in RichEdit1.SelAttributes.Style then
    BoldButton1.ImageIndex := 1
  else
    BoldButton1.ImageIndex := -1;
  if fsUnderLine in RichEdit1.SelAttributes.Style then
    UnderlineButton1.ImageIndex := 1
  else
    UnderlineButton1.ImageIndex := -1;
  if fsItalic in RichEdit1.SelAttributes.Style then
    ItalicButton1.ImageIndex := 1
  else
    ItalicButton1.ImageIndex := -1;
end;

procedure TForm2.RightJustifyButton1Click(Sender: TObject);
begin
  RichEdit1.Paragraph.Alignment := taRightjustify;
end;

function FindMax(str: string): integer;
var
  j, start: integer;
  max: integer;
begin
  max := 0;
  str := StringReplace(str, #13#10, '', [rfReplaceall]);
  j := 1;
  while j < length(str) do
  begin
    while (j <= length(str)) and (str[j] in Special) do
      Inc(j);
    start := j;
    while (j <= length(str)) and (not(str[j] in Special)) do
      Inc(j);
    if max < j - start then
      max := j - start;
  end;
  FindMax := max;
end;

procedure TForm2.SignsNumberClick(Sender: TObject);
var
  i, need, j, long, start, pos,pos9: integer;
  fl: Boolean;
begin
  need := StrToInt(NumberSignsEdit1.Text);
  if length(RichEdit1.SelText) = 0 then
    ShowMessage('Выделите нужный текст')
  else if (length(RichEdit1.SelText) > 300000) then
    ShowMessage('Слишком большой текст для обработки')
  else
  begin
    RichEdit1.Lines.BeginUpdate;
    start := RichEdit1.SelStart;
    pos := 0;
    for i := 0 to high(RichEdit1.SelText) - 1 do
    begin
      if (RichEdit1.SelText[i] = #13) then
        Inc(pos);
    end;
    long := RichEdit1.SelLength;
   // RichEdit1.SelText := StringReplace(RichEdit1.SelText, #13#10, '', [rfReplaceall]);
    RichEdit1.SelText := StringReplace(RichEdit1.SelText, #13, '', [rfReplaceall]);
    RichEdit1.SelStart := start;
    long := long -  pos;
    RichEdit1.SelLength := long;
    i := need;
      while (i <= long) and (length(RichEdit1.SelText) > 0) do
      begin
        fl := true;
        j := need;
        while (j > 0) and fl and (j < RichEdit1.SelLength) do
        begin
          if RichEdit1.SelText[j] in Special then
          begin
            while RichEdit1.SelText[j] in Special do
              Inc(j);
            dec(j);
            RichEdit1.SelStart := start + i - need + j;
            RichEdit1.SelLength := 0;
            RichEdit1.SelText := #13;
            RichEdit1.SelStart := start + i - need + j + 1;
            i := RichEdit1.SelStart - start;
            Inc(long, 1);
            RichEdit1.SelLength := long;
            fl := false;
          end;
          dec(j);
        end;
        if fl then
        begin
          j := need;
          while (j < RichEdit1.SelLength) and fl do
          begin
            if RichEdit1.SelText[j] in Special then
            begin
              while RichEdit1.SelText[j] in Special do
                Inc(j);
              dec(j);
              RichEdit1.SelStart := start + i - need + j;
              RichEdit1.SelLength := 0;
              RichEdit1.SelText := #13;
              RichEdit1.SelStart := start + i - need + j + 1;
              i := RichEdit1.SelStart - start;
              Inc(long, 1);
              RichEdit1.SelLength := long - start;
              fl := false;
            end;
            Inc(j);
          end;
        end;
        Inc(i, need);
      end;
    RichEdit1.Lines.EndUpdate;
  end;

end;

procedure TForm2.Splitter1Moved(Sender: TObject);
begin
  if Splitter2.Left > Splitter1.Left then
  begin
    SizePanelLeft.Width := Splitter1.Left;
    Splitter2.Left := Splitter1.Left;
  end;
  firstInden := Splitter1.Left;
  LeftInden := sizepanel.Width - Splitter2.Left;
  RichEdit1.Paragraph.FirstIndent := 3 * firstInden div 5;
  RichEdit1.Paragraph.LeftIndent := -3 * LeftInden div 5;
  RichEdit1.Paragraph.RightIndent := 3 * (RichEdit1.Width - RightSplitter.Left)
    div 5 + 1;
end;

end.
