B4A=true
Group=Schnitt\Model
ModulesStructureVersion=1
Type=StaticCode
Version=12.8
@EndOfDesignText@
'Code module
'Subs in this code module will be accessible from all modules.
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub

Public Sub getDistance(pLines As List, pPoint As Point) As Double
	Dim minimalDistance As Double = 10000000.0
	For Each line As Line In pLines
		Dim distance As Double = line.GetDistance(pPoint)
		If distance < minimalDistance Then
			minimalDistance = distance
		End If
	Next
	Return minimalDistance
End Sub