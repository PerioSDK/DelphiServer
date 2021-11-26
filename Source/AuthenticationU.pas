unit AuthenticationU;

interface

uses
  System.SysUtils, MVCFramework.Commons, System.Generics.Collections,
  MVCFramework;

type
  TAuthenticationSample = class(TInterfacedObject, IMVCAuthenticationHandler)
  protected
    procedure OnRequest(const AContext: TWebContext; const ControllerQualifiedClassName: string;
      const ActionName: string; var AuthenticationRequired: Boolean);
    procedure OnAuthentication(const AContext: TWebContext; const UserName: string; const Password: string;
      UserRoles: System.Generics.Collections.TList<System.string>;
      var IsValid: Boolean; const SessionData: TSessionData);
    procedure OnAuthorization(const AContext: TWebContext; UserRoles
      : System.Generics.Collections.TList<System.string>;
      const ControllerQualifiedClassName: string; const ActionName: string;
      var IsAuthorized: Boolean);
  end;

implementation

{ TMVCAuthorization }

procedure TAuthenticationSample.OnAuthentication(const AContext: TWebContext; const UserName: string;
  const Password: string;
  UserRoles: System.Generics.Collections.TList<System.string>;
  var IsValid: Boolean; const SessionData: TSessionData);
begin
  IsValid := UserName.Equals(Password); // Kullanýcý adý þifre ayný ise baþarýlý
end;

procedure TAuthenticationSample.OnAuthorization
  (const AContext: TWebContext; UserRoles
  : System.Generics.Collections.TList<System.string>;
  const ControllerQualifiedClassName: string; const ActionName: string;
  var IsAuthorized: Boolean);
begin
  IsAuthorized := True; //Rol Bazýnda Yetkilendirme Yok
end;

procedure TAuthenticationSample.OnRequest(const AContext: TWebContext; const ControllerQualifiedClassName: string;
  const ActionName: string; var AuthenticationRequired: Boolean);
begin
  AuthenticationRequired := (ActionName <> 'Index');
end;

end.
