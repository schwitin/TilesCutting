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
	Private mCurrentPointerPosition As Point
	Private mLineString As LineString
	Private mLastLine As Line
	Private mPhoneVibrate As PhoneVibrate
	Private const LONG_DOWN_MS As Long = 2000
	Private const MIN_LINE_LENGTH As Long = 10dip
End Sub

Public Sub Initialize(pCanvas As Canvas , pProject As Project) As LineTool
	mCanvas = pCanvas
	mProject = pProject
	mCursor.Initialize(mCanvas, Colors.Gray)
	mLongDownTimer.Initialize("LongDown", LONG_DOWN_MS)	
	Return Me
End Sub

Public Sub OnActionDown(pCurrentPointerPosition As Point)
	mCurrentPointerPosition = pCurrentPointerPosition
	Dim newLine As Line
	newLine.Initialize(mCurrentPointerPosition.Clone, mCurrentPointerPosition)
	mLineString.Initialize(newLine)
	mProject.AddShape(mLineString)
End Sub

Public Sub OnActionMove(pCurrentPointerPosition As Point)
	mCurrentPointerPosition = pCurrentPointerPosition
	mLongDownTimer.Enabled = False
	If mLastLine.point1.GetDistance(mLastLine.point2) >= MIN_LINE_LENGTH Then		
		mLongDownTimer.Enabled = True	
	End If
	mProject.DrawAllShapes(mCanvas)
	mCursor.Draw(mCurrentPointerPosition)
End Sub

Public Sub OnActionUp(pCurrentPointerPosition As Point)
	removeLastLineIfLastLineIsToShort
	removeLineStringFromProjectIfLineStringContainsNoLines
	mCursor.Clear
	mProject.DrawAllShapes(mCanvas)
End Sub

Sub LongDown_Tick
	mLongDownTimer.Enabled = False
	addNewLineIfLineLongEnought
End Sub

Private Sub addNewLineIfLineLongEnought
	If mLastLine.point1.GetDistance(mLastLine.point2) >= MIN_LINE_LENGTH Then
		mLastLine.point2 = mCurrentPointerPosition.Clone
		mLastLine = mLineString.AddLine(mCurrentPointerPosition)
		mPhoneVibrate.Vibrate(300)
	End If
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