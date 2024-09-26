unit Compare;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Math,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ExtCtrls, HashTAble, System.ImageList, Vcl.ImgList, Vcl.Imaging.jpeg,
  Vcl.Imaging.pngimage;

type

  TForm3 = class(TForm)
    PanelU3Edits: TPanel;
    RichEdit1: TRichEdit;
    PanelU3Buttons: TPanel;
    CompareTexts: TButton;
    RichEdit2: TRichEdit;
    RichEdit3: TRichEdit;
    GoBAckbutton: TButton;
    ImageList1: TImageList;
    FirstText: TLabel;
    SecondText: TLabel;
    ReplaceBtn: TButton;
    signsRadioButton: TRadioButton;
    WordsRadioButton: TRadioButton;
    ShinglesButton: TButton;
    ImageList2: TImageList;
    SaveDialogCompare: TSaveDialog;
    PanelForSafe: TPanel;
    SaveComparedTexts: TButton;
    procedure CompareText(mode: integer);
    procedure CompareTextsClick(Sender: TObject);
    procedure GoBAckbuttonClick(Sender: TObject);
    procedure ReplaceBtnClick(Sender: TObject);
    procedure PanelU3ButtonsResize(Sender: TObject);
    procedure signsRadioButtonClick(Sender: TObject);
    procedure WordsRadioButtonClick(Sender: TObject);
    procedure ShinglesButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SaveComparedTextsClick(Sender: TObject);
    procedure SAveFile;
    function Shingles(str1: ansistring; n: integer): THAshTAble;
    function Count(HashTAble: THAshTAble; str1: ansistring; n: integer)
      : extended;
  private
    F: string;
    NumberWords: integer;
  public
    NumberShingles: integer;
  end;

Type
  DinMAss = array of integer;
  ArrOfStr = array of string;
  ArrOfNUms = array of integer;
  Matrix = array of array of integer;

var
  Form3: TForm3;

implementation

{$R *.dfm}

const
  Special = ['"', '"', ',', '.', ':', '$', '#', '(', ')', ' ', '-', ':', ';',
    '«', '»', '_'];
  ReplaceLetters = ['a', 'o', 'i', 'u', 'y', 'e', 'а', 'о', 'е', 'и', 'ё', 'ю',
    'я', 'э', 'у', 'ы'];

function OneWord(var str1: string; mode: integer): ArrOfStr;
var
  i, p: integer;
  start: integer;
  strmas: ArrOfStr;
