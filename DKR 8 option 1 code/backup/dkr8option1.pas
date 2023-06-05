unit dkr8option1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls, MMSystem, DateUtils;

type
  { TForm1 }
  TForm1 = class(TForm)
    ustanovka: TButton;
    sbros: TButton;
    hour: TEdit;
    min: TEdit;
    Image1: TImage;
    nadpis: TLabel;
    textmin: TLabel;
    texthour: TLabel;
    Timer1: TTimer;
    const
      SoundFile = 'E:\2 курс\МДК 05.02 Разработка кода информационных систем\LAZARUS\KR-DKR\DKR 8\DKR 8 option 1 code\budilnik.wav';
    procedure texthourClick(Sender: TObject);
    procedure textminClick(Sender: TObject);
    procedure ustanovkaClick(Sender: TObject);
    procedure sbrosClick(Sender: TObject);
    procedure hourChange(Sender: TObject);
    procedure minChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure nadpisClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    FAlarmTime: TTime;
    FAlarmEnabled: Boolean;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  FAlarmEnabled := False;
  Image1.Picture.LoadFromFile('604x604.jpg');
end;

procedure TForm1.ustanovkaClick(Sender: TObject);
var
  AlarmHour, AlarmMin: Integer;
begin
  if TryStrToInt(hour.Text, AlarmHour) and TryStrToInt(min.Text, AlarmMin) then
  begin
    FAlarmTime := EncodeTime(AlarmHour, AlarmMin, 0, 0);
    nadpis.Caption := 'Будильник установлен на ' + Format('%d:%.2d', [AlarmHour, AlarmMin]);
    FAlarmEnabled := True;
    ustanovka.Enabled := False;
  end
  else
    ShowMessage('Введите время в формате "ЧЧ:ММ"');
end;

procedure TForm1.sbrosClick(Sender: TObject);
begin
  if FAlarmEnabled then
  begin
    FAlarmEnabled := False;
    ustanovka.Enabled := True;
    nadpis.Caption := '';
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  CurrentHour, CurrentMin, CurrentSec, CurrentMSec: Word;
begin
  DecodeTime(Time, CurrentHour, CurrentMin, CurrentSec, CurrentMSec);

  if FAlarmEnabled and (Time >= FAlarmTime) then
  begin
    FAlarmEnabled := False;
    ustanovka.Enabled := True;
    nadpis.Caption := '$$$$$Будильник сработал$$$$$';
    sndPlaySound(PChar('budilnik.wav'), SND_ASYNC or SND_FILENAME);
    Application.MessageBox('Будильник сработал!', 'Уведомление!');
  end;
end;

procedure TForm1.texthourClick(Sender: TObject);
begin
end;

procedure TForm1.textminClick(Sender: TObject);
begin
end;

procedure TForm1.hourChange(Sender: TObject);
begin
end;

procedure TForm1.minChange(Sender: TObject);
begin
end;

procedure TForm1.nadpisClick(Sender: TObject);
begin
  if FAlarmEnabled then
  begin
    FAlarmEnabled := False;
    ustanovka.Enabled := True;
    nadpis.Caption := '';
  end;
end;

procedure TForm1.Image1Click(Sender: TObject);
begin
end;

end.
