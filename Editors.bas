B4A=true
Group=Editors
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
Sub Class_Globals
	Public const TOOL_RECTANGLE As RectangleEditor
	Public const TOOL_LINE As LineEditor
	Public const TOOL_SELECT As SelectionTool
	Public const TOOL_MOVE As MoveTool
End Sub

Public Sub Initialize(pCanvas As Canvas, pProject As Project)
	TOOL_RECTANGLE.Initialize(pCanvas, pProject)
	TOOL_LINE.Initialize(pCanvas, pProject)
	TOOL_SELECT.Initialize(pCanvas, pProject)
	TOOL_MOVE.Initialize(pCanvas, pProject)
End Sub

