B4A=true
Group=Editors
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
Sub Class_Globals
	Private mRectangle As Rectangle
	Private mCanvas As Canvas
	Private mCursor As CursorCross
	Private mProject As Project
End Sub

Public Sub Initialize(pCanvas As Canvas, pProject As Project) As RectangleEditor
	mCanvas = pCanvas
	mProject = pProject
	mCursor.Initialize(mCanvas, Colors.Gray)
	Return Me
End Sub

Public Sub OnActionDown(startPoint As Point)
	Dim endPoint As Point
	endPoint.Initialize(startPoint.x, startPoint.y)
	Dim newRectangle As Rectangle 
	newRectangle.Initialize(startPoint, endPoint)
	mRectangle = newRectangle
	mProject.AddShape(newRectangle)
End Sub

Public Sub OnActionMove(currentPointerPosition As Point)
	mRectangle.Draw(mCanvas, Colors.White) ' clear on old positions
	changeLinePosition(currentPointerPosition)
	mCursor.Draw(mRectangle.diagonal.point2)
	mProject.DrawAllShapes(mCanvas)
End Sub

Public Sub OnActionUp(p As Point)
	mCursor.Clear
	mProject.DrawAllShapes(mCanvas)
End Sub

Private Sub changeLinePosition(currentPointerPosition As Point)
	mRectangle.diagonal.point2 = currentPointerPosition
End Sub