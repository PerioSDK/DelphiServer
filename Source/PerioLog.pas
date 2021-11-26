unit PerioLog;

interface

uses
  System.SysUtils,
  LoggerPro,
  LoggerPro.FileAppender,
  LoggerPro.ConsoleAppender;

Var
  PerioLogger : ILogWriter;

implementation

Var
  lLogsFolder : String;

initialization
  lLogsFolder := IncludeTrailingPathDelimiter(ExtractFilePath(GetModuleName(HInstance))) + 'logs';
  PerioLogger := BuildLogWriter([TLoggerProFileAppender.Create(5, 2000, lLogsFolder),TLoggerProConsoleAppender.Create]);


end.

