B4A=true
Group=Project\Model\Shapes
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
Sub Class_Globals
	Public x As Long
	Public y As Long
End Sub

Public Sub Initialize(pX As Long, pY As Long) As Point
	x = pX
	y = pY	
	Return Me
End Sub

Public Sub Move(vector As Line) As Point
	x = x + (vector.point2.x - vector.point1.x)
	y = y + (vector.point2.y - vector.point1.y)	
	Return Me
End Sub

' https://www.calc.ru/Formula-Dliny-Otrezka.html
Public Sub GetDistance(pPoint As Point) As Double
	Dim x1 As Long = x
	Dim y1 As Long = y
	
	Dim x2 As Long = pPoint.x
	Dim y2 As Long = pPoint.y
	
	Dim distance As Double = Sqrt(Power((x2-x1), 2) + Power((y2-y1), 2))
	
	Return distance
End Sub

Public Sub ToString As String
	Dim sb As StringBuilder
	sb.Initialize
	Return sb.Append("Point (").Append(x).Append(", ").Append(y).Append(")").ToString	
End Sub

Public Sub Clone As Point
	Dim newPoint As Point
	newPoint.Initialize(x, y)
	Return newPoint
End Sub

Public Sub Equals(pPoint As Point) As Boolean
	Return pPoint = Me Or pPoint.x = x And pPoint.y = y
End Sub