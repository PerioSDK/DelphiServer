unit DemoWebModuleU;

interface

uses System.SysUtils,
  System.Classes,
  Web.HTTPApp,
  MVCFramework;

type
  TDemoWebModule = class(TWebModule)
    procedure WebModuleCreate(Sender: TObject);
    procedure WebModuleDestroy(Sender: TObject);

  private
    MVC: TMVCEngine;

  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TDemoWebModule;

implementation

{$R *.dfm}


uses
  MVCFramework.Commons,
  MVCFramework.Middleware.Authentication,
  AuthenticationU,
  DemoControllerU;

procedure TDemoWebModule.WebModuleCreate(Sender: TObject);
begin
  MVC := TMVCEngine.Create(Self,
    procedure(Config: TMVCConfig)
    begin
      Config[TMVCConfigKey.SessionTimeout] := '30';
    end);
  MVC.AddMiddleware(TMVCBasicAuthenticationMiddleware.Create(TAuthenticationSample.Create));
  MVC.AddController(TDemoController);
end;

procedure TDemoWebModule.WebModuleDestroy(Sender: TObject);
begin
  MVC.free;
end;

end.
