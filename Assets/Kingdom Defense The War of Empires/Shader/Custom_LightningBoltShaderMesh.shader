//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Custom/LightningBoltShaderMesh" {
Properties {
_MainTex ("Main Texture (RGBA)", 2D) = "white" { }
_GlowTex ("Glow Texture (RGBA)", 2D) = "blue" { }
_TintColor ("Tint Color (RGB)", Color) = (1,1,1,1)
_GlowTintColor ("Glow Tint Color (RGB)", Color) = (1,1,1,1)
_InvFade ("Soft Particles Factor", Range(0.01, 100)) = 1
_JitterMultiplier ("Jitter Multiplier (Float)", Float) = 0
_Turbulence ("Turbulence (Float)", Float) = 0
_TurbulenceVelocity ("Turbulence Velocity (Vector)", Vector) = (0,0,0,0)
_SrcBlendMode ("SrcBlendMode (Source Blend Mode)", Float) = 5
_DstBlendMode ("DstBlendMode (Destination Blend Mode)", Float) = 1
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "ALWAYS" "PreviewType" = "Plane" "QUEUE" = "Transparent+10" "RenderType" = "Transparent" }
 Pass {
  Name "GLOWPASS"
  LOD 400
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "ALWAYS" "PreviewType" = "Plane" "QUEUE" = "Transparent+10" "RenderType" = "Transparent" }
  Blend Zero Zero, Zero Zero
  ZWrite Off
  Cull Off
  GpuProgramID 63959
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec2 tangent_1;
  lowp vec4 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = abs(_glesTANGENT.w);
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_4 = (tmpvar_5 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_6;
  tmpvar_6 = (_glesMultiTexCoord0.z * (tmpvar_3 + tmpvar_3));
  highp vec2 tmpvar_7;
  tmpvar_7 = (((_TurbulenceVelocity * vec4(tmpvar_4)).xz + normalize(_glesTANGENT.xz)) * ((_Turbulence / 
    max (0.5, tmpvar_3)
  ) * tmpvar_4));
  highp vec4 tmpvar_8;
  tmpvar_8.yw = vec2(0.0, 0.0);
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.z = tmpvar_7.y;
  highp vec2 tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_9 = (((
    normalize(_glesNormal.xz)
   * 
    (tmpvar_10 + tmpvar_10)
  ) * tmpvar_6) * 1.5);
  highp vec4 tmpvar_11;
  tmpvar_11.yw = vec2(0.0, 0.0);
  tmpvar_11.x = tmpvar_9.x;
  tmpvar_11.z = tmpvar_9.y;
  highp vec2 tmpvar_12;
  tmpvar_12.x = -(_glesNormal.z);
  tmpvar_12.y = _glesNormal.x;
  tangent_1 = (((
    normalize(tmpvar_12)
   * tmpvar_6) * (_glesTANGENT.w / tmpvar_3)) * (1.0 + (
    (fract((sin(
      dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))
    ) * 43758.55)) * _JitterMultiplier)
   * 0.05)));
  highp vec4 tmpvar_13;
  tmpvar_13.yw = vec2(0.0, 0.0);
  tmpvar_13.x = tangent_1.x;
  tmpvar_13.z = tangent_1.y;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((_glesVertex + tmpvar_11) + (tmpvar_13 + tmpvar_8)).xyz;
  highp float tmpvar_15;
  bool tmpvar_16;
  tmpvar_16 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_15 = ((float(tmpvar_16) * clamp (
    (tmpvar_5 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_16)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesColor.xyz;
  tmpvar_2 = ((tmpvar_15 * _GlowTintColor) * tmpvar_17);
  tmpvar_2.w = (tmpvar_2.w * _glesMultiTexCoord0.w);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_GlowTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec2 tangent_1;
  lowp vec4 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = abs(_glesTANGENT.w);
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_4 = (tmpvar_5 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_6;
  tmpvar_6 = (_glesMultiTexCoord0.z * (tmpvar_3 + tmpvar_3));
  highp vec2 tmpvar_7;
  tmpvar_7 = (((_TurbulenceVelocity * vec4(tmpvar_4)).xz + normalize(_glesTANGENT.xz)) * ((_Turbulence / 
    max (0.5, tmpvar_3)
  ) * tmpvar_4));
  highp vec4 tmpvar_8;
  tmpvar_8.yw = vec2(0.0, 0.0);
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.z = tmpvar_7.y;
  highp vec2 tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_9 = (((
    normalize(_glesNormal.xz)
   * 
    (tmpvar_10 + tmpvar_10)
  ) * tmpvar_6) * 1.5);
  highp vec4 tmpvar_11;
  tmpvar_11.yw = vec2(0.0, 0.0);
  tmpvar_11.x = tmpvar_9.x;
  tmpvar_11.z = tmpvar_9.y;
  highp vec2 tmpvar_12;
  tmpvar_12.x = -(_glesNormal.z);
  tmpvar_12.y = _glesNormal.x;
  tangent_1 = (((
    normalize(tmpvar_12)
   * tmpvar_6) * (_glesTANGENT.w / tmpvar_3)) * (1.0 + (
    (fract((sin(
      dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))
    ) * 43758.55)) * _JitterMultiplier)
   * 0.05)));
  highp vec4 tmpvar_13;
  tmpvar_13.yw = vec2(0.0, 0.0);
  tmpvar_13.x = tangent_1.x;
  tmpvar_13.z = tangent_1.y;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((_glesVertex + tmpvar_11) + (tmpvar_13 + tmpvar_8)).xyz;
  highp float tmpvar_15;
  bool tmpvar_16;
  tmpvar_16 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_15 = ((float(tmpvar_16) * clamp (
    (tmpvar_5 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_16)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesColor.xyz;
  tmpvar_2 = ((tmpvar_15 * _GlowTintColor) * tmpvar_17);
  tmpvar_2.w = (tmpvar_2.w * _glesMultiTexCoord0.w);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_GlowTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec2 tangent_1;
  lowp vec4 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = abs(_glesTANGENT.w);
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_4 = (tmpvar_5 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_6;
  tmpvar_6 = (_glesMultiTexCoord0.z * (tmpvar_3 + tmpvar_3));
  highp vec2 tmpvar_7;
  tmpvar_7 = (((_TurbulenceVelocity * vec4(tmpvar_4)).xz + normalize(_glesTANGENT.xz)) * ((_Turbulence / 
    max (0.5, tmpvar_3)
  ) * tmpvar_4));
  highp vec4 tmpvar_8;
  tmpvar_8.yw = vec2(0.0, 0.0);
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.z = tmpvar_7.y;
  highp vec2 tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_9 = (((
    normalize(_glesNormal.xz)
   * 
    (tmpvar_10 + tmpvar_10)
  ) * tmpvar_6) * 1.5);
  highp vec4 tmpvar_11;
  tmpvar_11.yw = vec2(0.0, 0.0);
  tmpvar_11.x = tmpvar_9.x;
  tmpvar_11.z = tmpvar_9.y;
  highp vec2 tmpvar_12;
  tmpvar_12.x = -(_glesNormal.z);
  tmpvar_12.y = _glesNormal.x;
  tangent_1 = (((
    normalize(tmpvar_12)
   * tmpvar_6) * (_glesTANGENT.w / tmpvar_3)) * (1.0 + (
    (fract((sin(
      dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))
    ) * 43758.55)) * _JitterMultiplier)
   * 0.05)));
  highp vec4 tmpvar_13;
  tmpvar_13.yw = vec2(0.0, 0.0);
  tmpvar_13.x = tangent_1.x;
  tmpvar_13.z = tangent_1.y;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((_glesVertex + tmpvar_11) + (tmpvar_13 + tmpvar_8)).xyz;
  highp float tmpvar_15;
  bool tmpvar_16;
  tmpvar_16 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_15 = ((float(tmpvar_16) * clamp (
    (tmpvar_5 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_16)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesColor.xyz;
  tmpvar_2 = ((tmpvar_15 * _GlowTintColor) * tmpvar_17);
  tmpvar_2.w = (tmpvar_2.w * _glesMultiTexCoord0.w);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_GlowTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
vec2 u_xlat7;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = dot(in_TANGENT0.xz, in_TANGENT0.xz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xy = u_xlat3.xx * in_TANGENT0.xz;
    u_xlat3.xy = u_xlat0.xx * _TurbulenceVelocity.xz + u_xlat3.xy;
    u_xlat9 = max(abs(in_TANGENT0.w), 0.5);
    u_xlat9 = _Turbulence / u_xlat9;
    u_xlat0.x = u_xlat9 * u_xlat0.x;
    u_xlat0.xz = u_xlat0.xx * u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier;
    u_xlat9 = u_xlat9 * 0.0500000007 + 1.0;
    u_xlat1.x = dot(in_NORMAL0.xz, in_NORMAL0.xz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xy = u_xlat1.xx * in_NORMAL0.xz;
    u_xlat7.x = in_TEXCOORD0.x + -0.5;
    u_xlat7.x = u_xlat7.x + u_xlat7.x;
    u_xlat1.xy = u_xlat7.xx * u_xlat1.xy;
    u_xlat7.x = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat7.x = u_xlat7.x * in_TEXCOORD0.z;
    u_xlat1.xy = u_xlat7.xx * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.5, 1.5) + in_POSITION0.xz;
    u_xlat2.xy = in_NORMAL0.zx * vec2(-1.0, 1.0);
    u_xlat10 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xy = vec2(u_xlat10) * u_xlat2.xy;
    u_xlat7.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.x = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat7.xy = u_xlat7.xy * u_xlat2.xx;
    u_xlat1.xz = u_xlat7.xy * vec2(u_xlat9) + u_xlat1.xy;
    u_xlat1.y = in_POSITION0.y;
    u_xlat0.y = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
vec2 u_xlat7;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = dot(in_TANGENT0.xz, in_TANGENT0.xz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xy = u_xlat3.xx * in_TANGENT0.xz;
    u_xlat3.xy = u_xlat0.xx * _TurbulenceVelocity.xz + u_xlat3.xy;
    u_xlat9 = max(abs(in_TANGENT0.w), 0.5);
    u_xlat9 = _Turbulence / u_xlat9;
    u_xlat0.x = u_xlat9 * u_xlat0.x;
    u_xlat0.xz = u_xlat0.xx * u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier;
    u_xlat9 = u_xlat9 * 0.0500000007 + 1.0;
    u_xlat1.x = dot(in_NORMAL0.xz, in_NORMAL0.xz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xy = u_xlat1.xx * in_NORMAL0.xz;
    u_xlat7.x = in_TEXCOORD0.x + -0.5;
    u_xlat7.x = u_xlat7.x + u_xlat7.x;
    u_xlat1.xy = u_xlat7.xx * u_xlat1.xy;
    u_xlat7.x = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat7.x = u_xlat7.x * in_TEXCOORD0.z;
    u_xlat1.xy = u_xlat7.xx * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.5, 1.5) + in_POSITION0.xz;
    u_xlat2.xy = in_NORMAL0.zx * vec2(-1.0, 1.0);
    u_xlat10 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xy = vec2(u_xlat10) * u_xlat2.xy;
    u_xlat7.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.x = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat7.xy = u_xlat7.xy * u_xlat2.xx;
    u_xlat1.xz = u_xlat7.xy * vec2(u_xlat9) + u_xlat1.xy;
    u_xlat1.y = in_POSITION0.y;
    u_xlat0.y = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
vec2 u_xlat7;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = dot(in_TANGENT0.xz, in_TANGENT0.xz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xy = u_xlat3.xx * in_TANGENT0.xz;
    u_xlat3.xy = u_xlat0.xx * _TurbulenceVelocity.xz + u_xlat3.xy;
    u_xlat9 = max(abs(in_TANGENT0.w), 0.5);
    u_xlat9 = _Turbulence / u_xlat9;
    u_xlat0.x = u_xlat9 * u_xlat0.x;
    u_xlat0.xz = u_xlat0.xx * u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier;
    u_xlat9 = u_xlat9 * 0.0500000007 + 1.0;
    u_xlat1.x = dot(in_NORMAL0.xz, in_NORMAL0.xz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xy = u_xlat1.xx * in_NORMAL0.xz;
    u_xlat7.x = in_TEXCOORD0.x + -0.5;
    u_xlat7.x = u_xlat7.x + u_xlat7.x;
    u_xlat1.xy = u_xlat7.xx * u_xlat1.xy;
    u_xlat7.x = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat7.x = u_xlat7.x * in_TEXCOORD0.z;
    u_xlat1.xy = u_xlat7.xx * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.5, 1.5) + in_POSITION0.xz;
    u_xlat2.xy = in_NORMAL0.zx * vec2(-1.0, 1.0);
    u_xlat10 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xy = vec2(u_xlat10) * u_xlat2.xy;
    u_xlat7.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.x = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat7.xy = u_xlat7.xy * u_xlat2.xx;
    u_xlat1.xz = u_xlat7.xy * vec2(u_xlat9) + u_xlat1.xy;
    u_xlat1.y = in_POSITION0.y;
    u_xlat0.y = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tangent_1;
  lowp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = abs(_glesTANGENT.w);
  highp float tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_5 = (tmpvar_6 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_7;
  tmpvar_7 = (_glesMultiTexCoord0.z * (tmpvar_4 + tmpvar_4));
  highp vec2 tmpvar_8;
  tmpvar_8 = (((_TurbulenceVelocity * vec4(tmpvar_5)).xz + normalize(_glesTANGENT.xz)) * ((_Turbulence / 
    max (0.5, tmpvar_4)
  ) * tmpvar_5));
  highp vec4 tmpvar_9;
  tmpvar_9.yw = vec2(0.0, 0.0);
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.z = tmpvar_8.y;
  highp vec2 tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_10 = (((
    normalize(_glesNormal.xz)
   * 
    (tmpvar_11 + tmpvar_11)
  ) * tmpvar_7) * 1.5);
  highp vec4 tmpvar_12;
  tmpvar_12.yw = vec2(0.0, 0.0);
  tmpvar_12.x = tmpvar_10.x;
  tmpvar_12.z = tmpvar_10.y;
  highp vec2 tmpvar_13;
  tmpvar_13.x = -(_glesNormal.z);
  tmpvar_13.y = _glesNormal.x;
  tangent_1 = (((
    normalize(tmpvar_13)
   * tmpvar_7) * (_glesTANGENT.w / tmpvar_4)) * (1.0 + (
    (fract((sin(
      dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))
    ) * 43758.55)) * _JitterMultiplier)
   * 0.05)));
  highp vec4 tmpvar_14;
  tmpvar_14.yw = vec2(0.0, 0.0);
  tmpvar_14.x = tangent_1.x;
  tmpvar_14.z = tangent_1.y;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = ((_glesVertex + tmpvar_12) + (tmpvar_14 + tmpvar_9)).xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  highp float tmpvar_17;
  bool tmpvar_18;
  tmpvar_18 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_17 = ((float(tmpvar_18) * clamp (
    (tmpvar_6 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_18)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = _glesColor.xyz;
  tmpvar_2 = ((tmpvar_17 * _GlowTintColor) * tmpvar_19);
  tmpvar_2.w = (tmpvar_2.w * _glesMultiTexCoord0.w);
  highp vec4 o_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
  o_20.xy = (tmpvar_22 + tmpvar_21.w);
  o_20.zw = tmpvar_15.zw;
  tmpvar_3.xyw = o_20.xyw;
  highp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = _glesVertex.xyz;
  tmpvar_3.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_23)).z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_2;
  gl_Position = tmpvar_15;
  xlv_TEXCOORD1 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_GlowTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tangent_1;
  lowp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = abs(_glesTANGENT.w);
  highp float tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_5 = (tmpvar_6 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_7;
  tmpvar_7 = (_glesMultiTexCoord0.z * (tmpvar_4 + tmpvar_4));
  highp vec2 tmpvar_8;
  tmpvar_8 = (((_TurbulenceVelocity * vec4(tmpvar_5)).xz + normalize(_glesTANGENT.xz)) * ((_Turbulence / 
    max (0.5, tmpvar_4)
  ) * tmpvar_5));
  highp vec4 tmpvar_9;
  tmpvar_9.yw = vec2(0.0, 0.0);
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.z = tmpvar_8.y;
  highp vec2 tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_10 = (((
    normalize(_glesNormal.xz)
   * 
    (tmpvar_11 + tmpvar_11)
  ) * tmpvar_7) * 1.5);
  highp vec4 tmpvar_12;
  tmpvar_12.yw = vec2(0.0, 0.0);
  tmpvar_12.x = tmpvar_10.x;
  tmpvar_12.z = tmpvar_10.y;
  highp vec2 tmpvar_13;
  tmpvar_13.x = -(_glesNormal.z);
  tmpvar_13.y = _glesNormal.x;
  tangent_1 = (((
    normalize(tmpvar_13)
   * tmpvar_7) * (_glesTANGENT.w / tmpvar_4)) * (1.0 + (
    (fract((sin(
      dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))
    ) * 43758.55)) * _JitterMultiplier)
   * 0.05)));
  highp vec4 tmpvar_14;
  tmpvar_14.yw = vec2(0.0, 0.0);
  tmpvar_14.x = tangent_1.x;
  tmpvar_14.z = tangent_1.y;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = ((_glesVertex + tmpvar_12) + (tmpvar_14 + tmpvar_9)).xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  highp float tmpvar_17;
  bool tmpvar_18;
  tmpvar_18 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_17 = ((float(tmpvar_18) * clamp (
    (tmpvar_6 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_18)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = _glesColor.xyz;
  tmpvar_2 = ((tmpvar_17 * _GlowTintColor) * tmpvar_19);
  tmpvar_2.w = (tmpvar_2.w * _glesMultiTexCoord0.w);
  highp vec4 o_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
  o_20.xy = (tmpvar_22 + tmpvar_21.w);
  o_20.zw = tmpvar_15.zw;
  tmpvar_3.xyw = o_20.xyw;
  highp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = _glesVertex.xyz;
  tmpvar_3.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_23)).z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_2;
  gl_Position = tmpvar_15;
  xlv_TEXCOORD1 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_GlowTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tangent_1;
  lowp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = abs(_glesTANGENT.w);
  highp float tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_5 = (tmpvar_6 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_7;
  tmpvar_7 = (_glesMultiTexCoord0.z * (tmpvar_4 + tmpvar_4));
  highp vec2 tmpvar_8;
  tmpvar_8 = (((_TurbulenceVelocity * vec4(tmpvar_5)).xz + normalize(_glesTANGENT.xz)) * ((_Turbulence / 
    max (0.5, tmpvar_4)
  ) * tmpvar_5));
  highp vec4 tmpvar_9;
  tmpvar_9.yw = vec2(0.0, 0.0);
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.z = tmpvar_8.y;
  highp vec2 tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_10 = (((
    normalize(_glesNormal.xz)
   * 
    (tmpvar_11 + tmpvar_11)
  ) * tmpvar_7) * 1.5);
  highp vec4 tmpvar_12;
  tmpvar_12.yw = vec2(0.0, 0.0);
  tmpvar_12.x = tmpvar_10.x;
  tmpvar_12.z = tmpvar_10.y;
  highp vec2 tmpvar_13;
  tmpvar_13.x = -(_glesNormal.z);
  tmpvar_13.y = _glesNormal.x;
  tangent_1 = (((
    normalize(tmpvar_13)
   * tmpvar_7) * (_glesTANGENT.w / tmpvar_4)) * (1.0 + (
    (fract((sin(
      dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))
    ) * 43758.55)) * _JitterMultiplier)
   * 0.05)));
  highp vec4 tmpvar_14;
  tmpvar_14.yw = vec2(0.0, 0.0);
  tmpvar_14.x = tangent_1.x;
  tmpvar_14.z = tangent_1.y;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = ((_glesVertex + tmpvar_12) + (tmpvar_14 + tmpvar_9)).xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  highp float tmpvar_17;
  bool tmpvar_18;
  tmpvar_18 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_17 = ((float(tmpvar_18) * clamp (
    (tmpvar_6 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_18)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = _glesColor.xyz;
  tmpvar_2 = ((tmpvar_17 * _GlowTintColor) * tmpvar_19);
  tmpvar_2.w = (tmpvar_2.w * _glesMultiTexCoord0.w);
  highp vec4 o_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
  o_20.xy = (tmpvar_22 + tmpvar_21.w);
  o_20.zw = tmpvar_15.zw;
  tmpvar_3.xyw = o_20.xyw;
  highp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = _glesVertex.xyz;
  tmpvar_3.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_23)).z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_2;
  gl_Position = tmpvar_15;
  xlv_TEXCOORD1 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_GlowTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
vec2 u_xlat7;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = dot(in_TANGENT0.xz, in_TANGENT0.xz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xy = u_xlat3.xx * in_TANGENT0.xz;
    u_xlat3.xy = u_xlat0.xx * _TurbulenceVelocity.xz + u_xlat3.xy;
    u_xlat9 = max(abs(in_TANGENT0.w), 0.5);
    u_xlat9 = _Turbulence / u_xlat9;
    u_xlat0.x = u_xlat9 * u_xlat0.x;
    u_xlat0.xz = u_xlat0.xx * u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier;
    u_xlat9 = u_xlat9 * 0.0500000007 + 1.0;
    u_xlat1.x = dot(in_NORMAL0.xz, in_NORMAL0.xz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xy = u_xlat1.xx * in_NORMAL0.xz;
    u_xlat7.x = in_TEXCOORD0.x + -0.5;
    u_xlat7.x = u_xlat7.x + u_xlat7.x;
    u_xlat1.xy = u_xlat7.xx * u_xlat1.xy;
    u_xlat7.x = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat7.x = u_xlat7.x * in_TEXCOORD0.z;
    u_xlat1.xy = u_xlat7.xx * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.5, 1.5) + in_POSITION0.xz;
    u_xlat2.xy = in_NORMAL0.zx * vec2(-1.0, 1.0);
    u_xlat10 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xy = vec2(u_xlat10) * u_xlat2.xy;
    u_xlat7.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.x = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat7.xy = u_xlat7.xy * u_xlat2.xx;
    u_xlat1.xz = u_xlat7.xy * vec2(u_xlat9) + u_xlat1.xy;
    u_xlat1.y = in_POSITION0.y;
    u_xlat0.y = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
vec2 u_xlat7;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = dot(in_TANGENT0.xz, in_TANGENT0.xz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xy = u_xlat3.xx * in_TANGENT0.xz;
    u_xlat3.xy = u_xlat0.xx * _TurbulenceVelocity.xz + u_xlat3.xy;
    u_xlat9 = max(abs(in_TANGENT0.w), 0.5);
    u_xlat9 = _Turbulence / u_xlat9;
    u_xlat0.x = u_xlat9 * u_xlat0.x;
    u_xlat0.xz = u_xlat0.xx * u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier;
    u_xlat9 = u_xlat9 * 0.0500000007 + 1.0;
    u_xlat1.x = dot(in_NORMAL0.xz, in_NORMAL0.xz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xy = u_xlat1.xx * in_NORMAL0.xz;
    u_xlat7.x = in_TEXCOORD0.x + -0.5;
    u_xlat7.x = u_xlat7.x + u_xlat7.x;
    u_xlat1.xy = u_xlat7.xx * u_xlat1.xy;
    u_xlat7.x = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat7.x = u_xlat7.x * in_TEXCOORD0.z;
    u_xlat1.xy = u_xlat7.xx * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.5, 1.5) + in_POSITION0.xz;
    u_xlat2.xy = in_NORMAL0.zx * vec2(-1.0, 1.0);
    u_xlat10 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xy = vec2(u_xlat10) * u_xlat2.xy;
    u_xlat7.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.x = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat7.xy = u_xlat7.xy * u_xlat2.xx;
    u_xlat1.xz = u_xlat7.xy * vec2(u_xlat9) + u_xlat1.xy;
    u_xlat1.y = in_POSITION0.y;
    u_xlat0.y = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
vec2 u_xlat7;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = dot(in_TANGENT0.xz, in_TANGENT0.xz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xy = u_xlat3.xx * in_TANGENT0.xz;
    u_xlat3.xy = u_xlat0.xx * _TurbulenceVelocity.xz + u_xlat3.xy;
    u_xlat9 = max(abs(in_TANGENT0.w), 0.5);
    u_xlat9 = _Turbulence / u_xlat9;
    u_xlat0.x = u_xlat9 * u_xlat0.x;
    u_xlat0.xz = u_xlat0.xx * u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier;
    u_xlat9 = u_xlat9 * 0.0500000007 + 1.0;
    u_xlat1.x = dot(in_NORMAL0.xz, in_NORMAL0.xz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xy = u_xlat1.xx * in_NORMAL0.xz;
    u_xlat7.x = in_TEXCOORD0.x + -0.5;
    u_xlat7.x = u_xlat7.x + u_xlat7.x;
    u_xlat1.xy = u_xlat7.xx * u_xlat1.xy;
    u_xlat7.x = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat7.x = u_xlat7.x * in_TEXCOORD0.z;
    u_xlat1.xy = u_xlat7.xx * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.5, 1.5) + in_POSITION0.xz;
    u_xlat2.xy = in_NORMAL0.zx * vec2(-1.0, 1.0);
    u_xlat10 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xy = vec2(u_xlat10) * u_xlat2.xy;
    u_xlat7.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.x = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat7.xy = u_xlat7.xy * u_xlat2.xx;
    u_xlat1.xz = u_xlat7.xy * vec2(u_xlat9) + u_xlat1.xy;
    u_xlat1.y = in_POSITION0.y;
    u_xlat0.y = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec2 tangent_1;
  lowp vec4 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = abs(_glesTANGENT.w);
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_4 = (tmpvar_5 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_6;
  tmpvar_6 = (_glesMultiTexCoord0.z * (tmpvar_3 + tmpvar_3));
  highp vec2 tmpvar_7;
  tmpvar_7 = (((_TurbulenceVelocity * vec4(tmpvar_4)).xz + normalize(_glesTANGENT.xz)) * ((_Turbulence / 
    max (0.5, tmpvar_3)
  ) * tmpvar_4));
  highp vec4 tmpvar_8;
  tmpvar_8.yw = vec2(0.0, 0.0);
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.z = tmpvar_7.y;
  highp vec2 tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_9 = (((
    normalize(_glesNormal.xz)
   * 
    (tmpvar_10 + tmpvar_10)
  ) * tmpvar_6) * 1.5);
  highp vec4 tmpvar_11;
  tmpvar_11.yw = vec2(0.0, 0.0);
  tmpvar_11.x = tmpvar_9.x;
  tmpvar_11.z = tmpvar_9.y;
  highp vec2 tmpvar_12;
  tmpvar_12.x = -(_glesNormal.z);
  tmpvar_12.y = _glesNormal.x;
  tangent_1 = (((
    normalize(tmpvar_12)
   * tmpvar_6) * (_glesTANGENT.w / tmpvar_3)) * (1.0 + (
    (fract((sin(
      dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))
    ) * 43758.55)) * _JitterMultiplier)
   * 0.05)));
  highp vec4 tmpvar_13;
  tmpvar_13.yw = vec2(0.0, 0.0);
  tmpvar_13.x = tangent_1.x;
  tmpvar_13.z = tangent_1.y;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((_glesVertex + tmpvar_11) + (tmpvar_13 + tmpvar_8)).xyz;
  highp float tmpvar_15;
  bool tmpvar_16;
  tmpvar_16 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_15 = ((float(tmpvar_16) * clamp (
    (tmpvar_5 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_16)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesColor.xyz;
  tmpvar_2 = ((tmpvar_15 * _GlowTintColor) * tmpvar_17);
  tmpvar_2.w = (tmpvar_2.w * _glesMultiTexCoord0.w);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_GlowTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec2 tangent_1;
  lowp vec4 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = abs(_glesTANGENT.w);
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_4 = (tmpvar_5 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_6;
  tmpvar_6 = (_glesMultiTexCoord0.z * (tmpvar_3 + tmpvar_3));
  highp vec2 tmpvar_7;
  tmpvar_7 = (((_TurbulenceVelocity * vec4(tmpvar_4)).xz + normalize(_glesTANGENT.xz)) * ((_Turbulence / 
    max (0.5, tmpvar_3)
  ) * tmpvar_4));
  highp vec4 tmpvar_8;
  tmpvar_8.yw = vec2(0.0, 0.0);
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.z = tmpvar_7.y;
  highp vec2 tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_9 = (((
    normalize(_glesNormal.xz)
   * 
    (tmpvar_10 + tmpvar_10)
  ) * tmpvar_6) * 1.5);
  highp vec4 tmpvar_11;
  tmpvar_11.yw = vec2(0.0, 0.0);
  tmpvar_11.x = tmpvar_9.x;
  tmpvar_11.z = tmpvar_9.y;
  highp vec2 tmpvar_12;
  tmpvar_12.x = -(_glesNormal.z);
  tmpvar_12.y = _glesNormal.x;
  tangent_1 = (((
    normalize(tmpvar_12)
   * tmpvar_6) * (_glesTANGENT.w / tmpvar_3)) * (1.0 + (
    (fract((sin(
      dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))
    ) * 43758.55)) * _JitterMultiplier)
   * 0.05)));
  highp vec4 tmpvar_13;
  tmpvar_13.yw = vec2(0.0, 0.0);
  tmpvar_13.x = tangent_1.x;
  tmpvar_13.z = tangent_1.y;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((_glesVertex + tmpvar_11) + (tmpvar_13 + tmpvar_8)).xyz;
  highp float tmpvar_15;
  bool tmpvar_16;
  tmpvar_16 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_15 = ((float(tmpvar_16) * clamp (
    (tmpvar_5 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_16)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesColor.xyz;
  tmpvar_2 = ((tmpvar_15 * _GlowTintColor) * tmpvar_17);
  tmpvar_2.w = (tmpvar_2.w * _glesMultiTexCoord0.w);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_GlowTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec2 tangent_1;
  lowp vec4 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = abs(_glesTANGENT.w);
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_4 = (tmpvar_5 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_6;
  tmpvar_6 = (_glesMultiTexCoord0.z * (tmpvar_3 + tmpvar_3));
  highp vec2 tmpvar_7;
  tmpvar_7 = (((_TurbulenceVelocity * vec4(tmpvar_4)).xz + normalize(_glesTANGENT.xz)) * ((_Turbulence / 
    max (0.5, tmpvar_3)
  ) * tmpvar_4));
  highp vec4 tmpvar_8;
  tmpvar_8.yw = vec2(0.0, 0.0);
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.z = tmpvar_7.y;
  highp vec2 tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_9 = (((
    normalize(_glesNormal.xz)
   * 
    (tmpvar_10 + tmpvar_10)
  ) * tmpvar_6) * 1.5);
  highp vec4 tmpvar_11;
  tmpvar_11.yw = vec2(0.0, 0.0);
  tmpvar_11.x = tmpvar_9.x;
  tmpvar_11.z = tmpvar_9.y;
  highp vec2 tmpvar_12;
  tmpvar_12.x = -(_glesNormal.z);
  tmpvar_12.y = _glesNormal.x;
  tangent_1 = (((
    normalize(tmpvar_12)
   * tmpvar_6) * (_glesTANGENT.w / tmpvar_3)) * (1.0 + (
    (fract((sin(
      dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))
    ) * 43758.55)) * _JitterMultiplier)
   * 0.05)));
  highp vec4 tmpvar_13;
  tmpvar_13.yw = vec2(0.0, 0.0);
  tmpvar_13.x = tangent_1.x;
  tmpvar_13.z = tangent_1.y;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((_glesVertex + tmpvar_11) + (tmpvar_13 + tmpvar_8)).xyz;
  highp float tmpvar_15;
  bool tmpvar_16;
  tmpvar_16 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_15 = ((float(tmpvar_16) * clamp (
    (tmpvar_5 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_16)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesColor.xyz;
  tmpvar_2 = ((tmpvar_15 * _GlowTintColor) * tmpvar_17);
  tmpvar_2.w = (tmpvar_2.w * _glesMultiTexCoord0.w);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_GlowTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
vec2 u_xlat7;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = dot(in_TANGENT0.xz, in_TANGENT0.xz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xy = u_xlat3.xx * in_TANGENT0.xz;
    u_xlat3.xy = u_xlat0.xx * _TurbulenceVelocity.xz + u_xlat3.xy;
    u_xlat9 = max(abs(in_TANGENT0.w), 0.5);
    u_xlat9 = _Turbulence / u_xlat9;
    u_xlat0.x = u_xlat9 * u_xlat0.x;
    u_xlat0.xz = u_xlat0.xx * u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier;
    u_xlat9 = u_xlat9 * 0.0500000007 + 1.0;
    u_xlat1.x = dot(in_NORMAL0.xz, in_NORMAL0.xz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xy = u_xlat1.xx * in_NORMAL0.xz;
    u_xlat7.x = in_TEXCOORD0.x + -0.5;
    u_xlat7.x = u_xlat7.x + u_xlat7.x;
    u_xlat1.xy = u_xlat7.xx * u_xlat1.xy;
    u_xlat7.x = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat7.x = u_xlat7.x * in_TEXCOORD0.z;
    u_xlat1.xy = u_xlat7.xx * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.5, 1.5) + in_POSITION0.xz;
    u_xlat2.xy = in_NORMAL0.zx * vec2(-1.0, 1.0);
    u_xlat10 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xy = vec2(u_xlat10) * u_xlat2.xy;
    u_xlat7.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.x = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat7.xy = u_xlat7.xy * u_xlat2.xx;
    u_xlat1.xz = u_xlat7.xy * vec2(u_xlat9) + u_xlat1.xy;
    u_xlat1.y = in_POSITION0.y;
    u_xlat0.y = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
vec2 u_xlat7;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = dot(in_TANGENT0.xz, in_TANGENT0.xz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xy = u_xlat3.xx * in_TANGENT0.xz;
    u_xlat3.xy = u_xlat0.xx * _TurbulenceVelocity.xz + u_xlat3.xy;
    u_xlat9 = max(abs(in_TANGENT0.w), 0.5);
    u_xlat9 = _Turbulence / u_xlat9;
    u_xlat0.x = u_xlat9 * u_xlat0.x;
    u_xlat0.xz = u_xlat0.xx * u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier;
    u_xlat9 = u_xlat9 * 0.0500000007 + 1.0;
    u_xlat1.x = dot(in_NORMAL0.xz, in_NORMAL0.xz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xy = u_xlat1.xx * in_NORMAL0.xz;
    u_xlat7.x = in_TEXCOORD0.x + -0.5;
    u_xlat7.x = u_xlat7.x + u_xlat7.x;
    u_xlat1.xy = u_xlat7.xx * u_xlat1.xy;
    u_xlat7.x = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat7.x = u_xlat7.x * in_TEXCOORD0.z;
    u_xlat1.xy = u_xlat7.xx * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.5, 1.5) + in_POSITION0.xz;
    u_xlat2.xy = in_NORMAL0.zx * vec2(-1.0, 1.0);
    u_xlat10 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xy = vec2(u_xlat10) * u_xlat2.xy;
    u_xlat7.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.x = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat7.xy = u_xlat7.xy * u_xlat2.xx;
    u_xlat1.xz = u_xlat7.xy * vec2(u_xlat9) + u_xlat1.xy;
    u_xlat1.y = in_POSITION0.y;
    u_xlat0.y = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
vec2 u_xlat7;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = dot(in_TANGENT0.xz, in_TANGENT0.xz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xy = u_xlat3.xx * in_TANGENT0.xz;
    u_xlat3.xy = u_xlat0.xx * _TurbulenceVelocity.xz + u_xlat3.xy;
    u_xlat9 = max(abs(in_TANGENT0.w), 0.5);
    u_xlat9 = _Turbulence / u_xlat9;
    u_xlat0.x = u_xlat9 * u_xlat0.x;
    u_xlat0.xz = u_xlat0.xx * u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier;
    u_xlat9 = u_xlat9 * 0.0500000007 + 1.0;
    u_xlat1.x = dot(in_NORMAL0.xz, in_NORMAL0.xz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xy = u_xlat1.xx * in_NORMAL0.xz;
    u_xlat7.x = in_TEXCOORD0.x + -0.5;
    u_xlat7.x = u_xlat7.x + u_xlat7.x;
    u_xlat1.xy = u_xlat7.xx * u_xlat1.xy;
    u_xlat7.x = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat7.x = u_xlat7.x * in_TEXCOORD0.z;
    u_xlat1.xy = u_xlat7.xx * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.5, 1.5) + in_POSITION0.xz;
    u_xlat2.xy = in_NORMAL0.zx * vec2(-1.0, 1.0);
    u_xlat10 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xy = vec2(u_xlat10) * u_xlat2.xy;
    u_xlat7.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.x = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat7.xy = u_xlat7.xy * u_xlat2.xx;
    u_xlat1.xz = u_xlat7.xy * vec2(u_xlat9) + u_xlat1.xy;
    u_xlat1.y = in_POSITION0.y;
    u_xlat0.y = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tangent_1;
  lowp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = abs(_glesTANGENT.w);
  highp float tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_5 = (tmpvar_6 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_7;
  tmpvar_7 = (_glesMultiTexCoord0.z * (tmpvar_4 + tmpvar_4));
  highp vec2 tmpvar_8;
  tmpvar_8 = (((_TurbulenceVelocity * vec4(tmpvar_5)).xz + normalize(_glesTANGENT.xz)) * ((_Turbulence / 
    max (0.5, tmpvar_4)
  ) * tmpvar_5));
  highp vec4 tmpvar_9;
  tmpvar_9.yw = vec2(0.0, 0.0);
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.z = tmpvar_8.y;
  highp vec2 tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_10 = (((
    normalize(_glesNormal.xz)
   * 
    (tmpvar_11 + tmpvar_11)
  ) * tmpvar_7) * 1.5);
  highp vec4 tmpvar_12;
  tmpvar_12.yw = vec2(0.0, 0.0);
  tmpvar_12.x = tmpvar_10.x;
  tmpvar_12.z = tmpvar_10.y;
  highp vec2 tmpvar_13;
  tmpvar_13.x = -(_glesNormal.z);
  tmpvar_13.y = _glesNormal.x;
  tangent_1 = (((
    normalize(tmpvar_13)
   * tmpvar_7) * (_glesTANGENT.w / tmpvar_4)) * (1.0 + (
    (fract((sin(
      dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))
    ) * 43758.55)) * _JitterMultiplier)
   * 0.05)));
  highp vec4 tmpvar_14;
  tmpvar_14.yw = vec2(0.0, 0.0);
  tmpvar_14.x = tangent_1.x;
  tmpvar_14.z = tangent_1.y;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = ((_glesVertex + tmpvar_12) + (tmpvar_14 + tmpvar_9)).xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  highp float tmpvar_17;
  bool tmpvar_18;
  tmpvar_18 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_17 = ((float(tmpvar_18) * clamp (
    (tmpvar_6 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_18)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = _glesColor.xyz;
  tmpvar_2 = ((tmpvar_17 * _GlowTintColor) * tmpvar_19);
  tmpvar_2.w = (tmpvar_2.w * _glesMultiTexCoord0.w);
  highp vec4 o_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
  o_20.xy = (tmpvar_22 + tmpvar_21.w);
  o_20.zw = tmpvar_15.zw;
  tmpvar_3.xyw = o_20.xyw;
  highp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = _glesVertex.xyz;
  tmpvar_3.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_23)).z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_2;
  gl_Position = tmpvar_15;
  xlv_TEXCOORD1 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_GlowTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tangent_1;
  lowp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = abs(_glesTANGENT.w);
  highp float tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_5 = (tmpvar_6 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_7;
  tmpvar_7 = (_glesMultiTexCoord0.z * (tmpvar_4 + tmpvar_4));
  highp vec2 tmpvar_8;
  tmpvar_8 = (((_TurbulenceVelocity * vec4(tmpvar_5)).xz + normalize(_glesTANGENT.xz)) * ((_Turbulence / 
    max (0.5, tmpvar_4)
  ) * tmpvar_5));
  highp vec4 tmpvar_9;
  tmpvar_9.yw = vec2(0.0, 0.0);
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.z = tmpvar_8.y;
  highp vec2 tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_10 = (((
    normalize(_glesNormal.xz)
   * 
    (tmpvar_11 + tmpvar_11)
  ) * tmpvar_7) * 1.5);
  highp vec4 tmpvar_12;
  tmpvar_12.yw = vec2(0.0, 0.0);
  tmpvar_12.x = tmpvar_10.x;
  tmpvar_12.z = tmpvar_10.y;
  highp vec2 tmpvar_13;
  tmpvar_13.x = -(_glesNormal.z);
  tmpvar_13.y = _glesNormal.x;
  tangent_1 = (((
    normalize(tmpvar_13)
   * tmpvar_7) * (_glesTANGENT.w / tmpvar_4)) * (1.0 + (
    (fract((sin(
      dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))
    ) * 43758.55)) * _JitterMultiplier)
   * 0.05)));
  highp vec4 tmpvar_14;
  tmpvar_14.yw = vec2(0.0, 0.0);
  tmpvar_14.x = tangent_1.x;
  tmpvar_14.z = tangent_1.y;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = ((_glesVertex + tmpvar_12) + (tmpvar_14 + tmpvar_9)).xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  highp float tmpvar_17;
  bool tmpvar_18;
  tmpvar_18 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_17 = ((float(tmpvar_18) * clamp (
    (tmpvar_6 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_18)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = _glesColor.xyz;
  tmpvar_2 = ((tmpvar_17 * _GlowTintColor) * tmpvar_19);
  tmpvar_2.w = (tmpvar_2.w * _glesMultiTexCoord0.w);
  highp vec4 o_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
  o_20.xy = (tmpvar_22 + tmpvar_21.w);
  o_20.zw = tmpvar_15.zw;
  tmpvar_3.xyw = o_20.xyw;
  highp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = _glesVertex.xyz;
  tmpvar_3.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_23)).z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_2;
  gl_Position = tmpvar_15;
  xlv_TEXCOORD1 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_GlowTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tangent_1;
  lowp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = abs(_glesTANGENT.w);
  highp float tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_5 = (tmpvar_6 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_7;
  tmpvar_7 = (_glesMultiTexCoord0.z * (tmpvar_4 + tmpvar_4));
  highp vec2 tmpvar_8;
  tmpvar_8 = (((_TurbulenceVelocity * vec4(tmpvar_5)).xz + normalize(_glesTANGENT.xz)) * ((_Turbulence / 
    max (0.5, tmpvar_4)
  ) * tmpvar_5));
  highp vec4 tmpvar_9;
  tmpvar_9.yw = vec2(0.0, 0.0);
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.z = tmpvar_8.y;
  highp vec2 tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_10 = (((
    normalize(_glesNormal.xz)
   * 
    (tmpvar_11 + tmpvar_11)
  ) * tmpvar_7) * 1.5);
  highp vec4 tmpvar_12;
  tmpvar_12.yw = vec2(0.0, 0.0);
  tmpvar_12.x = tmpvar_10.x;
  tmpvar_12.z = tmpvar_10.y;
  highp vec2 tmpvar_13;
  tmpvar_13.x = -(_glesNormal.z);
  tmpvar_13.y = _glesNormal.x;
  tangent_1 = (((
    normalize(tmpvar_13)
   * tmpvar_7) * (_glesTANGENT.w / tmpvar_4)) * (1.0 + (
    (fract((sin(
      dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))
    ) * 43758.55)) * _JitterMultiplier)
   * 0.05)));
  highp vec4 tmpvar_14;
  tmpvar_14.yw = vec2(0.0, 0.0);
  tmpvar_14.x = tangent_1.x;
  tmpvar_14.z = tangent_1.y;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = ((_glesVertex + tmpvar_12) + (tmpvar_14 + tmpvar_9)).xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  highp float tmpvar_17;
  bool tmpvar_18;
  tmpvar_18 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_17 = ((float(tmpvar_18) * clamp (
    (tmpvar_6 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_18)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = _glesColor.xyz;
  tmpvar_2 = ((tmpvar_17 * _GlowTintColor) * tmpvar_19);
  tmpvar_2.w = (tmpvar_2.w * _glesMultiTexCoord0.w);
  highp vec4 o_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (tmpvar_15 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_21.x;
  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
  o_20.xy = (tmpvar_22 + tmpvar_21.w);
  o_20.zw = tmpvar_15.zw;
  tmpvar_3.xyw = o_20.xyw;
  highp vec4 tmpvar_23;
  tmpvar_23.w = 1.0;
  tmpvar_23.xyz = _glesVertex.xyz;
  tmpvar_3.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_23)).z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_2;
  gl_Position = tmpvar_15;
  xlv_TEXCOORD1 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_GlowTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
vec2 u_xlat7;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = dot(in_TANGENT0.xz, in_TANGENT0.xz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xy = u_xlat3.xx * in_TANGENT0.xz;
    u_xlat3.xy = u_xlat0.xx * _TurbulenceVelocity.xz + u_xlat3.xy;
    u_xlat9 = max(abs(in_TANGENT0.w), 0.5);
    u_xlat9 = _Turbulence / u_xlat9;
    u_xlat0.x = u_xlat9 * u_xlat0.x;
    u_xlat0.xz = u_xlat0.xx * u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier;
    u_xlat9 = u_xlat9 * 0.0500000007 + 1.0;
    u_xlat1.x = dot(in_NORMAL0.xz, in_NORMAL0.xz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xy = u_xlat1.xx * in_NORMAL0.xz;
    u_xlat7.x = in_TEXCOORD0.x + -0.5;
    u_xlat7.x = u_xlat7.x + u_xlat7.x;
    u_xlat1.xy = u_xlat7.xx * u_xlat1.xy;
    u_xlat7.x = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat7.x = u_xlat7.x * in_TEXCOORD0.z;
    u_xlat1.xy = u_xlat7.xx * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.5, 1.5) + in_POSITION0.xz;
    u_xlat2.xy = in_NORMAL0.zx * vec2(-1.0, 1.0);
    u_xlat10 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xy = vec2(u_xlat10) * u_xlat2.xy;
    u_xlat7.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.x = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat7.xy = u_xlat7.xy * u_xlat2.xx;
    u_xlat1.xz = u_xlat7.xy * vec2(u_xlat9) + u_xlat1.xy;
    u_xlat1.y = in_POSITION0.y;
    u_xlat0.y = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
vec2 u_xlat7;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = dot(in_TANGENT0.xz, in_TANGENT0.xz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xy = u_xlat3.xx * in_TANGENT0.xz;
    u_xlat3.xy = u_xlat0.xx * _TurbulenceVelocity.xz + u_xlat3.xy;
    u_xlat9 = max(abs(in_TANGENT0.w), 0.5);
    u_xlat9 = _Turbulence / u_xlat9;
    u_xlat0.x = u_xlat9 * u_xlat0.x;
    u_xlat0.xz = u_xlat0.xx * u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier;
    u_xlat9 = u_xlat9 * 0.0500000007 + 1.0;
    u_xlat1.x = dot(in_NORMAL0.xz, in_NORMAL0.xz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xy = u_xlat1.xx * in_NORMAL0.xz;
    u_xlat7.x = in_TEXCOORD0.x + -0.5;
    u_xlat7.x = u_xlat7.x + u_xlat7.x;
    u_xlat1.xy = u_xlat7.xx * u_xlat1.xy;
    u_xlat7.x = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat7.x = u_xlat7.x * in_TEXCOORD0.z;
    u_xlat1.xy = u_xlat7.xx * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.5, 1.5) + in_POSITION0.xz;
    u_xlat2.xy = in_NORMAL0.zx * vec2(-1.0, 1.0);
    u_xlat10 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xy = vec2(u_xlat10) * u_xlat2.xy;
    u_xlat7.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.x = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat7.xy = u_xlat7.xy * u_xlat2.xx;
    u_xlat1.xz = u_xlat7.xy * vec2(u_xlat9) + u_xlat1.xy;
    u_xlat1.y = in_POSITION0.y;
    u_xlat0.y = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
vec2 u_xlat7;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = dot(in_TANGENT0.xz, in_TANGENT0.xz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xy = u_xlat3.xx * in_TANGENT0.xz;
    u_xlat3.xy = u_xlat0.xx * _TurbulenceVelocity.xz + u_xlat3.xy;
    u_xlat9 = max(abs(in_TANGENT0.w), 0.5);
    u_xlat9 = _Turbulence / u_xlat9;
    u_xlat0.x = u_xlat9 * u_xlat0.x;
    u_xlat0.xz = u_xlat0.xx * u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier;
    u_xlat9 = u_xlat9 * 0.0500000007 + 1.0;
    u_xlat1.x = dot(in_NORMAL0.xz, in_NORMAL0.xz);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat1.xy = u_xlat1.xx * in_NORMAL0.xz;
    u_xlat7.x = in_TEXCOORD0.x + -0.5;
    u_xlat7.x = u_xlat7.x + u_xlat7.x;
    u_xlat1.xy = u_xlat7.xx * u_xlat1.xy;
    u_xlat7.x = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat7.x = u_xlat7.x * in_TEXCOORD0.z;
    u_xlat1.xy = u_xlat7.xx * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.5, 1.5) + in_POSITION0.xz;
    u_xlat2.xy = in_NORMAL0.zx * vec2(-1.0, 1.0);
    u_xlat10 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat2.xy = vec2(u_xlat10) * u_xlat2.xy;
    u_xlat7.xy = u_xlat7.xx * u_xlat2.xy;
    u_xlat2.x = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat7.xy = u_xlat7.xy * u_xlat2.xx;
    u_xlat1.xz = u_xlat7.xy * vec2(u_xlat9) + u_xlat1.xy;
    u_xlat1.y = in_POSITION0.y;
    u_xlat0.y = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ORTHOGRAPHIC_XY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float tmpvar_2;
  tmpvar_2 = abs(_glesTANGENT.w);
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.z * (tmpvar_2 + tmpvar_2));
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(0.0, 0.0);
  tmpvar_6.xy = (_TurbulenceVelocity * vec4(tmpvar_3)).xy;
  highp vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = normalize(_glesTANGENT).xy;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(0.0, 0.0);
  highp float tmpvar_9;
  tmpvar_9 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_8.xy = (((
    normalize(_glesNormal.xy)
   * 
    (tmpvar_9 + tmpvar_9)
  ) * tmpvar_5) * 1.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = -(_glesNormal.y);
  tmpvar_10.y = _glesNormal.x;
  highp vec4 tmpvar_11;
  tmpvar_11.zw = vec2(0.0, 0.0);
  tmpvar_11.xy = (((
    normalize(tmpvar_10)
   * tmpvar_5) * (_glesTANGENT.w / tmpvar_2)) * (1.0 + (
    (fract((sin(
      dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))
    ) * 43758.55)) * _JitterMultiplier)
   * 0.05)));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (((_glesVertex + tmpvar_8) + tmpvar_11) + (tmpvar_6 + (tmpvar_7 * 
    ((_Turbulence / max (0.5, tmpvar_2)) * tmpvar_3)
  ))).xyz;
  highp float tmpvar_13;
  bool tmpvar_14;
  tmpvar_14 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_13 = ((float(tmpvar_14) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_14)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_13 * _GlowTintColor) * tmpvar_15);
  tmpvar_1.w = (tmpvar_1.w * _glesMultiTexCoord0.w);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_GlowTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ORTHOGRAPHIC_XY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float tmpvar_2;
  tmpvar_2 = abs(_glesTANGENT.w);
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.z * (tmpvar_2 + tmpvar_2));
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(0.0, 0.0);
  tmpvar_6.xy = (_TurbulenceVelocity * vec4(tmpvar_3)).xy;
  highp vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = normalize(_glesTANGENT).xy;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(0.0, 0.0);
  highp float tmpvar_9;
  tmpvar_9 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_8.xy = (((
    normalize(_glesNormal.xy)
   * 
    (tmpvar_9 + tmpvar_9)
  ) * tmpvar_5) * 1.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = -(_glesNormal.y);
  tmpvar_10.y = _glesNormal.x;
  highp vec4 tmpvar_11;
  tmpvar_11.zw = vec2(0.0, 0.0);
  tmpvar_11.xy = (((
    normalize(tmpvar_10)
   * tmpvar_5) * (_glesTANGENT.w / tmpvar_2)) * (1.0 + (
    (fract((sin(
      dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))
    ) * 43758.55)) * _JitterMultiplier)
   * 0.05)));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (((_glesVertex + tmpvar_8) + tmpvar_11) + (tmpvar_6 + (tmpvar_7 * 
    ((_Turbulence / max (0.5, tmpvar_2)) * tmpvar_3)
  ))).xyz;
  highp float tmpvar_13;
  bool tmpvar_14;
  tmpvar_14 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_13 = ((float(tmpvar_14) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_14)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_13 * _GlowTintColor) * tmpvar_15);
  tmpvar_1.w = (tmpvar_1.w * _glesMultiTexCoord0.w);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_GlowTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ORTHOGRAPHIC_XY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float tmpvar_2;
  tmpvar_2 = abs(_glesTANGENT.w);
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.z * (tmpvar_2 + tmpvar_2));
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(0.0, 0.0);
  tmpvar_6.xy = (_TurbulenceVelocity * vec4(tmpvar_3)).xy;
  highp vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = normalize(_glesTANGENT).xy;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(0.0, 0.0);
  highp float tmpvar_9;
  tmpvar_9 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_8.xy = (((
    normalize(_glesNormal.xy)
   * 
    (tmpvar_9 + tmpvar_9)
  ) * tmpvar_5) * 1.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = -(_glesNormal.y);
  tmpvar_10.y = _glesNormal.x;
  highp vec4 tmpvar_11;
  tmpvar_11.zw = vec2(0.0, 0.0);
  tmpvar_11.xy = (((
    normalize(tmpvar_10)
   * tmpvar_5) * (_glesTANGENT.w / tmpvar_2)) * (1.0 + (
    (fract((sin(
      dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))
    ) * 43758.55)) * _JitterMultiplier)
   * 0.05)));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (((_glesVertex + tmpvar_8) + tmpvar_11) + (tmpvar_6 + (tmpvar_7 * 
    ((_Turbulence / max (0.5, tmpvar_2)) * tmpvar_3)
  ))).xyz;
  highp float tmpvar_13;
  bool tmpvar_14;
  tmpvar_14 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_13 = ((float(tmpvar_14) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_14)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_13 * _GlowTintColor) * tmpvar_15);
  tmpvar_1.w = (tmpvar_1.w * _glesMultiTexCoord0.w);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_GlowTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ORTHOGRAPHIC_XY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6.x = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6.x = (u_xlatb9) ? 0.0 : u_xlat6.x;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6.x;
    u_xlat1 = u_xlat3.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6.x = dot(in_TANGENT0, in_TANGENT0);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xy = u_xlat6.xx * in_TANGENT0.xy;
    u_xlat3.xy = u_xlat3.xx * u_xlat6.xy;
    u_xlat0.xy = u_xlat0.xx * _TurbulenceVelocity.xy + u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier;
    u_xlat9 = u_xlat9 * 0.0500000007 + 1.0;
    u_xlat1.xy = in_NORMAL0.yx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat7 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat7 = u_xlat7 * in_TEXCOORD0.z;
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat10 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat1.xy;
    u_xlat2.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat9 = dot(in_NORMAL0.xy, in_NORMAL0.xy);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xy = vec2(u_xlat9) * in_NORMAL0.xy;
    u_xlat9 = in_TEXCOORD0.x + -0.5;
    u_xlat9 = u_xlat9 + u_xlat9;
    u_xlat1.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.5, 1.5) + in_POSITION0.xy;
    u_xlat1.z = in_POSITION0.z;
    u_xlat2.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
    u_xlat0.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ORTHOGRAPHIC_XY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6.x = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6.x = (u_xlatb9) ? 0.0 : u_xlat6.x;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6.x;
    u_xlat1 = u_xlat3.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6.x = dot(in_TANGENT0, in_TANGENT0);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xy = u_xlat6.xx * in_TANGENT0.xy;
    u_xlat3.xy = u_xlat3.xx * u_xlat6.xy;
    u_xlat0.xy = u_xlat0.xx * _TurbulenceVelocity.xy + u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier;
    u_xlat9 = u_xlat9 * 0.0500000007 + 1.0;
    u_xlat1.xy = in_NORMAL0.yx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat7 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat7 = u_xlat7 * in_TEXCOORD0.z;
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat10 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat1.xy;
    u_xlat2.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat9 = dot(in_NORMAL0.xy, in_NORMAL0.xy);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xy = vec2(u_xlat9) * in_NORMAL0.xy;
    u_xlat9 = in_TEXCOORD0.x + -0.5;
    u_xlat9 = u_xlat9 + u_xlat9;
    u_xlat1.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.5, 1.5) + in_POSITION0.xy;
    u_xlat1.z = in_POSITION0.z;
    u_xlat2.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
    u_xlat0.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ORTHOGRAPHIC_XY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6.x = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6.x = (u_xlatb9) ? 0.0 : u_xlat6.x;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6.x;
    u_xlat1 = u_xlat3.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6.x = dot(in_TANGENT0, in_TANGENT0);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xy = u_xlat6.xx * in_TANGENT0.xy;
    u_xlat3.xy = u_xlat3.xx * u_xlat6.xy;
    u_xlat0.xy = u_xlat0.xx * _TurbulenceVelocity.xy + u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier;
    u_xlat9 = u_xlat9 * 0.0500000007 + 1.0;
    u_xlat1.xy = in_NORMAL0.yx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat7 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat7 = u_xlat7 * in_TEXCOORD0.z;
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat10 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat1.xy;
    u_xlat2.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat9 = dot(in_NORMAL0.xy, in_NORMAL0.xy);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xy = vec2(u_xlat9) * in_NORMAL0.xy;
    u_xlat9 = in_TEXCOORD0.x + -0.5;
    u_xlat9 = u_xlat9 + u_xlat9;
    u_xlat1.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.5, 1.5) + in_POSITION0.xy;
    u_xlat1.z = in_POSITION0.z;
    u_xlat2.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
    u_xlat0.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = abs(_glesTANGENT.w);
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_4 = (tmpvar_5 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_6;
  tmpvar_6 = (_glesMultiTexCoord0.z * (tmpvar_3 + tmpvar_3));
  highp vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = (_TurbulenceVelocity * vec4(tmpvar_4)).xy;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(0.0, 0.0);
  tmpvar_8.xy = normalize(_glesTANGENT).xy;
  highp vec4 tmpvar_9;
  tmpvar_9.zw = vec2(0.0, 0.0);
  highp float tmpvar_10;
  tmpvar_10 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_9.xy = (((
    normalize(_glesNormal.xy)
   * 
    (tmpvar_10 + tmpvar_10)
  ) * tmpvar_6) * 1.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = -(_glesNormal.y);
  tmpvar_11.y = _glesNormal.x;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(0.0, 0.0);
  tmpvar_12.xy = (((
    normalize(tmpvar_11)
   * tmpvar_6) * (_glesTANGENT.w / tmpvar_3)) * (1.0 + (
    (fract((sin(
      dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))
    ) * 43758.55)) * _JitterMultiplier)
   * 0.05)));
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = (((_glesVertex + tmpvar_9) + tmpvar_12) + (tmpvar_7 + (tmpvar_8 * 
    ((_Turbulence / max (0.5, tmpvar_3)) * tmpvar_4)
  ))).xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  highp float tmpvar_15;
  bool tmpvar_16;
  tmpvar_16 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_15 = ((float(tmpvar_16) * clamp (
    (tmpvar_5 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_16)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_15 * _GlowTintColor) * tmpvar_17);
  tmpvar_1.w = (tmpvar_1.w * _glesMultiTexCoord0.w);
  highp vec4 o_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_13.zw;
  tmpvar_2.xyw = o_18.xyw;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _glesVertex.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_21)).z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_GlowTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = abs(_glesTANGENT.w);
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_4 = (tmpvar_5 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_6;
  tmpvar_6 = (_glesMultiTexCoord0.z * (tmpvar_3 + tmpvar_3));
  highp vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = (_TurbulenceVelocity * vec4(tmpvar_4)).xy;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(0.0, 0.0);
  tmpvar_8.xy = normalize(_glesTANGENT).xy;
  highp vec4 tmpvar_9;
  tmpvar_9.zw = vec2(0.0, 0.0);
  highp float tmpvar_10;
  tmpvar_10 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_9.xy = (((
    normalize(_glesNormal.xy)
   * 
    (tmpvar_10 + tmpvar_10)
  ) * tmpvar_6) * 1.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = -(_glesNormal.y);
  tmpvar_11.y = _glesNormal.x;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(0.0, 0.0);
  tmpvar_12.xy = (((
    normalize(tmpvar_11)
   * tmpvar_6) * (_glesTANGENT.w / tmpvar_3)) * (1.0 + (
    (fract((sin(
      dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))
    ) * 43758.55)) * _JitterMultiplier)
   * 0.05)));
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = (((_glesVertex + tmpvar_9) + tmpvar_12) + (tmpvar_7 + (tmpvar_8 * 
    ((_Turbulence / max (0.5, tmpvar_3)) * tmpvar_4)
  ))).xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  highp float tmpvar_15;
  bool tmpvar_16;
  tmpvar_16 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_15 = ((float(tmpvar_16) * clamp (
    (tmpvar_5 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_16)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_15 * _GlowTintColor) * tmpvar_17);
  tmpvar_1.w = (tmpvar_1.w * _glesMultiTexCoord0.w);
  highp vec4 o_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_13.zw;
  tmpvar_2.xyw = o_18.xyw;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _glesVertex.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_21)).z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_GlowTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = abs(_glesTANGENT.w);
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_4 = (tmpvar_5 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_6;
  tmpvar_6 = (_glesMultiTexCoord0.z * (tmpvar_3 + tmpvar_3));
  highp vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = (_TurbulenceVelocity * vec4(tmpvar_4)).xy;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(0.0, 0.0);
  tmpvar_8.xy = normalize(_glesTANGENT).xy;
  highp vec4 tmpvar_9;
  tmpvar_9.zw = vec2(0.0, 0.0);
  highp float tmpvar_10;
  tmpvar_10 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_9.xy = (((
    normalize(_glesNormal.xy)
   * 
    (tmpvar_10 + tmpvar_10)
  ) * tmpvar_6) * 1.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = -(_glesNormal.y);
  tmpvar_11.y = _glesNormal.x;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(0.0, 0.0);
  tmpvar_12.xy = (((
    normalize(tmpvar_11)
   * tmpvar_6) * (_glesTANGENT.w / tmpvar_3)) * (1.0 + (
    (fract((sin(
      dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))
    ) * 43758.55)) * _JitterMultiplier)
   * 0.05)));
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = (((_glesVertex + tmpvar_9) + tmpvar_12) + (tmpvar_7 + (tmpvar_8 * 
    ((_Turbulence / max (0.5, tmpvar_3)) * tmpvar_4)
  ))).xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  highp float tmpvar_15;
  bool tmpvar_16;
  tmpvar_16 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_15 = ((float(tmpvar_16) * clamp (
    (tmpvar_5 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_16)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_15 * _GlowTintColor) * tmpvar_17);
  tmpvar_1.w = (tmpvar_1.w * _glesMultiTexCoord0.w);
  highp vec4 o_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_13.zw;
  tmpvar_2.xyw = o_18.xyw;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _glesVertex.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_21)).z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_GlowTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6.x = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6.x = (u_xlatb9) ? 0.0 : u_xlat6.x;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6.x;
    u_xlat1 = u_xlat3.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6.x = dot(in_TANGENT0, in_TANGENT0);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xy = u_xlat6.xx * in_TANGENT0.xy;
    u_xlat3.xy = u_xlat3.xx * u_xlat6.xy;
    u_xlat0.xy = u_xlat0.xx * _TurbulenceVelocity.xy + u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier;
    u_xlat9 = u_xlat9 * 0.0500000007 + 1.0;
    u_xlat1.xy = in_NORMAL0.yx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat7 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat7 = u_xlat7 * in_TEXCOORD0.z;
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat10 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat1.xy;
    u_xlat2.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat9 = dot(in_NORMAL0.xy, in_NORMAL0.xy);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xy = vec2(u_xlat9) * in_NORMAL0.xy;
    u_xlat9 = in_TEXCOORD0.x + -0.5;
    u_xlat9 = u_xlat9 + u_xlat9;
    u_xlat1.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.5, 1.5) + in_POSITION0.xy;
    u_xlat1.z = in_POSITION0.z;
    u_xlat2.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
    u_xlat0.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6.x = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6.x = (u_xlatb9) ? 0.0 : u_xlat6.x;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6.x;
    u_xlat1 = u_xlat3.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6.x = dot(in_TANGENT0, in_TANGENT0);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xy = u_xlat6.xx * in_TANGENT0.xy;
    u_xlat3.xy = u_xlat3.xx * u_xlat6.xy;
    u_xlat0.xy = u_xlat0.xx * _TurbulenceVelocity.xy + u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier;
    u_xlat9 = u_xlat9 * 0.0500000007 + 1.0;
    u_xlat1.xy = in_NORMAL0.yx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat7 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat7 = u_xlat7 * in_TEXCOORD0.z;
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat10 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat1.xy;
    u_xlat2.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat9 = dot(in_NORMAL0.xy, in_NORMAL0.xy);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xy = vec2(u_xlat9) * in_NORMAL0.xy;
    u_xlat9 = in_TEXCOORD0.x + -0.5;
    u_xlat9 = u_xlat9 + u_xlat9;
    u_xlat1.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.5, 1.5) + in_POSITION0.xy;
    u_xlat1.z = in_POSITION0.z;
    u_xlat2.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
    u_xlat0.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6.x = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6.x = (u_xlatb9) ? 0.0 : u_xlat6.x;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6.x;
    u_xlat1 = u_xlat3.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6.x = dot(in_TANGENT0, in_TANGENT0);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xy = u_xlat6.xx * in_TANGENT0.xy;
    u_xlat3.xy = u_xlat3.xx * u_xlat6.xy;
    u_xlat0.xy = u_xlat0.xx * _TurbulenceVelocity.xy + u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier;
    u_xlat9 = u_xlat9 * 0.0500000007 + 1.0;
    u_xlat1.xy = in_NORMAL0.yx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat7 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat7 = u_xlat7 * in_TEXCOORD0.z;
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat10 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat1.xy;
    u_xlat2.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat9 = dot(in_NORMAL0.xy, in_NORMAL0.xy);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xy = vec2(u_xlat9) * in_NORMAL0.xy;
    u_xlat9 = in_TEXCOORD0.x + -0.5;
    u_xlat9 = u_xlat9 + u_xlat9;
    u_xlat1.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.5, 1.5) + in_POSITION0.xy;
    u_xlat1.z = in_POSITION0.z;
    u_xlat2.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
    u_xlat0.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float tmpvar_2;
  tmpvar_2 = abs(_glesTANGENT.w);
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.z * (tmpvar_2 + tmpvar_2));
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(0.0, 0.0);
  tmpvar_6.xy = (_TurbulenceVelocity * vec4(tmpvar_3)).xy;
  highp vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = normalize(_glesTANGENT).xy;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(0.0, 0.0);
  highp float tmpvar_9;
  tmpvar_9 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_8.xy = (((
    normalize(_glesNormal.xy)
   * 
    (tmpvar_9 + tmpvar_9)
  ) * tmpvar_5) * 1.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = -(_glesNormal.y);
  tmpvar_10.y = _glesNormal.x;
  highp vec4 tmpvar_11;
  tmpvar_11.zw = vec2(0.0, 0.0);
  tmpvar_11.xy = (((
    normalize(tmpvar_10)
   * tmpvar_5) * (_glesTANGENT.w / tmpvar_2)) * (1.0 + (
    (fract((sin(
      dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))
    ) * 43758.55)) * _JitterMultiplier)
   * 0.05)));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (((_glesVertex + tmpvar_8) + tmpvar_11) + (tmpvar_6 + (tmpvar_7 * 
    ((_Turbulence / max (0.5, tmpvar_2)) * tmpvar_3)
  ))).xyz;
  highp float tmpvar_13;
  bool tmpvar_14;
  tmpvar_14 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_13 = ((float(tmpvar_14) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_14)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_13 * _GlowTintColor) * tmpvar_15);
  tmpvar_1.w = (tmpvar_1.w * _glesMultiTexCoord0.w);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_GlowTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float tmpvar_2;
  tmpvar_2 = abs(_glesTANGENT.w);
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.z * (tmpvar_2 + tmpvar_2));
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(0.0, 0.0);
  tmpvar_6.xy = (_TurbulenceVelocity * vec4(tmpvar_3)).xy;
  highp vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = normalize(_glesTANGENT).xy;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(0.0, 0.0);
  highp float tmpvar_9;
  tmpvar_9 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_8.xy = (((
    normalize(_glesNormal.xy)
   * 
    (tmpvar_9 + tmpvar_9)
  ) * tmpvar_5) * 1.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = -(_glesNormal.y);
  tmpvar_10.y = _glesNormal.x;
  highp vec4 tmpvar_11;
  tmpvar_11.zw = vec2(0.0, 0.0);
  tmpvar_11.xy = (((
    normalize(tmpvar_10)
   * tmpvar_5) * (_glesTANGENT.w / tmpvar_2)) * (1.0 + (
    (fract((sin(
      dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))
    ) * 43758.55)) * _JitterMultiplier)
   * 0.05)));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (((_glesVertex + tmpvar_8) + tmpvar_11) + (tmpvar_6 + (tmpvar_7 * 
    ((_Turbulence / max (0.5, tmpvar_2)) * tmpvar_3)
  ))).xyz;
  highp float tmpvar_13;
  bool tmpvar_14;
  tmpvar_14 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_13 = ((float(tmpvar_14) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_14)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_13 * _GlowTintColor) * tmpvar_15);
  tmpvar_1.w = (tmpvar_1.w * _glesMultiTexCoord0.w);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_GlowTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float tmpvar_2;
  tmpvar_2 = abs(_glesTANGENT.w);
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.z * (tmpvar_2 + tmpvar_2));
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(0.0, 0.0);
  tmpvar_6.xy = (_TurbulenceVelocity * vec4(tmpvar_3)).xy;
  highp vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = normalize(_glesTANGENT).xy;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(0.0, 0.0);
  highp float tmpvar_9;
  tmpvar_9 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_8.xy = (((
    normalize(_glesNormal.xy)
   * 
    (tmpvar_9 + tmpvar_9)
  ) * tmpvar_5) * 1.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = -(_glesNormal.y);
  tmpvar_10.y = _glesNormal.x;
  highp vec4 tmpvar_11;
  tmpvar_11.zw = vec2(0.0, 0.0);
  tmpvar_11.xy = (((
    normalize(tmpvar_10)
   * tmpvar_5) * (_glesTANGENT.w / tmpvar_2)) * (1.0 + (
    (fract((sin(
      dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))
    ) * 43758.55)) * _JitterMultiplier)
   * 0.05)));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (((_glesVertex + tmpvar_8) + tmpvar_11) + (tmpvar_6 + (tmpvar_7 * 
    ((_Turbulence / max (0.5, tmpvar_2)) * tmpvar_3)
  ))).xyz;
  highp float tmpvar_13;
  bool tmpvar_14;
  tmpvar_14 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_13 = ((float(tmpvar_14) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_14)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_13 * _GlowTintColor) * tmpvar_15);
  tmpvar_1.w = (tmpvar_1.w * _glesMultiTexCoord0.w);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_GlowTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6.x = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6.x = (u_xlatb9) ? 0.0 : u_xlat6.x;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6.x;
    u_xlat1 = u_xlat3.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6.x = dot(in_TANGENT0, in_TANGENT0);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xy = u_xlat6.xx * in_TANGENT0.xy;
    u_xlat3.xy = u_xlat3.xx * u_xlat6.xy;
    u_xlat0.xy = u_xlat0.xx * _TurbulenceVelocity.xy + u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier;
    u_xlat9 = u_xlat9 * 0.0500000007 + 1.0;
    u_xlat1.xy = in_NORMAL0.yx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat7 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat7 = u_xlat7 * in_TEXCOORD0.z;
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat10 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat1.xy;
    u_xlat2.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat9 = dot(in_NORMAL0.xy, in_NORMAL0.xy);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xy = vec2(u_xlat9) * in_NORMAL0.xy;
    u_xlat9 = in_TEXCOORD0.x + -0.5;
    u_xlat9 = u_xlat9 + u_xlat9;
    u_xlat1.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.5, 1.5) + in_POSITION0.xy;
    u_xlat1.z = in_POSITION0.z;
    u_xlat2.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
    u_xlat0.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6.x = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6.x = (u_xlatb9) ? 0.0 : u_xlat6.x;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6.x;
    u_xlat1 = u_xlat3.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6.x = dot(in_TANGENT0, in_TANGENT0);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xy = u_xlat6.xx * in_TANGENT0.xy;
    u_xlat3.xy = u_xlat3.xx * u_xlat6.xy;
    u_xlat0.xy = u_xlat0.xx * _TurbulenceVelocity.xy + u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier;
    u_xlat9 = u_xlat9 * 0.0500000007 + 1.0;
    u_xlat1.xy = in_NORMAL0.yx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat7 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat7 = u_xlat7 * in_TEXCOORD0.z;
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat10 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat1.xy;
    u_xlat2.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat9 = dot(in_NORMAL0.xy, in_NORMAL0.xy);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xy = vec2(u_xlat9) * in_NORMAL0.xy;
    u_xlat9 = in_TEXCOORD0.x + -0.5;
    u_xlat9 = u_xlat9 + u_xlat9;
    u_xlat1.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.5, 1.5) + in_POSITION0.xy;
    u_xlat1.z = in_POSITION0.z;
    u_xlat2.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
    u_xlat0.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6.x = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6.x = (u_xlatb9) ? 0.0 : u_xlat6.x;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6.x;
    u_xlat1 = u_xlat3.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6.x = dot(in_TANGENT0, in_TANGENT0);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xy = u_xlat6.xx * in_TANGENT0.xy;
    u_xlat3.xy = u_xlat3.xx * u_xlat6.xy;
    u_xlat0.xy = u_xlat0.xx * _TurbulenceVelocity.xy + u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier;
    u_xlat9 = u_xlat9 * 0.0500000007 + 1.0;
    u_xlat1.xy = in_NORMAL0.yx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat7 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat7 = u_xlat7 * in_TEXCOORD0.z;
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat10 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat1.xy;
    u_xlat2.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat9 = dot(in_NORMAL0.xy, in_NORMAL0.xy);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xy = vec2(u_xlat9) * in_NORMAL0.xy;
    u_xlat9 = in_TEXCOORD0.x + -0.5;
    u_xlat9 = u_xlat9 + u_xlat9;
    u_xlat1.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.5, 1.5) + in_POSITION0.xy;
    u_xlat1.z = in_POSITION0.z;
    u_xlat2.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
    u_xlat0.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = abs(_glesTANGENT.w);
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_4 = (tmpvar_5 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_6;
  tmpvar_6 = (_glesMultiTexCoord0.z * (tmpvar_3 + tmpvar_3));
  highp vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = (_TurbulenceVelocity * vec4(tmpvar_4)).xy;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(0.0, 0.0);
  tmpvar_8.xy = normalize(_glesTANGENT).xy;
  highp vec4 tmpvar_9;
  tmpvar_9.zw = vec2(0.0, 0.0);
  highp float tmpvar_10;
  tmpvar_10 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_9.xy = (((
    normalize(_glesNormal.xy)
   * 
    (tmpvar_10 + tmpvar_10)
  ) * tmpvar_6) * 1.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = -(_glesNormal.y);
  tmpvar_11.y = _glesNormal.x;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(0.0, 0.0);
  tmpvar_12.xy = (((
    normalize(tmpvar_11)
   * tmpvar_6) * (_glesTANGENT.w / tmpvar_3)) * (1.0 + (
    (fract((sin(
      dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))
    ) * 43758.55)) * _JitterMultiplier)
   * 0.05)));
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = (((_glesVertex + tmpvar_9) + tmpvar_12) + (tmpvar_7 + (tmpvar_8 * 
    ((_Turbulence / max (0.5, tmpvar_3)) * tmpvar_4)
  ))).xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  highp float tmpvar_15;
  bool tmpvar_16;
  tmpvar_16 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_15 = ((float(tmpvar_16) * clamp (
    (tmpvar_5 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_16)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_15 * _GlowTintColor) * tmpvar_17);
  tmpvar_1.w = (tmpvar_1.w * _glesMultiTexCoord0.w);
  highp vec4 o_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_13.zw;
  tmpvar_2.xyw = o_18.xyw;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _glesVertex.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_21)).z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_GlowTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = abs(_glesTANGENT.w);
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_4 = (tmpvar_5 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_6;
  tmpvar_6 = (_glesMultiTexCoord0.z * (tmpvar_3 + tmpvar_3));
  highp vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = (_TurbulenceVelocity * vec4(tmpvar_4)).xy;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(0.0, 0.0);
  tmpvar_8.xy = normalize(_glesTANGENT).xy;
  highp vec4 tmpvar_9;
  tmpvar_9.zw = vec2(0.0, 0.0);
  highp float tmpvar_10;
  tmpvar_10 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_9.xy = (((
    normalize(_glesNormal.xy)
   * 
    (tmpvar_10 + tmpvar_10)
  ) * tmpvar_6) * 1.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = -(_glesNormal.y);
  tmpvar_11.y = _glesNormal.x;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(0.0, 0.0);
  tmpvar_12.xy = (((
    normalize(tmpvar_11)
   * tmpvar_6) * (_glesTANGENT.w / tmpvar_3)) * (1.0 + (
    (fract((sin(
      dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))
    ) * 43758.55)) * _JitterMultiplier)
   * 0.05)));
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = (((_glesVertex + tmpvar_9) + tmpvar_12) + (tmpvar_7 + (tmpvar_8 * 
    ((_Turbulence / max (0.5, tmpvar_3)) * tmpvar_4)
  ))).xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  highp float tmpvar_15;
  bool tmpvar_16;
  tmpvar_16 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_15 = ((float(tmpvar_16) * clamp (
    (tmpvar_5 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_16)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_15 * _GlowTintColor) * tmpvar_17);
  tmpvar_1.w = (tmpvar_1.w * _glesMultiTexCoord0.w);
  highp vec4 o_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_13.zw;
  tmpvar_2.xyw = o_18.xyw;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _glesVertex.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_21)).z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_GlowTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = abs(_glesTANGENT.w);
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_4 = (tmpvar_5 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_6;
  tmpvar_6 = (_glesMultiTexCoord0.z * (tmpvar_3 + tmpvar_3));
  highp vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = (_TurbulenceVelocity * vec4(tmpvar_4)).xy;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(0.0, 0.0);
  tmpvar_8.xy = normalize(_glesTANGENT).xy;
  highp vec4 tmpvar_9;
  tmpvar_9.zw = vec2(0.0, 0.0);
  highp float tmpvar_10;
  tmpvar_10 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_9.xy = (((
    normalize(_glesNormal.xy)
   * 
    (tmpvar_10 + tmpvar_10)
  ) * tmpvar_6) * 1.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = -(_glesNormal.y);
  tmpvar_11.y = _glesNormal.x;
  highp vec4 tmpvar_12;
  tmpvar_12.zw = vec2(0.0, 0.0);
  tmpvar_12.xy = (((
    normalize(tmpvar_11)
   * tmpvar_6) * (_glesTANGENT.w / tmpvar_3)) * (1.0 + (
    (fract((sin(
      dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))
    ) * 43758.55)) * _JitterMultiplier)
   * 0.05)));
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = (((_glesVertex + tmpvar_9) + tmpvar_12) + (tmpvar_7 + (tmpvar_8 * 
    ((_Turbulence / max (0.5, tmpvar_3)) * tmpvar_4)
  ))).xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  highp float tmpvar_15;
  bool tmpvar_16;
  tmpvar_16 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_15 = ((float(tmpvar_16) * clamp (
    (tmpvar_5 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_16)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_15 * _GlowTintColor) * tmpvar_17);
  tmpvar_1.w = (tmpvar_1.w * _glesMultiTexCoord0.w);
  highp vec4 o_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_13.zw;
  tmpvar_2.xyw = o_18.xyw;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _glesVertex.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_21)).z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_GlowTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6.x = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6.x = (u_xlatb9) ? 0.0 : u_xlat6.x;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6.x;
    u_xlat1 = u_xlat3.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6.x = dot(in_TANGENT0, in_TANGENT0);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xy = u_xlat6.xx * in_TANGENT0.xy;
    u_xlat3.xy = u_xlat3.xx * u_xlat6.xy;
    u_xlat0.xy = u_xlat0.xx * _TurbulenceVelocity.xy + u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier;
    u_xlat9 = u_xlat9 * 0.0500000007 + 1.0;
    u_xlat1.xy = in_NORMAL0.yx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat7 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat7 = u_xlat7 * in_TEXCOORD0.z;
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat10 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat1.xy;
    u_xlat2.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat9 = dot(in_NORMAL0.xy, in_NORMAL0.xy);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xy = vec2(u_xlat9) * in_NORMAL0.xy;
    u_xlat9 = in_TEXCOORD0.x + -0.5;
    u_xlat9 = u_xlat9 + u_xlat9;
    u_xlat1.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.5, 1.5) + in_POSITION0.xy;
    u_xlat1.z = in_POSITION0.z;
    u_xlat2.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
    u_xlat0.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6.x = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6.x = (u_xlatb9) ? 0.0 : u_xlat6.x;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6.x;
    u_xlat1 = u_xlat3.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6.x = dot(in_TANGENT0, in_TANGENT0);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xy = u_xlat6.xx * in_TANGENT0.xy;
    u_xlat3.xy = u_xlat3.xx * u_xlat6.xy;
    u_xlat0.xy = u_xlat0.xx * _TurbulenceVelocity.xy + u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier;
    u_xlat9 = u_xlat9 * 0.0500000007 + 1.0;
    u_xlat1.xy = in_NORMAL0.yx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat7 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat7 = u_xlat7 * in_TEXCOORD0.z;
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat10 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat1.xy;
    u_xlat2.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat9 = dot(in_NORMAL0.xy, in_NORMAL0.xy);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xy = vec2(u_xlat9) * in_NORMAL0.xy;
    u_xlat9 = in_TEXCOORD0.x + -0.5;
    u_xlat9 = u_xlat9 + u_xlat9;
    u_xlat1.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.5, 1.5) + in_POSITION0.xy;
    u_xlat1.z = in_POSITION0.z;
    u_xlat2.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
    u_xlat0.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