begin
  i := 1;
  p := 0;
  str1 := StringReplace(str1, #13#10, '', [rfReplaceall]);
  if mode = 1 then
    while i <= length(str1) do
    begin
      start := i;
      while (i <= length(str1)) and (str1[i] <> ' ') do
      begin
        inc(i);
      end;
      SetLength(strmas, length(strmas) + 1);
      strmas[p] := Copy(str1, start, i - start);
      inc(p);
      inc(i);
    end
  else
  begin
    SetLength(strmas, length(str1));
    for i := 0 to high(strmas) do
      strmas[i] := str1[i + 1]
  end;
  result := strmas;
end;

function MarkDiffer(strNUms1: ArrOfStr; LCS: ArrOfStr): ArrOfStr;
var
  j, k, i: integer;
  Str1Marks: ArrOfStr;
begin
  j := 0;
  k := 0;
  SetLength(Str1Marks, length(strNUms1));
  For i := 0 To length(strNUms1) - 1 do
  begin
    If (j <= length(LCS) - 1) and (LCS[j] = strNUms1[k]) Then
    begin
      Str1Marks[i] := '=';
      inc(j);
    end
    else
      Str1Marks[i] := '-';
    inc(k);
  End;
  result := Str1Marks;
end;

function MaxSubLine(strNUms1: ArrOfStr; strNUms2: ArrOfStr; var Len: integer;
  var Error: boolean): ArrOfStr;
var
  i, j, n, m, c: integer;
  MaxLEn: Matrix;
  Res: ArrOfStr;

begin
  n := length(strNUms1);
  m := length(strNUms2);
  try
    SetLength(MaxLEn, n + 1, m + 1);
  except
    SetLength(MaxLEn, 0);
    Error := true;
    ShowMessage('Недостаточно памяти для обработки');
  end;
  if length(MaxLEn) <> 0 then
  begin
    Error := false;
    for i := 0 to m do
      MaxLEn[0, i] := 0;
    for i := 0 to n do
      MaxLEn[i, 0] := 0;

    for i := 1 to n do
    begin
      for j := 1 to m do
      begin
        if strNUms1[i - 1] = strNUms2[j - 1] then
          MaxLEn[i, j] := 1 + MaxLEn[i - 1, j - 1]
        else if MaxLEn[i - 1, j] > MaxLEn[i, j - 1] Then
          MaxLEn[i, j] := MaxLEn[i - 1, j]
        else
          MaxLEn[i, j] := MaxLEn[i, j - 1]
      end

    end;
    Len := MaxLEn[n, m];
    If MaxLEn[n, m] = 0 Then
      SetLength(result, 0)
    else
    begin
      SetLength(Res, MaxLEn[n, m]);
      c := MaxLEn[n, m] - 1;
      i := n;
      j := m;
      While (i > 0) And (j > 0) do
      begin
        If strNUms1[i - 1] = strNUms2[j - 1] Then
        begin
          Res[c] := strNUms1[i - 1];
          c := c - 1;
          i := i - 1;
          j := j - 1;
        end
        else if MaxLEn[i - 1, j] = MaxLEn[i, j] then
          i := i - 1
        else
          j := j - 1
      end;
      result := Res;
    end;
    SetLength(MaxLEn, 0);
  end;
end;

procedure TForm3.GoBAckbuttonClick(Sender: TObject);
begin
  Self.ModalResult := mrOk;
end;

procedure TForm3.CompareText(mode: integer);
var
  i, j: integer;
  str1, str2, str: string;
  LCS: ArrOfStr;
  strarr1, strarr2: ArrOfStr;
  Str1Marks, str2Marks: ArrOfStr;
  AddMas: array [0 .. 1] of string;
  Error: boolean;
begin
  AddMas[0] := '';
  AddMas[1] := ' ';
  RichEdit3.Lines.BeginUpdate;
  str1 := RichEdit1.Text;;
  str := str1;
  str2 := RichEdit2.Text;
  strarr1 := OneWord(str1, mode);
  strarr2 := OneWord(str2, mode);
  LCS := MaxSubLine(strarr1, strarr2, j, Error);
  if not Error then
  begin
    Str1Marks := MarkDiffer(strarr1, LCS);
    str2Marks := MarkDiffer(strarr2, LCS);
    i := 0;
    j := 0;
    SetLength(strarr1, length(strarr1) + 1);
    SetLength(strarr2, length(strarr2) + 1);
    SetLength(Str1Marks, length(Str1Marks) + 1);
    SetLength(str2Marks, length(str2Marks) + 1);
    While (i <= length(strarr1) - 2) or (j <= length(strarr2) - 2) do
    begin
      If (Str1Marks[i] = '-') And (str2Marks[j] = '-') Then
      begin
        with RichEdit3 do
        begin
          SelStart := length(RichEdit3.Text);
          SelAttributes.Color := clRED;
          SelAttributes.Style := [fsStrikeOut];
          SelText := strarr1[i];
          SelAttributes.Style := [fsUnderline];
          SelAttributes.Color := clGreen;
          SelText := strarr2[j] + AddMas[mode];
        end;
        Str1Marks[i] := '';
        strarr1[i] := '';
        str2Marks[j] := '';
        strarr2[j] := '';
        inc(i);
        inc(j);
      end
      else If (Str1Marks[i] <> '-') And (str2Marks[j] = '-') then
      begin
        with RichEdit3 do
        begin
          SelStart := length(RichEdit3.Text) - length(strarr1[i]) + 1;
          SelAttributes.Color := clGreen;
          SelAttributes.Style := [fsUnderline];
          SelText := strarr2[j] + AddMas[mode];
        end;
        str2Marks[j] := '';
        strarr2[j] := '';
        inc(j);
      end
      else If (Str1Marks[i] = '-') And (str2Marks[j] <> '-') then
      begin
        with RichEdit3 do
        begin
          SelStart := length(RichEdit3.Text);
          SelAttributes.Color := clRED;
          SelAttributes.Style := [fsStrikeOut];
          SelText := strarr1[i] + AddMas[mode];
        end;
        Str1Marks[i] := '';
        strarr1[i] := '';
        inc(i);
      end
      else
      begin
        with RichEdit3 do
        begin
          SelStart := length(RichEdit3.Text);
          SelAttributes.Color := clBlack;
          SelAttributes.Style := [];
          SelText := strarr1[i] + AddMas[mode];
        end;
        Str1Marks[i] := '';
        strarr1[i] := '';
        str2Marks[j] := '';
        strarr2[j] := '';
        inc(i);
        inc(j);
      end;
      if (i > length(strarr1) - 2) and (j <= length(strarr2) - 2) then
        i := length(strarr1) - 1;
      if (i <= length(strarr1) - 2) and (j > length(strarr2) - 2) then
        j := length(strarr2) - 1;
    end;
    SetLength(Str1Marks, 0);
    SetLength(str2Marks, 0);
    SetLength(strarr1, 0);
    SetLength(strarr2, 0);
  end;
  RichEdit3.Lines.EndUpdate;
end;

procedure TForm3.PanelU3ButtonsResize(Sender: TObject);
begin
  RichEdit2.Width := Width div 2;
  ReplaceBtn.left := Width div 2 - ReplaceBtn.Width div 2;
  FirstText.left := Width div 4 - FirstText.Width div 2;
  SecondText.left := 3 * Width div 4 - SecondText.Width div 2;
end;

procedure TForm3.ReplaceBtnClick(Sender: TObject);
var
  temp: string;
begin
  temp := RichEdit1.Text;
  RichEdit1.Text := RichEdit2.Text;
  RichEdit2.Text := temp;
end;

function TForm3.Shingles(str1: ansistring; n: integer): THAshTAble;
var
  i, k, j, start: integer;
  mas3: array of string;
  Arr: string;
  HashTAble: THAshTAble;
  wasword: boolean;
begin
  i := 1;
  k := 0;
  NumberWords := 0;
  HashTAble := THAshTAble.Create;
  str1 := StringReplace(str1, #13#10, '', [rfReplaceall]);
  str1 := StringReplace(str1, #9, '', [rfReplaceall]);
  str1 := ansilowerCase(str1);
  SetLength(mas3, n);
  while i <= length(str1) do
  begin
    start := i;
    wasword := false;
    while (i <= length(str1)) and not(str1[i] in Special) do
    begin
      if str1[i] = 'p' then
        str1[i] := 'р'
      else if str1[i] = 'c' then
        str1[i] := 'с';
      if str1[i] in ReplaceLetters then
        Delete(str1, i, 1)
      else
        inc(i);
      wasword := true;
    end;
    if wasword then
    begin
      mas3[k] := Copy(str1, start, i - start);
      if k = n - 1 then
      begin
        for j := 0 to length(mas3) - 1 do
          Arr := Arr + mas3[j];
        if (not HashTAble.ContainsKEy(Arr)) then
        begin
          HashTAble.PutOrUpdate(Arr, 0);
          inc(NumberWords);
        end;
        Arr := '';
        for j := 0 to length(mas3) - 2 do
        begin
          mas3[j] := mas3[j + 1];
        end;
      end
      else
        inc(k);
    end;
    inc(i);
  end;
  result := HashTAble;

end;

function TForm3.Count(HashTAble: THAshTAble; str1: ansistring; n: integer)
  : extended;
var
  i, k, j, start, p, number: integer;
  mas3: array of string;
  Arr: string;
  wasword: boolean;
begin
  result := 0;
  number := 0;
  i := 1;
  k := 0;
  str1 := StringReplace(str1, #13#10, '', [rfReplaceall]);
  str1 := StringReplace(str1, #9, '', [rfReplaceall]);
  str1 := ansilowerCase(str1);
  SetLength(mas3, n);
  while i <= length(str1) do
  begin
    start := i;
    wasword := false;
    while (i <= length(str1)) and not(str1[i] in Special) do
    begin
      if str1[i] = 'p' then
        str1[i] := 'р'
      else if str1[i] = 'c' then
        str1[i] := 'с';
      if str1[i] in ReplaceLetters then
        Delete(str1, i, 1)
      else
        inc(i);
      wasword := true;
    end;
    if wasword then
    begin
      mas3[k] := Copy(str1, start, i - start);
      if k = n - 1 then
      begin
        for j := 0 to length(mas3) - 1 do
          Arr := Arr + mas3[j];
        if HashTAble.ContainsKEyUpdated(Arr) then
        begin
          inc(number);
        end;
        Arr := '';
        for j := 0 to length(mas3) - 2 do
        begin
          mas3[j] := mas3[j + 1];
        end;
      end
      else
        inc(k);
    end;
    inc(i);

  end;
  if NumberWords <> 0 then
    result := 100 * number / NumberWords
  else
    result := 0;
  HashTAble.Destroy;
end;

procedure TForm3.ShinglesButtonClick(Sender: TObject);
var
  Res: extended;
  n: integer;
  s, str1, str2: string;
  Error: boolean;
begin
  n := NumberShingles;
  str1 := RichEdit1.Text;;
  str2 := RichEdit2.Text;
  MaxSubLine(OneWord(str1, 0), OneWord(str2, 0), n, Error);
  if (length(str1) + length(str2) - n) <> 0 then
  begin
    Res := RoundTo(100 * n / (length(str1) + length(str2) - n), -2);
    s := 'Процентная схожесть певрого текста со вторым (%) -  ' +
      FloatToStr(Res) + #13#10 + 'Разница (%)' + FloatToStr(100 - Res) + #13#10
      + 'Общий (символы) ' + IntToStr(n) + #13#10 + 'Разница (символы) ' +
      IntToStr((length(str1) + length(str2) - 2 * n));
  end
  else
    s := 'Тексты пусты';
  ShowMessage(s);

end;

procedure TForm3.signsRadioButtonClick(Sender: TObject);
begin
  if signsRadioButton.Checked then
    WordsRadioButton.Checked := false
  else
    WordsRadioButton.Checked := true;
end;

procedure TForm3.WordsRadioButtonClick(Sender: TObject);
begin
  if WordsRadioButton.Checked then
    signsRadioButton.Checked := false
  else
    signsRadioButton.Checked := true;
end;

procedure TForm3.CompareTextsClick(Sender: TObject);
var
  mode: integer;
begin
  if WordsRadioButton.Checked then
    mode := 1
  else
    mode := 0;
  RichEdit3.CLear;
  CompareText(mode);
  if RichEdit3.Text <> '' then
    SaveComparedTexts.visible := true
  else
    SaveComparedTexts.visible := false;

end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  NumberShingles := 3;
  SaveDialogCompare.Filter := 'RTF Files |*.rtf';
end;

procedure TForm3.SAveFile;
begin
  if SaveDialogCompare.Execute then
  begin
    RichEdit3.Lines.SaveToFile(SaveDialogCompare.Filename + '.rtf');
    F := SaveDialogCompare.Filename + '.rtf';
  end;
end;

procedure TForm3.SaveComparedTextsClick(Sender: TObject);
begin
  SAveFile;
end;

end.
