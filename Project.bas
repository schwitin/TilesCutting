B4A=true
Group=Project\Model
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
Sub Class_Globals
	Private shapes As List
	Public selectedShape As Object = Null
End Sub

Public Sub Initialize()
	shapes.Initialize()	
End Sub

Public Sub AddShape(pShape As Object)
	shapes.Add(pShape)
	selectedShape = pShape
End Sub

Public Sub AddShapes(pShapes As List)
	shapes.AddAll(pShapes)
	selectedShape = Null
End Sub

Public Sub RemoveShape(pShape As Object)
	Dim index As Int = shapes.IndexOf(pShape)
	shapes.RemoveAt(index)
	If pShape = selectedShape Then
		selectedShape = Null
	End If
End Sub

Public Sub RemoveAllShapes
	shapes.Clear
	selectedShape = Null
End Sub

Public Sub RemoveSelectedShape
	If selectedShape <> Null Then
		Dim index As Int = shapes.IndexOf(selectedShape)
		shapes.RemoveAt(index)
		selectedShape = Null
	End If
 End Sub

Public Sub GetShapes As List
	Return shapes
End Sub

Public Sub DrawAllShapes(pCanvas As Canvas)
  clearCanvas(pCanvas)
	drawShapes(pCanvas)
End Sub

Private Sub clearCanvas(pCanvas As Canvas)
	Dim vRect As Rect
	vRect.Initialize(0,0,10000,10000)
	pCanvas.DrawRect(vRect, Colors.White, True, 0)
End Sub

Private Sub drawShapes(pCanvas As Canvas)
	For i = 0 To shapes.Size - 1
		Dim nextShape As Object = shapes.Get(i)
		Dim color As Int = IIf(nextShape <> selectedShape, Colors.Black, Colors.Blue)
		drawShape(pCanvas, nextShape, color)
	Next
End Sub

Private Sub drawShape(pCanvas As Canvas, pShape As Object, pColor As Int)
	CallSub3(pShape, "Draw", pCanvas, pColor)
End Sub
