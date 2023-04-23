unit Qizmos.Events;

interface

uses
  EventBus,
  Qizmos.Types, Qizmos.Settings;

type
  IThemeChangeEvent = interface
    ['{CEC869F4-50DE-441F-8C81-BF2C4C2B4C93}']
  end;

  IModuleChangeEvent = interface
    ['{C52EBC6A-D733-44FD-8F0F-F4109D1290B0}']
    function GetFormId: TManagedFormId;
    property FormId: TManagedFormId read GetFormId;
  end;

  ISettingChangeEvent = interface
    ['{74A71D00-110F-46DE-8724-F5DBBF078FF2}']
    function GetValue: TApplicationSettingValue;
    property Value: TApplicationSettingValue read GetValue;
  end;

  TEventFactory = class
  public
    class function NewThemeChangeEvent: IThemeChangeEvent;
    class function NewModuleChangeEvent(
      const AFormId: TManagedFormId): IModuleChangeEvent;
    class function NewSettingChangeEvent(
      const AValue: TApplicationSettingValue): ISettingChangeEvent;
  end;

implementation

type
  TThemeChangeEvent = class(TInterfacedObject, IThemeChangeEvent);

  TModuleChangeEvent = class(TInterfacedObject, IModuleChangeEvent)
  private
    FFormId: TManagedFormId;
  protected
    function GetFormId: TManagedFormId;
  public
    constructor Create(const AFormId: TManagedFormId);
    property FormId: TManagedFormId read GetFormId;
  end;

  TSettingChangeEvent = class(TInterfacedObject, ISettingChangeEvent)
  private
    FValue: TApplicationSettingValue;
  protected
    function GetValue: TApplicationSettingValue;
  public
    constructor Create(const AValue: TApplicationSettingValue);
    property Value: TApplicationSettingValue read GetValue;
  end;

{ TEventFactory }

class function TEventFactory.NewModuleChangeEvent(
  const AFormId: TManagedFormId): IModuleChangeEvent;
begin
  Result := TModuleChangeEvent.Create(AFormId);
end;

class function TEventFactory.NewSettingChangeEvent(
  const AValue: TApplicationSettingValue): ISettingChangeEvent;
begin
  Result := TSettingChangeEvent.Create(AValue);
end;

class function TEventFactory.NewThemeChangeEvent;
begin
  Result := TThemeChangeEvent.Create;
end;

{ TModuleChangeEvent }

constructor TModuleChangeEvent.Create(const AFormId: TManagedFormId);
begin
  inherited Create;
  FFormId := AFormId;
end;

function TModuleChangeEvent.GetFormId: TManagedFormId;
begin
  Result := FFormId;
end;

{ TSettingChangeEvent }

constructor TSettingChangeEvent.Create(const AValue: TApplicationSettingValue);
begin
  inherited Create;
  FValue := AValue;
end;

function TSettingChangeEvent.GetValue: TApplicationSettingValue;
begin
  Result := FValue;
end;

end.
