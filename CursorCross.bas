B4A=true
Group=Project\Tools\Cursors
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
Sub Class_Globals
	Private mColor As Int
	Private mCanvas As Canvas
	Private mVerticalLine As Line
	Private mHorizontalLine As Line
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(pCanvas As Canvas,  pColor As Int)
	mColor = pColor
	mCanvas = pCanvas
	initializeVerticalLine
	initializeHorizontalLine
End Sub

Private Sub initializeVerticalLine
	Dim p1, p2 As Point	
	p1.Initialize(0,0)
	p2.Initialize(0,10000)
	mVerticalLine.Initialize(p1,p2)
End Sub

Private Sub initializeHorizontalLine
	Dim p1, p2 As Point	
	p1.Initialize(0,0)
	p2.Initialize(10000,0)
	mHorizontalLine.Initialize(p1,p2)
End Sub

Public Sub Draw(pointerPosition As Point)
	Clear	
	changeLinesPosition(pointerPosition)
	DrawLines(mColor)	
End Sub

Private Sub changeLinesPosition( pointerPosition As Point)
	mHorizontalLine.point1.y = pointerPosition.y
	mHorizontalLine.point2.y= pointerPosition.y
	mVerticalLine.point1.x = pointerPosition.x
	mVerticalLine.point2.x= pointerPosition.x
End Sub

Public Sub Clear()
	DrawLines(Colors.White)
End Sub


Private Sub DrawLines(pColor As Int)
	mHorizontalLine.Draw(mCanvas, pColor)
	mVerticalLine.Draw(mCanvas, pColor)
End Sub