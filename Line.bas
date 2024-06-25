B4A=true
Group=Project\Model\Shapes
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
Sub Class_Globals
	Public point1 As Point
	Public point2 As Point
	Private const CLOSELY_DISTANCE As Int = 5
	Private iSelected As Boolean = False
End Sub

Public Sub Initialize(p1 As Point, p2 As Point) As Line
	point1 = p1
	point2 = p2
	Return Me
End Sub

Public Sub Move(vector As Line)
	point1.Move(vector)
	point2.Move(vector)	
End Sub

Public Sub Draw(canvas As Canvas, color As Int)
	Dim vColor As Int = IIf(iSelected, Colors.Blue, color)
	canvas.DrawLine(point1.x, point1.y, point2.x, point2.y, vColor, 1dip)
	canvas.DrawCircle(point1.x, point1.y, 2dip, vColor, True, 0)
	canvas.DrawCircle(point2.x, point2.y, 2dip, vColor, True, 0)
End Sub


Public Sub IsClosely(pPoint As Point) As Boolean
	Dim lengthOfMe As Double = point1.GetDistance(point2)
	
	Dim distanceToPoint1 As Double = pPoint.GetDistance(point1)
	Dim distanceToPoint2 As Double = pPoint.GetDistance(point2)
	'Log("Distance to Point 1 " & distanceToPoint1 )
	'Log("Distance to Point 2 " & distanceToPoint2 )
	'Log("Lenght of me        " & lengthOfMe )
	Return distanceToPoint1 + distanceToPoint2 - lengthOfMe < CLOSELY_DISTANCE
End Sub

Public Sub SelectLineCloselyToPoint(pPoint As Point) As Boolean
	iSelected = IIf(IsClosely(pPoint), True, False)
	' Log("--->" & iSelected)
	Return iSelected
End Sub

Public Sub DeselectLine
	iSelected = False
End Sub

Public Sub GetSelectedLine As Line
	Dim selectedLine As Line = IIf (iSelected, Me, Null)
	Return selectedLine
End Sub

Public Sub Clone As Line
	Dim newLine As Line
	newLine.Initialize(point1.Clone, point2.Clone)
	Return newLine
End Sub

Public Sub SplitSelectedLine(piecesCount As Int) As List
	Dim newShapes As List
	newShapes.Initialize
	
	' Return entire line if splitting is not possible
	If piecesCount < 2 Or iSelected = False  Then
		newShapes.Add(Me)
		Return newShapes
	End If

	Dim newLine As Line = createFirstPieceOfSplittedLine(piecesCount)
	newShapes.Add(newLine)
	
	For i=1 To piecesCount-1
		Dim p1 As Point = newLine.point2
		Dim p2 As Point = newLine.point2.Clone.Move(newLine)
		Dim newLine As Line
		newLine.Initialize(p1, p2)
		newShapes.Add(newLine)
	Next
	newLine.point2 = point2
	Return newShapes
End Sub

Private Sub createFirstPieceOfSplittedLine(piecesCount As Int) As Line
	Dim startPoint, endPoint As Point
	startPoint = point1
	
	Dim endPointX As Long = point1.x + (point2.x - point1.x) / piecesCount
	Dim endPointY As Long = point1.y + (point2.y - point1.y) / piecesCount
	endPoint.Initialize(endPointX, endPointY)
	
	Dim newLine As Line
	newLine.Initialize(startPoint, endPoint)
	Return newLine
End Sub

' https://ru.wikihow.com/%D0%BD%D0%B0%D0%B9%D1%82%D0%B8-%D1%83%D0%B3%D0%BE%D0%BB-%D0%BD%D0%B0%D0%BA%D0%BB%D0%BE%D0%BD%D0%B0-%D0%BF%D1%80%D1%8F%D0%BC%D0%BE%D0%B9-%D0%BF%D0%BE-%D0%B4%D0%B2%D1%83%D0%BC-%D1%82%D0%BE%D1%87%D0%BA%D0%B0%D0%BC
Public Sub GetDegreeToXAxis As Double
		' угловой коэффицент
		Dim nodal As Double = (point2.y - point1.y) / (point2.x - point1.x)
		Return ATanD(nodal)
End Sub

' https://matthew-brett.github.io/teaching/rotation_2d.html
Public Sub Rotate
	
End Sub