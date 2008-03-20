unit DSoutput;

interface

uses
  SysUtils, Classes, Windows, MMSystem, _DirectSound;

{$MINENUMSIZE 4}

type
  TDSoutput = class
  private
    FDS: IDirectSound;
    FPrimary: IDirectSoundBuffer;
    FSecondary: IDirectSoundBuffer;
    function GetPlayCursorPos: Cardinal;
  public
    property PlayCursorPos: Cardinal read GetPlayCursorPos;
    property Device: IDirectSound read FDS;
    property SoundBuffer: IDirectSoundBuffer read FSecondary;
    procedure Play;
    procedure Stop;
    function InitializeBuffer(const Arate, Achannels: Cardinal): Cardinal;
    constructor Create;
    destructor Destroy; override;
  end;

  // ESQUELETO PARA OS PLAYERS

type
  TRadioStatus = (rsStoped, rsPrebuffering, rsPlaying, rsRecovering);

type
  TRadioPlayer = class(TThread)
  private
    FDevice: TDSoutput;
  protected
    Frate: Integer;
    Fchannels: Integer;
    Fencoding: Integer;
    Fbuffersize: Cardinal;
    Flastsection: Cardinal;
    procedure updatebuffer; virtual; abstract;
    procedure initbuffer; virtual; abstract;
    procedure initdecoder; virtual; abstract;
    property DS: TDSoutput read FDevice write FDevice;
    procedure Execute; override;
  public
    StreamBitrate: Integer;
    StreamTitle: string;
    Status: TRadioStatus;
    procedure Volume(const value: Integer);
    procedure GetPlayInfo(var Atitle: string; var Aquality: Cardinal); virtual; abstract;
    function GetBufferPercentage: Integer; virtual; abstract;
    function open(const url: string): Boolean; virtual; abstract;
    procedure Play; virtual; abstract;
    constructor Create(ADevice: TDSoutput);
    destructor Destroy; override;
  end;

procedure DSCHECK(const value : HResult;const Where : string);

implementation

uses
  main;

{ TDSoutput }

{function DSEnumOutputCallback(lpGuid: PGUID; lpcstrDescription: PChar;
  lpcstrModule: PChar; lpContext: Pointer): BOOL; stdcall;
begin
  Result := True;
end;}


procedure DSCHECK(const value : HResult;const Where : string);
var
  ErrorStr : string;
begin
  if value = DS_OK then Exit;
  case value of
    DSERR_ACCESSDENIED : ErrorStr := 'DSERR_ACCESSDENIED';
    DSERR_BUFFERTOOSMALL : ErrorStr := 'DSERR_BUFFERTOOSMALL';
    DSERR_ALLOCATED: ErrorStr := 'DSERR_ALLOCATED';
    DSERR_INVALIDPARAM: ErrorStr := 'DSERR_INVALIDPARAM';
    DSERR_INVALIDCALL: ErrorStr := 'DSERR_INVALIDCALL';
    DSERR_GENERIC: ErrorStr := 'DSERR_GENERIC';
    DSERR_BADFORMAT: ErrorStr := 'DSERR_BADFORMAT';
    DSERR_UNSUPPORTED: ErrorStr := 'DSERR_UNSUPPORTED';
    DSERR_NODRIVER: ErrorStr := 'DSERR_NODRIVER';
    DSERR_ALREADYINITIALIZED: ErrorStr := 'DSERR_ALREADYINITIALIZED';
    DSERR_NOINTERFACE : ErrorStr := 'DSERR_NOINTERFACE';
  end;
  raise Exception.CreateFmt('ERRO, [%s] : %s',[ErrorStr,Where]);
end;


constructor TDSoutput.Create;
var
  Fpwfm: TWAVEFORMATEX;
  Fpdesc: TDSBUFFERDESC;
