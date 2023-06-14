unit edit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  ExtCtrls;

type

  { TfEdit }

  TfEdit = class(TForm)
    bSave: TBitBtn;
    bCancel: TBitBtn;
    eBrand: TEdit;
    eEngine: TEdit;
    ePrice: TEdit;
    eModel: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  fEdit: TfEdit;

implementation

{$R *.lfm}

{ TfEdit }

procedure TfEdit.FormShow(Sender: TObject);
begin
  eBrand.SetFocus;
end;

end.

