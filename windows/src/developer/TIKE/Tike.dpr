program Tike;

uses
  Forms,
  Dialogs,
  Windows,
  ComObj,
  ActiveX,
  kmxfile in '..\..\global\delphi\general\kmxfile.pas',
  UfrmMDIChild in 'child\UfrmMDIChild.pas' {frmTikeChild},
  UfrmNew in 'dialogs\UfrmNew.pas' {frmNew},
  UfrmStartup in 'main\UfrmStartup.pas' {frmStartup},
  UfrmAboutTike in 'dialogs\UfrmAboutTike.pas' {frmAboutTike},
  RegistryKeys in '..\..\global\delphi\general\RegistryKeys.pas',
  VersionInfo in '..\..\global\delphi\general\VersionInfo.pas',
  compile in '..\..\global\delphi\general\compile.pas',
  KeymanDeveloperOptions in 'main\KeymanDeveloperOptions.pas',
  keyman32_int in '..\..\global\delphi\general\keyman32_int.pas',
  int_kmdebug in '..\..\global\delphi\general\int_kmdebug.pas',
  UfrmKeyTest in 'debug\UfrmKeyTest.pas' {frmKeyTest},
  CompilePackage in '..\..\global\delphi\general\CompilePackage.pas',
  KeymanDeveloperUtils in 'main\KeymanDeveloperUtils.pas',
  CRC32 in '..\..\global\delphi\general\CRC32.pas',
  ResourceStrings in '..\..\global\delphi\general\ResourceStrings.pas',
  UfrmEditor in 'child\UfrmEditor.pas' {frmEditor},
  MenuImgList in '..\..\global\delphi\comp\MenuImgList.pas',
  UfrmSelectKey in 'dialogs\UfrmSelectKey.pas' {frmSelectKey},
  keybtn in '..\..\global\delphi\comp\keybtn.pas',
  unicodepanel in '..\..\global\delphi\comp\unicodepanel.pas',
  ttinfo in '..\..\global\delphi\general\ttinfo.pas',
  KeyNames in '..\..\global\delphi\general\KeyNames.pas',
  PaintPanel in '..\..\global\delphi\comp\PaintPanel.pas',
  UfrmMDIEditor in 'child\UfrmMDIEditor.pas' {frmTikeEditor},
  Keyman.Developer.UI.Project.UfrmProject in 'project\Keyman.Developer.UI.Project.UfrmProject.pas' {frmProject},
  Keyman.Developer.System.Project.ProjectFile in 'project\Keyman.Developer.System.Project.ProjectFile.pas',
  Keyman.Developer.System.Project.ProjectFileType in 'project\Keyman.Developer.System.Project.ProjectFileType.pas',
  Keyman.Developer.System.Project.ProjectFiles in 'project\Keyman.Developer.System.Project.ProjectFiles.pas',
  Keyman.Developer.System.Project.kpsProjectFile in 'project\Keyman.Developer.System.Project.kpsProjectFile.pas',
  Keyman.Developer.System.Project.kmxProjectFile in 'project\Keyman.Developer.System.Project.kmxProjectFile.pas',
  Keyman.Developer.System.Project.kmnProjectFile in 'project\Keyman.Developer.System.Project.kmnProjectFile.pas',
  Keyman.Developer.UI.Project.UfrmProjectSettings in 'project\Keyman.Developer.UI.Project.UfrmProjectSettings.pas' {frmProjectSettings},
  Keyman.Developer.UI.Project.ProjectFileUI in 'project\Keyman.Developer.UI.Project.ProjectFileUI.pas',
  Keyman.Developer.UI.Project.ProjectUI in 'project\Keyman.Developer.UI.Project.ProjectUI.pas',
  Keyman.Developer.UI.Project.ProjectUIFileType in 'project\Keyman.Developer.UI.Project.ProjectUIFileType.pas',
  Keyman.Developer.UI.Project.kmnProjectFileUI in 'project\Keyman.Developer.UI.Project.kmnProjectFileUI.pas',
  Keyman.Developer.UI.Project.kpsProjectFileUI in 'project\Keyman.Developer.UI.Project.kpsProjectFileUI.pas',
  Keyman.Developer.UI.Project.kmxProjectFileUI in 'project\Keyman.Developer.UI.Project.kmxProjectFileUI.pas',
  Keyman.Developer.UI.Project.kvkProjectFileUI in 'project\Keyman.Developer.UI.Project.kvkProjectFileUI.pas',
  Keyman.Developer.UI.Project.ProjectFilesUI in 'project\Keyman.Developer.UI.Project.ProjectFilesUI.pas',
  Keyman.Developer.System.Project.ProjectLog in 'project\Keyman.Developer.System.Project.ProjectLog.pas',
  Keyman.Developer.System.Project.Project in 'project\Keyman.Developer.System.Project.Project.pas',
  Keyman.Developer.System.Project.kvkProjectFile in 'project\Keyman.Developer.System.Project.kvkProjectFile.pas',
  Keyman.Developer.System.Project.ProjectLoader in 'project\Keyman.Developer.System.Project.ProjectLoader.pas',
  Keyman.Developer.System.Project.ProjectSaver in 'project\Keyman.Developer.System.Project.ProjectSaver.pas',
  VKeys in '..\..\global\delphi\general\VKeys.pas',
  Unicode in '..\..\global\delphi\general\Unicode.pas',
  debugging in 'main\debugging.pas',
  keymanstrings in 'rel\keymanstrings.pas',
  kwhelp in 'help\kwhelp.pas',
  UKeyBitmap in 'main\UKeyBitmap.pas',
  UfrmSelectSystemKeyboard in 'debug\UfrmSelectSystemKeyboard.pas' {frmSelectSystemKeyboard},
  RegressionTest in 'debug\RegressionTest.pas',
  DebugListView in '..\..\global\delphi\comp\DebugListView.pas',
  DebugBitBtn in '..\..\global\delphi\comp\DebugBitBtn.pas',
  DebugListBox in '..\..\global\delphi\comp\DebugListBox.pas',
  GetOsVersion in '..\..\global\delphi\general\GetOsVersion.pas',
  PackageFileFormats in '..\..\global\delphi\general\PackageFileFormats.pas',
  PackageInfo in '..\..\global\delphi\general\PackageInfo.pas',
  kmpinffile in '..\..\global\delphi\general\kmpinffile.pas',
  RedistFiles in 'main\RedistFiles.pas',
  UfrmBitmapEditor in 'child\UfrmBitmapEditor.pas' {frmBitmapEditor},
  HintLabel in '..\..\global\delphi\comp\HintLabel.pas',
  VisualKeyboard in '..\..\global\delphi\visualkeyboard\VisualKeyboard.pas',
  VisualKeyboardExportHTML in '..\..\global\delphi\visualkeyboard\VisualKeyboardExportHTML.pas',
  VisualKeyboardParameters in '..\..\global\delphi\visualkeyboard\VisualKeyboardParameters.pas',
  VisualKeyboardSaverXML in '..\..\global\delphi\visualkeyboard\VisualKeyboardSaverXML.pas',
  VisualKeyboardImportXML in '..\..\global\delphi\visualkeyboard\VisualKeyboardImportXML.pas',
  UfrmVisualKeyboardImportKMX in 'dialogs\UfrmVisualKeyboardImportKMX.pas' {frmVisualKeyboardImportKMX},
  PanelOverlapped in '..\..\global\delphi\comp\PanelOverlapped.pas',
  SHDocVw_TLB in '..\..\global\delphi\comp\SHDocVw_TLB.pas',
  ScanCodeMap in '..\..\global\delphi\general\ScanCodeMap.pas',
  UfrmRegressionTestFailure in 'dialogs\UfrmRegressionTestFailure.pas' {frmRegressionTestFailure},
  XString in '..\..\global\delphi\general\XString.pas',
  debugkeyboard in 'debug\debugkeyboard.pas',
  UfrmMustIncludeDebug in 'dialogs\UfrmMustIncludeDebug.pas' {frmMustIncludeDebug},
  debugdeadkeys in 'debug\debugdeadkeys.pas',
  MessageIdentifiers in 'main\MessageIdentifiers.pas',
  exceptionw in '..\..\global\delphi\general\exceptionw.pas',
  kpsfile in '..\..\global\delphi\general\kpsfile.pas',
  Keyman.UI.UframeCEFHost in '..\..\global\delphi\chromium\Keyman.UI.UframeCEFHost.pas' {frameCEFHost},
  UnitDrawArrow in '..\..\global\delphi\general\UnitDrawArrow.pas',
  StockObjects in 'kct\StockObjects.pas',
  CustomisationStorage in '..\..\global\delphi\cust\CustomisationStorage.pas',
  klog in '..\..\global\delphi\general\klog.pas',
  custinterfaces in '..\..\global\delphi\cust\custinterfaces.pas',
  CustomisationMessages in '..\..\global\delphi\cust\CustomisationMessages.pas',
  StockMessages in '..\..\global\delphi\cust\StockMessages.pas',
  HeadingCheckListBox in '..\..\global\delphi\comp\HeadingCheckListBox.pas',
  BitmapEditor in '..\..\global\delphi\comp\BitmapEditor.pas',
  StringGridEditControlled in '..\..\global\delphi\comp\StringGridEditControlled.pas',
  KMDevResourceStrings in 'main\KMDevResourceStrings.pas',
  httpuploader in '..\..\global\delphi\general\httpuploader.pas',
  httpuploader_messageprocessor_forms in '..\..\global\delphi\general\httpuploader_messageprocessor_forms.pas',
  utilsystem in '..\..\global\delphi\general\utilsystem.pas',
  utilfiletypes in '..\..\global\delphi\general\utilfiletypes.pas',
  UfrmNewFileDetails in 'dialogs\UfrmNewFileDetails.pas' {frmNewFileDetails},
  CustomisationMenu in '..\..\global\delphi\cust\CustomisationMenu.pas',
  StockFileNames in '..\..\global\delphi\cust\StockFileNames.pas',
  CompileKeymanWeb in 'compile\CompileKeymanWeb.pas',
  KeymanWebKeyCodes in 'compile\KeymanWebKeyCodes.pas',
  utildir in '..\..\global\delphi\general\utildir.pas',
  OnlineConstants in '..\..\global\delphi\productactivation\OnlineConstants.pas',
  ADOX_TLB in '..\..\global\delphi\tlb\ADOX_TLB.pas',
  ADODB_TLB in '..\..\global\delphi\tlb\ADODB_TLB.pas',
  utilhttp in '..\..\global\delphi\general\utilhttp.pas',
  mrulist in 'main\mrulist.pas',
  Upload_Settings in '..\..\global\delphi\general\Upload_Settings.pas',
  MLang in '..\..\global\delphi\general\MLang.pas',
  FixedTrackbar in '..\..\global\delphi\comp\FixedTrackbar.pas',
  utilstr in '..\..\global\delphi\general\utilstr.pas',
  utilkeyboard in '..\..\global\delphi\general\utilkeyboard.pas',
  KeyboardParser in 'main\KeyboardParser.pas',
  TextFileFormat in 'main\TextFileFormat.pas',
  KMDActions in '..\..\global\delphi\comp\KMDActions.pas',
  KMDActionInterfaces in 'actions\KMDActionInterfaces.pas',
  UfrmHelp in 'main\UfrmHelp.pas' {frmHelp},
  OnScreenKeyboard in '..\..\global\delphi\comp\OnScreenKeyboard.pas',
  ExtShiftState in '..\..\global\delphi\comp\ExtShiftState.pas',
  CleartypeDrawCharacter in '..\..\global\delphi\general\CleartypeDrawCharacter.pas',
  CharMapDropTool in 'main\CharMapDropTool.pas',
  CharMapDropTool_EmbeddedWB in 'main\CharMapDropTool_EmbeddedWB.pas',
  UfrmBitmapEditorText in 'dialogs\UfrmBitmapEditorText.pas' {frmBitmapEditorText},
  UFixFontDialogBold in '..\..\global\delphi\general\UFixFontDialogBold.pas',
  UnicodeData in '..\..\global\delphi\charmap\UnicodeData.pas',
  CharacterDragObject in '..\..\global\delphi\charmap\CharacterDragObject.pas',
  CharacterMapSettings in '..\..\global\delphi\charmap\CharacterMapSettings.pas',
  CharacterRanges in '..\..\global\delphi\charmap\CharacterRanges.pas',
  CharMapInsertMode in '..\..\global\delphi\charmap\CharMapInsertMode.pas',
  UfrmCharacterMapFilter in '..\..\global\delphi\charmap\UfrmCharacterMapFilter.pas' {frmCharacterMapFilter},
  UfrmUnicodeDataStatus in '..\..\global\delphi\charmap\UfrmUnicodeDataStatus.pas' {frmUnicodeDataStatus},
  UfrmDebugStatus_RegTest in 'debug\UfrmDebugStatus_RegTest.pas' {frmDebugStatus_RegTest},
  UfrmDebugStatus_CallStack in 'debug\UfrmDebugStatus_CallStack.pas' {frmDebugStatus_CallStack},
  UfrmDebugStatus_Deadkeys in 'debug\UfrmDebugStatus_Deadkeys.pas' {frmDebugStatus_DeadKeys},
  UfrmDebugStatus_Elements in 'debug\UfrmDebugStatus_Elements.pas' {frmDebugStatus_Elements},
  UfrmDebugStatus in 'child\UfrmDebugStatus.pas' {frmDebugStatus},
  UfrmDebugStatus_Key in 'debug\UfrmDebugStatus_Key.pas' {frmDebugStatus_Key},
  UfrmDebugStatus_Child in 'debug\UfrmDebugStatus_Child.pas' {frmDebugStatus_Child},
  OnlineUpdateCheck in '..\..\global\delphi\online\OnlineUpdateCheck.pas',
  UfrmOnlineUpdateNewVersion in '..\..\global\delphi\online\UfrmOnlineUpdateNewVersion.pas' {frmOnlineUpdateNewVersion},
  DebugPaths in '..\..\global\delphi\general\DebugPaths.pas',
  MessageDefaults in 'kct\MessageDefaults.pas',
  UfrmDownloadProgress in 'main\UfrmDownloadProgress.pas' {frmDownloadProgress},
  UframeOnScreenKeyboardEditor in 'main\UframeOnScreenKeyboardEditor.pas' {frameOnScreenKeyboardEditor},
  UfrmOSKEditor in 'child\UfrmOSKEditor.pas' {frmOSKEditor},
  utilxml in '..\..\global\delphi\general\utilxml.pas',
  UfrmTike in 'main\UfrmTike.pas' {TikeForm},
  UfrmOnlineUpdateSetup in '..\..\global\delphi\online\UfrmOnlineUpdateSetup.pas' {frmOnlineUpdateSetup},
  OnlineUpdateCheckMessages in 'main\OnlineUpdateCheckMessages.pas',
  VisualKeyboardExportBMP in '..\..\global\delphi\visualkeyboard\VisualKeyboardExportBMP.pas',
  VisualKeyboardExportPNG in '..\..\global\delphi\visualkeyboard\VisualKeyboardExportPNG.pas',
  MSXML2_TLB in '..\..\global\delphi\tlb\MSXML2_TLB.pas',
  CharacterInfo in 'main\CharacterInfo.pas',
  CompilePackageInstaller in '..\..\global\delphi\general\CompilePackageInstaller.pas',
  UTikeDebugMode in 'main\UTikeDebugMode.pas',
  kmxfileconsts in '..\..\global\delphi\general\kmxfileconsts.pas',
  kmxfileutils in '..\..\global\delphi\general\kmxfileutils.pas',
  UfrmSelectWindowsLanguages in 'dialogs\languages\UfrmSelectWindowsLanguages.pas' {frmSelectWindowsLanguages: TTntForm},
  Keyman.Developer.UI.UfrmSelectBCP47Language in 'dialogs\languages\Keyman.Developer.UI.UfrmSelectBCP47Language.pas' {frmSelectBCP47Language: TTntForm},
  WindowsLanguages in '..\..\global\delphi\general\WindowsLanguages.pas',
  wininet5 in '..\..\global\delphi\general\wininet5.pas',
  TextFileTemplates in 'main\TextFileTemplates.pas',
  ExternalExceptionHandler in '..\..\global\delphi\general\ExternalExceptionHandler.pas',
  GlobalProxySettings in '..\..\global\delphi\general\GlobalProxySettings.pas',
  ErrLogPath in '..\..\global\delphi\general\ErrLogPath.pas',
  UfrmFontHelper in 'dialogs\UfrmFontHelper.pas' {Form1},
  WebSoundControl in '..\..\global\delphi\general\WebSoundControl.pas',
  VKeyChars in '..\..\global\delphi\general\VKeyChars.pas',
  usp10 in '..\..\global\delphi\general\usp10.pas',
  UserMessages in '..\..\global\delphi\general\UserMessages.pas',
  utilmsxml in '..\..\global\delphi\general\utilmsxml.pas',
  ErrorControlledRegistry in '..\..\global\delphi\vcl\ErrorControlledRegistry.pas',
  UframeBitmapEditor in 'main\UframeBitmapEditor.pas' {frameBitmapEditor: TFrame},
  UfrmMessages in 'main\UfrmMessages.pas' {frmMessages},
  dmActionsKeyboardEditor in 'actions\dmActionsKeyboardEditor.pas' {modActionsKeyboardEditor: TDataModule},
  dmActionsMain in 'actions\dmActionsMain.pas' {modActionsMain: TDataModule},
  dmActionsTextEditor in 'actions\dmActionsTextEditor.pas' {modActionsTextEditor: TDataModule},
  UfrmCharacterMapNew in '..\..\global\delphi\charmap\UfrmCharacterMapNew.pas' {frmCharacterMapNew},
  UframeTextEditor in 'main\UframeTextEditor.pas' {frameTextEditor},
  UfrmVisualKeyboardExportBMPParams in '..\..\global\delphi\visualkeyboard\UfrmVisualKeyboardExportBMPParams.pas' {frmVisualKeyboardExportBMPParams},
  UfrmVisualKeyboardExportHTMLParams in '..\..\global\delphi\visualkeyboard\UfrmVisualKeyboardExportHTMLParams.pas' {frmVisualKeyboardExportHTMLParams},
  UfrmVisualKeyboardKeyBitmap in '..\..\global\delphi\visualkeyboard\UfrmVisualKeyboardKeyBitmap.pas' {frmVisualKeyboardKeyBitmap},
  UfrmOptions in 'dialogs\UfrmOptions.pas' {frmOptions},
  UfrmDebug in 'child\UfrmDebug.pas' {frmDebug},
  UfrmPackageEditor in 'child\UfrmPackageEditor.pas' {frmPackageEditor},
  utilexecute in '..\..\global\delphi\general\utilexecute.pas',
  KeymanVersion in '..\..\global\delphi\general\KeymanVersion.pas',
  CaptionPanel in '..\..\global\delphi\comp\CaptionPanel.pas',
  Glossary in '..\..\global\delphi\general\Glossary.pas',
  UframeTouchLayoutBuilder in 'oskbuilder\UframeTouchLayoutBuilder.pas' {frameTouchLayoutBuilder},
  TouchLayoutUtils in 'oskbuilder\TouchLayoutUtils.pas' {,
  UfrmSelectTouchLayoutTemplate in 'oskbuilder\UfrmSelectTouchLayoutTemplate.pas' {frmSelectTouchLayoutTemplate},
  UfrmSelectTouchLayoutTemplate in 'oskbuilder\UfrmSelectTouchLayoutTemplate.pas' {frmSelectTouchLayoutTemplate},
  OnScreenKeyboardData in '..\..\global\delphi\visualkeyboard\OnScreenKeyboardData.pas',
  TouchLayout in 'oskbuilder\TouchLayout.pas',
  TouchLayoutDefinitions in 'oskbuilder\TouchLayoutDefinitions.pas',
  CharMapDropTool_TntCustomEdit in 'main\CharMapDropTool_TntCustomEdit.pas',
  DebugUtils in 'debug\DebugUtils.pas',
  keyman_msctf in '..\..\global\delphi\winapi\keyman_msctf.pas',
  Winapi.UxTheme,
  CheckboxGridHelper in '..\..\global\delphi\general\CheckboxGridHelper.pas',
  UfrmAddKeyboardFeature in 'dialogs\UfrmAddKeyboardFeature.pas' {frmAddKeyboardFeature},
  LeftTabbedPageControl in '..\..\global\delphi\comp\LeftTabbedPageControl.pas',
  UmodWebHttpServer in 'web\UmodWebHttpServer.pas' {modWebHttpServer: TDataModule},
  TempFileManager in '..\..\global\delphi\general\TempFileManager.pas',
  UfrmKeymanWizard in 'child\UfrmKeymanWizard.pas' {frmKeymanWizard},
  UfrmKeyboardFonts in 'dialogs\UfrmKeyboardFonts.pas' {frmKeyboardFonts},
  CompileErrorCodes in '..\..\global\delphi\general\CompileErrorCodes.pas',
  KeyboardFonts in '..\..\global\delphi\general\KeyboardFonts.pas',
  SHDocVw in '..\..\global\delphi\vcl\SHDocVw.pas',
  utiltsf in '..\..\global\delphi\general\utiltsf.pas',
  JsonUtil in '..\..\global\delphi\general\JsonUtil.pas',
  TikeUnicodeData in 'main\TikeUnicodeData.pas',
  UKeymanTargets in '..\..\global\delphi\general\UKeymanTargets.pas',
  UfrmSMTPSetup in 'dialogs\UfrmSMTPSetup.pas' {frmSMTPSetup},
  UfrmSendURLsToEmail in 'dialogs\UfrmSendURLsToEmail.pas' {frmSendURLsToEmail},
  MSXMLDomCreate in '..\..\global\delphi\general\MSXMLDomCreate.pas',
  webhelp in 'help\webhelp.pas',
  UMD5Hash in '..\..\global\delphi\general\UMD5Hash.pas',
  Vcl.Themes,
  Vcl.Styles,
  UfrmMain in 'main\UfrmMain.pas' {frmKeymanDeveloper},
  UfrmCharacterIdentifier in 'main\UfrmCharacterIdentifier.pas' {frmCharacterIdentifier},
  utilcheckfontchars in '..\..\global\delphi\charmap\utilcheckfontchars.pas',
  findfonts in '..\..\global\delphi\general\findfonts.pas',
  KeymanPaths in '..\..\global\delphi\general\KeymanPaths.pas',
  utiljclexception in '..\..\global\delphi\general\utiljclexception.pas',
  keymanapi_TLB in '..\..\engine\kmcomapi\keymanapi_TLB.pas',
  VisualKeyboardLoaderXML in '..\..\global\delphi\visualkeyboard\VisualKeyboardLoaderXML.pas',
  VisualKeyboardExportXML in '..\..\global\delphi\visualkeyboard\VisualKeyboardExportXML.pas',
  VisualKeyboardLoaderBinary in '..\..\global\delphi\visualkeyboard\VisualKeyboardLoaderBinary.pas',
  VisualKeyboardSaverBinary in '..\..\global\delphi\visualkeyboard\VisualKeyboardSaverBinary.pas',
  DropTarget in '..\..\global\delphi\general\DropTarget.pas',
  CloseButtonPageControl in '..\..\global\delphi\comp\CloseButtonPageControl.pas',
  UfrmTIKEDock in 'dockforms\UfrmTIKEDock.pas' {TIKEDockForm},
  KeymanDeveloperDebuggerMemo in '..\..\global\delphi\comp\KeymanDeveloperDebuggerMemo.pas',
  UfrmCharacterMapDock in 'dockforms\UfrmCharacterMapDock.pas' {frmCharacterMapDock},
  Keyman.System.PackageInfoRefreshKeyboards in '..\..\global\delphi\packages\Keyman.System.PackageInfoRefreshKeyboards.pas',
  Keyman.System.Standards.ISO6393ToBCP47Registry in '..\..\global\delphi\standards\Keyman.System.Standards.ISO6393ToBCP47Registry.pas',
  Keyman.System.Standards.LCIDToBCP47Registry in '..\..\global\delphi\standards\Keyman.System.Standards.LCIDToBCP47Registry.pas',
  Keyman.System.KeyboardJSInfo in '..\..\global\delphi\keyboards\Keyman.System.KeyboardJSInfo.pas',
  Keyman.System.KeyboardUtils in '..\..\global\delphi\keyboards\Keyman.System.KeyboardUtils.pas',
  BCP47Tag in '..\..\global\delphi\general\BCP47Tag.pas',
  Keyman.System.KMXFileLanguages in '..\..\global\delphi\keyboards\Keyman.System.KMXFileLanguages.pas',
  Keyman.System.LanguageCodeUtils in '..\..\global\delphi\general\Keyman.System.LanguageCodeUtils.pas',
  Keyman.System.RegExGroupHelperRSP19902 in '..\..\global\delphi\general\Keyman.System.RegExGroupHelperRSP19902.pas',
  Keyman.System.UpdateCheckResponse in '..\..\global\delphi\general\Keyman.System.UpdateCheckResponse.pas',
  Keyman.Developer.System.HelpTopics in 'help\Keyman.Developer.System.HelpTopics.pas',
  Keyman.System.Standards.BCP47SubtagRegistry in '..\..\global\delphi\standards\Keyman.System.Standards.BCP47SubtagRegistry.pas',
  Keyman.System.Standards.BCP47SuppressScriptRegistry in '..\..\global\delphi\standards\Keyman.System.Standards.BCP47SuppressScriptRegistry.pas',
  Keyman.System.Standards.NRSIAllTagsRegistry in '..\..\global\delphi\standards\Keyman.System.Standards.NRSIAllTagsRegistry.pas',
  Keyman.System.CanonicalLanguageCodeUtils in '..\..\global\delphi\general\Keyman.System.CanonicalLanguageCodeUtils.pas',
  Keyman.System.CEFManager in '..\..\global\delphi\chromium\Keyman.System.CEFManager.pas',
  Keyman.Developer.System.HttpServer.Debugger in 'http\Keyman.Developer.System.HttpServer.Debugger.pas',
  Keyman.Developer.System.HttpServer.App in 'http\Keyman.Developer.System.HttpServer.App.pas',
  Keyman.Developer.System.HttpServer.Base in 'http\Keyman.Developer.System.HttpServer.Base.pas',
  Keyman.Developer.System.HttpServer.AppSource in 'http\Keyman.Developer.System.HttpServer.AppSource.pas',
  Keyman.UI.FontUtils in '..\..\global\delphi\general\Keyman.UI.FontUtils.pas',
  Keyman.Developer.System.TouchLayoutToVisualKeyboardConverter in '..\kmconvert\Keyman.Developer.System.TouchLayoutToVisualKeyboardConverter.pas',
  Keyman.Developer.System.Project.kmnProjectFileAction in 'project\Keyman.Developer.System.Project.kmnProjectFileAction.pas',
  Keyman.Developer.System.Project.kpsProjectFileAction in 'project\Keyman.Developer.System.Project.kpsProjectFileAction.pas',
  Keyman.Developer.UI.Project.UfrmNewProjectParameters in 'project\Keyman.Developer.UI.Project.UfrmNewProjectParameters.pas' {frmNewProjectParameters},
  Keyman.Developer.UI.Project.UfrmNewProject in 'project\Keyman.Developer.UI.Project.UfrmNewProject.pas' {frmNewProject},
  Keyman.Developer.System.KeyboardProjectTemplate in '..\kmconvert\Keyman.Developer.System.KeyboardProjectTemplate.pas',
  Keyman.Developer.UI.ImportWindowsKeyboardDialogManager in 'main\Keyman.Developer.UI.ImportWindowsKeyboardDialogManager.pas',
  Keyman.Developer.System.ImportWindowsKeyboard in '..\kmconvert\Keyman.Developer.System.ImportWindowsKeyboard.pas',
  Keyman.Developer.System.ImportKeyboardDLL in '..\kmconvert\Keyman.Developer.System.ImportKeyboardDLL.pas',
  Keyman.System.Util.RenderLanguageIcon in '..\..\global\delphi\ui\Keyman.System.Util.RenderLanguageIcon.pas';

{$R *.RES}
{$R ICONS.RES}
{$R VERSION.RES}
{$R MANIFEST.RES}

// CEF3 needs to set the LARGEADDRESSAWARE flag which allows 32-bit processes to use up to 3GB of RAM.
// If you don't add this flag the rederer process will crash when you try to load large images.
{$SetPEFlags IMAGE_FILE_LARGE_ADDRESS_AWARE}

begin
  CoInitFlags := COINIT_APARTMENTTHREADED;

  FInitializeCEF := TCEFManager.Create(SFolderKeymanDeveloper);
  try
    if FInitializeCEF.Start then
    begin
      InitThemeLibrary;
      SetThemeAppProperties(STAP_ALLOW_NONCLIENT or STAP_ALLOW_CONTROLS or STAP_ALLOW_WEBCONTENT);
      Application.Initialize;
    //  TStyleManager.TrySetStyle(FKeymanDeveloperOptions.DisplayTheme);
      Application.Title := 'Keyman Developer';
      //TBX.TBXSetTheme('OfficeXP2');
      if TikeActive then Exit;
      InitClasses;
      Application.CreateForm(TmodWebHttpServer, modWebHttpServer);
  Application.CreateForm(TfrmKeymanDeveloper, frmKeymanDeveloper);
  ShowStartup;
      Application.Run;
    end;
  finally
    FInitializeCEF.Free;
  end;
end.
