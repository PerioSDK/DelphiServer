program PerioRestDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Web.WebReq,
  Web.WebBroker,
  IdHTTPWebBrokerBridge,
  MVCFramework.REPLCommandsHandlerU,
  MVCFramework.Logger,
  MVCFramework.Console,
  AuthenticationU in 'AuthenticationU.pas',
  DemoControllerU in 'DemoControllerU.pas',
  DemoWebModuleU in 'DemoWebModuleU.pas' {DemoWebModule: TWebModule},
  PerioLog in 'PerioLog.pas';

procedure RunServer(APort: Integer);
var
  lServer: TIdHTTPWebBrokerBridge;
  lCustomHandler: TMVCCustomREPLCommandsHandler;
  lCmd, lStartupCommand: string;
begin
  if ParamCount >= 1 then
    lStartupCommand := ParamStr(1)
  else
    lStartupCommand := 'start';

  lCustomHandler := function(const Value: String; const Server: TIdHTTPWebBrokerBridge; out Handled: Boolean): THandleCommandResult
    begin
      Handled := False;
      Result := THandleCommandResult.Unknown;

      // Write here your custom command for the REPL using the following form...
      // ***
      // Handled := False;
      // if (Value = 'apiversion') then
      // begin
      // REPLEmit('Print my API version number');
      // Result := THandleCommandResult.Continue;
      // Handled := True;
      // end
      // else if (Value = 'datetime') then
      // begin
      // REPLEmit(DateTimeToStr(Now));
      // Result := THandleCommandResult.Continue;
      // Handled := True;
      // end;
    end;
  //Writeln(Format('Starting HTTP Server or port %d', [APort]));
  LServer := TIdHTTPWebBrokerBridge.Create(nil);
  try
    LServer.DefaultPort := APort;
    Log(Format('Server started on port %d', [APort]));
    LServer.MaxConnections := 0;
    LServer.ListenQueue := 200;
    WriteLn('Write "quit" or "exit" to shutdown the server');
    repeat
      TextColor(RED);
      //TextColor(LightRed);
      Write('-> ');
      TextColor(White);
      if lStartupCommand.IsEmpty then
        ReadLn(lCmd)
      else
      begin
        lCmd := lStartupCommand;
        lStartupCommand := '';
        WriteLn(lCmd);
      end;

      case HandleCommand(lCmd.ToLower, LServer, lCustomHandler) of
        THandleCommandResult.Continue:
          begin
            Continue;
          end;
        THandleCommandResult.Break:
          begin
            Break;
          end;
        THandleCommandResult.Unknown:
          begin
            REPLEmit('Unknown command: ' + lCmd);
          end;
      end;
    until false;

  finally
    LServer.Free;
  end;
end;

begin
  ReportMemoryLeaksOnShutdown := True;
  try
    if WebRequestHandler <> nil then
      WebRequestHandler.WebModuleClass := WebModuleClass;
    WebRequestHandlerProc.MaxConnections := 1024;
    RunServer(8080);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
