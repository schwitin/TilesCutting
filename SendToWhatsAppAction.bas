B4A=true
Group=Project\Actions
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
Sub Class_Globals
	Private mProject As Project
	Private mPhoneNumber As String
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(pPhoneNumber As String, pProject As Project) As SendToWhatsAppAction
	mProject = pProject
	mPhoneNumber = pPhoneNumber
	Return Me
End Sub

Public Sub DoAction
	Log(">> Sending message...")
	Dim sendIntent As Intent
	sendIntent.Initialize(sendIntent.ACTION_MAIN,"")
	sendIntent.PutExtra("jid", mPhoneNumber & "@s.whatsapp.net")
	sendIntent.Action=sendIntent.ACTION_SEND
	sendIntent.SetPackage("com.whatsapp")
	sendIntent.SetType("text/plain")
	sendIntent.PutExtra("android.intent.extra.TEXT","Hello from my B4A app!")
	StartActivity(sendIntent)
	Log(">> Sending message done")
End Sub