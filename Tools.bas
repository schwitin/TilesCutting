B4A=true
Group=Project\Tools
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
Sub Class_Globals
	Public const TOOL_RECTANGLE As RectangleTool
	Public const TOOL_LINE_STRING As LineStringTool
	Public const TOOL_CORNER As CornerTool
	Public const TOOL_SELECT_SHAPE As ShapeSelectionTool
	Public const TOOL_SELECT_LINE As LineSelectionTool
	Public const TOOL_MOVE As MoveTool
End Sub

Public Sub Initialize(pCanvas As Canvas, pProject As Project)
	TOOL_RECTANGLE.Initialize(pCanvas, pProject)
	TOOL_LINE_STRING.Initialize(pCanvas, pProject)
	TOOL_CORNER.Initialize(pCanvas, pProject)
	TOOL_SELECT_SHAPE.Initialize(pCanvas, pProject)
	TOOL_SELECT_LINE.Initialize(pCanvas, pProject)
	TOOL_MOVE.Initialize(pCanvas, pProject)
End Sub