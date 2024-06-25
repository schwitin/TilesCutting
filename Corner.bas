B4A=true
Group=Project\Model\Shapes
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
Sub Class_Globals
	Public side1 As Line
	Public side2 As Line
End Sub

Public Sub Initialize(pLine As Line, pPoint As Point) As Corner
	side1.Initialize(pLine.point1, pPoint)
	side1.Initialize(pLine.point2, pPoint)
	Return Me
End Sub

Public Sub Move(vector As Line)
	side1.Move(vector)
	side2.Move(vector)
End Sub

Public Sub Draw(canvas As Canvas, color As Int)
	side1.Draw(canvas, color)
	side2.Draw(canvas, color)
End Sub

Public Sub IsClosely(pPoint As Point) As Boolean
	Return side1.IsClosely(pPoint) Or side2.IsClosely(pPoint)
End Sub

Public Sub SelectLineCloselyToPoint(pPoint As Point) As Boolean
	Dim isSideSelected As Boolean = side1.SelectLineCloselyToPoint(pPoint) Or side2.SelectLineCloselyToPoint(pPoint)
	Log("--->" & isSideSelected)
	Return isSideSelected
End Sub

Public Sub DeselectLine
	side1.DeselectLine
	side2.DeselectLine
End Sub

Public Sub GetSelectedLine As Line
	Dim selectedLine As Line = side1.GetSelectedLine	
	Return IIf(selectedLine<>Null, selectedLine, side2.GetSelectedLine)
End Sub

Public Sub Clone As Corner
	Dim newLine As Line
	newLine.Initialize(side1.point1.Clone, side2.point1)
	Dim newCorner As Corner
	newCorner.Initialize(newLine, side1.point2)
	Return newCorner
End Sub

Public Sub SplitSelectedLine(piecesCount As Int) As List
	Dim newShapes As List = side1.SplitSelectedLine(piecesCount)
	Return IIf(newShapes.Size > 1, newShapes, side2.SplitSelectedLine(piecesCount))
End Sub