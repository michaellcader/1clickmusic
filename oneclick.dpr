{ KOL MCK } // Do not remove this line!
program oneclick;

{$R 'Form1_TrayIcon1.res' 'Form1_TrayIcon1.rc'}

uses
KOL,
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas' {Form2};

//{$R *.res}

begin // PROGRAM START HERE -- Please do not remove this comment

{$IFDEF KOL_MCK} {$I oneclick_0.inc} {$ELSE}

  {$IFDEF KOL_MCK}{$I oneclick_0.inc}{$ELSE}
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
  {$ENDIF}

{$ENDIF}

end.
