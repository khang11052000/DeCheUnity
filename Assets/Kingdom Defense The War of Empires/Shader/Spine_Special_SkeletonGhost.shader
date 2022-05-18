//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Spine/Special/SkeletonGhost" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_MainTex ("Base (RGB) Alpha (A)", 2D) = "white" { }
_TextureFade ("Texture Fade Out", Range(0, 1)) = 0
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "False" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "False" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend One OneMinusSrcAlpha, One OneMinusSrcAlpha
  ZWrite Off
  Cull Off
  Fog {
   Mode Off
  }
  GpuProgramID 1959
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp float _TextureFade;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = max (vec3(_TextureFade), tmpvar_2.xyz);
  tmpvar_3.w = tmpvar_2.w;
  tmpvar_1 = ((tmpvar_3 * xlv_COLOR) * (_Color * tmpvar_2.w));
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp float _TextureFade;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = max (vec3(_TextureFade), tmpvar_2.xyz);
  tmpvar_3.w = tmpvar_2.w;
  tmpvar_1 = ((tmpvar_3 * xlv_COLOR) * (_Color * tmpvar_2.w));
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
uniform lowp float _TextureFade;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_3;
  tmpvar_3.xyz = max (vec3(_TextureFade), tmpvar_2.xyz);
  tmpvar_3.w = tmpvar_2.w;
  tmpvar_1 = ((tmpvar_3 * xlv_COLOR) * (_Color * tmpvar_2.w));
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform 	mediump float _TextureFade;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0 = vs_COLOR0 * _Color;
    u_xlat1.xyz = u_xlat0.xyz;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.w = u_xlat10_2.w;
    u_xlat1 = u_xlat1.wwww * u_xlat1;
    u_xlat16_3.xyz = max(u_xlat10_2.xyz, vec3(_TextureFade));
    u_xlat2.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat2.w = u_xlat0.w * u_xlat1.w;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform 	mediump float _TextureFade;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0 = vs_COLOR0 * _Color;
    u_xlat1.xyz = u_xlat0.xyz;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.w = u_xlat10_2.w;
    u_xlat1 = u_xlat1.wwww * u_xlat1;
    u_xlat16_3.xyz = max(u_xlat10_2.xyz, vec3(_TextureFade));
    u_xlat2.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat2.w = u_xlat0.w * u_xlat1.w;
    SV_Target0 = u_xlat2;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	mediump vec4 _Color;
uniform 	mediump float _TextureFade;
uniform lowp sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_COLOR0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
void main()
{
    u_xlat0 = vs_COLOR0 * _Color;
    u_xlat1.xyz = u_xlat0.xyz;
    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.w = u_xlat10_2.w;
    u_xlat1 = u_xlat1.wwww * u_xlat1;
    u_xlat16_3.xyz = max(u_xlat10_2.xyz, vec3(_TextureFade));
    u_xlat2.xyz = u_xlat1.xyz * u_xlat16_3.xyz;
    u_xlat2.w = u_xlat0.w * u_xlat1.w;
    SV_Target0 = u_xlat2;
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
}
}
}
}