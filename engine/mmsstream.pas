unit mmsstream;

interface

// THIS ONE DOES NOT NEED HTTPSTREAM

uses SysUtils, Classes, Windows, DSoutput, libwma1;

type
  TMMS = class(TRadioPlayer)
  private
    Fhandle: wma_async_reader;
  protected
    procedure updatebuffer; override;
    procedure initdecoder; override;
    procedure initbuffer; override;
  public
    procedure GetPlayInfo(var Atitle: string; var Aquality: Cardinal); override;
    function GetBufferPercentage: Integer; override;
    function open(const url: string): Boolean; override;
    procedure Play; override;
    destructor Destroy; override;
  end;

implementation

uses
  main;

{ TMP3 }

destructor TMMS.Destroy;
begin
  DS.Stop;
  Terminate;
  inherited;
  if Assigned(Fhandle.reader) then
    lwma_async_reader_free(Fhandle);
end;

procedure TMMS.initdecoder;
begin
  lwma_async_reader_init(Fhandle);
  if not Assigned(Fhandle.reader) then
    raise Exception.Create('ERRO, inicializando o decodificador wma (mms)');
end;

procedure TMMS.initbuffer;
begin
  Fbuffersize := DS.InitializeBuffer(Frate, Fchannels);
end;

procedure TMMS.Play;
begin
  initbuffer();

  Status := rsPrebuffering;
  Flastsection := MaxInt;
  DS.SoundBuffer.SetCurrentPosition((Fbuffersize div 2) * 3);
  updatebuffer();
  DS.SoundBuffer.SetCurrentPosition(0);

  Resume;
  DS.Play;
  Status := rsPlaying;
end;

procedure TMMS.updatebuffer;
var
  buffer, bufferPos: PByte;
  tmpbuffer: Pointer;
  Size, TotalDecoded, tmpbuffersize: Cardinal;
  section: Cardinal;
begin
  if DS.PlayCursorPos > Fbuffersize then
    section := 0
  else
    section := 1;

  if section = Flastsection then Exit;

  DS.SoundBuffer.Lock(section * Fbuffersize, Fbuffersize, @buffer, @Size, nil, nil, 0);

  tmpbuffersize := Size;
  bufferPos := buffer;
  TotalDecoded := 0;

  while (TotalDecoded < Size) do
  begin
    lwma_async_reader_get_data(Fhandle, tmpbuffer, tmpbuffersize);
    CopyMemory(bufferPos, tmpbuffer, tmpbuffersize);
    Inc(bufferPos, tmpbuffersize);
    Inc(TotalDecoded, tmpbuffersize);
    tmpbuffersize := Size - TotalDecoded;
  end;

  DS.SoundBuffer.Unlock(buffer, Size, nil, 0);
  Flastsection := section;
end;

function TMMS.open(const url: string): Boolean;
begin
  lwma_async_reader_open(Fhandle, url);
  Result := Fhandle.has_audio;
  if not Result then Exit;
  Fchannels := Fhandle.channels;
  Frate := Fhandle.SampleRate;
  StreamBitrate := Fhandle.Bitrate;
end;

function TMMS.GetBufferPercentage: Integer;
begin
  Result := 0;
end;

procedure TMMS.GetPlayInfo(var Atitle: string; var Aquality: Cardinal);
begin
  Aquality := Fhandle.Bitrate div 1000;
end;

end.