begin
  //DirectSoundEnumerate(DSEnumOutputCallback, Self);
  // CREATING DEVICE FOR DEFAULT SOUND DRIVER
  //if DirectSoundCreate(nil, FDS, nil) <> DS_OK then
  //  raise Exception.Create('ERRO, criando o device do DirectSound');
  DSCHECK(DirectSoundCreate(nil, FDS, nil),'Creating DS device');

  //if FDS.SetCooperativeLevel(GetDesktopWindow, DSSCL_PRIORITY) <> DS_OK then
  //  raise Exception.Create('ERRO, negociando o cooperative level');
  DSCHECK(FDS.SetCooperativeLevel(GetDesktopWindow, DSSCL_PRIORITY),'Setting the cooperative level');

  FillChar(Fpdesc, SizeOf(TDSBUFFERDESC), 0);
  Fpdesc.dwSize := SizeOf(TDSBUFFERDESC);
  Fpdesc.dwFlags := DSBCAPS_PRIMARYBUFFER;
  Fpdesc.lpwfxFormat := nil;
  Fpdesc.dwBufferBytes := 0;

  //if FDS.CreateSoundBuffer(Fpdesc, Fprimary, nil) <> DS_OK then
  //  raise Exception.Create('ERRO, criando o buffer primario');
  DSCHECK(FDS.CreateSoundBuffer(Fpdesc, Fprimary, nil),'Creating Primary buffer');

  FillChar(Fpwfm, SizeOf(TWAVEFORMATEX), 0);
  Fpwfm.wFormatTag := WAVE_FORMAT_PCM;
  Fpwfm.nChannels := 2;
  Fpwfm.nSamplesPerSec := 44100;
  Fpwfm.nBlockAlign := 4;
  Fpwfm.wBitsPerSample := 16;
  Fpwfm.cbSize := 0;
  Fpwfm.nAvgBytesPerSec := 44100 * 4;

  //if FPrimary.SetFormat(@Fpwfm) <> DS_OK then
  //  raise Exception.Create('ERRO, setando formato do buffer primario');
  DSCHECK(FPrimary.SetFormat(@Fpwfm),'Chaning Primary buffer format');
end;

destructor TDSoutput.Destroy;
begin
  FPrimary := nil;
  FSecondary := nil;
  FDS := nil;
  inherited;
end;

function TDSoutput.GetPlayCursorPos: Cardinal;
begin
  if not Assigned(FSecondary) then Exit;
  FSecondary.GetCurrentPosition(@Result, nil);
end;

function TDSoutput.InitializeBuffer(const Arate, Achannels: Cardinal): Cardinal;
var
  Fswfm: TWAVEFORMATEX;
  Fsdesc: TDSBUFFERDESC;
  lastvolume: Integer;
begin
  lastvolume := 0;
  if FSecondary <> nil then
    FSecondary.GetVolume(lastvolume);
  FSecondary := nil;

  FillChar(Fswfm, SizeOf(TWAVEFORMATEX), 0);
  Fswfm.wFormatTag := WAVE_FORMAT_PCM;
  Fswfm.nChannels := Achannels;
  Fswfm.wBitsPerSample := 16;
  Fswfm.nSamplesPerSec := Arate;
  Fswfm.nBlockAlign := Achannels * 2;
  Fswfm.nAvgBytesPerSec := Arate * Achannels * 2;
  Fswfm.cbSize := 0;

  // set up the buffer
  FillChar(Fsdesc, SizeOf(TDSBUFFERDESC), 0);
  Fsdesc.dwSize := SizeOf(TDSBUFFERDESC);
  Fsdesc.dwReserved := 0;
  Fsdesc.dwFlags :=
    DSBCAPS_GETCURRENTPOSITION2 or
    DSBCAPS_CTRLVOLUME or
    DSBCAPS_GLOBALFOCUS;
  Fsdesc.lpwfxFormat := @Fswfm;
  Fsdesc.dwBufferBytes := 64 * 1024;

  if FDS.CreateSoundBuffer(Fsdesc, Fsecondary, nil) <> DS_OK then
    raise Exception.Create('ERRO, criando o buffer secundario');

  Result := Fsdesc.dwBufferBytes div 2;

  FSecondary.SetVolume(lastvolume);
end;

procedure TDSoutput.Play;
begin
  if Assigned(FSecondary) then
    FSecondary.Play(0, 0, DSBPLAY_LOOPING);
end;

procedure TDSoutput.Stop;
begin
  if Assigned(FSecondary) then
    FSecondary.Stop;
end;

{ TRadioPlayer }

constructor TRadioPlayer.Create(ADevice: TDSoutput);
begin
  // CREATE TRHEAD, SUSPENDED
  FDevice := ADevice;
  inherited Create(True);
  Priority := tpTimeCritical;
  initdecoder();
  Status := rsStoped;
end;

destructor TRadioPlayer.Destroy;
begin
  // DESTROY THREAD
  inherited;
end;

procedure TRadioPlayer.Execute;
var
  cs: TRTLCriticalSection;
begin
  InitializeCriticalSection(cs);
  repeat
    EnterCriticalSection(cs);
    UpdateBuffer;
    LeaveCriticalSection(cs);
    sleep(50);
  until Terminated;
  DeleteCriticalSection(cs);
end;

procedure TRadioPlayer.Volume(const value: Integer);
var
  curvolume: Integer;
begin
  if not Assigned(FDevice.SoundBuffer) then Exit;
  FDevice.SoundBuffer.GetVolume(curvolume);
  Inc(curvolume, value);
  if not ((curvolume < DSBVOLUME_MIN) or
    (curvolume > DSBVOLUME_MAX)) then
    FDevice.SoundBuffer.SetVolume(curvolume);
end;

end.

