B4A=true
Group=Project\Tools
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
Sub Class_Globals
	Private mCanvas As Canvas
	Private mCursor As CursorCross
	Private mProject As Project
End Sub

Public Sub Initialize(pCanvas As Canvas, pProject As Project) As ShapeSelectionTool
	mCanvas = pCanvas
	mProject = pProject
	mCursor.Initialize(mCanvas, Colors.Gray)
	Return Me
End Sub

Public Sub OnActionDown(startPoint As Point) 
	deselectLines
End Sub

Public Sub OnActionMove(currentPointerPosition As Point)
	changeSelection(currentPointerPosition)
	mProject.DrawAllShapes(mCanvas)
	mCursor.Draw(currentPointerPosition)
End Sub

Public Sub OnActionUp(p As Point)
	mCursor.Clear
	mProject.DrawAllShapes(mCanvas)
End Sub

Private Sub changeSelection(currentPointerPosition As Point)	
	mProject.selectedShape = Null	' deselect
	
	For Each shape As Object In mProject.GetShapes
		changeSelectionIfCursorCloseToShape(currentPointerPosition, shape)
	Next
End Sub

Private Sub changeSelectionIfCursorCloseToShape(currentPointerPosition As Point, pShape As Object)
	If isClosely(currentPointerPosition, pShape) Then
		mProject.selectedShape = pShape
	End If	
End Sub

Private Sub isClosely(currentPointerPosition As Point, pShape As Object) As Boolean
	Return CallSub2(pShape, "IsClosely", currentPointerPosition)
End Sub

Private Sub deselectLines
	For Each shape As Object In mProject.GetShapes
		CallSub(shape, "DeselectLine")
	Next
End Sub