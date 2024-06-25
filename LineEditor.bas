B4A=true
Group=Editors
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
Sub Class_Globals
	Private mLine As Line
	Private mCanvas As Canvas
	Private mCursor As CursorCross
	Private mProject As Project
	Private const CAPTURE_DISTANCE As Int = 20dip
End Sub

Public Sub Initialize(pCanvas As Canvas , pProject As Project) As LineEditor
	mCanvas = pCanvas	
	mProject = pProject
	mCursor.Initialize(mCanvas, Colors.Gray)
	Return Me
End Sub

Public Sub OnActionDown(pointerPosition As Point) As Line
	Dim endPoint As Point
	endPoint.Initialize(pointerPosition.x+50, pointerPosition.y+50)
	Dim newLine As Line
	newLine.Initialize(pointerPosition, endPoint)
	mLine = newLine
	mProject.AddShape(mLine)
	Return mLine
End Sub

Public Sub OnActionMove(currentPointerPosition As Point)
	mLine.Draw(mCanvas, Colors.White) ' clear on old positions	
	changeLinePosition(currentPointerPosition)
	mCursor.Draw(mLine.point2)
	mProject.DrawAllShapes(mCanvas)
End Sub

Public Sub OnActionUp(p As Point) 
	mCursor.Clear
	mProject.DrawAllShapes(mCanvas)
End Sub

Private Sub changeLinePosition(currentPointerPosition As Point)
	If isCapturingX(currentPointerPosition) Then
		mLine.point2.y = currentPointerPosition.y
		mLine.point2.x = mLine.point1.x
	Else If isCapturingY(currentPointerPosition) Then
		mLine.point2.x = currentPointerPosition.x
		mLine.point2.y = mLine.point1.y
	Else
		mLine.point2 = currentPointerPosition
	End If
End Sub

Private Sub isCapturingY(currentPointerPosition As Point) As Boolean
	Return CAPTURE_DISTANCE >  Abs(currentPointerPosition.y - mLine.point1.y)
End Sub

Private Sub isCapturingX(currentPointerPosition As Point) As Boolean
	Return CAPTURE_DISTANCE >  Abs(currentPointerPosition.x - mLine.point1.x)
End Sub

