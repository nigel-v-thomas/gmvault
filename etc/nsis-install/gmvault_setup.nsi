; gmvault.nsi
;
; This script is perhaps one of the simplest NSIs you can make. All of the
; optional settings are left to their default settings. The installer simply 
; prompts the user asking them where to install, and drops a copy of "MyProg.exe"
; there.

;--------------------------------
!include "MUI.nsh"
!include "TextFunc.nsh" ; for replacing INSTDIR in gmvault

; The name of the installer
Name "gmvault_setup"

; Request user privileges only
RequestExecutionLevel user

; The file to write
OutFile "gmvault_setup.exe"

; The default installation directory
InstallDir $PROGRAMFILES\gmvault
;InstallDir d:\Programs\gmvault

; The text to prompt the user to enter a directory
DirText "Please Choose a directory where to install gmvault"

;--------------------------------
; MUI Settings / Icons
!define MUI_ICON "gmv-icon.ico"
;!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\orange-uninstall-nsis.ico"

; MUI Settings / Header
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_RIGHT
!define MUI_HEADERIMAGE_BITMAP "orange-r-nsis.bmp"
!define MUI_HEADERIMAGE_UNBITMAP "orange-r-nsis.bmp"

; MUI Settings / Wizard
!define MUI_WELCOMEFINISHPAGE_BITMAP "gmvault.bmp"
!define MUI_UNWELCOMEFINISHPAGE_BITMAP "orange-uninstall-nsis.bmp"

; add create shortcut checkbox in end page
Function finishpageaction
CreateShortcut "$desktop\gmvault-shell.lnk" "$INSTDIR\gmvault-shell.bat" "" "$INSTDIR\gmv-icon.ico"
FunctionEnd

; MUI Setting for finish page
!define MUI_FINISHPAGE_SHOWREADME ""
!define MUI_FINISHPAGE_SHOWREADME_CHECKED
!define MUI_FINISHPAGE_SHOWREADME_TEXT "Create Desktop Shortcut"
!define MUI_FINISHPAGE_SHOWREADME_FUNCTION finishpageaction


!define MUI_WELCOMEPAGE_TITLE "GMVAULT Setup"

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "License.rtf"
!insertmacro MUI_PAGE_DIRECTORY 
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_LANGUAGE "English"

LangString msg ${LANG_ENGLISH} "English msg"

; Define variable for remplacing INSTDIR in gmvault.bat
!insertmacro LineFind

!define STRTOFIND "SET EXE_DIR=@PATHTOREPLACE@"

!define STRTOREPL "SET EXE_DIR=$INSTDIR"

; Define uninstaller_name
!define UNINSTALLER_NAME "gmvault-uninstaller.exe"
; Define website_link and start_link_dir
!define WEBSITE_LINK "www.gmvault.org"
!define START_LINK_DIR "$STARTMENU\Programs\Gmvault"

; The stuff to install
Section "gmvault" ;No components page, name is not important

; Set output path to the installation directory.
SetOutPath $INSTDIR

; create shortscuts in menu
; install in the current user context instead of all users
SetShellVarContext current 
createDirectory "${START_LINK_DIR}"
createShortCut  "${START_LINK_DIR}\gmvault-shell.lnk" "$INSTDIR\gmvault-shell.bat" "" "$INSTDIR\gmv-icon.ico"
createShortCut  "${START_LINK_DIR}\gmvault.lnk" "$INSTDIR\gmvault.bat" "" "$INSTDIR\gmv-icon.ico"
createShortCut  "${START_LINK_DIR}\uninstall.lnk" "$INSTDIR\${UNINSTALLER_NAME}" "" ""
createShortCut  "${START_LINK_DIR}\README.lnk" "$INSTDIR\README.txt" "" ""
createShortCut  "${START_LINK_DIR}\RELEASE-NOTE.lnk" "$INSTDIR\RELEASE-NOTE.txt" "" ""

; Add information to appear in control panel or Win 7 programs
!define REG_UNINSTALL "Software\Microsoft\Windows\CurrentVersion\Uninstall\Gmvault"