float u_xlat10;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6.x = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6.x = (u_xlatb9) ? 0.0 : u_xlat6.x;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6.x;
    u_xlat1 = u_xlat3.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6.x = dot(in_TANGENT0, in_TANGENT0);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xy = u_xlat6.xx * in_TANGENT0.xy;
    u_xlat3.xy = u_xlat3.xx * u_xlat6.xy;
    u_xlat0.xy = u_xlat0.xx * _TurbulenceVelocity.xy + u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier;
    u_xlat9 = u_xlat9 * 0.0500000007 + 1.0;
    u_xlat1.xy = in_NORMAL0.yx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat7 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat7 = u_xlat7 * in_TEXCOORD0.z;
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat10 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xy = vec2(u_xlat10) * u_xlat1.xy;
    u_xlat2.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat9 = dot(in_NORMAL0.xy, in_NORMAL0.xy);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xy = vec2(u_xlat9) * in_NORMAL0.xy;
    u_xlat9 = in_TEXCOORD0.x + -0.5;
    u_xlat9 = u_xlat9 + u_xlat9;
    u_xlat1.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * vec2(1.5, 1.5) + in_POSITION0.xy;
    u_xlat1.z = in_POSITION0.z;
    u_xlat2.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + u_xlat2.xyz;
    u_xlat0.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "PERSPECTIVE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float tmpvar_2;
  tmpvar_2 = abs(_glesTANGENT.w);
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.z * (tmpvar_2 + tmpvar_2));
  highp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(_glesNormal);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  highp float tmpvar_9;
  tmpvar_9 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_8.xyz = (((tmpvar_7 * 
    (tmpvar_9 + tmpvar_9)
  ) * tmpvar_5) * 1.5);
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - _glesVertex.xyz));
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = ((tmpvar_7.yzx * tmpvar_10.zxy) - (tmpvar_7.zxy * tmpvar_10.yzx));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (((_glesVertex + tmpvar_8) + (
    ((tmpvar_11 * tmpvar_5) * (_glesTANGENT.w / tmpvar_2))
   * 
    (1.0 + ((fract(
      (sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))) * 43758.55)
    ) * _JitterMultiplier) * 0.05))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_3)) + (tmpvar_6 * 
    ((_Turbulence / max (0.5, tmpvar_2)) * tmpvar_3)
  ))).xyz;
  highp float tmpvar_13;
  bool tmpvar_14;
  tmpvar_14 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_13 = ((float(tmpvar_14) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_14)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_13 * _GlowTintColor) * tmpvar_15);
  tmpvar_1.w = (tmpvar_1.w * _glesMultiTexCoord0.w);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_GlowTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "PERSPECTIVE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float tmpvar_2;
  tmpvar_2 = abs(_glesTANGENT.w);
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.z * (tmpvar_2 + tmpvar_2));
  highp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(_glesNormal);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  highp float tmpvar_9;
  tmpvar_9 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_8.xyz = (((tmpvar_7 * 
    (tmpvar_9 + tmpvar_9)
  ) * tmpvar_5) * 1.5);
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - _glesVertex.xyz));
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = ((tmpvar_7.yzx * tmpvar_10.zxy) - (tmpvar_7.zxy * tmpvar_10.yzx));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (((_glesVertex + tmpvar_8) + (
    ((tmpvar_11 * tmpvar_5) * (_glesTANGENT.w / tmpvar_2))
   * 
    (1.0 + ((fract(
      (sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))) * 43758.55)
    ) * _JitterMultiplier) * 0.05))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_3)) + (tmpvar_6 * 
    ((_Turbulence / max (0.5, tmpvar_2)) * tmpvar_3)
  ))).xyz;
  highp float tmpvar_13;
  bool tmpvar_14;
  tmpvar_14 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_13 = ((float(tmpvar_14) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_14)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_13 * _GlowTintColor) * tmpvar_15);
  tmpvar_1.w = (tmpvar_1.w * _glesMultiTexCoord0.w);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_GlowTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "PERSPECTIVE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float tmpvar_2;
  tmpvar_2 = abs(_glesTANGENT.w);
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.z * (tmpvar_2 + tmpvar_2));
  highp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(_glesNormal);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  highp float tmpvar_9;
  tmpvar_9 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_8.xyz = (((tmpvar_7 * 
    (tmpvar_9 + tmpvar_9)
  ) * tmpvar_5) * 1.5);
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - _glesVertex.xyz));
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = ((tmpvar_7.yzx * tmpvar_10.zxy) - (tmpvar_7.zxy * tmpvar_10.yzx));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (((_glesVertex + tmpvar_8) + (
    ((tmpvar_11 * tmpvar_5) * (_glesTANGENT.w / tmpvar_2))
   * 
    (1.0 + ((fract(
      (sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))) * 43758.55)
    ) * _JitterMultiplier) * 0.05))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_3)) + (tmpvar_6 * 
    ((_Turbulence / max (0.5, tmpvar_2)) * tmpvar_3)
  ))).xyz;
  highp float tmpvar_13;
  bool tmpvar_14;
  tmpvar_14 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_13 = ((float(tmpvar_14) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_14)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_13 * _GlowTintColor) * tmpvar_15);
  tmpvar_1.w = (tmpvar_1.w * _glesMultiTexCoord0.w);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_GlowTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "PERSPECTIVE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
