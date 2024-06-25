B4A=true
Group=Schnitt\Model
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
Sub Class_Globals
	Public Points As List
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize() As Shape
	Points.Initialize
	Return Me
	
End Sub

Public Sub AddPoint(p As Point) As Shape
	Points.Add(p)
	Return Me
End Sub