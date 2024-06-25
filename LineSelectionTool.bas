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
	Private mSelectionChangedListeners As List
End Sub

Public Sub Initialize(pCanvas As Canvas, pProject As Project) As LineSelectionTool
	mCanvas = pCanvas
	mProject = pProject
	mCursor.Initialize(mCanvas, Colors.Gray)
	mSelectionChangedListeners.Initialize
	Return Me
End Sub

Public Sub OnActionDown(startPoint As Point)
	mProject.selectedShape = Null
	mProject.DrawAllShapes(mCanvas)
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

Public Sub AddSelectionChangedListener(selectionChangedListener As Object)
	mSelectionChangedListeners.Add(selectionChangedListener)
End Sub

Public Sub RemoveSelectionChangedListener(selectionChangedListener As Object)
	mSelectionChangedListeners.RemoveAt(mSelectionChangedListeners.IndexOf(selectionChangedListener))
End Sub

Private Sub changeSelection(currentPointerPosition As Point)
	DeselectLines
		
	For Each shape As Object In mProject.GetShapes
		If selectLineCloselyToPoint(currentPointerPosition, shape) Then
			notifySelectionChangedListeners(shape)
			Return
		End If
	Next
End Sub

Private Sub selectLineCloselyToPoint(currentPointerPosition As Point, pShape As Object) As Boolean	
	Return CallSub2(pShape, "SelectLineCloselyToPoint", currentPointerPosition)
End Sub

Private Sub DeselectLines
	For Each shape As Object In mProject.GetShapes
		CallSub(shape, "DeselectLine")
	Next
	notifySelectionChangedListeners(Null)
End Sub

Private Sub notifySelectionChangedListeners(shapeWithSelectedLine As Object)
	If shapeWithSelectedLine = Null Then
		For Each selectionChangedListener In mSelectionChangedListeners
			CallSub(selectionChangedListener, "OnLineDeselected")
		Next
		Return
	End If	
	
	Dim selectedLine As Line = CallSub(shapeWithSelectedLine, "GetSelectedLine")
	If selectedLine = Null Then
		Log("Error! Shape with selected line has no line selected!")
		Return
	End If
	
	For Each selectionChangedListener In mSelectionChangedListeners
		CallSub3(selectionChangedListener, "OnLineSelected", shapeWithSelectedLine, selectedLine)
	Next	
End Sub