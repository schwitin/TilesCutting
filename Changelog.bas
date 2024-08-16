B4A=true
Group=Project\Updater
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
' Representiert changelog.json
Sub Class_Globals
	Private urlToChangelog As String
	Private username As String
	Private password As String
	Public availableVersions As List
End Sub


Public Sub Initialize(pUrlToChangelog As String, pUsername As String, pPassword As String)
	urlToChangelog = pUrlToChangelog
	username = pUsername
	password = pPassword	
	initializeAvailableVersions		
End Sub

Private Sub initializeAvailableVersions
	Dim job As HttpJob
	job = createDownloadJob
	Wait For (job) JobDone(job As HttpJob)
	
	Dim json As String
	If job.Success Then
		Log(job.GetString)
		json = job.GetString
		availableVersions = parseAllVersions(json)
	Else
		Log(job.ErrorMessage)
	End If
	job.Release	
End Sub

Private Sub parseAllVersions(json As String) As List
	Dim jsonParser As JSONParser
	jsonParser.Initialize(json)
		
	Dim parsedMap As Map
	parsedMap = jsonParser.NextObject
		
	Dim changelogItems As List
	changelogItems = parsedMap.Get("changelogitem")
	
	Dim AllVersions As List
	AllVersions.Initialize
	For i = 0 To changelogItems.Size - 1
		Dim v As Version
		v = parseVersion(changelogItems.Get(i))
		AllVersions.Add(v)
	Next
	
	Return AllVersions
End Sub

Private Sub parseVersion(changelogItem As Map) As Version
	Dim versionCode As String
	versionCode = changelogItem.Get("versionCode")
	
	Dim versionName As String
	versionName = changelogItem.Get("versionName")
	
	Dim fileName As String
	fileName = changelogItem.Get("fileName")
	
	Dim changes As List
	changes = changelogItem.Get("changes")
	
	Dim v As Version
	v.Initialize(versionCode, versionName, fileName, changes)
	
	Dim pm As PackageManager
	Dim installedVersionCode As Int
	installedVersionCode = pm.GetVersionCode ("b4a.example")
	If installedVersionCode == v.versionCode Then
		v.isInstalled = True
	End If
	
	Return v
End Sub

Private Sub createDownloadJob As HttpJob
	Dim credentials As StringBuilder
	credentials.Initialize
	credentials.Append(username)
	credentials.Append(":")
	credentials.Append(password)
	
	Dim stringUtils As StringUtils
	Dim authorisationHeader As StringBuilder
	authorisationHeader.Initialize
	authorisationHeader.Append("Basic ")
	authorisationHeader.Append(stringUtils.EncodeBase64(credentials.ToString.GetBytes("UTF8")))
		
	Dim job As HttpJob
	job.Initialize("", Me)
	job.Download(urlToChangelog)
	job.GetRequest.SetHeader("Authorization", authorisationHeader.ToString)
	job.GetRequest.SetHeader("accept","application/json")
	Return job
End Sub