B4A=true
Group=Actions
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
Sub Class_Globals
	Private mCanvas As Canvas
	Private mProject As Project
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(pCanvas As Canvas, pProject As Project) As MoveShapeAction
	mCanvas = pCanvas
	mProject = pProject
	Return Me
End Sub

Public Sub DoAction
	Log(">> Changing into move mode..")
	Log("<< Changing into move mode done")
	End Sub