B4A=true
Group=Project\Tools
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
Sub Class_Globals
	Private mCorner As Point
	Private mProject As Project
	Private mLineSelectionTool As LineSelectionTool
	Private mPhoneVibrate As PhoneVibrate
	Private mSelectedLine As Line = Null
End Sub

Public Sub Initialize(pCanvas As Canvas, pProject As Project) As CornerTool
	mProject = pProject
	mLineSelectionTool.Initialize(pCanvas, pProject)
	Return Me
End Sub

Public Sub OnActionDown(startPoint As Point)	
	mLineSelectionTool.AddSelectionChangedListener(Me)
	mLineSelectionTool.OnActionDown(startPoint)
	mCorner = startPoint
	OnActionMove(startPoint)
End Sub

Public Sub OnActionMove(currentPointerPosition As Point)
	mLineSelectionTool.OnActionMove(currentPointerPosition)
	changeCornerPosition(currentPointerPosition)
End Sub

Public Sub OnActionUp(currentPointerPosition As Point)
	mLineSelectionTool.OnActionUp(currentPointerPosition)	
	mLineSelectionTool.RemoveSelectionChangedListener(Me)
	mSelectedLine = Null
End Sub

Public Sub OnLineSelected(shapeWithSelectedLine As Object, selectedLine As Line)
	If mSelectedLine = Null Then
		mPhoneVibrate.Vibrate(50)
		mSelectedLine = selectedLine
		createCornerShape		
	End If
End Sub

Public Sub OnLineDeselected	
End Sub

Private Sub changeCornerPosition(currentPointerPosition As Point)
	mCorner.x = currentPointerPosition.x
	mCorner.y = currentPointerPosition.y
End Sub

Private Sub createCornerShape
	Dim point1 As Point = mSelectedLine.point1.Clone
	Dim point2 As Point = mSelectedLine.point2.Clone
	
	Dim cornerShape As LineString
	Dim firstLine As Line
	firstLine.Initialize(point1, mCorner)
	cornerShape.Initialize(firstLine)
	cornerShape.AddLine(point2)
	mProject.AddShape(cornerShape)
End Sub