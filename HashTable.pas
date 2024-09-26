unit HashTable;

interface

uses
  System.SysUtils;

type
  TKeyValue = record
    Key: string;
    Value: Integer;
  end;

  PSimpleNode = ^TSimpleNode;

  TSimpleNode = record
    Next: PSimpleNode;
    data: TKeyValue;
  end;

  DinMAss = array of PSimpleNode;
  TMAS = array [0 .. 29] of Integer;

  THashTable = class
  private
    FTable: DinMAss;
    FCount: Integer;
    FSize: Integer;
    Sizes_index: Integer;

  const
    Sizes: TMAS = (5, 11, 23, 47, 97, 193, 389, 769, 1543, 3072, 3079, 12289,
      24593, 49157, 98317, 196613, 393241, 786433, 1572869, 3145739, 6291469,
      12582917, 25165843, 50331653, 100663319, 201326611, 402653189, 805306457,
      1610612736, 2147483629);
    function GetHash(const AKey: string): Integer;
    function CheckMemory(): boolean;
    procedure MemoryAdd();
    procedure Add(const AKey: string; AValue: Integer);
  public
    constructor Create;
    destructor Destroy; override;
    function Get(const AKey: string): Integer;
    procedure PutOrUpdate(const AKey: string; AValue: Integer);
    function ContainsKEyUpdated(const AKey: string): boolean;
    function ContainsKEy(const AKey: string): boolean;
    property Count: Integer read FCount;
  end;

implementation

constructor THashTable.Create;
begin
  Sizes_index := 0;
  FSize := Sizes[Sizes_index];
  SetLength(FTable, Sizes[Sizes_index]);
end;

destructor THashTable.Destroy;
var
  i: Integer;
  x, temp: PSimpleNode;
begin
  for i := 0 to Length(FTable) - 1 do
  begin
    x := FTable[i];
    while x <> nil do
    begin
      temp := x^.Next;
      Dispose(x);
      x := temp;
    end;
  end;
  FTable := nil;
  inherited;
end;

function THashTable.CheckMemory(): boolean;
var
  factor: double;
begin
  factor := 0.75;
  result := FCount / FSize >= factor;
end;

function THashTable.GetHash(const AKey: string): Integer;
var
  i: Integer;
begin
  result := 0;
  for i := 1 to Length(AKey) do
    result := (result * 31 + Ord(AKey[i])) mod FSize;
end;

procedure THashTable.Add(const AKey: string; AValue: Integer);
var
  i: Integer;
  fl: boolean;
  x: PSimpleNode;
begin
  i := Get(AKey);
  if FTable[i] = nil then
  begin
    new(FTable[i]);
    FTable[i]^.data.Key := AKey;
    FTable[i]^.data.Value := AValue;
    FTable[i]^.Next := nil;
    inc(FCount);
  end
  else
  begin
    x := FTable[i];
    fl := true;
    if (x^.data.Key = AKey) then
      fl := false;
    while (x^.Next <> nil) and fl do
    begin
      if (x^.data.Key = AKey) then
        fl := false;
      x := x^.Next;
    end;
    if fl then
    begin
      new(x^.Next);
      x := x^.Next;
      x^.data.Key := AKey;
      x^.data.Value := AValue;
      x^.Next := nil;
      inc(FCount);
    end;
  end;
end;

procedure THashTable.MemoryAdd();
var
  oldArray: DinMAss;
  i: Integer;
  x: PSimpleNode;
begin
  FCount := 0;
  oldArray := FTable;
  FTable := nil;
  SetLength(FTable, Sizes[Sizes_index + 1]);
  FSize := Sizes[Sizes_index + 1];
  inc(Sizes_index);
  for i := 0 to Length(oldArray) - 1 do
  begin
    x := oldArray[i];
    while x <> nil do
    begin
      Add(x^.data.Key, x^.data.Value);
      x := x^.Next;
    end;

  end;

end;

function THashTable.Get(const AKey: string): Integer;
var
  i: Integer;
begin
  i := GetHash(AKey);
  result := i mod Length(FTable);
end;

procedure THashTable.PutOrUpdate(const AKey: string; AValue: Integer);
var
  i: Integer;
begin
  if CheckMemory() then
    MemoryAdd();
  Add(AKey, AValue);
end;

function THashTable.ContainsKEyUpdated(const AKey: string): boolean;
var
  i: Integer;
  x: PSimpleNode;
  fl: boolean;
begin
  i := Get(AKey);
  x := FTable[i];
  fl := false;
  while (x <> nil) and not fl do
  begin
    if (x^.data.Key = AKey) and (x^.data.Value = 0) then
    begin
      fl := true;
      inc(x^.data.Value);
    end;
    x := x^.Next;
  end;
  result := fl;
end;

function THashTable.ContainsKey(const AKey: string): boolean;
var
  i: Integer;
  x: PSimpleNode;
  fl: boolean;
begin
  i := Get(AKey);
  x := FTable[i];
  fl := false;
  while (x <> nil) and not fl do
  begin
    if (x^.data.Key = AKey) then
    begin
      fl := true;
    end;
    x := x^.Next;
  end;
  result := fl;
end;

end.
