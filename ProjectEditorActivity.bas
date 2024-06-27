B4A=true
Group=Project\View
ModulesStructureVersion=1
Type=Activity
Version=12.8
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: True
	#IncludeTitle: False
#End Region

Sub Process_Globals

End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.
	Private pnlCanvans As Panel
	Private canvas As Canvas
	Private Drawer As B4XDrawer
	Private lstMenu As ListView
	Private selectedTool As Object
	Private mProject As Project	
	Private mTools As Tools
	'Private pnlToolBar As Panel
	Private btnToolLine As SwiftButton
	Private btnToolRectangle As SwiftButton
	Private btnToolSelect As SwiftButton
	Private btnToolMove As SwiftButton	
	Private btnToolSelectLine As SwiftButton
	Private btnToolCorner As SwiftButton	
	Private const RASTER As Long = 10dip
End Sub

Sub Activity_Create(FirstTime As Boolean)
	initializeDrawer
	canvas.Initialize(pnlCanvans)
	mProject.Initialize()
	mTools.Initialize(canvas, mProject)
	initializeSelectedTool
	initializeActionMenu
End Sub

Private Sub initializeDrawer
	Drawer.Initialize(Me, "Drawer", Activity, 300dip)
	Drawer.CenterPanel.LoadLayout("project_editor_layout")
	Drawer.LeftPanel.LoadLayout("project_editor_Drawer_layout")
End Sub

Private Sub initializeSelectedTool
	selectedTool = mTools.TOOL_RECTANGLE
	setColorOnToolButtons(btnToolRectangle)
End Sub

Private Sub initializeActionMenu
	Dim vDeleteShapeAction  As DeleteShapeAction
	vDeleteShapeAction.Initialize(canvas, mProject)
	lstMenu.AddTwoLinesAndBitmap2("Löschen", "Entfernt das ausgewählter Element", LoadBitmap(File.DirAssets, "trash.png"), vDeleteShapeAction)
	
	Dim vSplitLineAction As SplitLineActioin
	vSplitLineAction.Initialize(canvas, mProject, 2)
	lstMenu.AddTwoLinesAndBitmap2("Teilen in 2 St.", "Teilt ausgewählte Linie", LoadBitmap(File.DirAssets, "split.png"), vSplitLineAction)
	mTools.TOOL_SELECT_LINE.AddSelectionChangedListener(vSplitLineAction)
	
	Dim vSendToWhatsAppAction As SendToWhatsAppAction
	vSendToWhatsAppAction.Initialize("4915150846500", mProject)
	lstMenu.AddTwoLinesAndBitmap2("An Grischa senden", "Sendet an Grischa WatsApp Nachricht", LoadBitmap(File.DirAssets, "whatsapp.png"), vSendToWhatsAppAction)
	
	
	For i = 1 To 30
		lstMenu.AddTwoLinesAndBitmap("First line", "Second line with long description", LoadBitmap(File.DirAssets, "compass.png"))
	Next
	lstMenu.TwoLinesAndBitmap.SecondLabel.TextSize = 12
	lstMenu.TwoLinesAndBitmap.SecondLabel.TextColor = Colors.White
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub

Sub Activity_KeyPress (KeyCode As Int) As Boolean
	If KeyCode = KeyCodes.KEYCODE_BACK And Drawer.LeftOpen Then
		Drawer.LeftOpen = False
		Return True
	End If
	Return False
End Sub


Private Sub btnHamburger_Click
	Drawer.LeftOpen = Not(Drawer.LeftOpen)
End Sub


Private Sub pnlCanvans_Touch (Action As Int, X As Double, Y As Double)
	Dim pointerPosition As Point
	Dim xRasterized As Int = (X / RASTER).As(Int) * RASTER
	Dim yRasterized As Int = (Y / RASTER).As(Int) * RASTER
	pointerPosition.Initialize(xRasterized, yRasterized)
	Log("Raster -->" & pointerPosition)
	
	Select Action
		Case pnlCanvans.ACTION_DOWN
			CallSub2(selectedTool, "OnActionDown", pointerPosition)
		Case pnlCanvans.ACTION_MOVE
			CallSub2(selectedTool, "OnActionMove", pointerPosition)
		Case pnlCanvans.ACTION_UP
			CallSub2(selectedTool, "OnActionUp", pointerPosition)
	End Select
	
	Activity.Invalidate
End Sub

Private Sub btnToolRectangle_Click
	selectedTool = mTools.TOOL_RECTANGLE
	Dim clickedToolButton As SwiftButton = Sender
	setColorOnToolButtons(clickedToolButton)
	Activity.Invalidate
End Sub

Private Sub btnToolSelect_Click
	selectedTool = mTools.TOOL_SELECT_SHAPE
	Dim clickedToolButton As SwiftButton = Sender
	setColorOnToolButtons(clickedToolButton)
	Activity.Invalidate
End Sub

Private Sub btnToolLine_Click
	selectedTool = mTools.TOOL_LINE_STRING
	Dim clickedToolButton As SwiftButton = Sender
	setColorOnToolButtons(clickedToolButton)
	Activity.Invalidate
End Sub

Private Sub btnToolMove_Click
	selectedTool = mTools.TOOL_MOVE
	Dim clickedToolButton As SwiftButton = Sender
	setColorOnToolButtons(clickedToolButton)
	Activity.Invalidate	
End Sub

Private Sub btnToolSelectLine_Click
	selectedTool = mTools.TOOL_SELECT_LINE
	Dim clickedToolButton As SwiftButton = Sender
	setColorOnToolButtons(clickedToolButton)
	Activity.Invalidate
End Sub


Private Sub btnToolCorner_Click
	selectedTool = mTools.TOOL_CORNER
	Dim clickedToolButton As SwiftButton = Sender
	setColorOnToolButtons(clickedToolButton)
	Activity.Invalidate
End Sub

Private Sub setColorOnToolButtons(clickedToolButton As SwiftButton)
	For Each toolButton As SwiftButton In Array(btnToolLine, btnToolRectangle, btnToolSelect, btnToolMove, btnToolSelectLine, btnToolCorner)	
		toolButton.SetColors(Colors.Gray, Colors.Gray)		
	Next
	clickedToolButton.SetColors(Colors.Blue, Colors.Blue)
End Sub

Private Sub lstMenu_ItemClick (Position As Int, action As Object)
	CallSub(action, "DoAction")
	Drawer.LeftOpen = Not(Drawer.LeftOpen)
	Activity.Invalidate
End Sub