WriteRegStr HKCU "${REG_UNINSTALL}" "DisplayName" "Gmvault"
WriteRegStr HKCU "${REG_UNINSTALL}" "DisplayIcon" "$\"$INSTDIR\gmvault.bat$\""
WriteRegStr HKCU "${REG_UNINSTALL}" "Publisher" "Guillaume Aubert"
WriteRegStr HKCU "${REG_UNINSTALL}" "DisplayVersion" "1.5-beta"
WriteRegDWord HKCU "${REG_UNINSTALL}" "EstimatedSize" 3 ;MB
WriteRegStr HKCU "${REG_UNINSTALL}" "HelpLink" "${WEBSITE_LINK}"
WriteRegStr HKCU "${REG_UNINSTALL}" "URLInfoAbout" "${WEBSITE_LINK}"
WriteRegStr HKCU "${REG_UNINSTALL}" "InstallLocation" "$\"$INSTDIR$\""
WriteRegStr HKCU "${REG_UNINSTALL}" "InstallSource" "$\"$EXEDIR$\""
WriteRegDWord HKCU "${REG_UNINSTALL}" "NoModify" 1
WriteRegDWord HKCU "${REG_UNINSTALL}" "NoRepair" 1
WriteRegStr HKCU "${REG_UNINSTALL}" "UninstallString" "$\"$INSTDIR\gmvault-uninstaller.lnk$\""
WriteRegStr HKCU "${REG_UNINSTALL}" "Comments" "Uninstalls Gmvault."

; Registry information for add/remove programs
;	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "DisplayName" "${COMPANYNAME} - ${APPNAME} - ${DESCRIPTION}"
;	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "UninstallString" "$\"$INSTDIR\uninstall.exe$\""
;	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "QuietUninstallString" "$\"$INSTDIR\uninstall.exe$\" /S"
;	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "InstallLocation" "$\"$INSTDIR$\""
;	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "DisplayIcon" "$\"$INSTDIR\logo.ico$\""
;	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "Publisher" "$\"${COMPANYNAME}$\""
;	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "HelpLink" "$\"${HELPURL}$\""
;	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "URLUpdateInfo" "$\"${UPDATEURL}$\""
;	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "URLInfoAbout" "$\"${ABOUTURL}$\""
;	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "DisplayVersion" "$\"${VERSIONMAJOR}.${VERSIONMINOR}.${VERSIONBUILD}$\""
;	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "VersionMajor" ${VERSIONMAJOR}
;	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "VersionMinor" ${VERSIONMINOR}
;	# There is no option for modifying or repairing the install
;	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "NoModify" 1
;	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "NoRepair" 1
;	# Set the INSTALLSIZE constant (!defined at the top of this script) so Add/Remove Programs can accurately report the size
;	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} ${APPNAME}" "EstimatedSize" ${INSTALLSIZE}


;MessageBox MB_OK "$INSTDIR"

; Put file there
File gmv_cmd.exe
File gmvault.bat
File gmv-msg.bat
File gmv-icon.ico
File gmvault-shell.bat
File RELEASE-NOTE.txt
File README.txt
File library.zip
File python27.dll
File w9xpopen.exe
File *.pyd
File /r Microsoft.VC90.CRT

; Add installation Dir in gmvault.bat
${LineFind} "$INSTDIR\gmvault.bat" "$INSTDIR\gmvault.bat" "1:-1" "LineFindCallback"

IfErrors 0 +2

MessageBox MB_OK "Error"

; =================================================
; Uninstaller
; =================================================
writeUninstaller "$INSTDIR\${UNINSTALLER_NAME}"

SectionEnd ; end the section

; The uninstall section
Section "Uninstall"

Delete $INSTDIR\uninstall.exe
Delete $INSTDIR\gmv_cmd.exe
Delete $INSTDIR\library.zip
Delete $INSTDIR\*.ico
Delete $INSTDIR\*.bat
Delete $INSTDIR\*.txt
Delete $INSTDIR\python27.dll
Delete $INSTDIR\w9xpopen.exe
Delete $INSTDIR\*.pyd
Delete $INSTDIR\Microsoft.VC90.CRT\*.dll
Delete $INSTDIR\Microsoft.VC90.CRT\*.manifest
rmDir /r $INSTDIR\Microsoft.VC90.CRT
;rmDir /r $INSTDIR
rmDir $INSTDIR

# Remove Start Menu Launcher
delete "${START_LINK_DIR}\gmvault-shell.lnk"
delete "${START_LINK_DIR}\gmvault.lnk"
delete "${START_LINK_DIR}\README.txt"
delete "${START_LINK_DIR}\RELEASE-NOTE.txt"
delete "${START_LINK_DIR}\uninstall.lnk"
rmDir  "${START_LINK_DIR}"


SectionEnd ; end the section

; =================================================
; Custom Functions
; =================================================
Function LineFindCallback

    StrLen $0 "${STRTOFIND}"

    StrCpy $1 "$R9" $0

    StrCmp $1 "${STRTOFIND}" 0 End

;    StrCpy $R9 "${STRTOREPL}$\r$\n"
    StrCpy $R9 "${STRTOREPL}$\n"

    End:

    Push $0

FunctionEnd