float u_xlat14;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat4.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat4.xy = u_xlat1.xy / u_xlat4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat8 = (-u_xlat4.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb12 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat8 = (u_xlatb12) ? 0.0 : u_xlat8;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat4.x = u_xlat12 * u_xlat4.x + u_xlat8;
    u_xlat1 = u_xlat4.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat4.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat4.x = _Turbulence / u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat0.x;
    u_xlat8 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * in_TANGENT0.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat4.xyz;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat12 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = u_xlat12 * 43758.5469;
    u_xlat12 = fract(u_xlat12);
    u_xlat12 = u_xlat12 * _JitterMultiplier;
    u_xlat12 = u_xlat12 * 0.0500000007 + 1.0;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat13 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * in_NORMAL0.zxy;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.zxy * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat13 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat13 = u_xlat13 * in_TEXCOORD0.z;
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat14 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat14);
    u_xlat14 = in_TEXCOORD0.x + -0.5;
    u_xlat14 = u_xlat14 + u_xlat14;
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.yzx;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(1.5, 1.5, 1.5) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "PERSPECTIVE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
float u_xlat14;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat4.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat4.xy = u_xlat1.xy / u_xlat4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat8 = (-u_xlat4.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb12 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat8 = (u_xlatb12) ? 0.0 : u_xlat8;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat4.x = u_xlat12 * u_xlat4.x + u_xlat8;
    u_xlat1 = u_xlat4.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat4.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat4.x = _Turbulence / u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat0.x;
    u_xlat8 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * in_TANGENT0.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat4.xyz;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat12 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = u_xlat12 * 43758.5469;
    u_xlat12 = fract(u_xlat12);
    u_xlat12 = u_xlat12 * _JitterMultiplier;
    u_xlat12 = u_xlat12 * 0.0500000007 + 1.0;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat13 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * in_NORMAL0.zxy;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.zxy * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat13 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat13 = u_xlat13 * in_TEXCOORD0.z;
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat14 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat14);
    u_xlat14 = in_TEXCOORD0.x + -0.5;
    u_xlat14 = u_xlat14 + u_xlat14;
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.yzx;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(1.5, 1.5, 1.5) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "PERSPECTIVE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
float u_xlat14;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat4.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat4.xy = u_xlat1.xy / u_xlat4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat8 = (-u_xlat4.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb12 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat8 = (u_xlatb12) ? 0.0 : u_xlat8;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat4.x = u_xlat12 * u_xlat4.x + u_xlat8;
    u_xlat1 = u_xlat4.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat4.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat4.x = _Turbulence / u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat0.x;
    u_xlat8 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * in_TANGENT0.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat4.xyz;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat12 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = u_xlat12 * 43758.5469;
    u_xlat12 = fract(u_xlat12);
    u_xlat12 = u_xlat12 * _JitterMultiplier;
    u_xlat12 = u_xlat12 * 0.0500000007 + 1.0;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat13 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * in_NORMAL0.zxy;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.zxy * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat13 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat13 = u_xlat13 * in_TEXCOORD0.z;
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat14 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat14);
    u_xlat14 = in_TEXCOORD0.x + -0.5;
    u_xlat14 = u_xlat14 + u_xlat14;
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.yzx;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(1.5, 1.5, 1.5) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = abs(_glesTANGENT.w);
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_4 = (tmpvar_5 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_6;
  tmpvar_6 = (_glesMultiTexCoord0.z * (tmpvar_3 + tmpvar_3));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(_glesNormal);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  highp float tmpvar_10;
  tmpvar_10 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_9.xyz = (((tmpvar_8 * 
    (tmpvar_10 + tmpvar_10)
  ) * tmpvar_6) * 1.5);
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - _glesVertex.xyz));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = ((tmpvar_8.yzx * tmpvar_11.zxy) - (tmpvar_8.zxy * tmpvar_11.yzx));
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = (((_glesVertex + tmpvar_9) + (
    ((tmpvar_12 * tmpvar_6) * (_glesTANGENT.w / tmpvar_3))
   * 
    (1.0 + ((fract(
      (sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))) * 43758.55)
    ) * _JitterMultiplier) * 0.05))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_4)) + (tmpvar_7 * 
    ((_Turbulence / max (0.5, tmpvar_3)) * tmpvar_4)
  ))).xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  highp float tmpvar_15;
  bool tmpvar_16;
  tmpvar_16 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_15 = ((float(tmpvar_16) * clamp (
    (tmpvar_5 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_16)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_15 * _GlowTintColor) * tmpvar_17);
  tmpvar_1.w = (tmpvar_1.w * _glesMultiTexCoord0.w);
  highp vec4 o_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_13.zw;
  tmpvar_2.xyw = o_18.xyw;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _glesVertex.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_21)).z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_GlowTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = abs(_glesTANGENT.w);
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_4 = (tmpvar_5 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_6;
  tmpvar_6 = (_glesMultiTexCoord0.z * (tmpvar_3 + tmpvar_3));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(_glesNormal);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  highp float tmpvar_10;
  tmpvar_10 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_9.xyz = (((tmpvar_8 * 
    (tmpvar_10 + tmpvar_10)
  ) * tmpvar_6) * 1.5);
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - _glesVertex.xyz));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = ((tmpvar_8.yzx * tmpvar_11.zxy) - (tmpvar_8.zxy * tmpvar_11.yzx));
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = (((_glesVertex + tmpvar_9) + (
    ((tmpvar_12 * tmpvar_6) * (_glesTANGENT.w / tmpvar_3))
   * 
    (1.0 + ((fract(
      (sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))) * 43758.55)
    ) * _JitterMultiplier) * 0.05))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_4)) + (tmpvar_7 * 
    ((_Turbulence / max (0.5, tmpvar_3)) * tmpvar_4)
  ))).xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  highp float tmpvar_15;
  bool tmpvar_16;
  tmpvar_16 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_15 = ((float(tmpvar_16) * clamp (
    (tmpvar_5 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_16)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_15 * _GlowTintColor) * tmpvar_17);
  tmpvar_1.w = (tmpvar_1.w * _glesMultiTexCoord0.w);
  highp vec4 o_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_13.zw;
  tmpvar_2.xyw = o_18.xyw;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _glesVertex.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_21)).z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_GlowTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = abs(_glesTANGENT.w);
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_4 = (tmpvar_5 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_6;
  tmpvar_6 = (_glesMultiTexCoord0.z * (tmpvar_3 + tmpvar_3));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(_glesNormal);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  highp float tmpvar_10;
  tmpvar_10 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_9.xyz = (((tmpvar_8 * 
    (tmpvar_10 + tmpvar_10)
  ) * tmpvar_6) * 1.5);
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - _glesVertex.xyz));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = ((tmpvar_8.yzx * tmpvar_11.zxy) - (tmpvar_8.zxy * tmpvar_11.yzx));
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = (((_glesVertex + tmpvar_9) + (
    ((tmpvar_12 * tmpvar_6) * (_glesTANGENT.w / tmpvar_3))
   * 
    (1.0 + ((fract(
      (sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))) * 43758.55)
    ) * _JitterMultiplier) * 0.05))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_4)) + (tmpvar_7 * 
    ((_Turbulence / max (0.5, tmpvar_3)) * tmpvar_4)
  ))).xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  highp float tmpvar_15;
  bool tmpvar_16;
  tmpvar_16 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_15 = ((float(tmpvar_16) * clamp (
    (tmpvar_5 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_16)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_15 * _GlowTintColor) * tmpvar_17);
  tmpvar_1.w = (tmpvar_1.w * _glesMultiTexCoord0.w);
  highp vec4 o_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_13.zw;
  tmpvar_2.xyw = o_18.xyw;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _glesVertex.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_21)).z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_GlowTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
