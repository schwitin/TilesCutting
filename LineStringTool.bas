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
	Private mLongDownTimer As Timer
	Private mLineString As LineString
	Private mLastLine As Line
	Private mPhoneVibrate As PhoneVibrate
	Private const LONG_DOWN_MS As Long = 1000
	Private const MIN_LINE_LENGTH As Long = 30dip
	Private const CAPTURE_DISTANCE As Int = 20dip
End Sub

Public Sub Initialize(pCanvas As Canvas , pProject As Project) As LineStringTool
	mCanvas = pCanvas
	mProject = pProject
	mCursor.Initialize(mCanvas, Colors.Gray)
	mLongDownTimer.Initialize("LongDown", LONG_DOWN_MS)	
	Return Me
End Sub

Public Sub OnActionDown(pCurrentPointerPosition As Point)
	createLineStringShape(pCurrentPointerPosition)
End Sub

Public Sub OnActionMove(pCurrentPointerPosition As Point)
	' do nothing if same position
	If mLastLine.point2.Equals(pCurrentPointerPosition) Then
		Return
	End If
	
	mLongDownTimer.Enabled = False
	changeLinePosition(pCurrentPointerPosition)
	enableLongDownTimerIfLastLineIsLongEnough	
	
	mProject.DrawAllShapes(mCanvas)
	mCursor.Draw(pCurrentPointerPosition)
End Sub

Public Sub OnActionUp(pCurrentPointerPosition As Point)
	mLongDownTimer.Enabled = False
	removeLastLineIfLastLineIsToShort
	removeLineStringFromProjectIfLineStringContainsNoLines
	mCursor.Clear
	mProject.DrawAllShapes(mCanvas)
End Sub

Sub LongDown_Tick
	mLongDownTimer.Enabled = False
	addNewLineIfLastLineIsLongEnough
End Sub

Private Sub createLineStringShape(pCurrentPointerPosition As Point)
	Dim firstLine As Line
	firstLine.Initialize(pCurrentPointerPosition.Clone, pCurrentPointerPosition)
	
	Dim newLineString As LineString
	newLineString.Initialize(firstLine)
	
	mLastLine = firstLine
	mLineString = newLineString
	mProject.AddShape(mLineString)
End Sub

Private Sub enableLongDownTimerIfLastLineIsLongEnough
	If mLastLine.point1.GetDistance(mLastLine.point2) >= MIN_LINE_LENGTH Then
		mLongDownTimer.Enabled = True
	End If
End Sub

Private Sub addNewLineIfLastLineIsLongEnough
	If mLastLine.point1.GetDistance(mLastLine.point2) >= MIN_LINE_LENGTH Then
		Dim vCurrentPointerPosition As Point = mLastLine.point2
		mLastLine.point2 = mLastLine.point2.Clone
		mLastLine = mLineString.AddLine(vCurrentPointerPosition)
		mPhoneVibrate.Vibrate(50)
	End If
End Sub

Private Sub changeLinePosition(currentPointerPosition As Point)
	If isCapturingX(currentPointerPosition) Then
		mLastLine.point2.y = currentPointerPosition.y
		mLastLine.point2.x = mLastLine.point1.x
	Else If isCapturingY(currentPointerPosition) Then
		mLastLine.point2.x = currentPointerPosition.x
		mLastLine.point2.y = mLastLine.point1.y
	Else
		mLastLine.point2.x = currentPointerPosition.x
		mLastLine.point2.y = currentPointerPosition.y
	End If
End Sub

Private Sub isCapturingY(currentPointerPosition As Point) As Boolean
	Return CAPTURE_DISTANCE >  Abs(currentPointerPosition.y - mLastLine.point1.y)
End Sub

Private Sub isCapturingX(currentPointerPosition As Point) As Boolean
	Return CAPTURE_DISTANCE >  Abs(currentPointerPosition.x - mLastLine.point1.x)
End Sub

Private Sub removeLastLineIfLastLineIsToShort
	If mLastLine.point1.GetDistance(mLastLine.point2) < MIN_LINE_LENGTH Then
		mLineString.RemoveLastLine
	End If
End Sub

Private Sub removeLineStringFromProjectIfLineStringContainsNoLines
	If mLineString.lines.Size = 0 Then
		mProject.RemoveShape(mLineString)
	End If
End Sub