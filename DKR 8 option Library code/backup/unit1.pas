unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SQLite3Conn, SQLDB, DB, Forms, Controls, Graphics, Dialogs,
  StdCtrls, DBGrids, edit;

type

  { TfMain }

  TfMain = class(TForm)
    ButOpenBd: TButton;
    ButAdd: TButton;
    ButChange: TButton;
    ButDel: TButton;
    ButSearch: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    eSearch: TEdit;
    Label1: TLabel;
    SQLite3Connection1: TSQLite3Connection;
    SQLQuery1: TSQLQuery;
    SQLQuery2: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    procedure ButOpenBdClick(Sender: TObject);
    procedure ButAddClick(Sender: TObject);
    procedure ButChangeClick(Sender: TObject);
    procedure ButDelClick(Sender: TObject);
    procedure ButSearchClick(Sender: TObject);
    procedure eSearchChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;

implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.ButOpenBdClick(Sender: TObject);
begin
  SQLQuery1.Close;
  SQLQuery1.SQL.Text:='select * from Library';
  SQLQuery1.Open;
  SQLQuery2.Close;
  SQLQuery2.SQL.Text:='select * from Library';
  SQLQuery2.Open;
  DBGrid1.Columns.Items[0].Width:=30;
  DBGrid1.Columns.Items[1].Width:=120;
  DBGrid1.Columns.Items[2].Width:=180;
  DBGrid1.Columns.Items[3].Width:=120;
  DBGrid1.Columns.Items[4].Width:=120;
end;

procedure TfMain.ButAddClick(Sender: TObject);
begin
  fEdit.eBrand.Text:= '';
  fEdit.eModel.Text:= '';
  fEdit.eEngine.Text:= '';
  fEdit.ePrice.Text:= '';
  fEdit.ModalResult:= mrNone;
  fEdit.ShowModal;
  if (fEdit.eBrand.Text= '') or (fEdit.eModel.Text= '') or (fEdit.eEngine.Text= '')
  or (fEdit.ePrice.Text= '') then exit;
  if fEdit.ModalResult <> mrOk then exit;
  SQLQuery1.Close;
  SQLQuery1.SQL.Text := 'insert into library (writer, name, page, price) values(:b,:m,:e,:p);';
  SQLQuery1.ParamByName('b').AsString := fEdit.eBrand.text;
  SQLQuery1.ParamByName('m').AsString := fEdit.eModel.text;
  SQLQuery1.ParamByName('e').AsString := fEdit.eEngine.text;
  SQLQuery1.ParamByName('p').AsString := fEdit.ePrice.text;
  SQLQuery1.ExecSQL;
  SQLTransaction1.Commit;
  SQLite3Connection1.DatabaseName := 'E:\2 курс\МДК 05.02 Разработка кода информационных систем\LAZARUS\KR-DKR\DKR 9\DKR 9 option Library code\school.db';
  SQLite3Connection1.CharSet := 'UTF8';
  SQLite3Connection1.Transaction := SQLTransaction1;
  try
    SQLite3Connection1.Open;
    SQLTransaction1.Active := True;
  except
    ShowMessage('Ошибка подключения к базе!');
  end;
  SQLQuery1.Close;
  SQLQuery1.SQL.Text:='select * from Library';
  SQLQuery1.Open;
  DBGrid1.Columns.Items[0].Width:=30;
  DBGrid1.Columns.Items[1].Width:=120;
  DBGrid1.Columns.Items[2].Width:=180;
  DBGrid1.Columns.Items[3].Width:=120;
  DBGrid1.Columns.Items[4].Width:=120;
end;