float u_xlat14;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat4.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat4.xy = u_xlat1.xy / u_xlat4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat8 = (-u_xlat4.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb12 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat8 = (u_xlatb12) ? 0.0 : u_xlat8;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat4.x = u_xlat12 * u_xlat4.x + u_xlat8;
    u_xlat1 = u_xlat4.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat4.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat4.x = _Turbulence / u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat0.x;
    u_xlat8 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * in_TANGENT0.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat4.xyz;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat12 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = u_xlat12 * 43758.5469;
    u_xlat12 = fract(u_xlat12);
    u_xlat12 = u_xlat12 * _JitterMultiplier;
    u_xlat12 = u_xlat12 * 0.0500000007 + 1.0;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat13 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * in_NORMAL0.zxy;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.zxy * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat13 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat13 = u_xlat13 * in_TEXCOORD0.z;
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat14 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat14);
    u_xlat14 = in_TEXCOORD0.x + -0.5;
    u_xlat14 = u_xlat14 + u_xlat14;
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.yzx;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(1.5, 1.5, 1.5) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat4.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
float u_xlat14;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat4.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat4.xy = u_xlat1.xy / u_xlat4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat8 = (-u_xlat4.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb12 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat8 = (u_xlatb12) ? 0.0 : u_xlat8;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat4.x = u_xlat12 * u_xlat4.x + u_xlat8;
    u_xlat1 = u_xlat4.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat4.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat4.x = _Turbulence / u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat0.x;
    u_xlat8 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * in_TANGENT0.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat4.xyz;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat12 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = u_xlat12 * 43758.5469;
    u_xlat12 = fract(u_xlat12);
    u_xlat12 = u_xlat12 * _JitterMultiplier;
    u_xlat12 = u_xlat12 * 0.0500000007 + 1.0;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat13 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * in_NORMAL0.zxy;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.zxy * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat13 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat13 = u_xlat13 * in_TEXCOORD0.z;
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat14 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat14);
    u_xlat14 = in_TEXCOORD0.x + -0.5;
    u_xlat14 = u_xlat14 + u_xlat14;
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.yzx;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(1.5, 1.5, 1.5) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat4.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
float u_xlat14;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat4.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat4.xy = u_xlat1.xy / u_xlat4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat8 = (-u_xlat4.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb12 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat8 = (u_xlatb12) ? 0.0 : u_xlat8;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat4.x = u_xlat12 * u_xlat4.x + u_xlat8;
    u_xlat1 = u_xlat4.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat4.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat4.x = _Turbulence / u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat0.x;
    u_xlat8 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * in_TANGENT0.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat4.xyz;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat12 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = u_xlat12 * 43758.5469;
    u_xlat12 = fract(u_xlat12);
    u_xlat12 = u_xlat12 * _JitterMultiplier;
    u_xlat12 = u_xlat12 * 0.0500000007 + 1.0;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat13 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * in_NORMAL0.zxy;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.zxy * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat13 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat13 = u_xlat13 * in_TEXCOORD0.z;
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat14 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat14);
    u_xlat14 = in_TEXCOORD0.x + -0.5;
    u_xlat14 = u_xlat14 + u_xlat14;
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.yzx;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(1.5, 1.5, 1.5) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat4.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float tmpvar_2;
  tmpvar_2 = abs(_glesTANGENT.w);
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.z * (tmpvar_2 + tmpvar_2));
  highp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(_glesNormal);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  highp float tmpvar_9;
  tmpvar_9 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_8.xyz = (((tmpvar_7 * 
    (tmpvar_9 + tmpvar_9)
  ) * tmpvar_5) * 1.5);
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - _glesVertex.xyz));
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = ((tmpvar_7.yzx * tmpvar_10.zxy) - (tmpvar_7.zxy * tmpvar_10.yzx));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (((_glesVertex + tmpvar_8) + (
    ((tmpvar_11 * tmpvar_5) * (_glesTANGENT.w / tmpvar_2))
   * 
    (1.0 + ((fract(
      (sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))) * 43758.55)
    ) * _JitterMultiplier) * 0.05))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_3)) + (tmpvar_6 * 
    ((_Turbulence / max (0.5, tmpvar_2)) * tmpvar_3)
  ))).xyz;
  highp float tmpvar_13;
  bool tmpvar_14;
  tmpvar_14 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_13 = ((float(tmpvar_14) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_14)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_13 * _GlowTintColor) * tmpvar_15);
  tmpvar_1.w = (tmpvar_1.w * _glesMultiTexCoord0.w);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_GlowTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float tmpvar_2;
  tmpvar_2 = abs(_glesTANGENT.w);
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.z * (tmpvar_2 + tmpvar_2));
  highp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(_glesNormal);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  highp float tmpvar_9;
  tmpvar_9 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_8.xyz = (((tmpvar_7 * 
    (tmpvar_9 + tmpvar_9)
  ) * tmpvar_5) * 1.5);
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - _glesVertex.xyz));
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = ((tmpvar_7.yzx * tmpvar_10.zxy) - (tmpvar_7.zxy * tmpvar_10.yzx));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (((_glesVertex + tmpvar_8) + (
    ((tmpvar_11 * tmpvar_5) * (_glesTANGENT.w / tmpvar_2))
   * 
    (1.0 + ((fract(
      (sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))) * 43758.55)
    ) * _JitterMultiplier) * 0.05))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_3)) + (tmpvar_6 * 
    ((_Turbulence / max (0.5, tmpvar_2)) * tmpvar_3)
  ))).xyz;
  highp float tmpvar_13;
  bool tmpvar_14;
  tmpvar_14 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_13 = ((float(tmpvar_14) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_14)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_13 * _GlowTintColor) * tmpvar_15);
  tmpvar_1.w = (tmpvar_1.w * _glesMultiTexCoord0.w);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_GlowTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float tmpvar_2;
  tmpvar_2 = abs(_glesTANGENT.w);
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.z * (tmpvar_2 + tmpvar_2));
  highp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(_glesNormal);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  highp float tmpvar_9;
  tmpvar_9 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_8.xyz = (((tmpvar_7 * 
    (tmpvar_9 + tmpvar_9)
  ) * tmpvar_5) * 1.5);
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - _glesVertex.xyz));
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = ((tmpvar_7.yzx * tmpvar_10.zxy) - (tmpvar_7.zxy * tmpvar_10.yzx));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (((_glesVertex + tmpvar_8) + (
    ((tmpvar_11 * tmpvar_5) * (_glesTANGENT.w / tmpvar_2))
   * 
    (1.0 + ((fract(
      (sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))) * 43758.55)
    ) * _JitterMultiplier) * 0.05))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_3)) + (tmpvar_6 * 
    ((_Turbulence / max (0.5, tmpvar_2)) * tmpvar_3)
  ))).xyz;
  highp float tmpvar_13;
  bool tmpvar_14;
  tmpvar_14 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_13 = ((float(tmpvar_14) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_14)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_13 * _GlowTintColor) * tmpvar_15);
  tmpvar_1.w = (tmpvar_1.w * _glesMultiTexCoord0.w);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_GlowTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
float u_xlat14;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat4.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat4.xy = u_xlat1.xy / u_xlat4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat8 = (-u_xlat4.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb12 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat8 = (u_xlatb12) ? 0.0 : u_xlat8;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat4.x = u_xlat12 * u_xlat4.x + u_xlat8;
    u_xlat1 = u_xlat4.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat4.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat4.x = _Turbulence / u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat0.x;
    u_xlat8 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * in_TANGENT0.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat4.xyz;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat12 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = u_xlat12 * 43758.5469;
    u_xlat12 = fract(u_xlat12);
    u_xlat12 = u_xlat12 * _JitterMultiplier;
    u_xlat12 = u_xlat12 * 0.0500000007 + 1.0;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat13 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * in_NORMAL0.zxy;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.zxy * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat13 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat13 = u_xlat13 * in_TEXCOORD0.z;
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat14 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat14);
    u_xlat14 = in_TEXCOORD0.x + -0.5;
    u_xlat14 = u_xlat14 + u_xlat14;
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.yzx;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(1.5, 1.5, 1.5) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
float u_xlat14;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat4.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat4.xy = u_xlat1.xy / u_xlat4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat8 = (-u_xlat4.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb12 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat8 = (u_xlatb12) ? 0.0 : u_xlat8;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat4.x = u_xlat12 * u_xlat4.x + u_xlat8;
    u_xlat1 = u_xlat4.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat4.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat4.x = _Turbulence / u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat0.x;
    u_xlat8 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * in_TANGENT0.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat4.xyz;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat12 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = u_xlat12 * 43758.5469;
    u_xlat12 = fract(u_xlat12);
    u_xlat12 = u_xlat12 * _JitterMultiplier;
    u_xlat12 = u_xlat12 * 0.0500000007 + 1.0;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat13 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * in_NORMAL0.zxy;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.zxy * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat13 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat13 = u_xlat13 * in_TEXCOORD0.z;
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat14 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat14);
    u_xlat14 = in_TEXCOORD0.x + -0.5;
    u_xlat14 = u_xlat14 + u_xlat14;
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.yzx;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(1.5, 1.5, 1.5) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
float u_xlat14;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat4.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat4.xy = u_xlat1.xy / u_xlat4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat8 = (-u_xlat4.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb12 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat8 = (u_xlatb12) ? 0.0 : u_xlat8;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat4.x = u_xlat12 * u_xlat4.x + u_xlat8;
    u_xlat1 = u_xlat4.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat4.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat4.x = _Turbulence / u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat0.x;
    u_xlat8 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * in_TANGENT0.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat4.xyz;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat12 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = u_xlat12 * 43758.5469;
    u_xlat12 = fract(u_xlat12);
    u_xlat12 = u_xlat12 * _JitterMultiplier;
    u_xlat12 = u_xlat12 * 0.0500000007 + 1.0;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat13 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * in_NORMAL0.zxy;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.zxy * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat13 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat13 = u_xlat13 * in_TEXCOORD0.z;
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat14 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat14);
    u_xlat14 = in_TEXCOORD0.x + -0.5;
    u_xlat14 = u_xlat14 + u_xlat14;
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.yzx;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(1.5, 1.5, 1.5) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = abs(_glesTANGENT.w);
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_4 = (tmpvar_5 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_6;
  tmpvar_6 = (_glesMultiTexCoord0.z * (tmpvar_3 + tmpvar_3));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(_glesNormal);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  highp float tmpvar_10;
  tmpvar_10 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_9.xyz = (((tmpvar_8 * 
    (tmpvar_10 + tmpvar_10)
  ) * tmpvar_6) * 1.5);
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - _glesVertex.xyz));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = ((tmpvar_8.yzx * tmpvar_11.zxy) - (tmpvar_8.zxy * tmpvar_11.yzx));
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = (((_glesVertex + tmpvar_9) + (
    ((tmpvar_12 * tmpvar_6) * (_glesTANGENT.w / tmpvar_3))
   * 
    (1.0 + ((fract(
      (sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))) * 43758.55)
    ) * _JitterMultiplier) * 0.05))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_4)) + (tmpvar_7 * 
    ((_Turbulence / max (0.5, tmpvar_3)) * tmpvar_4)
  ))).xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  highp float tmpvar_15;
  bool tmpvar_16;
  tmpvar_16 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_15 = ((float(tmpvar_16) * clamp (
    (tmpvar_5 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_16)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_15 * _GlowTintColor) * tmpvar_17);
  tmpvar_1.w = (tmpvar_1.w * _glesMultiTexCoord0.w);
  highp vec4 o_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_13.zw;
  tmpvar_2.xyw = o_18.xyw;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _glesVertex.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_21)).z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_GlowTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = abs(_glesTANGENT.w);
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_4 = (tmpvar_5 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_6;
  tmpvar_6 = (_glesMultiTexCoord0.z * (tmpvar_3 + tmpvar_3));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(_glesNormal);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  highp float tmpvar_10;
  tmpvar_10 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_9.xyz = (((tmpvar_8 * 
    (tmpvar_10 + tmpvar_10)
  ) * tmpvar_6) * 1.5);
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - _glesVertex.xyz));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = ((tmpvar_8.yzx * tmpvar_11.zxy) - (tmpvar_8.zxy * tmpvar_11.yzx));
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = (((_glesVertex + tmpvar_9) + (
    ((tmpvar_12 * tmpvar_6) * (_glesTANGENT.w / tmpvar_3))
   * 
    (1.0 + ((fract(
      (sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))) * 43758.55)
    ) * _JitterMultiplier) * 0.05))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_4)) + (tmpvar_7 * 
    ((_Turbulence / max (0.5, tmpvar_3)) * tmpvar_4)
  ))).xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  highp float tmpvar_15;
  bool tmpvar_16;
  tmpvar_16 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_15 = ((float(tmpvar_16) * clamp (
    (tmpvar_5 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_16)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_15 * _GlowTintColor) * tmpvar_17);
  tmpvar_1.w = (tmpvar_1.w * _glesMultiTexCoord0.w);
  highp vec4 o_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_13.zw;
  tmpvar_2.xyw = o_18.xyw;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _glesVertex.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_21)).z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_GlowTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = abs(_glesTANGENT.w);
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_4 = (tmpvar_5 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_6;
  tmpvar_6 = (_glesMultiTexCoord0.z * (tmpvar_3 + tmpvar_3));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(_glesNormal);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  highp float tmpvar_10;
  tmpvar_10 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_9.xyz = (((tmpvar_8 * 
    (tmpvar_10 + tmpvar_10)
  ) * tmpvar_6) * 1.5);
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - _glesVertex.xyz));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = ((tmpvar_8.yzx * tmpvar_11.zxy) - (tmpvar_8.zxy * tmpvar_11.yzx));
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = (((_glesVertex + tmpvar_9) + (
    ((tmpvar_12 * tmpvar_6) * (_glesTANGENT.w / tmpvar_3))
   * 
    (1.0 + ((fract(
      (sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))) * 43758.55)
    ) * _JitterMultiplier) * 0.05))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_4)) + (tmpvar_7 * 
    ((_Turbulence / max (0.5, tmpvar_3)) * tmpvar_4)
  ))).xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  highp float tmpvar_15;
  bool tmpvar_16;
  tmpvar_16 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_15 = ((float(tmpvar_16) * clamp (
    (tmpvar_5 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_16)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_15 * _GlowTintColor) * tmpvar_17);
  tmpvar_1.w = (tmpvar_1.w * _glesMultiTexCoord0.w);
  highp vec4 o_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_13.zw;
  tmpvar_2.xyw = o_18.xyw;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _glesVertex.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_21)).z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_GlowTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
