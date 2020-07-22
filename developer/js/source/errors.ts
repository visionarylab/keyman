/**
 * Error codes. Use these when logging messages.
 * 
 * Extends https://github.com/keymanapp/keyman/blob/99db3c0d2448f448242e6397f9d72e9a7ccee4b9/windows/src/global/inc/Comperr.h
 */
export enum KeymanCompilerError {
  CERR_LEXICAL_MODEL_MIN = 0x0800,
  CERR_LEXICAL_MODEL_MAX = 0x08FF,

  CERR_FATAL = 0x8000,
  CERR_ERROR = 0x4000,
  CERR_WARNING = 0x2000,
  CERR_MEMORY = 0x1000,  // N.B., probably unused in TypeScript

  CERR_FATAL_LM = CERR_FATAL | CERR_LEXICAL_MODEL_MIN,
  /* Place all fatal LM compiler errors here! */

  CERR_ERROR_LM = CERR_ERROR | CERR_LEXICAL_MODEL_MIN,
  /* Place all recoverable LM compiler errors here! */

  CERR_WARN_LM = CERR_WARNING | CERR_LEXICAL_MODEL_MIN,
  /* Place all LM compiler warnings here! */
  MixedNormalizationForms,
  DuplicateWordInSameFile,
}

const LOG_LEVEL_TITLE = {
  [0]: '',
  [KeymanCompilerError.CERR_WARNING]: 'Warning',
  [KeymanCompilerError.CERR_ERROR]: 'Error',
  [KeymanCompilerError.CERR_FATAL]: 'Fatal Error',
};

interface FilenameAndLineNo {
  readonly filename: string;
  readonly lineno: number;
}

/**
 * Logs compiler messages (warnings, errors, logs).
 * 
 * @param code Error code
 * @param message A helpful message!
 * @param source [optional] the filename/line number in the source that induced this error
 * 
 * @see https://github.com/keymanapp/keyman/blob/99db3c0d2448f448242e6397f9d72e9a7ccee4b9/windows/src/developer/TIKE/project/Keyman.Developer.System.Project.ProjectLog.pas#L60-L77
 */
export function log(code: KeymanCompilerError, message: string, source?: FilenameAndLineNo) {
  let logMessage = source
    ? new LogMessageFromSource(code, message, source)
    : new LogMessage(code, message);

  console.error(logMessage.format());
}

function determineLogLevelTitle(code: KeymanCompilerError): string {
  let level = code & 0xF000;
  return LOG_LEVEL_TITLE[level];
}

class LogMessage {
  readonly code: KeymanCompilerError;
  readonly message: string;

  constructor(code: KeymanCompilerError, message: string) {
    this.code = code;
    this.message = message;
  }

  format(): string {
    let prefix = determineLogLevelTitle(this.code);
    if (prefix)
      prefix = `${prefix}: `;

    return `${prefix}${h(this.code)} ${this.message}`   
  }

  get logLevel(): KeymanCompilerError {
    return this.code & 0xF000;
  }
}

class LogMessageFromSource extends LogMessage {
  readonly source: FilenameAndLineNo;

  constructor(code: KeymanCompilerError, message: string, source: FilenameAndLineNo) {
    super(code, message);
    this.source = source;
  }

  format(): string {
    let originalMessage = super.format();
    return `${this.filename} (${this.lineno}): ${originalMessage}`;
  }

  get filename(): string {
    return this.source.filename;
  }

  get lineno(): number {
    return this.source.lineno;
  }
}



/**
 * Format a number as a zero-padded 4 digit hexadecimal.
 */
function h(n: number) {
  let formatted = n.toString(16).toUpperCase();
  if (formatted.length < 4) {
    formatted = '0'.repeat(4 - formatted.length);
  }

  return formatted; 
}