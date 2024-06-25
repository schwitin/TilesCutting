B4A=true
Group=Schnitt\Model
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
Sub Class_Globals
	Public point1 As Point
	Public point2 As Point
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(p1 As Point, p2 As Point) As Linie
	point1 = p1
	point2 = p2
	Return Me
End Sub