float u_xlat14;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat4.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat4.xy = u_xlat1.xy / u_xlat4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat8 = (-u_xlat4.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb12 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat8 = (u_xlatb12) ? 0.0 : u_xlat8;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat4.x = u_xlat12 * u_xlat4.x + u_xlat8;
    u_xlat1 = u_xlat4.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat4.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat4.x = _Turbulence / u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat0.x;
    u_xlat8 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * in_TANGENT0.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat4.xyz;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat12 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = u_xlat12 * 43758.5469;
    u_xlat12 = fract(u_xlat12);
    u_xlat12 = u_xlat12 * _JitterMultiplier;
    u_xlat12 = u_xlat12 * 0.0500000007 + 1.0;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat13 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * in_NORMAL0.zxy;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.zxy * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat13 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat13 = u_xlat13 * in_TEXCOORD0.z;
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat14 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat14);
    u_xlat14 = in_TEXCOORD0.x + -0.5;
    u_xlat14 = u_xlat14 + u_xlat14;
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.yzx;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(1.5, 1.5, 1.5) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat4.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
float u_xlat14;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat4.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat4.xy = u_xlat1.xy / u_xlat4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat8 = (-u_xlat4.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb12 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat8 = (u_xlatb12) ? 0.0 : u_xlat8;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat4.x = u_xlat12 * u_xlat4.x + u_xlat8;
    u_xlat1 = u_xlat4.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat4.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat4.x = _Turbulence / u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat0.x;
    u_xlat8 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * in_TANGENT0.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat4.xyz;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat12 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = u_xlat12 * 43758.5469;
    u_xlat12 = fract(u_xlat12);
    u_xlat12 = u_xlat12 * _JitterMultiplier;
    u_xlat12 = u_xlat12 * 0.0500000007 + 1.0;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat13 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * in_NORMAL0.zxy;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.zxy * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat13 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat13 = u_xlat13 * in_TEXCOORD0.z;
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat14 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat14);
    u_xlat14 = in_TEXCOORD0.x + -0.5;
    u_xlat14 = u_xlat14 + u_xlat14;
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.yzx;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(1.5, 1.5, 1.5) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat4.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
float u_xlat14;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat4.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat4.xy = u_xlat1.xy / u_xlat4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat8 = (-u_xlat4.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb12 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat8 = (u_xlatb12) ? 0.0 : u_xlat8;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat4.x = u_xlat12 * u_xlat4.x + u_xlat8;
    u_xlat1 = u_xlat4.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat4.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat4.x = _Turbulence / u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat0.x;
    u_xlat8 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * in_TANGENT0.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat4.xyz;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat12 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = u_xlat12 * 43758.5469;
    u_xlat12 = fract(u_xlat12);
    u_xlat12 = u_xlat12 * _JitterMultiplier;
    u_xlat12 = u_xlat12 * 0.0500000007 + 1.0;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat13 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * in_NORMAL0.zxy;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.zxy * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat13 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat13 = u_xlat13 * in_TEXCOORD0.z;
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat14 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat14);
    u_xlat14 = in_TEXCOORD0.x + -0.5;
    u_xlat14 = u_xlat14 + u_xlat14;
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.yzx;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(1.5, 1.5, 1.5) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat4.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float tmpvar_2;
  tmpvar_2 = abs(_glesTANGENT.w);
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.z * (tmpvar_2 + tmpvar_2));
  highp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(_glesNormal);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  highp float tmpvar_9;
  tmpvar_9 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_8.xyz = (((tmpvar_7 * 
    (tmpvar_9 + tmpvar_9)
  ) * tmpvar_5) * 1.5);
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - _glesVertex.xyz));
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = ((tmpvar_7.yzx * tmpvar_10.zxy) - (tmpvar_7.zxy * tmpvar_10.yzx));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (((_glesVertex + tmpvar_8) + (
    ((tmpvar_11 * tmpvar_5) * (_glesTANGENT.w / tmpvar_2))
   * 
    (1.0 + ((fract(
      (sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))) * 43758.55)
    ) * _JitterMultiplier) * 0.05))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_3)) + (tmpvar_6 * 
    ((_Turbulence / max (0.5, tmpvar_2)) * tmpvar_3)
  ))).xyz;
  highp float tmpvar_13;
  bool tmpvar_14;
  tmpvar_14 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_13 = ((float(tmpvar_14) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_14)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_13 * _GlowTintColor) * tmpvar_15);
  tmpvar_1.w = (tmpvar_1.w * _glesMultiTexCoord0.w);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_GlowTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float tmpvar_2;
  tmpvar_2 = abs(_glesTANGENT.w);
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.z * (tmpvar_2 + tmpvar_2));
  highp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(_glesNormal);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  highp float tmpvar_9;
  tmpvar_9 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_8.xyz = (((tmpvar_7 * 
    (tmpvar_9 + tmpvar_9)
  ) * tmpvar_5) * 1.5);
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - _glesVertex.xyz));
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = ((tmpvar_7.yzx * tmpvar_10.zxy) - (tmpvar_7.zxy * tmpvar_10.yzx));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (((_glesVertex + tmpvar_8) + (
    ((tmpvar_11 * tmpvar_5) * (_glesTANGENT.w / tmpvar_2))
   * 
    (1.0 + ((fract(
      (sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))) * 43758.55)
    ) * _JitterMultiplier) * 0.05))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_3)) + (tmpvar_6 * 
    ((_Turbulence / max (0.5, tmpvar_2)) * tmpvar_3)
  ))).xyz;
  highp float tmpvar_13;
  bool tmpvar_14;
  tmpvar_14 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_13 = ((float(tmpvar_14) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_14)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_13 * _GlowTintColor) * tmpvar_15);
  tmpvar_1.w = (tmpvar_1.w * _glesMultiTexCoord0.w);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_GlowTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float tmpvar_2;
  tmpvar_2 = abs(_glesTANGENT.w);
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.z * (tmpvar_2 + tmpvar_2));
  highp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(_glesNormal);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  highp float tmpvar_9;
  tmpvar_9 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_8.xyz = (((tmpvar_7 * 
    (tmpvar_9 + tmpvar_9)
  ) * tmpvar_5) * 1.5);
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - _glesVertex.xyz));
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = ((tmpvar_7.yzx * tmpvar_10.zxy) - (tmpvar_7.zxy * tmpvar_10.yzx));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (((_glesVertex + tmpvar_8) + (
    ((tmpvar_11 * tmpvar_5) * (_glesTANGENT.w / tmpvar_2))
   * 
    (1.0 + ((fract(
      (sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))) * 43758.55)
    ) * _JitterMultiplier) * 0.05))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_3)) + (tmpvar_6 * 
    ((_Turbulence / max (0.5, tmpvar_2)) * tmpvar_3)
  ))).xyz;
  highp float tmpvar_13;
  bool tmpvar_14;
  tmpvar_14 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_13 = ((float(tmpvar_14) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_14)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_13 * _GlowTintColor) * tmpvar_15);
  tmpvar_1.w = (tmpvar_1.w * _glesMultiTexCoord0.w);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_GlowTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
float u_xlat14;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat4.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat4.xy = u_xlat1.xy / u_xlat4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat8 = (-u_xlat4.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb12 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat8 = (u_xlatb12) ? 0.0 : u_xlat8;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat4.x = u_xlat12 * u_xlat4.x + u_xlat8;
    u_xlat1 = u_xlat4.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat4.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat4.x = _Turbulence / u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat0.x;
    u_xlat8 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * in_TANGENT0.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat4.xyz;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat12 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = u_xlat12 * 43758.5469;
    u_xlat12 = fract(u_xlat12);
    u_xlat12 = u_xlat12 * _JitterMultiplier;
    u_xlat12 = u_xlat12 * 0.0500000007 + 1.0;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat13 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * in_NORMAL0.zxy;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.zxy * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat13 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat13 = u_xlat13 * in_TEXCOORD0.z;
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat14 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat14);
    u_xlat14 = in_TEXCOORD0.x + -0.5;
    u_xlat14 = u_xlat14 + u_xlat14;
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.yzx;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(1.5, 1.5, 1.5) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
float u_xlat14;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat4.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat4.xy = u_xlat1.xy / u_xlat4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat8 = (-u_xlat4.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb12 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat8 = (u_xlatb12) ? 0.0 : u_xlat8;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat4.x = u_xlat12 * u_xlat4.x + u_xlat8;
    u_xlat1 = u_xlat4.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat4.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat4.x = _Turbulence / u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat0.x;
    u_xlat8 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * in_TANGENT0.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat4.xyz;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat12 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = u_xlat12 * 43758.5469;
    u_xlat12 = fract(u_xlat12);
    u_xlat12 = u_xlat12 * _JitterMultiplier;
    u_xlat12 = u_xlat12 * 0.0500000007 + 1.0;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat13 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * in_NORMAL0.zxy;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.zxy * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat13 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat13 = u_xlat13 * in_TEXCOORD0.z;
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat14 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat14);
    u_xlat14 = in_TEXCOORD0.x + -0.5;
    u_xlat14 = u_xlat14 + u_xlat14;
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.yzx;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(1.5, 1.5, 1.5) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
float u_xlat14;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat4.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat4.xy = u_xlat1.xy / u_xlat4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat8 = (-u_xlat4.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb12 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat8 = (u_xlatb12) ? 0.0 : u_xlat8;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat4.x = u_xlat12 * u_xlat4.x + u_xlat8;
    u_xlat1 = u_xlat4.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat4.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat4.x = _Turbulence / u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat0.x;
    u_xlat8 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * in_TANGENT0.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat4.xyz;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat12 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = u_xlat12 * 43758.5469;
    u_xlat12 = fract(u_xlat12);
    u_xlat12 = u_xlat12 * _JitterMultiplier;
    u_xlat12 = u_xlat12 * 0.0500000007 + 1.0;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat13 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * in_NORMAL0.zxy;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.zxy * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat13 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat13 = u_xlat13 * in_TEXCOORD0.z;
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat14 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat14);
    u_xlat14 = in_TEXCOORD0.x + -0.5;
    u_xlat14 = u_xlat14 + u_xlat14;
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.yzx;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(1.5, 1.5, 1.5) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = abs(_glesTANGENT.w);
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_4 = (tmpvar_5 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_6;
  tmpvar_6 = (_glesMultiTexCoord0.z * (tmpvar_3 + tmpvar_3));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(_glesNormal);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  highp float tmpvar_10;
  tmpvar_10 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_9.xyz = (((tmpvar_8 * 
    (tmpvar_10 + tmpvar_10)
  ) * tmpvar_6) * 1.5);
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - _glesVertex.xyz));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = ((tmpvar_8.yzx * tmpvar_11.zxy) - (tmpvar_8.zxy * tmpvar_11.yzx));
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = (((_glesVertex + tmpvar_9) + (
    ((tmpvar_12 * tmpvar_6) * (_glesTANGENT.w / tmpvar_3))
   * 
    (1.0 + ((fract(
      (sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))) * 43758.55)
    ) * _JitterMultiplier) * 0.05))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_4)) + (tmpvar_7 * 
    ((_Turbulence / max (0.5, tmpvar_3)) * tmpvar_4)
  ))).xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  highp float tmpvar_15;
  bool tmpvar_16;
  tmpvar_16 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_15 = ((float(tmpvar_16) * clamp (
    (tmpvar_5 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_16)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_15 * _GlowTintColor) * tmpvar_17);
  tmpvar_1.w = (tmpvar_1.w * _glesMultiTexCoord0.w);
  highp vec4 o_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_13.zw;
  tmpvar_2.xyw = o_18.xyw;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _glesVertex.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_21)).z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_GlowTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = abs(_glesTANGENT.w);
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_4 = (tmpvar_5 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_6;
  tmpvar_6 = (_glesMultiTexCoord0.z * (tmpvar_3 + tmpvar_3));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(_glesNormal);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  highp float tmpvar_10;
  tmpvar_10 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_9.xyz = (((tmpvar_8 * 
    (tmpvar_10 + tmpvar_10)
  ) * tmpvar_6) * 1.5);
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - _glesVertex.xyz));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = ((tmpvar_8.yzx * tmpvar_11.zxy) - (tmpvar_8.zxy * tmpvar_11.yzx));
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = (((_glesVertex + tmpvar_9) + (
    ((tmpvar_12 * tmpvar_6) * (_glesTANGENT.w / tmpvar_3))
   * 
    (1.0 + ((fract(
      (sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))) * 43758.55)
    ) * _JitterMultiplier) * 0.05))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_4)) + (tmpvar_7 * 
    ((_Turbulence / max (0.5, tmpvar_3)) * tmpvar_4)
  ))).xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  highp float tmpvar_15;
  bool tmpvar_16;
  tmpvar_16 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_15 = ((float(tmpvar_16) * clamp (
    (tmpvar_5 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_16)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_15 * _GlowTintColor) * tmpvar_17);
  tmpvar_1.w = (tmpvar_1.w * _glesMultiTexCoord0.w);
  highp vec4 o_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_13.zw;
  tmpvar_2.xyw = o_18.xyw;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _glesVertex.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_21)).z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_GlowTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = abs(_glesTANGENT.w);
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_4 = (tmpvar_5 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_6;
  tmpvar_6 = (_glesMultiTexCoord0.z * (tmpvar_3 + tmpvar_3));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(_glesNormal);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  highp float tmpvar_10;
  tmpvar_10 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_9.xyz = (((tmpvar_8 * 
    (tmpvar_10 + tmpvar_10)
  ) * tmpvar_6) * 1.5);
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - _glesVertex.xyz));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = ((tmpvar_8.yzx * tmpvar_11.zxy) - (tmpvar_8.zxy * tmpvar_11.yzx));
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = (((_glesVertex + tmpvar_9) + (
    ((tmpvar_12 * tmpvar_6) * (_glesTANGENT.w / tmpvar_3))
   * 
    (1.0 + ((fract(
      (sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))) * 43758.55)
    ) * _JitterMultiplier) * 0.05))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_4)) + (tmpvar_7 * 
    ((_Turbulence / max (0.5, tmpvar_3)) * tmpvar_4)
  ))).xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  highp float tmpvar_15;
  bool tmpvar_16;
  tmpvar_16 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_15 = ((float(tmpvar_16) * clamp (
    (tmpvar_5 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_16)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_15 * _GlowTintColor) * tmpvar_17);
  tmpvar_1.w = (tmpvar_1.w * _glesMultiTexCoord0.w);
  highp vec4 o_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_13.zw;
  tmpvar_2.xyw = o_18.xyw;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _glesVertex.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_21)).z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_GlowTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
float u_xlat14;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat4.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat4.xy = u_xlat1.xy / u_xlat4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat8 = (-u_xlat4.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb12 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat8 = (u_xlatb12) ? 0.0 : u_xlat8;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat4.x = u_xlat12 * u_xlat4.x + u_xlat8;
    u_xlat1 = u_xlat4.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat4.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat4.x = _Turbulence / u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat0.x;
    u_xlat8 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * in_TANGENT0.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat4.xyz;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat12 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = u_xlat12 * 43758.5469;
    u_xlat12 = fract(u_xlat12);
    u_xlat12 = u_xlat12 * _JitterMultiplier;
    u_xlat12 = u_xlat12 * 0.0500000007 + 1.0;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat13 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * in_NORMAL0.zxy;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.zxy * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat13 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat13 = u_xlat13 * in_TEXCOORD0.z;
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat14 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat14);
    u_xlat14 = in_TEXCOORD0.x + -0.5;
    u_xlat14 = u_xlat14 + u_xlat14;
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.yzx;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(1.5, 1.5, 1.5) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat4.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
float u_xlat14;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat4.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat4.xy = u_xlat1.xy / u_xlat4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat8 = (-u_xlat4.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb12 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat8 = (u_xlatb12) ? 0.0 : u_xlat8;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat4.x = u_xlat12 * u_xlat4.x + u_xlat8;
    u_xlat1 = u_xlat4.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat4.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat4.x = _Turbulence / u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat0.x;
    u_xlat8 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * in_TANGENT0.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat4.xyz;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat12 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = u_xlat12 * 43758.5469;
    u_xlat12 = fract(u_xlat12);
    u_xlat12 = u_xlat12 * _JitterMultiplier;
    u_xlat12 = u_xlat12 * 0.0500000007 + 1.0;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat13 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * in_NORMAL0.zxy;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.zxy * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat13 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat13 = u_xlat13 * in_TEXCOORD0.z;
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat14 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat14);
    u_xlat14 = in_TEXCOORD0.x + -0.5;
    u_xlat14 = u_xlat14 + u_xlat14;
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.yzx;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(1.5, 1.5, 1.5) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat4.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
float u_xlat14;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat4.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat4.xy = u_xlat1.xy / u_xlat4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat8 = (-u_xlat4.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb12 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat8 = (u_xlatb12) ? 0.0 : u_xlat8;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat4.x = u_xlat12 * u_xlat4.x + u_xlat8;
    u_xlat1 = u_xlat4.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat4.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat4.x = _Turbulence / u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat0.x;
    u_xlat8 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * in_TANGENT0.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat4.xyz;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat12 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = u_xlat12 * 43758.5469;
    u_xlat12 = fract(u_xlat12);
    u_xlat12 = u_xlat12 * _JitterMultiplier;
    u_xlat12 = u_xlat12 * 0.0500000007 + 1.0;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat13 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * in_NORMAL0.zxy;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.zxy * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat13 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat13 = u_xlat13 * in_TEXCOORD0.z;
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat14 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat14);
    u_xlat14 = in_TEXCOORD0.x + -0.5;
    u_xlat14 = u_xlat14 + u_xlat14;
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.yzx;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(1.5, 1.5, 1.5) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat4.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float tmpvar_2;
  tmpvar_2 = abs(_glesTANGENT.w);
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.z * (tmpvar_2 + tmpvar_2));
  highp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(_glesNormal);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  highp float tmpvar_9;
  tmpvar_9 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_8.xyz = (((tmpvar_7 * 
    (tmpvar_9 + tmpvar_9)
  ) * tmpvar_5) * 1.5);
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - _glesVertex.xyz));
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = ((tmpvar_7.yzx * tmpvar_10.zxy) - (tmpvar_7.zxy * tmpvar_10.yzx));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (((_glesVertex + tmpvar_8) + (
    ((tmpvar_11 * tmpvar_5) * (_glesTANGENT.w / tmpvar_2))
   * 
    (1.0 + ((fract(
      (sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))) * 43758.55)
    ) * _JitterMultiplier) * 0.05))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_3)) + (tmpvar_6 * 
    ((_Turbulence / max (0.5, tmpvar_2)) * tmpvar_3)
  ))).xyz;
  highp float tmpvar_13;
  bool tmpvar_14;
  tmpvar_14 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_13 = ((float(tmpvar_14) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_14)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_13 * _GlowTintColor) * tmpvar_15);
  tmpvar_1.w = (tmpvar_1.w * _glesMultiTexCoord0.w);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_GlowTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float tmpvar_2;
  tmpvar_2 = abs(_glesTANGENT.w);
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.z * (tmpvar_2 + tmpvar_2));
  highp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(_glesNormal);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  highp float tmpvar_9;
  tmpvar_9 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_8.xyz = (((tmpvar_7 * 
    (tmpvar_9 + tmpvar_9)
  ) * tmpvar_5) * 1.5);
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - _glesVertex.xyz));
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = ((tmpvar_7.yzx * tmpvar_10.zxy) - (tmpvar_7.zxy * tmpvar_10.yzx));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (((_glesVertex + tmpvar_8) + (
    ((tmpvar_11 * tmpvar_5) * (_glesTANGENT.w / tmpvar_2))
   * 
    (1.0 + ((fract(
      (sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))) * 43758.55)
    ) * _JitterMultiplier) * 0.05))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_3)) + (tmpvar_6 * 
    ((_Turbulence / max (0.5, tmpvar_2)) * tmpvar_3)
  ))).xyz;
  highp float tmpvar_13;
  bool tmpvar_14;
  tmpvar_14 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_13 = ((float(tmpvar_14) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_14)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_13 * _GlowTintColor) * tmpvar_15);
  tmpvar_1.w = (tmpvar_1.w * _glesMultiTexCoord0.w);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_GlowTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float tmpvar_2;
  tmpvar_2 = abs(_glesTANGENT.w);
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.z * (tmpvar_2 + tmpvar_2));
  highp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(_glesNormal);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  highp float tmpvar_9;
  tmpvar_9 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_8.xyz = (((tmpvar_7 * 
    (tmpvar_9 + tmpvar_9)
  ) * tmpvar_5) * 1.5);
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - _glesVertex.xyz));
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = ((tmpvar_7.yzx * tmpvar_10.zxy) - (tmpvar_7.zxy * tmpvar_10.yzx));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = (((_glesVertex + tmpvar_8) + (
    ((tmpvar_11 * tmpvar_5) * (_glesTANGENT.w / tmpvar_2))
   * 
    (1.0 + ((fract(
      (sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))) * 43758.55)
    ) * _JitterMultiplier) * 0.05))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_3)) + (tmpvar_6 * 
    ((_Turbulence / max (0.5, tmpvar_2)) * tmpvar_3)
  ))).xyz;
  highp float tmpvar_13;
  bool tmpvar_14;
  tmpvar_14 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_13 = ((float(tmpvar_14) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_14)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_13 * _GlowTintColor) * tmpvar_15);
  tmpvar_1.w = (tmpvar_1.w * _glesMultiTexCoord0.w);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_GlowTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
float u_xlat14;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat4.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat4.xy = u_xlat1.xy / u_xlat4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat8 = (-u_xlat4.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb12 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat8 = (u_xlatb12) ? 0.0 : u_xlat8;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat4.x = u_xlat12 * u_xlat4.x + u_xlat8;
    u_xlat1 = u_xlat4.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat4.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat4.x = _Turbulence / u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat0.x;
    u_xlat8 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * in_TANGENT0.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat4.xyz;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat12 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = u_xlat12 * 43758.5469;
    u_xlat12 = fract(u_xlat12);
    u_xlat12 = u_xlat12 * _JitterMultiplier;
    u_xlat12 = u_xlat12 * 0.0500000007 + 1.0;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat13 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * in_NORMAL0.zxy;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.zxy * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat13 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat13 = u_xlat13 * in_TEXCOORD0.z;
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat14 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat14);
    u_xlat14 = in_TEXCOORD0.x + -0.5;
    u_xlat14 = u_xlat14 + u_xlat14;
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.yzx;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(1.5, 1.5, 1.5) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
float u_xlat14;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat4.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat4.xy = u_xlat1.xy / u_xlat4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat8 = (-u_xlat4.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb12 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat8 = (u_xlatb12) ? 0.0 : u_xlat8;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat4.x = u_xlat12 * u_xlat4.x + u_xlat8;
    u_xlat1 = u_xlat4.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat4.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat4.x = _Turbulence / u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat0.x;
    u_xlat8 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * in_TANGENT0.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat4.xyz;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat12 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = u_xlat12 * 43758.5469;
    u_xlat12 = fract(u_xlat12);
    u_xlat12 = u_xlat12 * _JitterMultiplier;
    u_xlat12 = u_xlat12 * 0.0500000007 + 1.0;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat13 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * in_NORMAL0.zxy;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.zxy * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat13 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat13 = u_xlat13 * in_TEXCOORD0.z;
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat14 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat14);
    u_xlat14 = in_TEXCOORD0.x + -0.5;
    u_xlat14 = u_xlat14 + u_xlat14;
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.yzx;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(1.5, 1.5, 1.5) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
float u_xlat14;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat4.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat4.xy = u_xlat1.xy / u_xlat4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat8 = (-u_xlat4.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb12 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat8 = (u_xlatb12) ? 0.0 : u_xlat8;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat4.x = u_xlat12 * u_xlat4.x + u_xlat8;
    u_xlat1 = u_xlat4.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat4.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat4.x = _Turbulence / u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat0.x;
    u_xlat8 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * in_TANGENT0.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat4.xyz;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat12 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = u_xlat12 * 43758.5469;
    u_xlat12 = fract(u_xlat12);
    u_xlat12 = u_xlat12 * _JitterMultiplier;
    u_xlat12 = u_xlat12 * 0.0500000007 + 1.0;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat13 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * in_NORMAL0.zxy;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.zxy * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat13 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat13 = u_xlat13 * in_TEXCOORD0.z;
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat14 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat14);
    u_xlat14 = in_TEXCOORD0.x + -0.5;
    u_xlat14 = u_xlat14 + u_xlat14;
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.yzx;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(1.5, 1.5, 1.5) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = abs(_glesTANGENT.w);
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_4 = (tmpvar_5 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_6;
  tmpvar_6 = (_glesMultiTexCoord0.z * (tmpvar_3 + tmpvar_3));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(_glesNormal);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  highp float tmpvar_10;
  tmpvar_10 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_9.xyz = (((tmpvar_8 * 
    (tmpvar_10 + tmpvar_10)
  ) * tmpvar_6) * 1.5);
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - _glesVertex.xyz));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = ((tmpvar_8.yzx * tmpvar_11.zxy) - (tmpvar_8.zxy * tmpvar_11.yzx));
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = (((_glesVertex + tmpvar_9) + (
    ((tmpvar_12 * tmpvar_6) * (_glesTANGENT.w / tmpvar_3))
   * 
    (1.0 + ((fract(
      (sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))) * 43758.55)
    ) * _JitterMultiplier) * 0.05))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_4)) + (tmpvar_7 * 
    ((_Turbulence / max (0.5, tmpvar_3)) * tmpvar_4)
  ))).xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  highp float tmpvar_15;
  bool tmpvar_16;
  tmpvar_16 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_15 = ((float(tmpvar_16) * clamp (
    (tmpvar_5 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_16)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_15 * _GlowTintColor) * tmpvar_17);
  tmpvar_1.w = (tmpvar_1.w * _glesMultiTexCoord0.w);
  highp vec4 o_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_13.zw;
  tmpvar_2.xyw = o_18.xyw;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _glesVertex.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_21)).z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_GlowTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = abs(_glesTANGENT.w);
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_4 = (tmpvar_5 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_6;
  tmpvar_6 = (_glesMultiTexCoord0.z * (tmpvar_3 + tmpvar_3));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(_glesNormal);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  highp float tmpvar_10;
  tmpvar_10 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_9.xyz = (((tmpvar_8 * 
    (tmpvar_10 + tmpvar_10)
  ) * tmpvar_6) * 1.5);
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - _glesVertex.xyz));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = ((tmpvar_8.yzx * tmpvar_11.zxy) - (tmpvar_8.zxy * tmpvar_11.yzx));
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = (((_glesVertex + tmpvar_9) + (
    ((tmpvar_12 * tmpvar_6) * (_glesTANGENT.w / tmpvar_3))
   * 
    (1.0 + ((fract(
      (sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))) * 43758.55)
    ) * _JitterMultiplier) * 0.05))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_4)) + (tmpvar_7 * 
    ((_Turbulence / max (0.5, tmpvar_3)) * tmpvar_4)
  ))).xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  highp float tmpvar_15;
  bool tmpvar_16;
  tmpvar_16 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_15 = ((float(tmpvar_16) * clamp (
    (tmpvar_5 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_16)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_15 * _GlowTintColor) * tmpvar_17);
  tmpvar_1.w = (tmpvar_1.w * _glesMultiTexCoord0.w);
  highp vec4 o_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_13.zw;
  tmpvar_2.xyw = o_18.xyw;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _glesVertex.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_21)).z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_GlowTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _GlowTintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = abs(_glesTANGENT.w);
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_4 = (tmpvar_5 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp float tmpvar_6;
  tmpvar_6 = (_glesMultiTexCoord0.z * (tmpvar_3 + tmpvar_3));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(_glesNormal);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  highp float tmpvar_10;
  tmpvar_10 = (_glesMultiTexCoord0.x - 0.5);
  tmpvar_9.xyz = (((tmpvar_8 * 
    (tmpvar_10 + tmpvar_10)
  ) * tmpvar_6) * 1.5);
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - _glesVertex.xyz));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = ((tmpvar_8.yzx * tmpvar_11.zxy) - (tmpvar_8.zxy * tmpvar_11.yzx));
  highp vec4 tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = (((_glesVertex + tmpvar_9) + (
    ((tmpvar_12 * tmpvar_6) * (_glesTANGENT.w / tmpvar_3))
   * 
    (1.0 + ((fract(
      (sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432))) * 43758.55)
    ) * _JitterMultiplier) * 0.05))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_4)) + (tmpvar_7 * 
    ((_Turbulence / max (0.5, tmpvar_3)) * tmpvar_4)
  ))).xyz;
  tmpvar_13 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  highp float tmpvar_15;
  bool tmpvar_16;
  tmpvar_16 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_15 = ((float(tmpvar_16) * clamp (
    (tmpvar_5 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_16)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_15 * _GlowTintColor) * tmpvar_17);
  tmpvar_1.w = (tmpvar_1.w * _glesMultiTexCoord0.w);
  highp vec4 o_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_13 * 0.5);
  highp vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_18.xy = (tmpvar_20 + tmpvar_19.w);
  o_18.zw = tmpvar_13.zw;
  tmpvar_2.xyw = o_18.xyw;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = _glesVertex.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_21)).z);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = tmpvar_13;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _GlowTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_GlowTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
