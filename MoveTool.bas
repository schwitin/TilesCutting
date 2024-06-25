B4A=true
Group=Project\Tools
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
Sub Class_Globals
	Private mCanvas As Canvas
	Private mProject As Project
	Private mMotion As Line
End Sub

Public Sub Initialize(pCanvas As Canvas , pProject As Project) As MoveTool
	mCanvas = pCanvas
	mProject = pProject
	Return Me
End Sub

Public Sub OnActionDown(currentPointerPosition As Point)
	mMotion.Initialize(currentPointerPosition, currentPointerPosition)
End Sub

Public Sub OnActionMove(currentPointerPosition As Point)
	mMotion.point2 = currentPointerPosition
	moveSelectedShape
	mProject.DrawAllShapes(mCanvas)
	mMotion.point1 = currentPointerPosition
End Sub

Public Sub OnActionUp(currentPointerPosition As Point)
End Sub

Private Sub moveSelectedShape
	If mProject.selectedShape <> Null Then
		CallSub2(mProject.selectedShape, "Move", mMotion)
	End If
End Sub