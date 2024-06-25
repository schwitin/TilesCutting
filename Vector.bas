B4A=true
Group=Schnitt
ModulesStructureVersion=1
Type=Class
Version=4
@EndOfDesignText@
'Class module
Sub Class_Globals
	Dim Description As String
	Dim Units       As String
    Dim Size        As Double
    Dim AngleD      As Double
    Dim AngleR      As Double
    Dim dirX        As Double
	Dim dirY        As Double
End Sub

'Sets this vector's description and units
Public Sub vecDescription(Vector_Description As String, Vector_Units As String)
	Description = Vector_Description
	Units       = Vector_Units
End Sub

'Sets this vector's directional components, magnitude and angle from an imaginary line between two points in space, given their X, Y coordinates.
Public Sub vecLine(aX As Double, aY As Double, bX As Double, bY As Double)
    dirX      = bX - aX
    dirY      = bY - aY
    AngleD    = ATan2D(dirY, dirX)
    AngleR    = ATan2 (dirY, dirX)
    Size      = Sqrt(Power(dirX, 2) + Power(dirY, 2))    
End Sub

'Sets this vector's directional components based on the given size and angle in degrees.
Public Sub vecAngleMagD(Magnitude As Double, Degrees As Double)
	AngleD    = Degrees
    AngleR    = Degrees * cPI / 180
    Size      = Magnitude
    dirX      = CosD(Degrees) * Magnitude
    dirY      = SinD(Degrees) * Magnitude
End Sub

'Sets this vector's directional components based on the given size and angle in degrees.
Public Sub vecAngleMagR(Magnitude As Double, Radians As Double)
    AngleD    = Radians * 180 / cPI
	AngleR    = Radians    
    Size      = Magnitude
    dirX      = Cos(Radians) * Magnitude
    dirY      = Sin(Radians) * Magnitude
End Sub

'Sets this Vector's directional components, magnitude and angle in radians based on the given angle in degrees.
Public Sub vecAngleD(Degrees As Double)
	AngleD    = Degrees
    AngleR    = Degrees * cPI / 180    
    dirX      = CosD(Degrees) * Size
    dirY      = SinD(Degrees) * Size
End Sub

'Sets this vector's directional components, magnitude and angle in degrees based on the given angle in radians.
Public Sub vecAngleR(Radians As Double)
	AngleD    = Radians * 180 / cPI
    AngleR    = Radians
    dirX      = Cos(Radians) * Size
    dirY      = Sin(Radians) * Size
End Sub