float u_xlat14;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat4.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat4.xy = u_xlat1.xy / u_xlat4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat8 = (-u_xlat4.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb12 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat8 = (u_xlatb12) ? 0.0 : u_xlat8;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat4.x = u_xlat12 * u_xlat4.x + u_xlat8;
    u_xlat1 = u_xlat4.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat4.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat4.x = _Turbulence / u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat0.x;
    u_xlat8 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * in_TANGENT0.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat4.xyz;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat12 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = u_xlat12 * 43758.5469;
    u_xlat12 = fract(u_xlat12);
    u_xlat12 = u_xlat12 * _JitterMultiplier;
    u_xlat12 = u_xlat12 * 0.0500000007 + 1.0;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat13 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * in_NORMAL0.zxy;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.zxy * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat13 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat13 = u_xlat13 * in_TEXCOORD0.z;
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat14 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat14);
    u_xlat14 = in_TEXCOORD0.x + -0.5;
    u_xlat14 = u_xlat14 + u_xlat14;
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.yzx;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(1.5, 1.5, 1.5) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat4.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
float u_xlat14;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat4.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat4.xy = u_xlat1.xy / u_xlat4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat8 = (-u_xlat4.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb12 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat8 = (u_xlatb12) ? 0.0 : u_xlat8;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat4.x = u_xlat12 * u_xlat4.x + u_xlat8;
    u_xlat1 = u_xlat4.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat4.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat4.x = _Turbulence / u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat0.x;
    u_xlat8 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * in_TANGENT0.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat4.xyz;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat12 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = u_xlat12 * 43758.5469;
    u_xlat12 = fract(u_xlat12);
    u_xlat12 = u_xlat12 * _JitterMultiplier;
    u_xlat12 = u_xlat12 * 0.0500000007 + 1.0;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat13 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * in_NORMAL0.zxy;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.zxy * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat13 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat13 = u_xlat13 * in_TEXCOORD0.z;
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat14 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat14);
    u_xlat14 = in_TEXCOORD0.x + -0.5;
    u_xlat14 = u_xlat14 + u_xlat14;
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.yzx;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(1.5, 1.5, 1.5) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat4.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _GlowTintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec3 in_NORMAL0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
vec3 u_xlat4;
float u_xlat8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
float u_xlat14;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat4.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat4.xy = u_xlat1.xy / u_xlat4.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat8 = (-u_xlat4.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb12 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat8 = (u_xlatb12) ? 0.0 : u_xlat8;
    u_xlat12 = u_xlatb12 ? 1.0 : float(0.0);
    u_xlat4.x = u_xlat12 * u_xlat4.x + u_xlat8;
    u_xlat1 = u_xlat4.xxxx * _GlowTintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat2.w = u_xlat1.x * in_TEXCOORD0.w;
    vs_COLOR0 = u_xlat2;
    u_xlat4.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat4.x = _Turbulence / u_xlat4.x;
    u_xlat4.x = u_xlat4.x * u_xlat0.x;
    u_xlat8 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat8 = inversesqrt(u_xlat8);
    u_xlat1.xyz = vec3(u_xlat8) * in_TANGENT0.xyz;
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat4.xyz;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat12 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat12 = sin(u_xlat12);
    u_xlat12 = u_xlat12 * 43758.5469;
    u_xlat12 = fract(u_xlat12);
    u_xlat12 = u_xlat12 * _JitterMultiplier;
    u_xlat12 = u_xlat12 * 0.0500000007 + 1.0;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat13 = dot(in_NORMAL0.xyz, in_NORMAL0.xyz);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.xyz = vec3(u_xlat13) * in_NORMAL0.zxy;
    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.xyz = u_xlat2.zxy * u_xlat1.yzx + (-u_xlat3.xyz);
    u_xlat13 = abs(in_TANGENT0.w) + abs(in_TANGENT0.w);
    u_xlat13 = u_xlat13 * in_TEXCOORD0.z;
    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
    u_xlat14 = in_TANGENT0.w / abs(in_TANGENT0.w);
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat14);
    u_xlat14 = in_TEXCOORD0.x + -0.5;
    u_xlat14 = u_xlat14 + u_xlat14;
    u_xlat2.xyz = vec3(u_xlat14) * u_xlat2.yzx;
    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
    u_xlat2.xyz = u_xlat2.xyz * vec3(1.5, 1.5, 1.5) + in_POSITION0.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat2.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat4.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat4.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _GlowTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_GlowTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
