B4A=true
Group=Project\Updater
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
' Representiert eine Version aus changelog.json
Sub Class_Globals
	Public versionCode As Int
	Public isInstalled As Boolean
	Public versionName As String
	Public fileName As String
	Public changes As List	
End Sub

Public Sub Initialize(pVersionCode As Int, pVersionName As String, pFileName As String, pChanges As List)
	versionCode = pVersionCode
	versionName = pVersionName
	fileName = pFileName
	changes = pChanges
	isInstalled = False
End Sub

Public Sub IsGreater(otherVersion As Version) As Boolean
	Return versionCode > otherVersion.versionCode
End Sub

Public Sub Install
	If isInstalled Then
		Return
	End If
	
	Dim job As HttpJob
	job = createDownloadJob
	Wait For (job) JobDone(job As HttpJob)
	
	If job.Success Then
		Wait For (saveFileToSharedFolder(job.GetInputStream)) Complete (isSaveFileSuccess As Boolean)
		If isSaveFileSuccess Then
			sendInstallIntent
			' TODO nach dem Neustart der App die heruntergeladene APK löschen.
			' https://www.b4x.com/android/forum/threads/safe-apk-installation-problem.161835/
		Else
			Log("APK konnte nicht gespeichert werden!")
		End If
	Else
		Log(job.ErrorMessage)
	End If
	job.Release
End Sub

Public Sub ToString As String
	Dim result As StringBuilder
	result.Initialize
	result.Append(versionName)
	result.Append(fileName)
	result.Append(IIf(isInstalled, "Installed", "Not installed"))
	result.Append("Changes:")
	For Each change In changes
		result.Append(change)
	Next
	Return result.ToString
End Sub

Private Sub saveFileToSharedFolder(inputStream As InputStream) As ResumableSub
	Dim outputStream As OutputStream = File.OpenOutput(Starter.Provider.SharedFolder, fileName, False)
	Wait For (File.Copy2Async(inputStream, outputStream)) Complete (Success As Boolean)
	outputStream.Close
	Return Success
End Sub

' Beispiel: https://www.b4x.com/android/forum/threads/version-safe-apk-installation.87667/
' Signieren: https://www.b4x.com/android/forum/threads/signing-your-application-before-uploading-to-google-play.6756/
Private Sub sendInstallIntent
	If canRequestPackageInstalls Then
		Dim sendIntent As Intent
		Dim uri As Object = Starter.Provider.GetFileUri(fileName)
		sendIntent.Initialize("android.intent.action.INSTALL_PACKAGE", uri)
		sendIntent.Flags = Bit.Or(sendIntent.Flags, 1) 'FLAG_GRANT_READ_URI_PERMISSION
		StartActivity(sendIntent)
	Else
		' TODO Berechtigungung anfragen, s Beispiel
		Log("Die App kann keine unbekannten Apps installieren")	
	End If
	
End Sub

Private Sub canRequestPackageInstalls As Boolean
	Dim ctxt As JavaObject
	ctxt.InitializeContext
	Dim PackageManager As JavaObject = ctxt.RunMethod("getPackageManager", Null)
	Return PackageManager.RunMethod("canRequestPackageInstalls", Null)
End Sub

Private Sub createDownloadJob As HttpJob
	Dim credentials As StringBuilder
	credentials.Initialize
	credentials.Append(UpdaterConstants.APK_DOWNLOAD_USER)
	credentials.Append(":")
	credentials.Append(UpdaterConstants.APK_DOWNLOAD_PASS)
	
	Dim stringUtils As StringUtils
	Dim authorisationHeader As StringBuilder
	authorisationHeader.Initialize
	authorisationHeader.Append("Basic ")
	authorisationHeader.Append(stringUtils.EncodeBase64(credentials.ToString.GetBytes("UTF8")))
		
	Dim job As HttpJob
	job.Initialize("", Me)
	job.Download(UpdaterConstants.APK_DOWNLOAD_URL & fileName)
	job.GetRequest.SetHeader("Authorization", authorisationHeader.ToString)
	job.GetRequest.SetHeader("accept","application/octet-stream")
	Return job
End Sub