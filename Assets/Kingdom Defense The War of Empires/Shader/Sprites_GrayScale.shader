//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Sprites/GrayScale" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
[MaterialToggle] PixelSnap ("Pixel snap", Float) = 0
_EffectAmount ("Effect Amount", Range(0, 1)) = 1
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ZWrite Off
  Cull Off
  Fog {
   Mode Off
  }
  GpuProgramID 34618
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DUMMY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = tmpvar_1;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _EffectAmount;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_2 = tmpvar_3;
  mediump float tmpvar_4;
  tmpvar_4 = dot (texcol_2.xyz, vec3(0.3, 0.59, 0.11));
  highp vec3 tmpvar_5;
  tmpvar_5 = mix (texcol_2.xyz, vec3(tmpvar_4), vec3(_EffectAmount));
  texcol_2.xyz = tmpvar_5;
  texcol_2 = (texcol_2 * xlv_COLOR);
  tmpvar_1 = texcol_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DUMMY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = tmpvar_1;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _EffectAmount;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_2 = tmpvar_3;
  mediump float tmpvar_4;
  tmpvar_4 = dot (texcol_2.xyz, vec3(0.3, 0.59, 0.11));
  highp vec3 tmpvar_5;
  tmpvar_5 = mix (texcol_2.xyz, vec3(tmpvar_4), vec3(_EffectAmount));
  texcol_2.xyz = tmpvar_5;
  texcol_2 = (texcol_2 * xlv_COLOR);
  tmpvar_1 = texcol_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DUMMY" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = tmpvar_1;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _EffectAmount;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_2 = tmpvar_3;
  mediump float tmpvar_4;
  tmpvar_4 = dot (texcol_2.xyz, vec3(0.3, 0.59, 0.11));
  highp vec3 tmpvar_5;
  tmpvar_5 = mix (texcol_2.xyz, vec3(tmpvar_4), vec3(_EffectAmount));
  texcol_2.xyz = tmpvar_5;
  texcol_2 = (texcol_2 * xlv_COLOR);
  tmpvar_1 = texcol_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DUMMY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _EffectAmount;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.x = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xxx;
    u_xlat0.xyz = vec3(_EffectAmount) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DUMMY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _EffectAmount;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.x = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xxx;
    u_xlat0.xyz = vec3(_EffectAmount) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DUMMY" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
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
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _EffectAmount;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.x = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xxx;
    u_xlat0.xyz = vec3(_EffectAmount) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "PIXELSNAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  tmpvar_2 = (_glesColor * _Color);
  highp vec4 pos_6;
  pos_6.zw = tmpvar_4.zw;
  highp vec2 tmpvar_7;
  tmpvar_7 = (_ScreenParams.xy * 0.5);
  pos_6.xy = ((floor(
    (((tmpvar_4.xy / tmpvar_4.w) * tmpvar_7) + vec2(0.5, 0.5))
  ) / tmpvar_7) * tmpvar_4.w);
  gl_Position = pos_6;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _EffectAmount;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_2 = tmpvar_3;
  mediump float tmpvar_4;
  tmpvar_4 = dot (texcol_2.xyz, vec3(0.3, 0.59, 0.11));
  highp vec3 tmpvar_5;
  tmpvar_5 = mix (texcol_2.xyz, vec3(tmpvar_4), vec3(_EffectAmount));
  texcol_2.xyz = tmpvar_5;
  texcol_2 = (texcol_2 * xlv_COLOR);
  tmpvar_1 = texcol_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "PIXELSNAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  tmpvar_2 = (_glesColor * _Color);
  highp vec4 pos_6;
  pos_6.zw = tmpvar_4.zw;
  highp vec2 tmpvar_7;
  tmpvar_7 = (_ScreenParams.xy * 0.5);
  pos_6.xy = ((floor(
    (((tmpvar_4.xy / tmpvar_4.w) * tmpvar_7) + vec2(0.5, 0.5))
  ) / tmpvar_7) * tmpvar_4.w);
  gl_Position = pos_6;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _EffectAmount;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_2 = tmpvar_3;
  mediump float tmpvar_4;
  tmpvar_4 = dot (texcol_2.xyz, vec3(0.3, 0.59, 0.11));
  highp vec3 tmpvar_5;
  tmpvar_5 = mix (texcol_2.xyz, vec3(tmpvar_4), vec3(_EffectAmount));
  texcol_2.xyz = tmpvar_5;
  texcol_2 = (texcol_2 * xlv_COLOR);
  tmpvar_1 = texcol_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "PIXELSNAP_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  tmpvar_2 = (_glesColor * _Color);
  highp vec4 pos_6;
  pos_6.zw = tmpvar_4.zw;
  highp vec2 tmpvar_7;
  tmpvar_7 = (_ScreenParams.xy * 0.5);
  pos_6.xy = ((floor(
    (((tmpvar_4.xy / tmpvar_4.w) * tmpvar_7) + vec2(0.5, 0.5))
  ) / tmpvar_7) * tmpvar_4.w);
  gl_Position = pos_6;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _EffectAmount;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 texcol_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texcol_2 = tmpvar_3;
  mediump float tmpvar_4;
  tmpvar_4 = dot (texcol_2.xyz, vec3(0.3, 0.59, 0.11));
  highp vec3 tmpvar_5;
  tmpvar_5 = mix (texcol_2.xyz, vec3(tmpvar_4), vec3(_EffectAmount));
  texcol_2.xyz = tmpvar_5;
  texcol_2 = (texcol_2 * xlv_COLOR);
  tmpvar_1 = texcol_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "PIXELSNAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat1.xy = _ScreenParams.xy * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
    u_xlat0.xy = roundEven(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy / u_xlat1.xy;
    gl_Position.xy = u_xlat0.ww * u_xlat0.xy;
    gl_Position.zw = u_xlat0.zw;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _EffectAmount;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.x = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xxx;
    u_xlat0.xyz = vec3(_EffectAmount) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "PIXELSNAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat1.xy = _ScreenParams.xy * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
    u_xlat0.xy = roundEven(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy / u_xlat1.xy;
    gl_Position.xy = u_xlat0.ww * u_xlat0.xy;
    gl_Position.zw = u_xlat0.zw;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _EffectAmount;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.x = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xxx;
    u_xlat0.xyz = vec3(_EffectAmount) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat0 * vs_COLOR0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "PIXELSNAP_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec2 vs_TEXCOORD0;
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
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    u_xlat0.xy = u_xlat0.xy / u_xlat0.ww;
    u_xlat1.xy = _ScreenParams.xy * vec2(0.5, 0.5);
    u_xlat0.xy = u_xlat0.xy * u_xlat1.xy;
    u_xlat0.xy = roundEven(u_xlat0.xy);
    u_xlat0.xy = u_xlat0.xy / u_xlat1.xy;
    gl_Position.xy = u_xlat0.ww * u_xlat0.xy;
    gl_Position.zw = u_xlat0.zw;
    u_xlat0 = in_COLOR0 * _Color;
    vs_COLOR0 = u_xlat0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	float _EffectAmount;
uniform lowp sampler2D _MainTex;
in mediump vec4 vs_COLOR0;
in mediump vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec3 u_xlat1;
void main()
{
    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1.x = dot(u_xlat0.xyz, vec3(0.300000012, 0.589999974, 0.109999999));
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xxx;
    u_xlat0.xyz = vec3(_EffectAmount) * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0 = u_xlat0 * vs_COLOR0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "DUMMY" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DUMMY" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DUMMY" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "DUMMY" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "DUMMY" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "DUMMY" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "PIXELSNAP_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "PIXELSNAP_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "PIXELSNAP_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "PIXELSNAP_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "PIXELSNAP_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "PIXELSNAP_ON" }
""
}
}
}
}
Fallback "Sprites/Default"
}