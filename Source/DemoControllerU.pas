unit DemoControllerU;

interface

{$I dmvcframework.inc}

uses
  MVCFramework,
  MVCFramework.Logger,
  MVCFramework.Commons,
  Web.HTTPApp;

type

  [MVCPath('/')]
  TDemoController = class(TMVCController)
  public
    [MVCPath('/')]
    [MVCHTTPMethod([httpGET])]
    procedure Index;

    [MVCPath('/api/ext/trx')]
    [MVCHTTPMethod([httpPOST])]
    procedure AddEmployeeTrx; //Çalýþan Giriþ Çýkýþlarýný Kaydet

    [MVCPath('/api/ext/trx/($id)')]
    [MVCHTTPMethod([httpPUT])]
    procedure UpdEmployeeTrxById(id : integer); //id li Çalýþan Giriþ Çýkýþlarýný düzenle

    [MVCPath('/api/ext/trx/($id)')]
    [MVCHTTPMethod([httpDelete])]
    procedure DelEmployeeTrxById(id : integer); //id li Çalýþan Giriþ Çýkýþlarýný düzenle
  end;

implementation

uses
  System.SysUtils,
  MVCFramework.Serializer.JSONDataObjects,
  MVCFramework.Serializer.Commons,
  JSONDataObjects,
  PerioLog;

{ TDemoController }

procedure TDemoController.Index;
begin
  Render('Merhaba Perio Rest Api Demo Server Çalýþýyor! ' + TimeToStr(Time) );
end;

procedure TDemoController.AddEmployeeTrx;
var
  lJSON: TJSONObject;
begin
  lJSON := StrToJSONObject(Context.Request.Body);
  try
    PerioLogger.Info(' Data : ' + lJSON.ToJSON(True), 'AddEmployeeTrx');
    Render('{"status":"Successfuly added"}');
  finally
    lJSON.Free;
  end;
end;

procedure TDemoController.UpdEmployeeTrxById(id: integer);
var
  lJSON: TJSONObject;
begin
  lJSON := StrToJSONObject(Context.Request.Body);
  try
    PerioLogger.Info('id : ' + id.ToString + ' Data : ' + lJSON.ToJSON(True), 'UpdEmployeeTrxById');
    Render('{"status":"Successfuly updated"}');
  finally
    lJSON.Free;
  end;
end;

procedure TDemoController.DelEmployeeTrxById(id: integer);
begin
  PerioLogger.Info('id : ' + id.ToString, 'DelEmployeeTrxById');
  Render('{"status":"Successfuly deleted"}');
end;

end.
