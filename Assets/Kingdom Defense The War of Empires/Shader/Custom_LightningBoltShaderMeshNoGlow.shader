//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Custom/LightningBoltShaderMeshNoGlow" {
Properties {
_MainTex ("Color (RGB) Alpha (A)", 2D) = "white" { }
_TintColor ("Tint Color (RGB)", Color) = (1,1,1,1)
_InvFade ("Soft Particles Factor", Range(0.01, 100)) = 1
_JitterMultiplier ("Jitter Multiplier (Float)", Float) = 0
_Turbulence ("Turbulence (Float)", Float) = 0
_TurbulenceVelocity ("Turbulence Velocity (Vector)", Vector) = (0,0,0,0)
_SrcBlendMode ("SrcBlendMode (Source Blend Mode)", Float) = 5
_DstBlendMode ("DstBlendMode (Destination Blend Mode)", Float) = 1
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "ALWAYS" "PreviewType" = "Plane" "QUEUE" = "Transparent+10" "RenderType" = "Transparent" }
 UsePass "Custom/LightningBoltShaderMesh/LINEPASS"
}
}