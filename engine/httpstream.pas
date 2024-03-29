unit httpstream;

interface

uses
  SysUtils,
  Classes,
  Windows,
  synautil,
  blcksock,
  main;

const // CONFIGURATION
  BUFFPACKET = 1024 * 1;
  BUFFPACKETCOUNT = 150; // 50 extra buffers  xD
  BUFFSIZETOTAL = 1024 * BUFFPACKETCOUNT;

  BUFFRESTORE = 50;
  BUFFPRE = 60;

type
  THTTPSTREAM = class(TThread)
  private
    fAccept: string;
    BytesUntilMeta: Integer; // used to manage icy data
    fHTTP: TTCPBlockSocket;
    MetaInterval: Integer;
    MetaBitrate, MetaTitle: string;
    Cursor, Feed: Integer;
    inbuffer: array[0..BUFFPACKETCOUNT - 1, 0..BUFFPACKET - 1] of Byte;
    procedure UpdateBuffer;
  protected
    procedure Execute; override;
  public
    //# n buff packets filled
    BuffFilled: Integer;
    //# Get ShoutCast info
    procedure GetMetaInfo(var Atitle, Aquality: string);
    //# Read the Buffer
    function GetBuffer(): PByte;
    procedure NextBuffer();
    //# Open stream
    function Open(const url: string): LongBool;
    constructor Create(const accept: string);
    destructor Destroy; override;
  end;

implementation

uses utils;

procedure ParseHeader(const url, accept: string; var host, port, icyheader: string);
const
  ICYHEADERSTUB =
    'GET %s HTTP/1.0' + #13#10 +
    'Host: %s:%s' + #13#10 +
    'Accept: %s' + #13#10 +
    'Icy-MetaData:1' + #13#10 +
    'User-Agent: 1ClickMusic' + #13#10 +
    #13#10;
var
  prot, user, pass, path, para: string;
begin
  ParseURL(url, prot, user, pass, host, port, path, para);
  icyheader := Format(ICYHEADERSTUB, [path, host, port, accept]);
end;

function ParseMetaHeader(var meta: string; const accept: string; var MetaInterval: Integer; var MetaBitrate: string): Integer;
var
  MetaData: TStringlist;
  field, value: string;
  i: Integer;
label _exit_;
begin
  Result := 0;

  if meta = '' then Exit;

  MetaData := TStringlist.Create;
  MetaData.Text := meta;

  if Pos('200', MetaData[0]) <> 0 then
  begin
    for i := 1 to MetaData.Count - 1 do
    begin
      SplitValue(MetaData[i], field, value);

      if field = 'location' then
      begin
        meta := value;
        Result := -1;
        Break;
      end;

      if (field = 'content-type') and (value <> accept) then
      begin
        Result := 0;
        Break;
      end;

      if field = 'icy-metaint' then
      begin
        MetaInterval := StrToInt(value);
        Result := 1;
      end
      else
        if field = 'icy-br' then
        begin
          MetaBitrate := value;
        end;
    end;
  end;

  MetaData.Free;
end;

function ParseMetaData(const meta: string): string;
const
  field = 'StreamTitle=''';
begin
  Result := Copy(meta, Length(field) + 1, Pos(''';', meta) - (Length(field) + 1));
end;

{ THTTPSTREAM }

procedure THTTPSTREAM.UpdateBuffer;
var
  metalength: Byte;
  bytesreceived, bytestoreceive: Integer;
begin
  bytesreceived := 0;
  repeat
    if Terminated then Exit;

    if BytesUntilMeta = 0 then
    begin
      BytesUntilMeta := MetaInterval;
      metalength := fHTTP.RecvByte(30000);
      if metalength = 0 then Continue;
      MetaTitle := ParseMetaData(fHTTP.RecvBufferStr(metalength * 16, 15000));
      NotifyForm(NOTIFY_NEWINFO, 0);
    end
    else
    begin
      bytestoreceive := BUFFPACKET - bytesreceived;
      if bytestoreceive > BytesUntilMeta then
        bytestoreceive := BytesUntilMeta;


      fHTTP.RecvBufferEx(@inbuffer[Feed, bytesreceived], bytestoreceive, 30000);

      Dec(BytesUntilMeta, bytestoreceive);
      Inc(bytesreceived, bytestoreceive);
    end;

    if (fHTTP.LastError <> 0) and (not Terminated) then
    begin
      Terminate;
      NotifyForm(NOTIFY_DISCONECT, 0);
      Exit;
    end;

  until (bytesreceived >= BUFFPACKET);

  if Feed = BUFFPACKETCOUNT - 1 then
    Feed := 0
  else
    Inc(Feed);

  Inc(BuffFilled);
end;

constructor THTTPSTREAM.Create(const accept: string);
var
  pip, pport, puser, ppass, _: string;
begin
  inherited Create(True);
  fHTTP := TTCPBlockSocket.Create;
  if proxy_enabled and (proxy_proxy <> '') then
  begin
    ParseURL(proxy_proxy, _, puser, ppass, pip, pport, _, _);
    fHTTP.HTTPTunnelIP := pip;
    fHTTP.HTTPTunnelPort := pport;
    fHTTP.HTTPTunnelUser := puser;
    fHTTP.HTTPTunnelPass := ppass;
  end;
  Priority := tpTimeCritical;

  fAccept := accept;
end;

destructor THTTPSTREAM.Destroy;
begin
  // flag terminated := True
  Terminate;
  // now close socket
  fHTTP.CloseSocket;
  // destroy the thread
  inherited;
  // now we can free the Socket
  fHTTP.Free;
end;

procedure THTTPSTREAM.Execute;
begin
  repeat
    //# if we have a free buffer lets fill it
    if BuffFilled < BUFFPACKETCOUNT then
      UpdateBuffer()
    else
      Sleep(64);
  until Terminated;
end;

function THTTPSTREAM.Open(const url: string): LongBool;
var
  host, port, icyheader: string;
  response: string;
begin
  Result := False;
  ParseHeader(url, fAccept, host, port, icyheader);
  fHTTP.AbortSocket;

  fHTTP.Connect(host, port);
  if fHTTP.LastError <> 0 then
    Exit;
  fHTTP.SendString(icyheader);

  response := fHTTP.RecvTerminated(5000, #13#10#13#10);

  case ParseMetaHeader(response, fAccept, MetaInterval, MetaBitrate) of
    1:
      begin
        BytesUntilMeta := MetaInterval;
        Resume;
        Result := True;
      end;
    -1:
      Result := Open(response);
  end;

end;

procedure THTTPSTREAM.GetMetaInfo(var Atitle, Aquality: string);
begin
  Atitle := MetaTitle;
  Aquality := MetaBitrate;
end;

function THTTPSTREAM.GetBuffer(): PByte;
begin
  Result := @inbuffer[Cursor];
end;

procedure THTTPSTREAM.NextBuffer();
begin
  if Cursor = BUFFPACKETCOUNT - 1 then Cursor := 0 else Inc(Cursor);
  Dec(BuffFilled);
end;

end.