procedure TfMain.ButChangeClick(Sender: TObject);
begin
  fEdit.eBrand.Text:= SQLQuery1.Fields.FieldByName('writer').AsString;
  fEdit.eModel.Text:= SQLQuery1.Fields.FieldByName('name').AsString;
  fEdit.eEngine.Text:= SQLQuery1.Fields.FieldByName('page').AsString;
  fEdit.ePrice.Text:= SQLQuery1.Fields.FieldByName('price').AsString;
  fEdit.ModalResult:= mrNone;
  fEdit.ShowModal;
  if fEdit.ModalResult <> mrOk then exit;
  SQLQuery1.Edit;
  if not (fEdit.eBrand.Text= '') then SQLQuery1.Fields.FieldByName('writer').AsString := fEdit.eBrand.Text;
  if not (fEdit.eModel.Text= '') then SQLQuery1.Fields.FieldByName('name').AsString := fEdit.eModel.Text;
  if not (fEdit.eEngine.Text= '') then SQLQuery1.Fields.FieldByName('page').AsString := fEdit.eEngine.Text;
  if not (fEdit.ePrice.Text= '') then SQLQuery1.Fields.FieldByName('price').AsString := fEdit.ePrice.Text;
  Sqlquery1.Post;
  sqlquery1.ApplyUpdates;
  SQLTransaction1.Commit;
  SQLite3Connection1.DatabaseName := 'E:\2 курс\МДК 05.02 Разработка кода информационных систем\LAZARUS\KR-DKR\DKR 9\DKR 9 option Library code\school.db';
  SQLite3Connection1.CharSet := 'UTF8';
  SQLite3Connection1.Transaction := SQLTransaction1;
  try
    SQLite3Connection1.Open;
    SQLTransaction1.Active := True;
  except
    ShowMessage('Ошибка подключения к базе!');
  end;
  SQLQuery1.Close;
  SQLQuery1.SQL.Text:='select * from Library';
  SQLQuery1.Open;
  DBGrid1.Columns.Items[0].Width:=30;
  DBGrid1.Columns.Items[1].Width:=120;
  DBGrid1.Columns.Items[2].Width:=180;
  DBGrid1.Columns.Items[3].Width:=120;
  DBGrid1.Columns.Items[4].Width:=120;
end;

procedure TfMain.ButDelClick(Sender: TObject);
begin
  SQLQuery1.Delete;
  DBGrid1.Columns.Items[0].Width:=30;
  DBGrid1.Columns.Items[1].Width:=120;
  DBGrid1.Columns.Items[2].Width:=180;
  DBGrid1.Columns.Items[3].Width:=120;
  DBGrid1.Columns.Items[4].Width:=120;
end;

procedure TfMain.ButSearchClick(Sender: TObject);
begin
  if not (eSearch.text = '') then begin
  SQLQuery1.Close;
  SQLQuery1.SQL.Text := 'select * from Library where name = :m';
  SQLQuery1.ParamByName('m').AsString:= eSearch.text;
  SQLQuery1.Open;
  end
  else ShowMessage('Введите название книги для поиска записи!');
  DBGrid1.Columns.Items[0].Width:=30;
  DBGrid1.Columns.Items[1].Width:=120;
  DBGrid1.Columns.Items[2].Width:=180;
  DBGrid1.Columns.Items[3].Width:=120;
  DBGrid1.Columns.Items[4].Width:=120;
end;

procedure TfMain.eSearchChange(Sender: TObject);
begin

end;

procedure TfMain.FormCreate(Sender: TObject);
begin
  fMain.width:=600;
  SQLite3Connection1.DatabaseName := 'E:\2 курс\МДК 05.02 Разработка кода информационных систем\LAZARUS\KR-DKR\DKR 9\DKR 9 option Library code\school.db';
  SQLite3Connection1.CharSet := 'UTF8';
  SQLite3Connection1.Transaction := SQLTransaction1;
  try
    SQLite3Connection1.Open;
    SQLTransaction1.Active := True;
  except
    ShowMessage('Ошибка подключения к базе!');
  end;
end;

procedure TfMain.Label1Click(Sender: TObject);
begin

end;

end.
