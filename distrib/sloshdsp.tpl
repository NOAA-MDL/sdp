;sloshdsp.tpl--slosh display installer template
;to be used with slosh_nsi.tcl and all.text to create sloshdsp.nsi

;--------------------------------
; Script Definitions

!define prjDate "PRJDATE"
!define prjVer "PRJVER"
!define prjName "sloshdsp"

Var shortDir
Var Dialog
Var Checkbox
Var f_desktopShort

!define UninstLog "uninstall.log"
Var UninstLog_FP

!include nsDialogs.nsh
!include "MUI2.nsh"
!include LogicLib.nsh

!define MUI_ICON sloshdsp.ico

;-----------------------------------------------------------------------------
Function .onInit
  ; Make sure there is only one instance running at a time.
  System::Call 'kernel32::CreateMutexA(i 0, i 0, t "${prjName}Mutex") i .r1 ?e'
  Pop $R0
  StrCmp $R0 0 +3
    MessageBox MB_OK|MB_ICONEXCLAMATION "The installer is already running."
    Abort

;  System::Call 'kernel32::Beep(i 800,i 100) l'
FunctionEnd

;-----------------------------------------------------------------------------
Function un.onInit
  ; Make sure there is only one instance running at a time.
  System::Call 'kernel32::CreateMutexA(i 0, i 0, t "${prjName}MutexUn") i .r1 ?e'
  Pop $R0
  StrCmp $R0 0 +3
    MessageBox MB_OK|MB_ICONEXCLAMATION "The uninstaller is already running."
    Abort

  StrCpy $INSTDIR "$INSTDIR\.."
FunctionEnd

;-----------------------------------------------------------------------------
; Allow the user to change the StartMenuGroup
Function StartMenuGroupSelect
	Push $R1
	StartMenu::Select /checknoshortcuts "Don't create a start menu folder" /autoadd /lastused $shortDir "SLOSH Display"
	Pop $R1

	StrCmp $R1 "success" success
	StrCmp $R1 "cancel" done
		; error
		MessageBox MB_OK $R1
		StrCpy $shortDir "SLOSH Display" # use default
		Return
	success:
	Pop $shortDir

	done:
	Pop $R1
FunctionEnd

;-----------------------------------------------------------------------------
; Allow the user to choose to create a desktop shortcut
Function DesktopShortCut
  nsDialogs::Create /NOUNLOAD 1018
  Pop $Dialog

  ${If} $Dialog == error
    Abort
  ${EndIf}

  ${NSD_CreateCheckBox} 50u 8u 100% -8u "Create Shortcut on the Desktop?"
  Pop $Checkbox
;  ${NSD_Check} $Checkbox

  nsDialogs::Show
FunctionEnd

Function DesktopShortCutPageLeave
  ${NSD_GetState} $Checkbox $f_desktopShort
FunctionEnd

;-----------------------------------------------------------------------------
Function LaunchLink
;  Avoid the execShell with the lnk since user may not create the .lnk file
;  ExecShell "" "$SMPROGRAMS\$shortDir\tkdegrib.lnk"
  Exec '"$INSTDIR\${prjName}\bin\tclkit854.exe" $INSTDIR\${prjName}\sloshdsp.kit'
FunctionEnd

;-----------------------------------------------------------------------------
; LogIt
!macro LogIt Cmd Path
 FileWrite $UninstLog_FP "${Cmd} ${Path}$\r$\n"
!macroend
!define LogIt "!insertmacro LogIt"

;--------------------------------

; The name of the installer
Name "SLOSH Display ${prjVer}"

; The file to write
OutFile "sloshdsp-install.exe"

BrandingText "${prjName} ${prjVer}"

; The default installation directory
InstallDir "c:\slosh.pkg"

; Request application privileges for Windows Vista
RequestExecutionLevel user

;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING


;--------------------------------
;Pages

; Title to display on the top of the page.
  !define MUI_WELCOMEPAGE_TITLE "Welcome to the SLOSH Display ${prjVer} Installation Wizard"
; Extra space for the title area.
;   !define MUI_WELCOMEPAGE_TITLE_3LINES
; Text to display on the page.
  !define MUI_WELCOMEPAGE_TEXT "This wizard will guide you through the installation of the SLOSH Display ${prjVer}$\n$\n\
      SLOSH Display ${prjVer} was created on ${prjDate}, by the$\n   Meteorological Development Laboratory$\n   \
      National Weather Service$\n   National Oceanic and Atmospheric Administration$\n   United States' Department of Commerce$\n$\n\
      It is recommended that you close all other applications$\n\
      before starting Setup.  This will make it possible to update$\n\
      relevant system files without having to reboot your$\n\
      computer.$\n$\n\
      Click Next to continue."

  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_LICENSE "..\DISCLAIMER.txt"
