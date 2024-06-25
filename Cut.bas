B4A=true
Group=Project\Model
ModulesStructureVersion=1
Type=Class
Version=12.8
@EndOfDesignText@
Sub Class_Globals
	Private mCutSide As String
	Private mSplice As Splice
	Private DummyButton As Button 'ignore

End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(pSplice As Splice, pCutSide As String)
	mSplice = pSplice
	mCutSide = pCutSide
End Sub

Private Sub getName As String
	Return mSplice.GetTypeName + " " + mSplice.GetId + " " + mCutSide
End Sub

Public Sub DrawNameOnSketch(pCanvas As Canvas)
	Dim line As Line = mSplice.GetLine
	Dim name As String = getName
	pCanvas.DrawLine(100dip, 100dip, 200dip, 200dip, Colors.Red, 10dip)
	
	pCanvas.DrawTextRotated(name, 200dip, 200dip, Typeface.DEFAULT_BOLD, 30, Colors.Black, "CENTER", -45)
	

End Sub
