B4A=true
Group=Project\Model\Shapes
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
Sub Class_Globals
	Public lines As List
	Private iSelected As Boolean = False
End Sub

Public Sub Initialize(pLine As Line) As LineString
	lines.Initialize
	lines.Add(pLine)
	Return Me
End Sub

Public Sub AddLine(pNextPoint As Point) As Line
	Dim lastLine As Line =lines.Get(lines.Size-1)
	Dim newLine As Line
	newLine.Initialize(lastLine.point2, pNextPoint)
	lines.Add(newLine)
	Return newLine
End Sub

Public Sub RemoveLastLine
	If lines.Size > 0 Then
		lines.RemoveAt(lines.Size-1)		
	End If
End Sub

Public Sub Initialize2(pLines As List) As LineString
	lines = pLines
	Return Me
End Sub

Public Sub Move(vector As Line)	
	For Each line As Line In lines
		line.point1.Move(vector)
	Next
	Dim lastLine As Line = lines.Get(lines.Size-1)
	lastLine.point2.Move(vector)
End Sub

Public Sub Draw(canvas As Canvas, color As Int)
	Dim vColor As Int = IIf(iSelected, Colors.Blue, color)
	For Each line As Line In lines
		line.Draw(canvas, vColor)
	Next
End Sub

Public Sub IsClosely(pPoint As Point) As Boolean
	For Each line As Line In lines
		If line.IsClosely(pPoint) Then
			Return True
		End If
	Next
	Return False
End Sub

Public Sub SelectLineCloselyToPoint(pPoint As Point) As Boolean
	For Each line As Line In lines
		If line.SelectLineCloselyToPoint(pPoint) Then
			Return True
		End If
	Next
	Return False
End Sub

Public Sub DeselectLine
	For Each line As Line In lines
		line.DeselectLine
	Next
End Sub

Public Sub GetSelectedLine As Line
	For Each line As Line In lines
		line.GetSelectedLine
		If line.GetSelectedLine <> Null Then
			Return line
		End If
	Next
	Return Null
End Sub

Public Sub Clone As LineString
	Dim vLines As List
	vLines.Initialize
	For Each line As Line In lines
		vLines.Add(line.Clone)
	Next
	Dim newLineString As LineString
	newLineString.Initialize2(vLines)
	Return newLineString
End Sub

Public Sub SplitSelectedLine(piecesCount As Int)
	Dim selectedLine As Line = GetSelectedLine	
	If selectedLine <> Null Then
		lines.RemoveAt(lines.IndexOf(selectedLine))
		Dim newLines As List = selectedLine.SplitSelectedLine(piecesCount)
		lines.AddAll(newLines)
	End If
End Sub