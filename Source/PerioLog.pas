unit PerioLog;

interface

uses
  System.SysUtils,
  LoggerPro,
  LoggerPro.FileAppender
{$IFDEF MSWINDOWS}
  ,LoggerPro.ConsoleAppender
{$ENDIF}
  ;

Var
  PerioLogger : ILogWriter;

implementation

Var
  lLogsFolder : String;

initialization
  lLogsFolder := IncludeTrailingPathDelimiter(ExtractFilePath(GetModuleName(HInstance))) + 'logs';
{$IFDEF MSWINDOWS}
  PerioLogger := BuildLogWriter([TLoggerProFileAppender.Create(5, 2000, lLogsFolder),TLoggerProConsoleAppender.Create]);
{$ELSEIF DEFINED(ANDROID)}
  PerioLogger := BuildLogWriter([TLoggerProFileAppender.Create(5, 2000, lLogsFolder)]);
{$ENDIF}

end.