;  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY
  Page custom StartMenuGroupSelect "" ": Start Menu Folder"
  Page custom DesktopShortCut DesktopShortCutPageLeave ": Desktop Shortcuts"
  !insertmacro MUI_PAGE_INSTFILES

    # These indented statements modify settings for MUI_PAGE_FINISH
    !define MUI_FINISHPAGE_TITLE "Completing the SLOSH Display ${prjVer} Installation Wizard"
    !define MUI_FINISHPAGE_NOAUTOCLOSE
    !define MUI_FINISHPAGE_RUN
    !define MUI_FINISHPAGE_RUN_NOTCHECKED
    !define MUI_FINISHPAGE_RUN_TEXT "Start SLOSH Display"
    !define MUI_FINISHPAGE_RUN_FUNCTION "LaunchLink"
;    !define MUI_FINISHPAGE_SHOWREADME_NOTCHECKED
;    !define MUI_FINISHPAGE_SHOWREADME $INSTDIR\readme.txt
  !insertmacro MUI_PAGE_FINISH

; Title to display on the top of the page.
    !define MUI_WELCOMEPAGE_TITLE "Welcome to the SLOSH Display ${prjVer} Uninstall Wizard"
; Text to display on the page.
    !define MUI_WELCOMEPAGE_TEXT "This wizard will guide you through the uninstallation of SLOSH Display ${prjVer}$\n$\n\
      Before starting the uninstallation, make sure SLOSH Display is not running$\n$\n\
      Click Next to continue."
  !insertmacro MUI_UNPAGE_WELCOME
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
    !define MUI_FINISHPAGE_TITLE "Completing the SLOSH Display ${prjVer} Uninstall Wizard"
    !define MUI_FINISHPAGE_TEXT "SLOSH Display ${prjVer} has been uninstalled from your computer.$\n$\n\
     Click Finish to close this wizard."
  !insertmacro MUI_UNPAGE_FINISH

;--------------------------------
;Languages

  !insertmacro MUI_LANGUAGE "English"

;--------------------------------
;Section on opening log files
Section -openlogfile
        CreateDirectory "$INSTDIR"
        CreateDirectory "$INSTDIR\${prjName}"
        IfFileExists "$INSTDIR\${prjName}\${UninstLog}" +3
        FileOpen $UninstLog_FP "$INSTDIR\${prjName}\${UninstLog}" w
        Goto +4
        SetFileAttributes "$INSTDIR\${prjName}\${UninstLog}" NORMAL
        FileOpen $UninstLog_FP "$INSTDIR\${prjName}\${UninstLog}" a
        FileSeek $UninstLog_FP 0 END
SectionEnd

;--------------------------------


;--------------------------------

; The stuff to install
Section "SLOSH Display" ;No components page, name is not important

  ; Set output path to the installation directory.
  SetOutPath $INSTDIR

   ; Write the installation path into the registry
  WriteRegStr HKLM SOFTWARE\${prjName} "Install_Dir" "$INSTDIR"

  ; Write the uninstall keys for Windows
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${prjName}" "DisplayName" "SLOSH Display ${prjVer}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${prjName}" "UninstallString" '"$INSTDIR\${prjName}\uninstall.exe"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${prjName}" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${prjName}" "NoRepair" 1
  WriteUninstaller "$INSTDIR\${prjName}\uninstall.exe"

  SetOutPath $INSTDIR\${prjName}

  PRJFILES
  PRJUNINST_FILE
  PRJUNINST_DIR

  IfFileExists "$EXEDIR\data\*.kit" KitExists KitDone
  KitExists:
    CopyFiles /SILENT $EXEDIR\data\*.kit $INSTDIR\${prjName}\data
  KitDone:

  IfFileExists "$EXEDIR\rexfiles\*.rex" RexExists RexDone
  RexExists:
    CopyFiles /SILENT $EXEDIR\rexfiles\*.rex $INSTDIR\${prjName}\rexfiles
  RexDone:

   # this part is only necessary if you used /checknoshortcuts
  StrCpy $R1 $shortDir 1
  StrCmp $R1 ">" skip
    CreateDirectory "$SMPROGRAMS\$shortDir"
    ;SetOutPath $INSTDIR\sloshdsp.143
    CreateShortCut "$SMPROGRAMS\$shortDir\SLOSH Display.lnk" "$INSTDIR\${prjName}\bin\tclkit854.exe" "sloshdsp.kit" "$INSTDIR\${prjName}\bin\sloshdsp.ico" 0
    ${LogIt} Delete "$SMPROGRAMS\$shortDir\SLOSH Display.lnk"
