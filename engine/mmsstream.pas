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
    procedure StartPlay; override;
  public
    procedure GetPlayInfo(out Atitle: string; out Aquality, ABuffPercentage: Cardinal); override;
    function Open(const url: string): Boolean; override;
    destructor Destroy; override;
  end;

implementation

uses
  main, utils;

{ TMP3 }

destructor TMMS.Destroy;
begin
  inherited;
  if Assigned(Fhandle.reader) then
    lwma_async_reader_free(Fhandle);
end;

procedure TMMS.initdecoder;
begin
  lwma_async_reader_init(Fhandle);
  if not Assigned(Fhandle.reader) then
    RaiseError('ERRO, inicializando o decodificador wma (mms)');
end;

procedure TMMS.initbuffer;
begin
  Fbuffersize := DS.InitializeBuffer(Frate, Fchannels);
end;

procedure TMMS.StartPlay;
begin
  // WAIT TO PREBUFFER!
  repeat
    Sleep(50);
    if Terminated then Exit;
  until Fhandle.BlockList.Count > 5;
  initbuffer();

  updatebuffer();

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
    section := Fbuffersize;

  if section = Flastsection then Exit;

  DS.SoundBuffer.Lock(section, Fbuffersize, @buffer, @Size, nil, nil, 0);

  tmpbuffersize := Size;
  bufferPos := buffer;
  TotalDecoded := 0;
  
  repeat
    lwma_async_reader_get_data(Fhandle, tmpbuffer, tmpbuffersize);
    Move(tmpbuffer^,bufferPos^,tmpbuffersize);
    Inc(bufferPos, tmpbuffersize);
    Inc(TotalDecoded, tmpbuffersize);
    tmpbuffersize := Size - TotalDecoded;
  until TotalDecoded >= Size;

  DS.SoundBuffer.Unlock(buffer, Size, nil, 0);
  Flastsection := section;
end;

function TMMS.Open(const url: string): Boolean;
begin
  lwma_async_reader_open(Fhandle, url);
  Result := Fhandle.has_audio;
  if Result then
  begin
    Fchannels := Fhandle.channels;
    Frate := Fhandle.SampleRate;
    Status := rsPrebuffering;
    Resume;
  end;
end;

procedure TMMS.GetPlayInfo(out Atitle: string; out Aquality, ABuffPercentage: Cardinal);
begin
  Aquality := Fhandle.Bitrate div 1000;
end;

end.

