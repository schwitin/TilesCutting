B4A=true
Group=Project\Actions
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
Sub Class_Globals
	Private mCanvas As Canvas
	Private mProject As Project
	Private mPiecesCount As Int
	Private mShapeWithSelectedLine As Object = Null
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(pCanvas As Canvas, pProject As Project, pPiecesCount As Int) As SplitLineActioin
	mCanvas = pCanvas
	mProject = pProject
	mPiecesCount = pPiecesCount
	Return Me
End Sub

Public Sub DoAction
	Log(">> Spliting Line in " & mPiecesCount & " pieces ...")
	splitSelectedLine
	mProject.DrawAllShapes(mCanvas)
	Log(">> Spliting Line in " & mPiecesCount & " pieces done")
End Sub

Private Sub splitSelectedLine
	If mShapeWithSelectedLine = Null Then
		Return
	End If	
	CallSub2(mShapeWithSelectedLine, "SplitSelectedLine", mPiecesCount)
End Sub

Public Sub OnLineDeselected
	mShapeWithSelectedLine = Null
End Sub

Public Sub OnLineSelected(shapeWithSelectedLine As Object, selectedLine As Line)
	mShapeWithSelectedLine = shapeWithSelectedLine
End Sub