;    CreateShortCut "$SMPROGRAMS\$shortDir\Hurricane Tracker.lnk" "$INSTDIR\${prjName}\bin\tclkit854.exe" "sloshdsp.kit track" "$INSTDIR\${prjName}\bin\track.ico" 0
;    ${LogIt} Delete "$SMPROGRAMS\$shortDir\Hurricane Tracker.lnk"
;    CreateShortCut "$SMPROGRAMS\$shortDir\Tide.lnk" "$INSTDIR\${prjName}\bin\tclkit854.exe" "sloshdsp.kit tide" "$INSTDIR\${prjName}\bin\tide.ico" 0
;    ${LogIt} Delete "$SMPROGRAMS\$shortDir\Tide.lnk"
;     CreateShortCut "$SMPROGRAMS\$shortDir\Install SLOSH Data.lnk" "$INSTDIR\${prjName}\bin\tclkit854.exe" "sloshdsp.kit dataconf" "$INSTDIR\${prjName}\bin\data.ico" 0
;     ${LogIt} Delete "$SMPROGRAMS\$shortDir\Install SLOSH Data.lnk"
    CreateShortCut "$SMPROGRAMS\$shortDir\UnInstall SLOSH Display.lnk" "$INSTDIR\${prjName}\uninstall.exe" "" "$INSTDIR\${prjName}\uninstall.exe" 0
    ${LogIt} Delete "$SMPROGRAMS\$shortDir\UnInstall SLOSH Display.lnk"
    ${LogIt} RMDir "$SMPROGRAMS\$shortDir"
;      SetShellVarContext All
  skip:

  StrCpy $R1 $f_desktopShort 1
  StrCmp $R1 ">" skip2
    CreateShortCut "$DESKTOP\SLOSH Display${prjVer}.lnk" "$INSTDIR\${prjName}\bin\tclkit854.exe" "sloshdsp.kit" "$INSTDIR\${prjName}\bin\sloshdsp.ico" 0
    ${LogIt} Delete "$DESKTOP\SLOSH Display${prjVer}.lnk"
  skip2:

SectionEnd ; end the section

;--------------------------------
; Section on closing log files
Section -closelogfile
 FileClose $UninstLog_FP
 SetFileAttributes "$INSTDIR\${prjName}\${UninstLog}" READONLY|SYSTEM|HIDDEN
SectionEnd

LangString UninstLogMissing ${LANG_ENGLISH} "${UninstLog} not found!$\r$\nUninstallation cannot proceed!"
;--------------------------------

; Uninstaller stuff.
Section Uninstall

 ; Can't uninstall if uninstall log is missing!
 IfFileExists "$INSTDIR\${prjName}\${UninstLog}" +3
  MessageBox MB_OK|MB_ICONSTOP "$(UninstLogMissing)"
   Abort
 Push $R0
 Push $R1
 SetFileAttributes "$INSTDIR\${prjName}\${UninstLog}" NORMAL
 FileOpen $UninstLog_FP "$INSTDIR\${prjName}\${UninstLog}" r

 LoopOver:
  ClearErrors
  FileRead $UninstLog_FP $R0
; Remove trailing \r\n
   StrCpy $R0 $R0 -2
   StrCpy $R1 $R0 6
   StrCmp $R1 "Delete" 0 Continue
     StrCpy $R1 $R0 "" 7
     Delete "$R1"
     Goto Done
   Continue:
   StrCpy $R1 $R0 5
   StrCmp $R1 "RMDir" 0 Done
     StrCpy $R1 $R0 "" 6
     RMDir "$R1"
; RMDir causes error if directory couldn't be deleted.
     ClearErrors
     Goto Done
   Done:
   IfErrors 0 LoopOver

 FileClose $UninstLog_FP

 Delete "$INSTDIR\${prjName}\${UninstLog}"

 Delete $INSTDIR\${prjName}\uninstall.exe
 RMDir "$INSTDIR\${prjName}"
 RMDir "$INSTDIR"

 ; Remove registry keys
 DeleteRegKey HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${prjName}"
 Pop $R0
 Pop $R1

SectionEnd