""
}
SubProgram "gles hw_tier01 " {
""
}
SubProgram "gles hw_tier02 " {
""
}
SubProgram "gles3 hw_tier00 " {
""
}
SubProgram "gles3 hw_tier01 " {
""
}
SubProgram "gles3 hw_tier02 " {
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "PERSPECTIVE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "PERSPECTIVE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "PERSPECTIVE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "PERSPECTIVE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "PERSPECTIVE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "PERSPECTIVE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
}
}
 Pass {
  Name "LINEPASS"
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "ALWAYS" "PreviewType" = "Plane" "QUEUE" = "Transparent+10" "RenderType" = "Transparent" }
  Blend Zero Zero, Zero Zero
  ZWrite Off
  Cull Off
  GpuProgramID 75453
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec2 tangent_1;
  lowp vec4 tmpvar_2;
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec2 tmpvar_5;
  tmpvar_5 = (((_TurbulenceVelocity * vec4(tmpvar_3)).xz + normalize(_glesTANGENT.xz)) * ((_Turbulence / 
    max (0.5, abs(_glesTANGENT.w))
  ) * tmpvar_3));
  highp vec4 tmpvar_6;
  tmpvar_6.yw = vec2(0.0, 0.0);
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.z = tmpvar_5.y;
  highp vec2 tmpvar_7;
  tmpvar_7.x = -(_glesTANGENT.z);
  tmpvar_7.y = _glesTANGENT.x;
  tangent_1 = (normalize(tmpvar_7) * _glesTANGENT.w);
  highp vec4 tmpvar_8;
  tmpvar_8.yw = vec2(0.0, 0.0);
  tmpvar_8.x = tangent_1.x;
  tmpvar_8.z = tangent_1.y;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = ((_glesVertex + (tmpvar_8 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + tmpvar_6).xyz;
  highp float tmpvar_10;
  bool tmpvar_11;
  tmpvar_11 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_10 = ((float(tmpvar_11) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_11)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesColor.xyz;
  tmpvar_2 = ((tmpvar_10 * _TintColor) * tmpvar_12);
  tmpvar_2.w = (tmpvar_2.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec2 tangent_1;
  lowp vec4 tmpvar_2;
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec2 tmpvar_5;
  tmpvar_5 = (((_TurbulenceVelocity * vec4(tmpvar_3)).xz + normalize(_glesTANGENT.xz)) * ((_Turbulence / 
    max (0.5, abs(_glesTANGENT.w))
  ) * tmpvar_3));
  highp vec4 tmpvar_6;
  tmpvar_6.yw = vec2(0.0, 0.0);
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.z = tmpvar_5.y;
  highp vec2 tmpvar_7;
  tmpvar_7.x = -(_glesTANGENT.z);
  tmpvar_7.y = _glesTANGENT.x;
  tangent_1 = (normalize(tmpvar_7) * _glesTANGENT.w);
  highp vec4 tmpvar_8;
  tmpvar_8.yw = vec2(0.0, 0.0);
  tmpvar_8.x = tangent_1.x;
  tmpvar_8.z = tangent_1.y;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = ((_glesVertex + (tmpvar_8 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + tmpvar_6).xyz;
  highp float tmpvar_10;
  bool tmpvar_11;
  tmpvar_11 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_10 = ((float(tmpvar_11) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_11)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesColor.xyz;
  tmpvar_2 = ((tmpvar_10 * _TintColor) * tmpvar_12);
  tmpvar_2.w = (tmpvar_2.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec2 tangent_1;
  lowp vec4 tmpvar_2;
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec2 tmpvar_5;
  tmpvar_5 = (((_TurbulenceVelocity * vec4(tmpvar_3)).xz + normalize(_glesTANGENT.xz)) * ((_Turbulence / 
    max (0.5, abs(_glesTANGENT.w))
  ) * tmpvar_3));
  highp vec4 tmpvar_6;
  tmpvar_6.yw = vec2(0.0, 0.0);
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.z = tmpvar_5.y;
  highp vec2 tmpvar_7;
  tmpvar_7.x = -(_glesTANGENT.z);
  tmpvar_7.y = _glesTANGENT.x;
  tangent_1 = (normalize(tmpvar_7) * _glesTANGENT.w);
  highp vec4 tmpvar_8;
  tmpvar_8.yw = vec2(0.0, 0.0);
  tmpvar_8.x = tangent_1.x;
  tmpvar_8.z = tangent_1.y;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = ((_glesVertex + (tmpvar_8 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + tmpvar_6).xyz;
  highp float tmpvar_10;
  bool tmpvar_11;
  tmpvar_11 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_10 = ((float(tmpvar_11) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_11)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesColor.xyz;
  tmpvar_2 = ((tmpvar_10 * _TintColor) * tmpvar_12);
  tmpvar_2.w = (tmpvar_2.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = dot(in_TANGENT0.xz, in_TANGENT0.xz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xy = u_xlat3.xx * in_TANGENT0.xz;
    u_xlat3.xy = u_xlat0.xx * _TurbulenceVelocity.xz + u_xlat3.xy;
    u_xlat9 = max(abs(in_TANGENT0.w), 0.5);
    u_xlat9 = _Turbulence / u_xlat9;
    u_xlat0.x = u_xlat9 * u_xlat0.x;
    u_xlat0.xz = u_xlat0.xx * u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xy = in_TANGENT0.zx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * in_TANGENT0.ww;
    u_xlat1.xz = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.y = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.y = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = dot(in_TANGENT0.xz, in_TANGENT0.xz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xy = u_xlat3.xx * in_TANGENT0.xz;
    u_xlat3.xy = u_xlat0.xx * _TurbulenceVelocity.xz + u_xlat3.xy;
    u_xlat9 = max(abs(in_TANGENT0.w), 0.5);
    u_xlat9 = _Turbulence / u_xlat9;
    u_xlat0.x = u_xlat9 * u_xlat0.x;
    u_xlat0.xz = u_xlat0.xx * u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xy = in_TANGENT0.zx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * in_TANGENT0.ww;
    u_xlat1.xz = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.y = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.y = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = dot(in_TANGENT0.xz, in_TANGENT0.xz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xy = u_xlat3.xx * in_TANGENT0.xz;
    u_xlat3.xy = u_xlat0.xx * _TurbulenceVelocity.xz + u_xlat3.xy;
    u_xlat9 = max(abs(in_TANGENT0.w), 0.5);
    u_xlat9 = _Turbulence / u_xlat9;
    u_xlat0.x = u_xlat9 * u_xlat0.x;
    u_xlat0.xz = u_xlat0.xx * u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xy = in_TANGENT0.zx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * in_TANGENT0.ww;
    u_xlat1.xz = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.y = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.y = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tangent_1;
  lowp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_4 = (tmpvar_5 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec2 tmpvar_6;
  tmpvar_6 = (((_TurbulenceVelocity * vec4(tmpvar_4)).xz + normalize(_glesTANGENT.xz)) * ((_Turbulence / 
    max (0.5, abs(_glesTANGENT.w))
  ) * tmpvar_4));
  highp vec4 tmpvar_7;
  tmpvar_7.yw = vec2(0.0, 0.0);
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.z = tmpvar_6.y;
  highp vec2 tmpvar_8;
  tmpvar_8.x = -(_glesTANGENT.z);
  tmpvar_8.y = _glesTANGENT.x;
  tangent_1 = (normalize(tmpvar_8) * _glesTANGENT.w);
  highp vec4 tmpvar_9;
  tmpvar_9.yw = vec2(0.0, 0.0);
  tmpvar_9.x = tangent_1.x;
  tmpvar_9.z = tangent_1.y;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = ((_glesVertex + (tmpvar_9 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + tmpvar_7).xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp float tmpvar_12;
  bool tmpvar_13;
  tmpvar_13 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_12 = ((float(tmpvar_13) * clamp (
    (tmpvar_5 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_13)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesColor.xyz;
  tmpvar_2 = ((tmpvar_12 * _TintColor) * tmpvar_14);
  highp vec4 o_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = (tmpvar_16.y * _ProjectionParams.x);
  o_15.xy = (tmpvar_17 + tmpvar_16.w);
  o_15.zw = tmpvar_10.zw;
  tmpvar_3.xyw = o_15.xyw;
  highp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = _glesVertex.xyz;
  tmpvar_3.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_18)).z);
  tmpvar_2.w = (tmpvar_2.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_2;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_MainTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tangent_1;
  lowp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_4 = (tmpvar_5 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec2 tmpvar_6;
  tmpvar_6 = (((_TurbulenceVelocity * vec4(tmpvar_4)).xz + normalize(_glesTANGENT.xz)) * ((_Turbulence / 
    max (0.5, abs(_glesTANGENT.w))
  ) * tmpvar_4));
  highp vec4 tmpvar_7;
  tmpvar_7.yw = vec2(0.0, 0.0);
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.z = tmpvar_6.y;
  highp vec2 tmpvar_8;
  tmpvar_8.x = -(_glesTANGENT.z);
  tmpvar_8.y = _glesTANGENT.x;
  tangent_1 = (normalize(tmpvar_8) * _glesTANGENT.w);
  highp vec4 tmpvar_9;
  tmpvar_9.yw = vec2(0.0, 0.0);
  tmpvar_9.x = tangent_1.x;
  tmpvar_9.z = tangent_1.y;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = ((_glesVertex + (tmpvar_9 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + tmpvar_7).xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp float tmpvar_12;
  bool tmpvar_13;
  tmpvar_13 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_12 = ((float(tmpvar_13) * clamp (
    (tmpvar_5 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_13)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesColor.xyz;
  tmpvar_2 = ((tmpvar_12 * _TintColor) * tmpvar_14);
  highp vec4 o_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = (tmpvar_16.y * _ProjectionParams.x);
  o_15.xy = (tmpvar_17 + tmpvar_16.w);
  o_15.zw = tmpvar_10.zw;
  tmpvar_3.xyw = o_15.xyw;
  highp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = _glesVertex.xyz;
  tmpvar_3.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_18)).z);
  tmpvar_2.w = (tmpvar_2.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_2;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_MainTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tangent_1;
  lowp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_4 = (tmpvar_5 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec2 tmpvar_6;
  tmpvar_6 = (((_TurbulenceVelocity * vec4(tmpvar_4)).xz + normalize(_glesTANGENT.xz)) * ((_Turbulence / 
    max (0.5, abs(_glesTANGENT.w))
  ) * tmpvar_4));
  highp vec4 tmpvar_7;
  tmpvar_7.yw = vec2(0.0, 0.0);
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.z = tmpvar_6.y;
  highp vec2 tmpvar_8;
  tmpvar_8.x = -(_glesTANGENT.z);
  tmpvar_8.y = _glesTANGENT.x;
  tangent_1 = (normalize(tmpvar_8) * _glesTANGENT.w);
  highp vec4 tmpvar_9;
  tmpvar_9.yw = vec2(0.0, 0.0);
  tmpvar_9.x = tangent_1.x;
  tmpvar_9.z = tangent_1.y;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = ((_glesVertex + (tmpvar_9 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + tmpvar_7).xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp float tmpvar_12;
  bool tmpvar_13;
  tmpvar_13 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_12 = ((float(tmpvar_13) * clamp (
    (tmpvar_5 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_13)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesColor.xyz;
  tmpvar_2 = ((tmpvar_12 * _TintColor) * tmpvar_14);
  highp vec4 o_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = (tmpvar_16.y * _ProjectionParams.x);
  o_15.xy = (tmpvar_17 + tmpvar_16.w);
  o_15.zw = tmpvar_10.zw;
  tmpvar_3.xyw = o_15.xyw;
  highp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = _glesVertex.xyz;
  tmpvar_3.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_18)).z);
  tmpvar_2.w = (tmpvar_2.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_2;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_MainTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = dot(in_TANGENT0.xz, in_TANGENT0.xz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xy = u_xlat3.xx * in_TANGENT0.xz;
    u_xlat3.xy = u_xlat0.xx * _TurbulenceVelocity.xz + u_xlat3.xy;
    u_xlat9 = max(abs(in_TANGENT0.w), 0.5);
    u_xlat9 = _Turbulence / u_xlat9;
    u_xlat0.x = u_xlat9 * u_xlat0.x;
    u_xlat0.xz = u_xlat0.xx * u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xy = in_TANGENT0.zx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * in_TANGENT0.ww;
    u_xlat1.xz = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.y = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.y = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = dot(in_TANGENT0.xz, in_TANGENT0.xz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xy = u_xlat3.xx * in_TANGENT0.xz;
    u_xlat3.xy = u_xlat0.xx * _TurbulenceVelocity.xz + u_xlat3.xy;
    u_xlat9 = max(abs(in_TANGENT0.w), 0.5);
    u_xlat9 = _Turbulence / u_xlat9;
    u_xlat0.x = u_xlat9 * u_xlat0.x;
    u_xlat0.xz = u_xlat0.xx * u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xy = in_TANGENT0.zx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * in_TANGENT0.ww;
    u_xlat1.xz = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.y = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.y = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = dot(in_TANGENT0.xz, in_TANGENT0.xz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xy = u_xlat3.xx * in_TANGENT0.xz;
    u_xlat3.xy = u_xlat0.xx * _TurbulenceVelocity.xz + u_xlat3.xy;
    u_xlat9 = max(abs(in_TANGENT0.w), 0.5);
    u_xlat9 = _Turbulence / u_xlat9;
    u_xlat0.x = u_xlat9 * u_xlat0.x;
    u_xlat0.xz = u_xlat0.xx * u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xy = in_TANGENT0.zx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * in_TANGENT0.ww;
    u_xlat1.xz = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.y = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.y = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec2 tangent_1;
  lowp vec4 tmpvar_2;
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec2 tmpvar_5;
  tmpvar_5 = (((_TurbulenceVelocity * vec4(tmpvar_3)).xz + normalize(_glesTANGENT.xz)) * ((_Turbulence / 
    max (0.5, abs(_glesTANGENT.w))
  ) * tmpvar_3));
  highp vec4 tmpvar_6;
  tmpvar_6.yw = vec2(0.0, 0.0);
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.z = tmpvar_5.y;
  highp vec2 tmpvar_7;
  tmpvar_7.x = -(_glesTANGENT.z);
  tmpvar_7.y = _glesTANGENT.x;
  tangent_1 = (normalize(tmpvar_7) * _glesTANGENT.w);
  highp vec4 tmpvar_8;
  tmpvar_8.yw = vec2(0.0, 0.0);
  tmpvar_8.x = tangent_1.x;
  tmpvar_8.z = tangent_1.y;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = ((_glesVertex + (tmpvar_8 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + tmpvar_6).xyz;
  highp float tmpvar_10;
  bool tmpvar_11;
  tmpvar_11 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_10 = ((float(tmpvar_11) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_11)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesColor.xyz;
  tmpvar_2 = ((tmpvar_10 * _TintColor) * tmpvar_12);
  tmpvar_2.w = (tmpvar_2.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec2 tangent_1;
  lowp vec4 tmpvar_2;
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec2 tmpvar_5;
  tmpvar_5 = (((_TurbulenceVelocity * vec4(tmpvar_3)).xz + normalize(_glesTANGENT.xz)) * ((_Turbulence / 
    max (0.5, abs(_glesTANGENT.w))
  ) * tmpvar_3));
  highp vec4 tmpvar_6;
  tmpvar_6.yw = vec2(0.0, 0.0);
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.z = tmpvar_5.y;
  highp vec2 tmpvar_7;
  tmpvar_7.x = -(_glesTANGENT.z);
  tmpvar_7.y = _glesTANGENT.x;
  tangent_1 = (normalize(tmpvar_7) * _glesTANGENT.w);
  highp vec4 tmpvar_8;
  tmpvar_8.yw = vec2(0.0, 0.0);
  tmpvar_8.x = tangent_1.x;
  tmpvar_8.z = tangent_1.y;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = ((_glesVertex + (tmpvar_8 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + tmpvar_6).xyz;
  highp float tmpvar_10;
  bool tmpvar_11;
  tmpvar_11 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_10 = ((float(tmpvar_11) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_11)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesColor.xyz;
  tmpvar_2 = ((tmpvar_10 * _TintColor) * tmpvar_12);
  tmpvar_2.w = (tmpvar_2.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec2 tangent_1;
  lowp vec4 tmpvar_2;
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec2 tmpvar_5;
  tmpvar_5 = (((_TurbulenceVelocity * vec4(tmpvar_3)).xz + normalize(_glesTANGENT.xz)) * ((_Turbulence / 
    max (0.5, abs(_glesTANGENT.w))
  ) * tmpvar_3));
  highp vec4 tmpvar_6;
  tmpvar_6.yw = vec2(0.0, 0.0);
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.z = tmpvar_5.y;
  highp vec2 tmpvar_7;
  tmpvar_7.x = -(_glesTANGENT.z);
  tmpvar_7.y = _glesTANGENT.x;
  tangent_1 = (normalize(tmpvar_7) * _glesTANGENT.w);
  highp vec4 tmpvar_8;
  tmpvar_8.yw = vec2(0.0, 0.0);
  tmpvar_8.x = tangent_1.x;
  tmpvar_8.z = tangent_1.y;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = ((_glesVertex + (tmpvar_8 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + tmpvar_6).xyz;
  highp float tmpvar_10;
  bool tmpvar_11;
  tmpvar_11 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_10 = ((float(tmpvar_11) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_11)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesColor.xyz;
  tmpvar_2 = ((tmpvar_10 * _TintColor) * tmpvar_12);
  tmpvar_2.w = (tmpvar_2.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_2;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = dot(in_TANGENT0.xz, in_TANGENT0.xz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xy = u_xlat3.xx * in_TANGENT0.xz;
    u_xlat3.xy = u_xlat0.xx * _TurbulenceVelocity.xz + u_xlat3.xy;
    u_xlat9 = max(abs(in_TANGENT0.w), 0.5);
    u_xlat9 = _Turbulence / u_xlat9;
    u_xlat0.x = u_xlat9 * u_xlat0.x;
    u_xlat0.xz = u_xlat0.xx * u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xy = in_TANGENT0.zx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * in_TANGENT0.ww;
    u_xlat1.xz = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.y = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.y = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = dot(in_TANGENT0.xz, in_TANGENT0.xz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xy = u_xlat3.xx * in_TANGENT0.xz;
    u_xlat3.xy = u_xlat0.xx * _TurbulenceVelocity.xz + u_xlat3.xy;
    u_xlat9 = max(abs(in_TANGENT0.w), 0.5);
    u_xlat9 = _Turbulence / u_xlat9;
    u_xlat0.x = u_xlat9 * u_xlat0.x;
    u_xlat0.xz = u_xlat0.xx * u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xy = in_TANGENT0.zx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * in_TANGENT0.ww;
    u_xlat1.xz = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.y = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.y = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = dot(in_TANGENT0.xz, in_TANGENT0.xz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xy = u_xlat3.xx * in_TANGENT0.xz;
    u_xlat3.xy = u_xlat0.xx * _TurbulenceVelocity.xz + u_xlat3.xy;
    u_xlat9 = max(abs(in_TANGENT0.w), 0.5);
    u_xlat9 = _Turbulence / u_xlat9;
    u_xlat0.x = u_xlat9 * u_xlat0.x;
    u_xlat0.xz = u_xlat0.xx * u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xy = in_TANGENT0.zx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * in_TANGENT0.ww;
    u_xlat1.xz = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.y = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.y = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tangent_1;
  lowp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_4 = (tmpvar_5 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec2 tmpvar_6;
  tmpvar_6 = (((_TurbulenceVelocity * vec4(tmpvar_4)).xz + normalize(_glesTANGENT.xz)) * ((_Turbulence / 
    max (0.5, abs(_glesTANGENT.w))
  ) * tmpvar_4));
  highp vec4 tmpvar_7;
  tmpvar_7.yw = vec2(0.0, 0.0);
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.z = tmpvar_6.y;
  highp vec2 tmpvar_8;
  tmpvar_8.x = -(_glesTANGENT.z);
  tmpvar_8.y = _glesTANGENT.x;
  tangent_1 = (normalize(tmpvar_8) * _glesTANGENT.w);
  highp vec4 tmpvar_9;
  tmpvar_9.yw = vec2(0.0, 0.0);
  tmpvar_9.x = tangent_1.x;
  tmpvar_9.z = tangent_1.y;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = ((_glesVertex + (tmpvar_9 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + tmpvar_7).xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp float tmpvar_12;
  bool tmpvar_13;
  tmpvar_13 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_12 = ((float(tmpvar_13) * clamp (
    (tmpvar_5 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_13)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesColor.xyz;
  tmpvar_2 = ((tmpvar_12 * _TintColor) * tmpvar_14);
  highp vec4 o_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = (tmpvar_16.y * _ProjectionParams.x);
  o_15.xy = (tmpvar_17 + tmpvar_16.w);
  o_15.zw = tmpvar_10.zw;
  tmpvar_3.xyw = o_15.xyw;
  highp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = _glesVertex.xyz;
  tmpvar_3.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_18)).z);
  tmpvar_2.w = (tmpvar_2.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_2;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_MainTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tangent_1;
  lowp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_4 = (tmpvar_5 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec2 tmpvar_6;
  tmpvar_6 = (((_TurbulenceVelocity * vec4(tmpvar_4)).xz + normalize(_glesTANGENT.xz)) * ((_Turbulence / 
    max (0.5, abs(_glesTANGENT.w))
  ) * tmpvar_4));
  highp vec4 tmpvar_7;
  tmpvar_7.yw = vec2(0.0, 0.0);
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.z = tmpvar_6.y;
  highp vec2 tmpvar_8;
  tmpvar_8.x = -(_glesTANGENT.z);
  tmpvar_8.y = _glesTANGENT.x;
  tangent_1 = (normalize(tmpvar_8) * _glesTANGENT.w);
  highp vec4 tmpvar_9;
  tmpvar_9.yw = vec2(0.0, 0.0);
  tmpvar_9.x = tangent_1.x;
  tmpvar_9.z = tangent_1.y;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = ((_glesVertex + (tmpvar_9 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + tmpvar_7).xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp float tmpvar_12;
  bool tmpvar_13;
  tmpvar_13 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_12 = ((float(tmpvar_13) * clamp (
    (tmpvar_5 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_13)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesColor.xyz;
  tmpvar_2 = ((tmpvar_12 * _TintColor) * tmpvar_14);
  highp vec4 o_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = (tmpvar_16.y * _ProjectionParams.x);
  o_15.xy = (tmpvar_17 + tmpvar_16.w);
  o_15.zw = tmpvar_10.zw;
  tmpvar_3.xyw = o_15.xyw;
  highp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = _glesVertex.xyz;
  tmpvar_3.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_18)).z);
  tmpvar_2.w = (tmpvar_2.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_2;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_MainTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tangent_1;
  lowp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_4 = (tmpvar_5 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec2 tmpvar_6;
  tmpvar_6 = (((_TurbulenceVelocity * vec4(tmpvar_4)).xz + normalize(_glesTANGENT.xz)) * ((_Turbulence / 
    max (0.5, abs(_glesTANGENT.w))
  ) * tmpvar_4));
  highp vec4 tmpvar_7;
  tmpvar_7.yw = vec2(0.0, 0.0);
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.z = tmpvar_6.y;
  highp vec2 tmpvar_8;
  tmpvar_8.x = -(_glesTANGENT.z);
  tmpvar_8.y = _glesTANGENT.x;
  tangent_1 = (normalize(tmpvar_8) * _glesTANGENT.w);
  highp vec4 tmpvar_9;
  tmpvar_9.yw = vec2(0.0, 0.0);
  tmpvar_9.x = tangent_1.x;
  tmpvar_9.z = tangent_1.y;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = ((_glesVertex + (tmpvar_9 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + tmpvar_7).xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp float tmpvar_12;
  bool tmpvar_13;
  tmpvar_13 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_12 = ((float(tmpvar_13) * clamp (
    (tmpvar_5 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_13)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = _glesColor.xyz;
  tmpvar_2 = ((tmpvar_12 * _TintColor) * tmpvar_14);
  highp vec4 o_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = (tmpvar_16.y * _ProjectionParams.x);
  o_15.xy = (tmpvar_17 + tmpvar_16.w);
  o_15.zw = tmpvar_10.zw;
  tmpvar_3.xyw = o_15.xyw;
  highp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = _glesVertex.xyz;
  tmpvar_3.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_18)).z);
  tmpvar_2.w = (tmpvar_2.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_2;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD1 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_MainTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = dot(in_TANGENT0.xz, in_TANGENT0.xz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xy = u_xlat3.xx * in_TANGENT0.xz;
    u_xlat3.xy = u_xlat0.xx * _TurbulenceVelocity.xz + u_xlat3.xy;
    u_xlat9 = max(abs(in_TANGENT0.w), 0.5);
    u_xlat9 = _Turbulence / u_xlat9;
    u_xlat0.x = u_xlat9 * u_xlat0.x;
    u_xlat0.xz = u_xlat0.xx * u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xy = in_TANGENT0.zx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * in_TANGENT0.ww;
    u_xlat1.xz = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.y = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.y = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = dot(in_TANGENT0.xz, in_TANGENT0.xz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xy = u_xlat3.xx * in_TANGENT0.xz;
    u_xlat3.xy = u_xlat0.xx * _TurbulenceVelocity.xz + u_xlat3.xy;
    u_xlat9 = max(abs(in_TANGENT0.w), 0.5);
    u_xlat9 = _Turbulence / u_xlat9;
    u_xlat0.x = u_xlat9 * u_xlat0.x;
    u_xlat0.xz = u_xlat0.xx * u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xy = in_TANGENT0.zx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * in_TANGENT0.ww;
    u_xlat1.xz = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.y = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.y = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = dot(in_TANGENT0.xz, in_TANGENT0.xz);
    u_xlat3.x = inversesqrt(u_xlat3.x);
    u_xlat3.xy = u_xlat3.xx * in_TANGENT0.xz;
    u_xlat3.xy = u_xlat0.xx * _TurbulenceVelocity.xz + u_xlat3.xy;
    u_xlat9 = max(abs(in_TANGENT0.w), 0.5);
    u_xlat9 = _Turbulence / u_xlat9;
    u_xlat0.x = u_xlat9 * u_xlat0.x;
    u_xlat0.xz = u_xlat0.xx * u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xy = in_TANGENT0.zx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * in_TANGENT0.ww;
    u_xlat1.xz = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.y = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.y = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ORTHOGRAPHIC_XY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_2 = (tmpvar_3 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.xy = (_TurbulenceVelocity * vec4(tmpvar_2)).xy;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = normalize(_glesTANGENT).xy;
  highp vec2 tmpvar_6;
  tmpvar_6.x = -(_glesTANGENT.y);
  tmpvar_6.y = _glesTANGENT.x;
  highp vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = (normalize(tmpvar_6) * _glesTANGENT.w);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = ((_glesVertex + (tmpvar_7 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + (tmpvar_4 + (tmpvar_5 * 
    ((_Turbulence / max (0.5, abs(_glesTANGENT.w))) * tmpvar_2)
  ))).xyz;
  highp float tmpvar_9;
  bool tmpvar_10;
  tmpvar_10 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_9 = ((float(tmpvar_10) * clamp (
    (tmpvar_3 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_10)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_9 * _TintColor) * tmpvar_11);
  tmpvar_1.w = (tmpvar_1.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ORTHOGRAPHIC_XY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_2 = (tmpvar_3 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.xy = (_TurbulenceVelocity * vec4(tmpvar_2)).xy;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = normalize(_glesTANGENT).xy;
  highp vec2 tmpvar_6;
  tmpvar_6.x = -(_glesTANGENT.y);
  tmpvar_6.y = _glesTANGENT.x;
  highp vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = (normalize(tmpvar_6) * _glesTANGENT.w);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = ((_glesVertex + (tmpvar_7 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + (tmpvar_4 + (tmpvar_5 * 
    ((_Turbulence / max (0.5, abs(_glesTANGENT.w))) * tmpvar_2)
  ))).xyz;
  highp float tmpvar_9;
  bool tmpvar_10;
  tmpvar_10 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_9 = ((float(tmpvar_10) * clamp (
    (tmpvar_3 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_10)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_9 * _TintColor) * tmpvar_11);
  tmpvar_1.w = (tmpvar_1.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ORTHOGRAPHIC_XY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_2 = (tmpvar_3 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.xy = (_TurbulenceVelocity * vec4(tmpvar_2)).xy;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = normalize(_glesTANGENT).xy;
  highp vec2 tmpvar_6;
  tmpvar_6.x = -(_glesTANGENT.y);
  tmpvar_6.y = _glesTANGENT.x;
  highp vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = (normalize(tmpvar_6) * _glesTANGENT.w);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = ((_glesVertex + (tmpvar_7 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + (tmpvar_4 + (tmpvar_5 * 
    ((_Turbulence / max (0.5, abs(_glesTANGENT.w))) * tmpvar_2)
  ))).xyz;
  highp float tmpvar_9;
  bool tmpvar_10;
  tmpvar_10 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_9 = ((float(tmpvar_10) * clamp (
    (tmpvar_3 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_10)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_9 * _TintColor) * tmpvar_11);
  tmpvar_1.w = (tmpvar_1.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ORTHOGRAPHIC_XY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6.x = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6.x = (u_xlatb9) ? 0.0 : u_xlat6.x;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6.x;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6.x = dot(in_TANGENT0, in_TANGENT0);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xy = u_xlat6.xx * in_TANGENT0.xy;
    u_xlat3.xy = u_xlat3.xx * u_xlat6.xy;
    u_xlat0.xy = u_xlat0.xx * _TurbulenceVelocity.xy + u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xy = in_TANGENT0.yx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * in_TANGENT0.ww;
    u_xlat1.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ORTHOGRAPHIC_XY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6.x = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6.x = (u_xlatb9) ? 0.0 : u_xlat6.x;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6.x;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6.x = dot(in_TANGENT0, in_TANGENT0);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xy = u_xlat6.xx * in_TANGENT0.xy;
    u_xlat3.xy = u_xlat3.xx * u_xlat6.xy;
    u_xlat0.xy = u_xlat0.xx * _TurbulenceVelocity.xy + u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xy = in_TANGENT0.yx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * in_TANGENT0.ww;
    u_xlat1.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ORTHOGRAPHIC_XY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6.x = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6.x = (u_xlatb9) ? 0.0 : u_xlat6.x;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6.x;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6.x = dot(in_TANGENT0, in_TANGENT0);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xy = u_xlat6.xx * in_TANGENT0.xy;
    u_xlat3.xy = u_xlat3.xx * u_xlat6.xy;
    u_xlat0.xy = u_xlat0.xx * _TurbulenceVelocity.xy + u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xy = in_TANGENT0.yx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * in_TANGENT0.ww;
    u_xlat1.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = (_TurbulenceVelocity * vec4(tmpvar_3)).xy;
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(0.0, 0.0);
  tmpvar_6.xy = normalize(_glesTANGENT).xy;
  highp vec2 tmpvar_7;
  tmpvar_7.x = -(_glesTANGENT.y);
  tmpvar_7.y = _glesTANGENT.x;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(0.0, 0.0);
  tmpvar_8.xy = (normalize(tmpvar_7) * _glesTANGENT.w);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = ((_glesVertex + (tmpvar_8 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + (tmpvar_5 + (tmpvar_6 * 
    ((_Turbulence / max (0.5, abs(_glesTANGENT.w))) * tmpvar_3)
  ))).xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  highp float tmpvar_11;
  bool tmpvar_12;
  tmpvar_12 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_11 = ((float(tmpvar_12) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_12)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_11 * _TintColor) * tmpvar_13);
  highp vec4 o_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_9.zw;
  tmpvar_2.xyw = o_14.xyw;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesVertex.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_17)).z);
  tmpvar_1.w = (tmpvar_1.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_MainTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = (_TurbulenceVelocity * vec4(tmpvar_3)).xy;
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(0.0, 0.0);
  tmpvar_6.xy = normalize(_glesTANGENT).xy;
  highp vec2 tmpvar_7;
  tmpvar_7.x = -(_glesTANGENT.y);
  tmpvar_7.y = _glesTANGENT.x;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(0.0, 0.0);
  tmpvar_8.xy = (normalize(tmpvar_7) * _glesTANGENT.w);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = ((_glesVertex + (tmpvar_8 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + (tmpvar_5 + (tmpvar_6 * 
    ((_Turbulence / max (0.5, abs(_glesTANGENT.w))) * tmpvar_3)
  ))).xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  highp float tmpvar_11;
  bool tmpvar_12;
  tmpvar_12 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_11 = ((float(tmpvar_12) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_12)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_11 * _TintColor) * tmpvar_13);
  highp vec4 o_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_9.zw;
  tmpvar_2.xyw = o_14.xyw;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesVertex.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_17)).z);
  tmpvar_1.w = (tmpvar_1.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_MainTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = (_TurbulenceVelocity * vec4(tmpvar_3)).xy;
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(0.0, 0.0);
  tmpvar_6.xy = normalize(_glesTANGENT).xy;
  highp vec2 tmpvar_7;
  tmpvar_7.x = -(_glesTANGENT.y);
  tmpvar_7.y = _glesTANGENT.x;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(0.0, 0.0);
  tmpvar_8.xy = (normalize(tmpvar_7) * _glesTANGENT.w);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = ((_glesVertex + (tmpvar_8 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + (tmpvar_5 + (tmpvar_6 * 
    ((_Turbulence / max (0.5, abs(_glesTANGENT.w))) * tmpvar_3)
  ))).xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  highp float tmpvar_11;
  bool tmpvar_12;
  tmpvar_12 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_11 = ((float(tmpvar_12) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_12)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_11 * _TintColor) * tmpvar_13);
  highp vec4 o_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_9.zw;
  tmpvar_2.xyw = o_14.xyw;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesVertex.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_17)).z);
  tmpvar_1.w = (tmpvar_1.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_MainTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6.x = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6.x = (u_xlatb9) ? 0.0 : u_xlat6.x;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6.x;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6.x = dot(in_TANGENT0, in_TANGENT0);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xy = u_xlat6.xx * in_TANGENT0.xy;
    u_xlat3.xy = u_xlat3.xx * u_xlat6.xy;
    u_xlat0.xy = u_xlat0.xx * _TurbulenceVelocity.xy + u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xy = in_TANGENT0.yx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * in_TANGENT0.ww;
    u_xlat1.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6.x = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6.x = (u_xlatb9) ? 0.0 : u_xlat6.x;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6.x;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6.x = dot(in_TANGENT0, in_TANGENT0);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xy = u_xlat6.xx * in_TANGENT0.xy;
    u_xlat3.xy = u_xlat3.xx * u_xlat6.xy;
    u_xlat0.xy = u_xlat0.xx * _TurbulenceVelocity.xy + u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xy = in_TANGENT0.yx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * in_TANGENT0.ww;
    u_xlat1.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6.x = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6.x = (u_xlatb9) ? 0.0 : u_xlat6.x;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6.x;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6.x = dot(in_TANGENT0, in_TANGENT0);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xy = u_xlat6.xx * in_TANGENT0.xy;
    u_xlat3.xy = u_xlat3.xx * u_xlat6.xy;
    u_xlat0.xy = u_xlat0.xx * _TurbulenceVelocity.xy + u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xy = in_TANGENT0.yx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * in_TANGENT0.ww;
    u_xlat1.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_2 = (tmpvar_3 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.xy = (_TurbulenceVelocity * vec4(tmpvar_2)).xy;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = normalize(_glesTANGENT).xy;
  highp vec2 tmpvar_6;
  tmpvar_6.x = -(_glesTANGENT.y);
  tmpvar_6.y = _glesTANGENT.x;
  highp vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = (normalize(tmpvar_6) * _glesTANGENT.w);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = ((_glesVertex + (tmpvar_7 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + (tmpvar_4 + (tmpvar_5 * 
    ((_Turbulence / max (0.5, abs(_glesTANGENT.w))) * tmpvar_2)
  ))).xyz;
  highp float tmpvar_9;
  bool tmpvar_10;
  tmpvar_10 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_9 = ((float(tmpvar_10) * clamp (
    (tmpvar_3 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_10)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_9 * _TintColor) * tmpvar_11);
  tmpvar_1.w = (tmpvar_1.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_2 = (tmpvar_3 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.xy = (_TurbulenceVelocity * vec4(tmpvar_2)).xy;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = normalize(_glesTANGENT).xy;
  highp vec2 tmpvar_6;
  tmpvar_6.x = -(_glesTANGENT.y);
  tmpvar_6.y = _glesTANGENT.x;
  highp vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = (normalize(tmpvar_6) * _glesTANGENT.w);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = ((_glesVertex + (tmpvar_7 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + (tmpvar_4 + (tmpvar_5 * 
    ((_Turbulence / max (0.5, abs(_glesTANGENT.w))) * tmpvar_2)
  ))).xyz;
  highp float tmpvar_9;
  bool tmpvar_10;
  tmpvar_10 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_9 = ((float(tmpvar_10) * clamp (
    (tmpvar_3 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_10)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_9 * _TintColor) * tmpvar_11);
  tmpvar_1.w = (tmpvar_1.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_2 = (tmpvar_3 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.xy = (_TurbulenceVelocity * vec4(tmpvar_2)).xy;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = normalize(_glesTANGENT).xy;
  highp vec2 tmpvar_6;
  tmpvar_6.x = -(_glesTANGENT.y);
  tmpvar_6.y = _glesTANGENT.x;
  highp vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = (normalize(tmpvar_6) * _glesTANGENT.w);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = ((_glesVertex + (tmpvar_7 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + (tmpvar_4 + (tmpvar_5 * 
    ((_Turbulence / max (0.5, abs(_glesTANGENT.w))) * tmpvar_2)
  ))).xyz;
  highp float tmpvar_9;
  bool tmpvar_10;
  tmpvar_10 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_9 = ((float(tmpvar_10) * clamp (
    (tmpvar_3 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_10)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_9 * _TintColor) * tmpvar_11);
  tmpvar_1.w = (tmpvar_1.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6.x = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6.x = (u_xlatb9) ? 0.0 : u_xlat6.x;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6.x;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6.x = dot(in_TANGENT0, in_TANGENT0);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xy = u_xlat6.xx * in_TANGENT0.xy;
    u_xlat3.xy = u_xlat3.xx * u_xlat6.xy;
    u_xlat0.xy = u_xlat0.xx * _TurbulenceVelocity.xy + u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xy = in_TANGENT0.yx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * in_TANGENT0.ww;
    u_xlat1.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6.x = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6.x = (u_xlatb9) ? 0.0 : u_xlat6.x;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6.x;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6.x = dot(in_TANGENT0, in_TANGENT0);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xy = u_xlat6.xx * in_TANGENT0.xy;
    u_xlat3.xy = u_xlat3.xx * u_xlat6.xy;
    u_xlat0.xy = u_xlat0.xx * _TurbulenceVelocity.xy + u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xy = in_TANGENT0.yx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * in_TANGENT0.ww;
    u_xlat1.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6.x = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6.x = (u_xlatb9) ? 0.0 : u_xlat6.x;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6.x;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6.x = dot(in_TANGENT0, in_TANGENT0);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xy = u_xlat6.xx * in_TANGENT0.xy;
    u_xlat3.xy = u_xlat3.xx * u_xlat6.xy;
    u_xlat0.xy = u_xlat0.xx * _TurbulenceVelocity.xy + u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xy = in_TANGENT0.yx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * in_TANGENT0.ww;
    u_xlat1.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = (_TurbulenceVelocity * vec4(tmpvar_3)).xy;
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(0.0, 0.0);
  tmpvar_6.xy = normalize(_glesTANGENT).xy;
  highp vec2 tmpvar_7;
  tmpvar_7.x = -(_glesTANGENT.y);
  tmpvar_7.y = _glesTANGENT.x;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(0.0, 0.0);
  tmpvar_8.xy = (normalize(tmpvar_7) * _glesTANGENT.w);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = ((_glesVertex + (tmpvar_8 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + (tmpvar_5 + (tmpvar_6 * 
    ((_Turbulence / max (0.5, abs(_glesTANGENT.w))) * tmpvar_3)
  ))).xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  highp float tmpvar_11;
  bool tmpvar_12;
  tmpvar_12 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_11 = ((float(tmpvar_12) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_12)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_11 * _TintColor) * tmpvar_13);
  highp vec4 o_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_9.zw;
  tmpvar_2.xyw = o_14.xyw;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesVertex.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_17)).z);
  tmpvar_1.w = (tmpvar_1.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_MainTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = (_TurbulenceVelocity * vec4(tmpvar_3)).xy;
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(0.0, 0.0);
  tmpvar_6.xy = normalize(_glesTANGENT).xy;
  highp vec2 tmpvar_7;
  tmpvar_7.x = -(_glesTANGENT.y);
  tmpvar_7.y = _glesTANGENT.x;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(0.0, 0.0);
  tmpvar_8.xy = (normalize(tmpvar_7) * _glesTANGENT.w);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = ((_glesVertex + (tmpvar_8 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + (tmpvar_5 + (tmpvar_6 * 
    ((_Turbulence / max (0.5, abs(_glesTANGENT.w))) * tmpvar_3)
  ))).xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  highp float tmpvar_11;
  bool tmpvar_12;
  tmpvar_12 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_11 = ((float(tmpvar_12) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_12)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_11 * _TintColor) * tmpvar_13);
  highp vec4 o_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_9.zw;
  tmpvar_2.xyw = o_14.xyw;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesVertex.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_17)).z);
  tmpvar_1.w = (tmpvar_1.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_MainTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = (_TurbulenceVelocity * vec4(tmpvar_3)).xy;
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(0.0, 0.0);
  tmpvar_6.xy = normalize(_glesTANGENT).xy;
  highp vec2 tmpvar_7;
  tmpvar_7.x = -(_glesTANGENT.y);
  tmpvar_7.y = _glesTANGENT.x;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(0.0, 0.0);
  tmpvar_8.xy = (normalize(tmpvar_7) * _glesTANGENT.w);
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = ((_glesVertex + (tmpvar_8 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + (tmpvar_5 + (tmpvar_6 * 
    ((_Turbulence / max (0.5, abs(_glesTANGENT.w))) * tmpvar_3)
  ))).xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  highp float tmpvar_11;
  bool tmpvar_12;
  tmpvar_12 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_11 = ((float(tmpvar_12) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_12)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_11 * _TintColor) * tmpvar_13);
  highp vec4 o_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_9 * 0.5);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_15.x;
  tmpvar_16.y = (tmpvar_15.y * _ProjectionParams.x);
  o_14.xy = (tmpvar_16 + tmpvar_15.w);
  o_14.zw = tmpvar_9.zw;
  tmpvar_2.xyw = o_14.xyw;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = _glesVertex.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_17)).z);
  tmpvar_1.w = (tmpvar_1.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_MainTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6.x = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6.x = (u_xlatb9) ? 0.0 : u_xlat6.x;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6.x;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6.x = dot(in_TANGENT0, in_TANGENT0);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xy = u_xlat6.xx * in_TANGENT0.xy;
    u_xlat3.xy = u_xlat3.xx * u_xlat6.xy;
    u_xlat0.xy = u_xlat0.xx * _TurbulenceVelocity.xy + u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xy = in_TANGENT0.yx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * in_TANGENT0.ww;
    u_xlat1.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6.x = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6.x = (u_xlatb9) ? 0.0 : u_xlat6.x;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6.x;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6.x = dot(in_TANGENT0, in_TANGENT0);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xy = u_xlat6.xx * in_TANGENT0.xy;
    u_xlat3.xy = u_xlat3.xx * u_xlat6.xy;
    u_xlat0.xy = u_xlat0.xx * _TurbulenceVelocity.xy + u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xy = in_TANGENT0.yx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * in_TANGENT0.ww;
    u_xlat1.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
vec2 u_xlat6;
float u_xlat7;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6.x = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6.x = (u_xlatb9) ? 0.0 : u_xlat6.x;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6.x;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6.x = dot(in_TANGENT0, in_TANGENT0);
    u_xlat6.x = inversesqrt(u_xlat6.x);
    u_xlat6.xy = u_xlat6.xx * in_TANGENT0.xy;
    u_xlat3.xy = u_xlat3.xx * u_xlat6.xy;
    u_xlat0.xy = u_xlat0.xx * _TurbulenceVelocity.xy + u_xlat3.xy;
    u_xlat1.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat1.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xy = in_TANGENT0.yx * vec2(-1.0, 1.0);
    u_xlat7 = dot(u_xlat1.xy, u_xlat1.xy);
    u_xlat7 = inversesqrt(u_xlat7);
    u_xlat1.xy = vec2(u_xlat7) * u_xlat1.xy;
    u_xlat1.xy = u_xlat1.xy * in_TANGENT0.ww;
    u_xlat1.xy = vec2(u_xlat9) * u_xlat1.xy;
    u_xlat1.z = 0.0;
    u_xlat1.xyz = u_xlat1.xyz + in_POSITION0.xyz;
    u_xlat0.z = 0.0;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "PERSPECTIVE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_2 = (tmpvar_3 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceCameraPos - _glesVertex.xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = (normalize((
    (_glesTANGENT.yzx * tmpvar_5.zxy)
   - 
    (_glesTANGENT.zxy * tmpvar_5.yzx)
  )) * _glesTANGENT.w);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = ((_glesVertex + (tmpvar_6 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_2)) + (tmpvar_4 * 
    ((_Turbulence / max (0.5, abs(_glesTANGENT.w))) * tmpvar_2)
  ))).xyz;
  highp float tmpvar_8;
  bool tmpvar_9;
  tmpvar_9 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_8 = ((float(tmpvar_9) * clamp (
    (tmpvar_3 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_9)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_8 * _TintColor) * tmpvar_10);
  tmpvar_1.w = (tmpvar_1.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "PERSPECTIVE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_2 = (tmpvar_3 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceCameraPos - _glesVertex.xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = (normalize((
    (_glesTANGENT.yzx * tmpvar_5.zxy)
   - 
    (_glesTANGENT.zxy * tmpvar_5.yzx)
  )) * _glesTANGENT.w);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = ((_glesVertex + (tmpvar_6 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_2)) + (tmpvar_4 * 
    ((_Turbulence / max (0.5, abs(_glesTANGENT.w))) * tmpvar_2)
  ))).xyz;
  highp float tmpvar_8;
  bool tmpvar_9;
  tmpvar_9 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_8 = ((float(tmpvar_9) * clamp (
    (tmpvar_3 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_9)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_8 * _TintColor) * tmpvar_10);
  tmpvar_1.w = (tmpvar_1.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "PERSPECTIVE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_2 = (tmpvar_3 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceCameraPos - _glesVertex.xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = (normalize((
    (_glesTANGENT.yzx * tmpvar_5.zxy)
   - 
    (_glesTANGENT.zxy * tmpvar_5.yzx)
  )) * _glesTANGENT.w);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = ((_glesVertex + (tmpvar_6 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_2)) + (tmpvar_4 * 
    ((_Turbulence / max (0.5, abs(_glesTANGENT.w))) * tmpvar_2)
  ))).xyz;
  highp float tmpvar_8;
  bool tmpvar_9;
  tmpvar_9 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_8 = ((float(tmpvar_9) * clamp (
    (tmpvar_3 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_9)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_8 * _TintColor) * tmpvar_10);
  tmpvar_1.w = (tmpvar_1.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "PERSPECTIVE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * in_TANGENT0.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat3.xyz;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat2.xyz = u_xlat1.xyz * in_TANGENT0.zxy;
    u_xlat1.xyz = in_TANGENT0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat2.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "PERSPECTIVE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * in_TANGENT0.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat3.xyz;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat2.xyz = u_xlat1.xyz * in_TANGENT0.zxy;
    u_xlat1.xyz = in_TANGENT0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat2.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "PERSPECTIVE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * in_TANGENT0.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat3.xyz;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat2.xyz = u_xlat1.xyz * in_TANGENT0.zxy;
    u_xlat1.xyz = in_TANGENT0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat2.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_6;
  tmpvar_6 = (_WorldSpaceCameraPos - _glesVertex.xyz);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = (normalize((
    (_glesTANGENT.yzx * tmpvar_6.zxy)
   - 
    (_glesTANGENT.zxy * tmpvar_6.yzx)
  )) * _glesTANGENT.w);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = ((_glesVertex + (tmpvar_7 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_3)) + (tmpvar_5 * 
    ((_Turbulence / max (0.5, abs(_glesTANGENT.w))) * tmpvar_3)
  ))).xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp float tmpvar_10;
  bool tmpvar_11;
  tmpvar_11 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_10 = ((float(tmpvar_11) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_11)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_10 * _TintColor) * tmpvar_12);
  highp vec4 o_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14.x;
  tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
  o_13.xy = (tmpvar_15 + tmpvar_14.w);
  o_13.zw = tmpvar_8.zw;
  tmpvar_2.xyw = o_13.xyw;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_16)).z);
  tmpvar_1.w = (tmpvar_1.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_MainTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_6;
  tmpvar_6 = (_WorldSpaceCameraPos - _glesVertex.xyz);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = (normalize((
    (_glesTANGENT.yzx * tmpvar_6.zxy)
   - 
    (_glesTANGENT.zxy * tmpvar_6.yzx)
  )) * _glesTANGENT.w);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = ((_glesVertex + (tmpvar_7 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_3)) + (tmpvar_5 * 
    ((_Turbulence / max (0.5, abs(_glesTANGENT.w))) * tmpvar_3)
  ))).xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp float tmpvar_10;
  bool tmpvar_11;
  tmpvar_11 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_10 = ((float(tmpvar_11) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_11)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_10 * _TintColor) * tmpvar_12);
  highp vec4 o_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14.x;
  tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
  o_13.xy = (tmpvar_15 + tmpvar_14.w);
  o_13.zw = tmpvar_8.zw;
  tmpvar_2.xyw = o_13.xyw;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_16)).z);
  tmpvar_1.w = (tmpvar_1.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_MainTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_6;
  tmpvar_6 = (_WorldSpaceCameraPos - _glesVertex.xyz);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = (normalize((
    (_glesTANGENT.yzx * tmpvar_6.zxy)
   - 
    (_glesTANGENT.zxy * tmpvar_6.yzx)
  )) * _glesTANGENT.w);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = ((_glesVertex + (tmpvar_7 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_3)) + (tmpvar_5 * 
    ((_Turbulence / max (0.5, abs(_glesTANGENT.w))) * tmpvar_3)
  ))).xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp float tmpvar_10;
  bool tmpvar_11;
  tmpvar_11 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_10 = ((float(tmpvar_11) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_11)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_10 * _TintColor) * tmpvar_12);
  highp vec4 o_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14.x;
  tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
  o_13.xy = (tmpvar_15 + tmpvar_14.w);
  o_13.zw = tmpvar_8.zw;
  tmpvar_2.xyw = o_13.xyw;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_16)).z);
  tmpvar_1.w = (tmpvar_1.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_MainTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * in_TANGENT0.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat3.xyz;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat2.xyz = u_xlat1.xyz * in_TANGENT0.zxy;
    u_xlat1.xyz = in_TANGENT0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat2.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * in_TANGENT0.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat3.xyz;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat2.xyz = u_xlat1.xyz * in_TANGENT0.zxy;
    u_xlat1.xyz = in_TANGENT0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat2.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * in_TANGENT0.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat3.xyz;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat2.xyz = u_xlat1.xyz * in_TANGENT0.zxy;
    u_xlat1.xyz = in_TANGENT0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat2.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_2 = (tmpvar_3 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceCameraPos - _glesVertex.xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = (normalize((
    (_glesTANGENT.yzx * tmpvar_5.zxy)
   - 
    (_glesTANGENT.zxy * tmpvar_5.yzx)
  )) * _glesTANGENT.w);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = ((_glesVertex + (tmpvar_6 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_2)) + (tmpvar_4 * 
    ((_Turbulence / max (0.5, abs(_glesTANGENT.w))) * tmpvar_2)
  ))).xyz;
  highp float tmpvar_8;
  bool tmpvar_9;
  tmpvar_9 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_8 = ((float(tmpvar_9) * clamp (
    (tmpvar_3 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_9)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_8 * _TintColor) * tmpvar_10);
  tmpvar_1.w = (tmpvar_1.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_2 = (tmpvar_3 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceCameraPos - _glesVertex.xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = (normalize((
    (_glesTANGENT.yzx * tmpvar_5.zxy)
   - 
    (_glesTANGENT.zxy * tmpvar_5.yzx)
  )) * _glesTANGENT.w);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = ((_glesVertex + (tmpvar_6 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_2)) + (tmpvar_4 * 
    ((_Turbulence / max (0.5, abs(_glesTANGENT.w))) * tmpvar_2)
  ))).xyz;
  highp float tmpvar_8;
  bool tmpvar_9;
  tmpvar_9 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_8 = ((float(tmpvar_9) * clamp (
    (tmpvar_3 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_9)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_8 * _TintColor) * tmpvar_10);
  tmpvar_1.w = (tmpvar_1.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_2 = (tmpvar_3 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceCameraPos - _glesVertex.xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = (normalize((
    (_glesTANGENT.yzx * tmpvar_5.zxy)
   - 
    (_glesTANGENT.zxy * tmpvar_5.yzx)
  )) * _glesTANGENT.w);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = ((_glesVertex + (tmpvar_6 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_2)) + (tmpvar_4 * 
    ((_Turbulence / max (0.5, abs(_glesTANGENT.w))) * tmpvar_2)
  ))).xyz;
  highp float tmpvar_8;
  bool tmpvar_9;
  tmpvar_9 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_8 = ((float(tmpvar_9) * clamp (
    (tmpvar_3 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_9)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_8 * _TintColor) * tmpvar_10);
  tmpvar_1.w = (tmpvar_1.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * in_TANGENT0.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat3.xyz;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat2.xyz = u_xlat1.xyz * in_TANGENT0.zxy;
    u_xlat1.xyz = in_TANGENT0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat2.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * in_TANGENT0.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat3.xyz;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat2.xyz = u_xlat1.xyz * in_TANGENT0.zxy;
    u_xlat1.xyz = in_TANGENT0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat2.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * in_TANGENT0.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat3.xyz;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat2.xyz = u_xlat1.xyz * in_TANGENT0.zxy;
    u_xlat1.xyz = in_TANGENT0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat2.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_6;
  tmpvar_6 = (_WorldSpaceCameraPos - _glesVertex.xyz);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = (normalize((
    (_glesTANGENT.yzx * tmpvar_6.zxy)
   - 
    (_glesTANGENT.zxy * tmpvar_6.yzx)
  )) * _glesTANGENT.w);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = ((_glesVertex + (tmpvar_7 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_3)) + (tmpvar_5 * 
    ((_Turbulence / max (0.5, abs(_glesTANGENT.w))) * tmpvar_3)
  ))).xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp float tmpvar_10;
  bool tmpvar_11;
  tmpvar_11 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_10 = ((float(tmpvar_11) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_11)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_10 * _TintColor) * tmpvar_12);
  highp vec4 o_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14.x;
  tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
  o_13.xy = (tmpvar_15 + tmpvar_14.w);
  o_13.zw = tmpvar_8.zw;
  tmpvar_2.xyw = o_13.xyw;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_16)).z);
  tmpvar_1.w = (tmpvar_1.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_MainTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_6;
  tmpvar_6 = (_WorldSpaceCameraPos - _glesVertex.xyz);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = (normalize((
    (_glesTANGENT.yzx * tmpvar_6.zxy)
   - 
    (_glesTANGENT.zxy * tmpvar_6.yzx)
  )) * _glesTANGENT.w);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = ((_glesVertex + (tmpvar_7 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_3)) + (tmpvar_5 * 
    ((_Turbulence / max (0.5, abs(_glesTANGENT.w))) * tmpvar_3)
  ))).xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp float tmpvar_10;
  bool tmpvar_11;
  tmpvar_11 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_10 = ((float(tmpvar_11) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_11)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_10 * _TintColor) * tmpvar_12);
  highp vec4 o_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14.x;
  tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
  o_13.xy = (tmpvar_15 + tmpvar_14.w);
  o_13.zw = tmpvar_8.zw;
  tmpvar_2.xyw = o_13.xyw;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_16)).z);
  tmpvar_1.w = (tmpvar_1.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_MainTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_6;
  tmpvar_6 = (_WorldSpaceCameraPos - _glesVertex.xyz);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = (normalize((
    (_glesTANGENT.yzx * tmpvar_6.zxy)
   - 
    (_glesTANGENT.zxy * tmpvar_6.yzx)
  )) * _glesTANGENT.w);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = ((_glesVertex + (tmpvar_7 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_3)) + (tmpvar_5 * 
    ((_Turbulence / max (0.5, abs(_glesTANGENT.w))) * tmpvar_3)
  ))).xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp float tmpvar_10;
  bool tmpvar_11;
  tmpvar_11 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_10 = ((float(tmpvar_11) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_11)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_10 * _TintColor) * tmpvar_12);
  highp vec4 o_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14.x;
  tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
  o_13.xy = (tmpvar_15 + tmpvar_14.w);
  o_13.zw = tmpvar_8.zw;
  tmpvar_2.xyw = o_13.xyw;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_16)).z);
  tmpvar_1.w = (tmpvar_1.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_MainTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * in_TANGENT0.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat3.xyz;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat2.xyz = u_xlat1.xyz * in_TANGENT0.zxy;
    u_xlat1.xyz = in_TANGENT0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat2.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * in_TANGENT0.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat3.xyz;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat2.xyz = u_xlat1.xyz * in_TANGENT0.zxy;
    u_xlat1.xyz = in_TANGENT0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat2.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * in_TANGENT0.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat3.xyz;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat2.xyz = u_xlat1.xyz * in_TANGENT0.zxy;
    u_xlat1.xyz = in_TANGENT0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat2.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_2 = (tmpvar_3 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceCameraPos - _glesVertex.xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = (normalize((
    (_glesTANGENT.yzx * tmpvar_5.zxy)
   - 
    (_glesTANGENT.zxy * tmpvar_5.yzx)
  )) * _glesTANGENT.w);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = ((_glesVertex + (tmpvar_6 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_2)) + (tmpvar_4 * 
    ((_Turbulence / max (0.5, abs(_glesTANGENT.w))) * tmpvar_2)
  ))).xyz;
  highp float tmpvar_8;
  bool tmpvar_9;
  tmpvar_9 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_8 = ((float(tmpvar_9) * clamp (
    (tmpvar_3 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_9)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_8 * _TintColor) * tmpvar_10);
  tmpvar_1.w = (tmpvar_1.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_2 = (tmpvar_3 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceCameraPos - _glesVertex.xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = (normalize((
    (_glesTANGENT.yzx * tmpvar_5.zxy)
   - 
    (_glesTANGENT.zxy * tmpvar_5.yzx)
  )) * _glesTANGENT.w);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = ((_glesVertex + (tmpvar_6 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_2)) + (tmpvar_4 * 
    ((_Turbulence / max (0.5, abs(_glesTANGENT.w))) * tmpvar_2)
  ))).xyz;
  highp float tmpvar_8;
  bool tmpvar_9;
  tmpvar_9 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_8 = ((float(tmpvar_9) * clamp (
    (tmpvar_3 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_9)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_8 * _TintColor) * tmpvar_10);
  tmpvar_1.w = (tmpvar_1.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_2 = (tmpvar_3 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceCameraPos - _glesVertex.xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = (normalize((
    (_glesTANGENT.yzx * tmpvar_5.zxy)
   - 
    (_glesTANGENT.zxy * tmpvar_5.yzx)
  )) * _glesTANGENT.w);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = ((_glesVertex + (tmpvar_6 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_2)) + (tmpvar_4 * 
    ((_Turbulence / max (0.5, abs(_glesTANGENT.w))) * tmpvar_2)
  ))).xyz;
  highp float tmpvar_8;
  bool tmpvar_9;
  tmpvar_9 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_8 = ((float(tmpvar_9) * clamp (
    (tmpvar_3 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_9)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_8 * _TintColor) * tmpvar_10);
  tmpvar_1.w = (tmpvar_1.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * in_TANGENT0.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat3.xyz;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat2.xyz = u_xlat1.xyz * in_TANGENT0.zxy;
    u_xlat1.xyz = in_TANGENT0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat2.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * in_TANGENT0.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat3.xyz;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat2.xyz = u_xlat1.xyz * in_TANGENT0.zxy;
    u_xlat1.xyz = in_TANGENT0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat2.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * in_TANGENT0.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat3.xyz;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat2.xyz = u_xlat1.xyz * in_TANGENT0.zxy;
    u_xlat1.xyz = in_TANGENT0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat2.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_6;
  tmpvar_6 = (_WorldSpaceCameraPos - _glesVertex.xyz);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = (normalize((
    (_glesTANGENT.yzx * tmpvar_6.zxy)
   - 
    (_glesTANGENT.zxy * tmpvar_6.yzx)
  )) * _glesTANGENT.w);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = ((_glesVertex + (tmpvar_7 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_3)) + (tmpvar_5 * 
    ((_Turbulence / max (0.5, abs(_glesTANGENT.w))) * tmpvar_3)
  ))).xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp float tmpvar_10;
  bool tmpvar_11;
  tmpvar_11 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_10 = ((float(tmpvar_11) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_11)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_10 * _TintColor) * tmpvar_12);
  highp vec4 o_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14.x;
  tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
  o_13.xy = (tmpvar_15 + tmpvar_14.w);
  o_13.zw = tmpvar_8.zw;
  tmpvar_2.xyw = o_13.xyw;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_16)).z);
  tmpvar_1.w = (tmpvar_1.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_MainTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_6;
  tmpvar_6 = (_WorldSpaceCameraPos - _glesVertex.xyz);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = (normalize((
    (_glesTANGENT.yzx * tmpvar_6.zxy)
   - 
    (_glesTANGENT.zxy * tmpvar_6.yzx)
  )) * _glesTANGENT.w);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = ((_glesVertex + (tmpvar_7 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_3)) + (tmpvar_5 * 
    ((_Turbulence / max (0.5, abs(_glesTANGENT.w))) * tmpvar_3)
  ))).xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp float tmpvar_10;
  bool tmpvar_11;
  tmpvar_11 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_10 = ((float(tmpvar_11) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_11)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_10 * _TintColor) * tmpvar_12);
  highp vec4 o_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14.x;
  tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
  o_13.xy = (tmpvar_15 + tmpvar_14.w);
  o_13.zw = tmpvar_8.zw;
  tmpvar_2.xyw = o_13.xyw;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_16)).z);
  tmpvar_1.w = (tmpvar_1.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_MainTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_6;
  tmpvar_6 = (_WorldSpaceCameraPos - _glesVertex.xyz);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = (normalize((
    (_glesTANGENT.yzx * tmpvar_6.zxy)
   - 
    (_glesTANGENT.zxy * tmpvar_6.yzx)
  )) * _glesTANGENT.w);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = ((_glesVertex + (tmpvar_7 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_3)) + (tmpvar_5 * 
    ((_Turbulence / max (0.5, abs(_glesTANGENT.w))) * tmpvar_3)
  ))).xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp float tmpvar_10;
  bool tmpvar_11;
  tmpvar_11 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_10 = ((float(tmpvar_11) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_11)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_10 * _TintColor) * tmpvar_12);
  highp vec4 o_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14.x;
  tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
  o_13.xy = (tmpvar_15 + tmpvar_14.w);
  o_13.zw = tmpvar_8.zw;
  tmpvar_2.xyw = o_13.xyw;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_16)).z);
  tmpvar_1.w = (tmpvar_1.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_MainTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * in_TANGENT0.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat3.xyz;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat2.xyz = u_xlat1.xyz * in_TANGENT0.zxy;
    u_xlat1.xyz = in_TANGENT0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat2.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * in_TANGENT0.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat3.xyz;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat2.xyz = u_xlat1.xyz * in_TANGENT0.zxy;
    u_xlat1.xyz = in_TANGENT0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat2.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * in_TANGENT0.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat3.xyz;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat2.xyz = u_xlat1.xyz * in_TANGENT0.zxy;
    u_xlat1.xyz = in_TANGENT0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat2.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_2 = (tmpvar_3 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceCameraPos - _glesVertex.xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = (normalize((
    (_glesTANGENT.yzx * tmpvar_5.zxy)
   - 
    (_glesTANGENT.zxy * tmpvar_5.yzx)
  )) * _glesTANGENT.w);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = ((_glesVertex + (tmpvar_6 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_2)) + (tmpvar_4 * 
    ((_Turbulence / max (0.5, abs(_glesTANGENT.w))) * tmpvar_2)
  ))).xyz;
  highp float tmpvar_8;
  bool tmpvar_9;
  tmpvar_9 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_8 = ((float(tmpvar_9) * clamp (
    (tmpvar_3 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_9)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_8 * _TintColor) * tmpvar_10);
  tmpvar_1.w = (tmpvar_1.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_2 = (tmpvar_3 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceCameraPos - _glesVertex.xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = (normalize((
    (_glesTANGENT.yzx * tmpvar_5.zxy)
   - 
    (_glesTANGENT.zxy * tmpvar_5.yzx)
  )) * _glesTANGENT.w);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = ((_glesVertex + (tmpvar_6 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_2)) + (tmpvar_4 * 
    ((_Turbulence / max (0.5, abs(_glesTANGENT.w))) * tmpvar_2)
  ))).xyz;
  highp float tmpvar_8;
  bool tmpvar_9;
  tmpvar_9 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_8 = ((float(tmpvar_9) * clamp (
    (tmpvar_3 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_9)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_8 * _TintColor) * tmpvar_10);
  tmpvar_1.w = (tmpvar_1.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp float tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_2 = (tmpvar_3 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceCameraPos - _glesVertex.xyz);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = (normalize((
    (_glesTANGENT.yzx * tmpvar_5.zxy)
   - 
    (_glesTANGENT.zxy * tmpvar_5.yzx)
  )) * _glesTANGENT.w);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = ((_glesVertex + (tmpvar_6 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_2)) + (tmpvar_4 * 
    ((_Turbulence / max (0.5, abs(_glesTANGENT.w))) * tmpvar_2)
  ))).xyz;
  highp float tmpvar_8;
  bool tmpvar_9;
  tmpvar_9 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_8 = ((float(tmpvar_9) * clamp (
    (tmpvar_3 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_9)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_8 * _TintColor) * tmpvar_10);
  tmpvar_1.w = (tmpvar_1.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * in_TANGENT0.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat3.xyz;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat2.xyz = u_xlat1.xyz * in_TANGENT0.zxy;
    u_xlat1.xyz = in_TANGENT0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat2.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * in_TANGENT0.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat3.xyz;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat2.xyz = u_xlat1.xyz * in_TANGENT0.zxy;
    u_xlat1.xyz = in_TANGENT0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat2.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * in_TANGENT0.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat3.xyz;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat2.xyz = u_xlat1.xyz * in_TANGENT0.zxy;
    u_xlat1.xyz = in_TANGENT0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat2.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec4 u_xlat10_0;
void main()
{
    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0 = u_xlat10_0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_6;
  tmpvar_6 = (_WorldSpaceCameraPos - _glesVertex.xyz);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = (normalize((
    (_glesTANGENT.yzx * tmpvar_6.zxy)
   - 
    (_glesTANGENT.zxy * tmpvar_6.yzx)
  )) * _glesTANGENT.w);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = ((_glesVertex + (tmpvar_7 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_3)) + (tmpvar_5 * 
    ((_Turbulence / max (0.5, abs(_glesTANGENT.w))) * tmpvar_3)
  ))).xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp float tmpvar_10;
  bool tmpvar_11;
  tmpvar_11 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_10 = ((float(tmpvar_11) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_11)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_10 * _TintColor) * tmpvar_12);
  highp vec4 o_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14.x;
  tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
  o_13.xy = (tmpvar_15 + tmpvar_14.w);
  o_13.zw = tmpvar_8.zw;
  tmpvar_2.xyw = o_13.xyw;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_16)).z);
  tmpvar_1.w = (tmpvar_1.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_MainTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_6;
  tmpvar_6 = (_WorldSpaceCameraPos - _glesVertex.xyz);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = (normalize((
    (_glesTANGENT.yzx * tmpvar_6.zxy)
   - 
    (_glesTANGENT.zxy * tmpvar_6.yzx)
  )) * _glesTANGENT.w);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = ((_glesVertex + (tmpvar_7 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_3)) + (tmpvar_5 * 
    ((_Turbulence / max (0.5, abs(_glesTANGENT.w))) * tmpvar_3)
  ))).xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp float tmpvar_10;
  bool tmpvar_11;
  tmpvar_11 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_10 = ((float(tmpvar_11) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_11)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_10 * _TintColor) * tmpvar_12);
  highp vec4 o_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14.x;
  tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
  o_13.xy = (tmpvar_15 + tmpvar_14.w);
  o_13.zw = tmpvar_8.zw;
  tmpvar_2.xyw = o_13.xyw;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_16)).z);
  tmpvar_1.w = (tmpvar_1.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_MainTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _JitterMultiplier;
uniform highp float _Turbulence;
uniform highp vec4 _TurbulenceVelocity;
uniform lowp vec4 _TintColor;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (_Time.y - _glesMultiTexCoord1.x);
  tmpvar_3 = (tmpvar_4 / (_glesMultiTexCoord1.w - _glesMultiTexCoord1.x));
  highp vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_6;
  tmpvar_6 = (_WorldSpaceCameraPos - _glesVertex.xyz);
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = (normalize((
    (_glesTANGENT.yzx * tmpvar_6.zxy)
   - 
    (_glesTANGENT.zxy * tmpvar_6.yzx)
  )) * _glesTANGENT.w);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = ((_glesVertex + (tmpvar_7 * 
    (1.0 + (fract((
      sin(dot ((_Time.yzw * _glesVertex.xyz), vec3(12.9898, 78.233, 45.5432)))
     * 43758.55)) * _JitterMultiplier))
  )) + ((_TurbulenceVelocity * vec4(tmpvar_3)) + (tmpvar_5 * 
    ((_Turbulence / max (0.5, abs(_glesTANGENT.w))) * tmpvar_3)
  ))).xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp float tmpvar_10;
  bool tmpvar_11;
  tmpvar_11 = (_Time.y < _glesMultiTexCoord1.y);
  tmpvar_10 = ((float(tmpvar_11) * clamp (
    (tmpvar_4 / max (1e-05, (_glesMultiTexCoord1.y - _glesMultiTexCoord1.x)))
  , 0.0, 1.0)) + (float(
    !(tmpvar_11)
  ) * (1.0 - 
    clamp (((_Time.y - _glesMultiTexCoord1.z) / max (1e-05, (_glesMultiTexCoord1.w - _glesMultiTexCoord1.z))), 0.0, 1.0)
  )));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesColor.xyz;
  tmpvar_1 = ((tmpvar_10 * _TintColor) * tmpvar_12);
  highp vec4 o_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14.x;
  tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
  o_13.xy = (tmpvar_15 + tmpvar_14.w);
  o_13.zw = tmpvar_8.zw;
  tmpvar_2.xyw = o_13.xyw;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = _glesVertex.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_16)).z);
  tmpvar_1.w = (tmpvar_1.w * (_glesColor.w * 10.0));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = tmpvar_8;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _InvFade;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR0.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_3;
  z_3 = tmpvar_2.x;
  highp float tmpvar_4;
  tmpvar_4 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * z_3) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR0.w * tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = (texture2D (_MainTex, xlv_TEXCOORD0) * tmpvar_1);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * in_TANGENT0.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat3.xyz;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat2.xyz = u_xlat1.xyz * in_TANGENT0.zxy;
    u_xlat1.xyz = in_TANGENT0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat2.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * in_TANGENT0.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat3.xyz;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat2.xyz = u_xlat1.xyz * in_TANGENT0.zxy;
    u_xlat1.xyz = in_TANGENT0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat2.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _Time;
uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ProjectionParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _JitterMultiplier;
uniform 	float _Turbulence;
uniform 	vec4 _TurbulenceVelocity;
uniform 	mediump vec4 _TintColor;
in highp vec4 in_POSITION0;
in highp vec4 in_TANGENT0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD1;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec3 u_xlat3;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat0.xyz = vec3((-in_TEXCOORD1.x) + in_TEXCOORD1.w, (-in_TEXCOORD1.x) + in_TEXCOORD1.y, (-in_TEXCOORD1.z) + in_TEXCOORD1.w);
    u_xlat3.xy = max(u_xlat0.yz, vec2(9.99999975e-006, 9.99999975e-006));
    u_xlat1.xy = (-in_TEXCOORD1.xz) + _Time.yy;
    u_xlat3.xy = u_xlat1.xy / u_xlat3.xy;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.xy = min(max(u_xlat3.xy, 0.0), 1.0);
#else
    u_xlat3.xy = clamp(u_xlat3.xy, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat1.x / u_xlat0.x;
    u_xlat6 = (-u_xlat3.y) + 1.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(_Time.y<in_TEXCOORD1.y);
#else
    u_xlatb9 = _Time.y<in_TEXCOORD1.y;
#endif
    u_xlat6 = (u_xlatb9) ? 0.0 : u_xlat6;
    u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
    u_xlat3.x = u_xlat9 * u_xlat3.x + u_xlat6;
    u_xlat1 = u_xlat3.xxxx * _TintColor.wxyz;
    u_xlat2.xyz = vec3(u_xlat1.y * in_COLOR0.x, u_xlat1.z * in_COLOR0.y, u_xlat1.w * in_COLOR0.z);
    u_xlat3.x = u_xlat1.x * in_COLOR0.w;
    u_xlat2.w = u_xlat3.x * 10.0;
    vs_COLOR0 = u_xlat2;
    u_xlat3.x = max(abs(in_TANGENT0.w), 0.5);
    u_xlat3.x = _Turbulence / u_xlat3.x;
    u_xlat3.x = u_xlat3.x * u_xlat0.x;
    u_xlat6 = dot(in_TANGENT0.xyz, in_TANGENT0.xyz);
    u_xlat6 = inversesqrt(u_xlat6);
    u_xlat1.xyz = vec3(u_xlat6) * in_TANGENT0.xyz;
    u_xlat3.xyz = u_xlat3.xxx * u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xxx * _TurbulenceVelocity.xyz + u_xlat3.xyz;
    u_xlat1.xyz = (-in_POSITION0.yzx) + _WorldSpaceCameraPos.yzx;
    u_xlat2.xyz = u_xlat1.xyz * in_TANGENT0.zxy;
    u_xlat1.xyz = in_TANGENT0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_TANGENT0.www;
    u_xlat2.xyz = vec3(in_POSITION0.x * _Time.y, in_POSITION0.y * _Time.z, in_POSITION0.z * _Time.w);
    u_xlat9 = dot(u_xlat2.xyz, vec3(12.9898005, 78.2330017, 45.5432014));
    u_xlat9 = sin(u_xlat9);
    u_xlat9 = u_xlat9 * 43758.5469;
    u_xlat9 = fract(u_xlat9);
    u_xlat9 = u_xlat9 * _JitterMultiplier + 1.0;
    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9) + in_POSITION0.xyz;
    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
    vs_TEXCOORD1.w = u_xlat0.w;
    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat3.x = u_xlat0.y * hlslcc_mtx4x4unity_MatrixV[1].z;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[0].z * u_xlat0.x + u_xlat3.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
    u_xlat0.x = hlslcc_mtx4x4unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
    vs_TEXCOORD1.z = (-u_xlat0.x);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _ZBufferParams;
uniform 	float _InvFade;
uniform highp sampler2D _CameraDepthTexture;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD1;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
lowp vec4 u_xlat10_1;
void main()
{
    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
    u_xlat0.x = texture(_CameraDepthTexture, u_xlat0.xy).x;
    u_xlat0.x = _ZBufferParams.z * u_xlat0.x + _ZBufferParams.w;
    u_xlat0.x = float(1.0) / u_xlat0.x;
    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD1.z);
    u_xlat0.x = u_xlat0.x * _InvFade;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    SV_Target0.w = u_xlat0.x * u_xlat10_1.w;
    SV_Target0.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
""
}
SubProgram "gles hw_tier01 " {
""
}
SubProgram "gles hw_tier02 " {
""
}
SubProgram "gles3 hw_tier00 " {
""
}
SubProgram "gles3 hw_tier01 " {
""
}
SubProgram "gles3 hw_tier02 " {
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "PERSPECTIVE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "PERSPECTIVE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "PERSPECTIVE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "PERSPECTIVE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "PERSPECTIVE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "PERSPECTIVE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "PERSPECTIVE" "ORTHOGRAPHIC_XY" "ORTHOGRAPHIC_XZ" }
""
}
}
}
}
}