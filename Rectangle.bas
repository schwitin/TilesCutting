B4A=true
Group=Project\Model\Shapes
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
Sub Class_Globals
	Public diagonal As Line
	Private selectedLine As Line = Null
End Sub

Public Sub Initialize(corner1 As Point, corner2 As Point) As Rectangle
	diagonal.Initialize(corner1, corner2)
	Return Me
End Sub

Public Sub Move(pVector As Line)
	diagonal.Move(pVector)
End Sub

Public Sub Draw(pCanvas As Canvas, pColor As Int)
	drawShape(pCanvas, pColor)
	drawSelectedLine(pCanvas, Colors.Blue)
End Sub

Private Sub drawShape(pCanvas As Canvas, pColor As Int)
	Dim rect As Rect
	rect.Initialize(diagonal.point1.x, diagonal.point1.y, diagonal.point2.x, diagonal.point2.y)
	pCanvas.DrawRect(rect, pColor, False, 1dip)
End Sub

Private Sub drawSelectedLine(pCanvas As Canvas, pColor As Int)
	If selectedLine <> Null Then
		selectedLine.Draw(pCanvas, pColor)
	End If
End Sub

Public Sub IsClosely(pPoint As Point) As Boolean
	Dim lineCloselyToPoint As Line = getLineCloselyToPoint(pPoint)
	Return lineCloselyToPoint <> Null
End Sub

Public Sub SelectLineCloselyToPoint(pPoint As Point) As Boolean
	selectedLine = getLineCloselyToPoint(pPoint)
	Return selectedLine <> Null
End Sub

Private Sub getLineCloselyToPoint(pPoint As Point) As Line
	Dim lines As List = getLines
	For Each line As Line In lines
		If line.IsClosely(pPoint) Then
			Return line
		End If
	Next
	Return Null
End Sub

Public Sub DeselectLine
	selectedLine = Null
End Sub

Public Sub GetSelectedLine As Line
	Return selectedLine
End Sub

Private Sub getLines As List
	Dim lines As List
	lines.Initialize
	
	Dim corner1, corner2, corner3, corner4 As Point
	corner1 = diagonal.point1
	corner2.Initialize(diagonal.point1.x, diagonal.point2.y)
	corner3 = diagonal.point2
	corner4.Initialize(diagonal.point2.x, diagonal.point1.y)
	
	'Log("Diagonal " & diagonal.point1.ToString & "-" & diagonal.point2.ToString)
	'Log("Line 1   " & corner1.ToString & "-" & corner2.ToString)
	'Log("Line 2   " & corner2.ToString & "-" & corner3.ToString)
	'Log("Line 3   " & corner3.ToString & "-" & corner4.ToString)
	'Log("Line 4   " & corner4.ToString & "-" & corner1.ToString)
	
	Dim line1, line2, line3, line4 As Line
	lines.Add(line1.Initialize(corner1, corner2))
	lines.Add(line2.Initialize(corner2, corner3))
	lines.Add(line3.Initialize(corner3, corner4))
	lines.Add(line4.Initialize(corner4, corner1))
	
	Return lines	
End Sub

Public Sub Clone As Rectangle
	Dim newRectangle As Rectangle
	newRectangle.Initialize(diagonal.point1.Clone, diagonal.point2.Clone)
	Return newRectangle
End Sub

Public Sub SplitSelectedLine(piecesCount As Int) As List
	Log("Rectangle sides couldn't be split!")
	Dim newShapes As List
	newShapes.Initialize	
	newShapes.Add(Me)
	Return newShapes
End Sub