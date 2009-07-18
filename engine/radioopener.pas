unit radioopener;

interface

//{$R decoders.res}

uses
  Kol,
  Windows,
  SysUtils,
  Classes,
  DSOutput,
  mmsstream, {$DEFINE MMS}
  mp3stream, {$DEFINE MP3}
  aacpstream, {$DEFINE AACP}
  httpsend,
  main,
  utils;

// "THIS" retrieves the PLS or M3U or WTF!...
// and then try to open the linwith avaliable decoders

type
  TRadioOpener = class(TThread)
  private
    fUrl: string;
  protected
    procedure Execute(); override;
  public
    constructor Create(const url: string);
  end;

{var
  TV: PControl;
  Radio: Cardinal;}

implementation

procedure ParseASX(const src, dst: TStrings);
var
  i, a, b: Integer;
  Line: string;
begin
  for i := 0 to src.Count - 1 do
  begin
    Line := src[i];
    a := Pos('<ref', Line);
    if (a <> 0) and (not MultiPos(['.htm', '.asp', '.php', '.cgi', '<!--'], Line)) then
    begin
      a := PosEx('"', Line, a) + 1;
      b := PosEx('"', Line, a + 5);
      dst.Add(Copy(Line, a, b - a));
    end;
  end;
end;

procedure ParsePLS(const src, dst: TStrings);
var
  i, p: Integer;
  Line: string;
begin
  for i := 0 to src.Count - 1 do
  begin
    Line := src[i];
    p := Pos('http://', Line); // can be mms or http
    if p = 0 then p := Pos('mms://', Line);

    if (p = 1) or
      ((p <> 0) and (Pos('file', Line) = 1)) then
    begin
      dst.Add(Copy(Line, p, Length(Line) - p + 1));
    end;
  end;

end;

procedure OpenPls(const url: string; const urls: TStringList);
var
  pls: TStringList;
begin
  if MultiPos(['mms://', 'rtsp://'], url) then
  begin
    urls.Add(url);
    Exit;
  end;

  pls := TStringList.Create;
  // mms is the only we know for sure,
  // otherwise we will test the url for asx, m3u and pls
  HttpGetText(url, pls);
  if pls.Count = 0 then Exit;
  if pls[0] = '' then pls.Delete(0);
  // lowercase the content for parse
  pls.Text := LowerCase(pls.Text);

  {// check for an http page
  if Pos('<html', pls.Text) <> 0 then
  begin
    urls.Add(url);
  end
  else}
    // check for asx playlist
    if Pos('asx', pls[0]) <> 0 then
      ParseASX(pls, urls)
    else
      // check for m3u or pls playlist
      if MultiPos(['playlist', 'm3u'], pls[0]) or
        (Pos('.m3u', url) <> 0) then
        ParsePLS(pls, urls)
      else
      begin
        urls.Add(url);
      end;

  pls.Free;
end;

{ TRadioOpener }

constructor TRadioOpener.Create(const url: string);
begin
  fUrl := url;
  FreeOnTerminate := True;
  inherited Create(False);
end;

procedure TRadioOpener.Execute;
var
  urls: TStringList;
  i: Integer;
  Player: TRadioPlayer;
  r: LongBool;
  //res: Cardinal;
begin
  Player := nil;
  r := False;

  urls := TStringList.Create;
  OpenPls(fUrl, urls);

  for i := 0 to urls.Count - 1 do
  begin
{$IFDEF MMS}
    if MultiPos(['mms://', '.wma', '.asf', 'rtsp://'], urls[i]) then
    begin
      Player := TMMS.Create();
      r := Player.Open(urls[i]);
      if r or Terminated then Break;
    end;
{$ENDIF}

{$IFDEF MP3}
    Player := TMP3.Create();
    r := Player.Open(urls[i]);
    if r or Terminated then Break;
{$ENDIF}

{$IFDEF AACP}
    Player := TAACP.Create();
    r := Player.Open(urls[i]);
    if r or Terminated then Break;
{$ENDIF}

{$IFDEF MMS}
    // give a chance for some .aspx urls (ex: 1.fm)
    if Pos('.aspx', fUrl) <> 0 then
    begin
      Player := TMMS.Create();
      r := Player.Open(urls[i]);
      if r or Terminated then Break;
    end;
{$ENDIF}
  end;

  if Terminated then
  begin
    if r then
    begin
      Player.Terminate;
      Player.Resume;
    end;
  end
  else
  begin
    if r then
    begin
      {res := tv.TVItemChild[Radio];
      while res <> 0 do
      begin
        TV.TVDelete(res);
        res := tv.TVItemChild[Radio];
      end;

      if urls.Count > 1 then
        for i := 0 to urls.Count - 1 do
        begin
          radiolist.Add(
            TV.TVInsert(Radio, TVI_LAST, IntToStr(i)),
            '',
            urls[i]
            );
        end;}
      Chn := Player;
      Player.Resume;
    end
    else
      NotifyForm(NOTIFY_OPENERROR, 0);
  end;

  urls.Free;

  {Dec(RadioOpenersRunning);}
end;

end.

