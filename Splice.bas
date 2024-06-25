B4A=true
Group=Project\Model
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
' Representiert eine Stoßverbindung
Sub Class_Globals
	
	' Eindeutige Nummer der Stoßverbindung
	Private mId As Int
	
	' Typ der Stoßverbindung (Grat, Kehle)
	Private mSpliceType As Int
	
	' Linie auf der Skizze
	Private mLine As Line
	
	' Linker Schnitt 
	Private mCutLeft As Cut
	
	' Rechter Schnitt
	Private mCutRight As Cut
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(pLine As Line, pSpliceType As Int)
	mLine = pLine
	mSpliceType = pSpliceType
	mCutLeft.Initialize(Me, Constants.CUT_SIDE_LEFT)
	mCutRight.Initialize(Me, Constants.CUT_SIDE_RIGHT)
	mId = SpliceIdGenerator.NextId
End Sub

Public Sub GetTypeName As String
	Select mSpliceType
		Case Constants.SPLICE_TYPE_RABBET
		Return "Kehle"
		Case Constants.SPLICE_TYPE_RIB
		Return "Grat"
		Case Else
		Return "Unb."
	End Select
End Sub

Public Sub GetId As Int
	Return mId
End Sub

Public Sub GetLine As Line
	Return mLine
End Sub