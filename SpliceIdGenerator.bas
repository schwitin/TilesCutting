B4A=true
Group=Project\Model
ModulesStructureVersion=1
Type=StaticCode
Version=12.8
@EndOfDesignText@
'Code module
'Subs in this code module will be accessible from all modules.
Sub Process_Globals
	Private currentId As Int = 0

End Sub

public Sub NextId As Int
	currentId = currentId + 1
	Return currentId
End Sub