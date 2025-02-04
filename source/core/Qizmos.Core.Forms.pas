unit Qizmos.Core.Forms;

interface

uses
  System.Classes,
  Vcl.Forms,
  Qodelib.ManagedForms, Qodelib.NavigationView,
  Qizmos.Core.Types;

type
  TManagedForm = class(TQzManagedForm)
  private
    FButtonItem: TQzNavigationButtonItem;
  protected
    procedure FontChanged; override;
    procedure ActiveFormChanged(ActiveForm: TQzManagedForm); override;
  public
    procedure AfterConstruction; override;
    procedure KeyDownEvent(var Key: Word; Shift: TShiftState); virtual;
    property ButtonItem: TQzNavigationButtonItem read FButtonItem write FButtonItem;
  end;

  TDialogForm = class(TForm)
  public
    procedure AfterConstruction; override;
  end;

  TNavigationViewFormHelper = class
  private
    FForm: TManagedForm;
    FNavigationView: TQzNavigationView;
  protected
    property Form: TManagedForm read FForm;
    property NavigationView: TQzNavigationView read FNavigationView;
  public
    constructor Create(const AForm: TManagedForm;
      const ANavigationView: TQzNavigationView);
    function AddForm(const AFormClass: TQzManagedFormClass): TQzManagedForm;
  end;

implementation

uses
  Qizmos.Core.Settings;

{ TDialogForm }

procedure TDialogForm.AfterConstruction;
begin
  inherited;
  Font.Name := DefaultFontName;
  Font.Size := ApplicationSettings.FontSize;
end;

{ TManagedForm }

procedure TManagedForm.ActiveFormChanged(ActiveForm: TQzManagedForm);
var
  ButtonItem: TQzNavigationButtonItem;
begin
  inherited;

  if ActiveForm is TManagedForm then
    begin
      ButtonItem := TManagedForm(ActiveForm).ButtonItem;
      if Assigned(ButtonItem) then
        ButtonItem.NavigationView.ItemIndex := ButtonItem.Index;
    end;
end;

procedure TManagedForm.AfterConstruction;
begin
  inherited;
  FontChanged;
  ThemeChanged;
end;

procedure TManagedForm.FontChanged;
begin
  inherited;
  Font.Name := DefaultFontName; // Settings?
  Font.Size := ApplicationSettings.FontSize;
end;

procedure TManagedForm.KeyDownEvent(var Key: Word; Shift: TShiftState);
begin
  if Assigned(ManagedForms.ActiveForm) and (ManagedForms.ActiveForm is TManagedForm) then
    TManagedForm(ManagedForms.ActiveForm).KeyDownEvent(Key, Shift);
end;

{ TNavigationViewFormHelper }

function TNavigationViewFormHelper.AddForm(
  const AFormClass: TQzManagedFormClass): TQzManagedForm;
var
  Item: TQzNavigationButtonItem;
begin
  Result := Form.ManagedForms.AddForm(AFormClass);
  Item := FNavigationView.Items.Add;
  Item.Caption := Result.Caption;
  Item.ImageIndex := Result.ImageIndex;
  Item.Tag := Result.FormId;
  if Result is TManagedForm then
    TManagedForm(Result).ButtonItem := Item;
end;

constructor TNavigationViewFormHelper.Create(const AForm: TManagedForm;
  const ANavigationView: TQzNavigationView);
begin
  FForm := AForm;
  FNavigationView := ANavigationView;
end;

end.
