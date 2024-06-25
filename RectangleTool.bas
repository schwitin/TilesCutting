B4A=true
Group=Project\Tools
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
Sub Class_Globals
	Dim corner1, corner2, corner3, corner4 As Point
	Private mCanvas As Canvas
	Private mCursor As CursorCross
	Private mProject As Project
End Sub

Public Sub Initialize(pCanvas As Canvas, pProject As Project) As RectangleTool
	mCanvas = pCanvas
	mProject = pProject
	mCursor.Initialize(mCanvas, Colors.Gray)
	Return Me
End Sub

Public Sub OnActionDown(currentPointerPosition As Point)
	Dim newRectangle As LineString = createRectangleShape( currentPointerPosition)
	mProject.AddShape(newRectangle)
End Sub

Public Sub OnActionMove(currentPointerPosition As Point)
	changeDiagonalPosition(currentPointerPosition)
	mCursor.Draw(currentPointerPosition)
	mProject.DrawAllShapes(mCanvas)
End Sub

Public Sub OnActionUp(p As Point)
	mCursor.Clear
	mProject.DrawAllShapes(mCanvas)
End Sub

Private Sub changeDiagonalPosition(currentPointerPosition As Point)
	corner2.x = currentPointerPosition.x
	corner3.x = currentPointerPosition.x
	corner3.y = currentPointerPosition.y
	corner4.y = currentPointerPosition.y
End Sub

Private Sub createRectangleShape(currentPointerPosition As Point) As LineString
	corner1 = currentPointerPosition.Clone
	corner2 = currentPointerPosition.Clone
	corner3 = currentPointerPosition.Clone
	corner4 = currentPointerPosition.Clone
	
	Dim firstLine As Line	
	Dim rectangleShape As LineString
	
	rectangleShape.Initialize(firstLine.Initialize(corner1, corner2))
	rectangleShape.AddLine(corner3)
	rectangleShape.AddLine(corner4)
	rectangleShape.AddLine(corner1)
	
	Return rectangleShape
End Sub