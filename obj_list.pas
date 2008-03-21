unit obj_list;

interface

uses kol, SysUtils;

type
  PRadioItem = ^TRadioItem;
  TRadioItem = record
    pos: Cardinal;
    Name: string;
    pls: string;
  end;

type
  PRadioList = ^TRadioList;
  TRadioList = object(TObj)
  private
    FList: PList;
    function GetItem(Index: Integer): PRadioItem;
  public
    procedure Add(const pos: Cardinal; const Name, pls: string);
    function getpos(const Name: string): Cardinal;
    function getname(const pos: Cardinal): string;
    function getpls(const Name: string): string;
    //procedure Automate(const radiolib: string; const Achanneltree: PControl);
    constructor Create;
    destructor Destroy; virtual;
  end;

function NewRadioList: PRadioList;

implementation

//uses StrUtils;

function NewRadioList: PRadioList;
begin
  New(Result, Create);
end;

{ TRadioList }

procedure TRadioList.Add(const pos: Cardinal; const Name, pls: string);
var
  newitem: PRadioItem;
begin
  New(newitem);
  newitem.pos := pos;
  newitem.Name := Name;
  newitem.pls := pls;
  FList.Add(newitem);
end;

{procedure SplitQuotedValues(var data: string; out field, value: string);
const
  delimiter = ' "';
var
  p: Integer;
begin
  data := Trim(data);
  p := Pos(delimiter, data);
  if p > 0 then
  begin
    field := AnsiDequotedStr(Copy(data, 1, p), '"');
    value := AnsiDequotedStr(Copy(data, p + 1, Length(data) - p), '"');
  end;
end;

procedure TRadioList.Automate(const radiolib: string;
  const Achanneltree: PControl);
const
  quote = '"';
  opentree = '<';
  closetree = '>';
var
  channeltree: PControl;
  Lines: PStrList;
  Line: string;
  i: Integer;

  procedure ParseTree(const ownerTree: cardinal);
  var
    curTree: Cardinal;
    field, value: string;
  begin
    value := Copy(Line,2,Length(value)-2);
    curTree := channeltree.TVInsert(ownerTree, 0, value);
    Inc(i);

    repeat
      Line := Lines.Items[i];
      if Line[1] = opentree then
        ParseTree(curTree)
      else
        if Line[1] = quote then
        begin
          SplitQuotedValues(Line, field, value);
          Add(channeltree.TVInsert(curTree, 0, field),
            field,
            value
            );
        end;
      Inc(i);
      Line := Lines.Items[i];
    until Line[1] = closetree;
  end;

begin
  channeltree := Achanneltree;
  Lines := NewStrList;
  i := 0;
  Lines.Text := radiolib;

  try

    while i < Lines.Count do
    begin
      Line := Lines.Items[i];
      if Line[1] = opentree then
        ParseTree(0);
      Inc(i);
    end;
  finally
    Lines.Free;
  end;
end;}

constructor TRadioList.Create;
begin
  inherited Create;
  FList := NewList;
end;

destructor TRadioList.Destroy;
begin
  while FList.Count > 0 do
  begin
    Dispose(GetItem(0));
    FList.Delete(0);
  end;
  FList.Free;
end;

function TRadioList.GetItem(Index: Integer): PRadioItem;
begin
  Result := FList.Items[Index];
end;

function TRadioList.getname(const pos: Cardinal): string;
var
  i: Integer;
begin
  for i := 0 to FList.Count - 1 do
    if GetItem(i).pos = pos then
    begin
      Result := GetItem(i).Name;
      Exit;
    end;
  Result := '';
end;

function TRadioList.getpls(const Name: string): string;
var
  i: Integer;
begin
  for i := 0 to FList.Count - 1 do
    if GetItem(i).Name = Name then
    begin
      Result := GetItem(i).pls;
      Exit;
    end;
  Result := '';
end;

function TRadioList.getpos(const Name: string): Cardinal;
var
  i: Integer;
begin
  for i := 0 to FList.Count - 1 do
    if GetItem(i).Name = Name then
    begin
      Result := GetItem(i).pos;
      Exit;
    end;
  Result := 0;
end;

end.

