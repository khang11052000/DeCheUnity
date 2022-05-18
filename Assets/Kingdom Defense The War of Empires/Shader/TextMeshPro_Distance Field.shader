//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "TextMeshPro/Distance Field" {
Properties {
_FaceTex ("Face Texture", 2D) = "white" { }
_FaceUVSpeedX ("Face UV Speed X", Range(-5, 5)) = 0
_FaceUVSpeedY ("Face UV Speed Y", Range(-5, 5)) = 0
_FaceColor ("Face Color", Color) = (1,1,1,1)
_FaceDilate ("Face Dilate", Range(-1, 1)) = 0
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
_OutlineTex ("Outline Texture", 2D) = "white" { }
_OutlineUVSpeedX ("Outline UV Speed X", Range(-5, 5)) = 0
_OutlineUVSpeedY ("Outline UV Speed Y", Range(-5, 5)) = 0
_OutlineWidth ("Outline Thickness", Range(0, 1)) = 0
_OutlineSoftness ("Outline Softness", Range(-1, 1)) = 0
_Bevel ("Bevel", Range(0, 1)) = 0.5
_BevelOffset ("Bevel Offset", Range(-0.5, 0.5)) = 0
_BevelWidth ("Bevel Width", Range(-0.5, 0.5)) = 0
_BevelClamp ("Bevel Clamp", Range(0, 1)) = 0
_BevelRoundness ("Bevel Roundness", Range(0, 1)) = 0
_LightAngle ("Light Angle", Range(0, 6.283185)) = 3.1416
_SpecularColor ("Specular", Color) = (1,1,1,1)
_SpecularPower ("Specular", Range(0, 4)) = 2
_Reflectivity ("Reflectivity", Range(5, 15)) = 10
_Diffuse ("Diffuse", Range(0, 1)) = 0.5
_Ambient ("Ambient", Range(1, 0)) = 0.5
_BumpMap ("Normal map", 2D) = "bump" { }
_BumpOutline ("Bump Outline", Range(0, 1)) = 0
_BumpFace ("Bump Face", Range(0, 1)) = 0
_ReflectFaceColor ("Reflection Color", Color) = (0,0,0,1)
_ReflectOutlineColor ("Reflection Color", Color) = (0,0,0,1)
_Cube ("Reflection Cubemap", Cube) = "black" { }
_EnvMatrixRotation ("Texture Rotation", Vector) = (0,0,0,0)
_UnderlayColor ("Border Color", Color) = (0,0,0,0.5)
_UnderlayOffsetX ("Border OffsetX", Range(-1, 1)) = 0
_UnderlayOffsetY ("Border OffsetY", Range(-1, 1)) = 0
_UnderlayDilate ("Border Dilate", Range(-1, 1)) = 0
_UnderlaySoftness ("Border Softness", Range(0, 1)) = 0
_GlowColor ("Color", Color) = (0,1,0,0.5)
_GlowOffset ("Offset", Range(-1, 1)) = 0
_GlowInner ("Inner", Range(0, 1)) = 0.05
_GlowOuter ("Outer", Range(0, 1)) = 0.05
_GlowPower ("Falloff", Range(1, 0)) = 0.75
_WeightNormal ("Weight Normal", Float) = 0
_WeightBold ("Weight Bold", Float) = 0.5
_ShaderFlags ("Flags", Float) = 0
_ScaleRatioA ("Scale RatioA", Float) = 1
_ScaleRatioB ("Scale RatioB", Float) = 1
_ScaleRatioC ("Scale RatioC", Float) = 1
_MainTex ("Font Atlas", 2D) = "white" { }
_TextureWidth ("Texture Width", Float) = 512
_TextureHeight ("Texture Height", Float) = 512
_GradientScale ("Gradient Scale", Float) = 5
_ScaleX ("Scale X", Float) = 1
_ScaleY ("Scale Y", Float) = 1
_PerspectiveFilter ("Perspective Correction", Range(0, 1)) = 0.875
_VertexOffsetX ("Vertex OffsetX", Float) = 0
_VertexOffsetY ("Vertex OffsetY", Float) = 0
_MaskCoord ("Mask Coordinates", Vector) = (0,0,32767,32767)
_ClipRect ("Clip Rect", Vector) = (-32767,-32767,32767,32767)
_MaskSoftnessX ("Mask SoftnessX", Float) = 0
_MaskSoftnessY ("Mask SoftnessY", Float) = 0
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend One OneMinusSrcAlpha, One OneMinusSrcAlpha
  ColorMask 0 0
  ZTest Off
  ZWrite Off
  Cull Off
  Stencil {
   ReadMask 0
   WriteMask 0
   Comp Disabled
   Pass Keep
   Fail Keep
   ZFail Keep
  }
  Fog {
   Mode Off
  }
  GpuProgramID 26853
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixVP;
uniform highp float _FaceDilate;
uniform highp float _OutlineSoftness;
uniform highp float _OutlineWidth;
uniform highp mat4 _EnvMatrix;
uniform highp float _WeightNormal;
uniform highp float _WeightBold;
uniform highp float _ScaleRatioA;
uniform highp float _VertexOffsetX;
uniform highp float _VertexOffsetY;
uniform highp vec4 _ClipRect;
uniform highp float _MaskSoftnessX;
uniform highp float _MaskSoftnessY;
uniform highp float _GradientScale;
uniform highp float _ScaleX;
uniform highp float _ScaleY;
uniform highp float _PerspectiveFilter;
uniform highp vec4 _FaceTex_ST;
uniform highp vec4 _OutlineTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp float weight_3;
  highp float scale_4;
  highp vec2 pixelSize_5;
  highp vec4 vert_6;
  highp float tmpvar_7;
  tmpvar_7 = float((0.0 >= _glesMultiTexCoord1.y));
  vert_6.zw = _glesVertex.zw;
  vert_6.x = (_glesVertex.x + _VertexOffsetX);
  vert_6.y = (_glesVertex.y + _VertexOffsetY);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = vert_6.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp vec2 tmpvar_10;
  tmpvar_10.x = _ScaleX;
  tmpvar_10.y = _ScaleY;
  highp mat2 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_projection[0].xy;
  tmpvar_11[1] = glstate_matrix_projection[1].xy;
  pixelSize_5 = (tmpvar_8.ww / (tmpvar_10 * abs(
    (tmpvar_11 * _ScreenParams.xy)
  )));
  scale_4 = (inversesqrt(dot (pixelSize_5, pixelSize_5)) * ((
    abs(_glesMultiTexCoord1.y)
   * _GradientScale) * 1.5));
  if ((glstate_matrix_projection[3].w == 0.0)) {
    highp mat3 tmpvar_12;
    tmpvar_12[0] = unity_WorldToObject[0].xyz;
    tmpvar_12[1] = unity_WorldToObject[1].xyz;
    tmpvar_12[2] = unity_WorldToObject[2].xyz;
    scale_4 = mix ((abs(scale_4) * (1.0 - _PerspectiveFilter)), scale_4, abs(dot (
      normalize((_glesNormal * tmpvar_12))
    , 
      normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_6).xyz))
    )));
  };
  weight_3 = (((
    (mix (_WeightNormal, _WeightBold, tmpvar_7) / 4.0)
   + _FaceDilate) * _ScaleRatioA) * 0.5);
  highp vec4 tmpvar_13;
  tmpvar_13 = clamp (_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10), vec4(2e+10, 2e+10, 2e+10, 2e+10));
  highp vec2 tmpvar_14;
  highp vec2 xlat_varoutput_15;
  xlat_varoutput_15.x = floor((_glesMultiTexCoord1.x / 4096.0));
  xlat_varoutput_15.y = (_glesMultiTexCoord1.x - (4096.0 * xlat_varoutput_15.x));
  tmpvar_14 = (xlat_varoutput_15 * 0.001953125);
  highp vec4 tmpvar_16;
  tmpvar_16.x = (((
    ((1.0 - (_OutlineWidth * _ScaleRatioA)) - (_OutlineSoftness * _ScaleRatioA))
   / 2.0) - (0.5 / scale_4)) - weight_3);
  tmpvar_16.y = scale_4;
  tmpvar_16.z = ((0.5 - weight_3) + (0.5 / scale_4));
  tmpvar_16.w = weight_3;
  highp vec2 tmpvar_17;
  tmpvar_17.x = _MaskSoftnessX;
  tmpvar_17.y = _MaskSoftnessY;
  highp vec4 tmpvar_18;
  tmpvar_18.xy = (((vert_6.xy * 2.0) - tmpvar_13.xy) - tmpvar_13.zw);
  tmpvar_18.zw = (0.25 / ((0.25 * tmpvar_17) + pixelSize_5));
  highp mat3 tmpvar_19;
  tmpvar_19[0] = _EnvMatrix[0].xyz;
  tmpvar_19[1] = _EnvMatrix[1].xyz;
  tmpvar_19[2] = _EnvMatrix[2].xyz;
  highp vec4 tmpvar_20;
  tmpvar_20.xy = ((tmpvar_14 * _FaceTex_ST.xy) + _FaceTex_ST.zw);
  tmpvar_20.zw = ((tmpvar_14 * _OutlineTex_ST.xy) + _OutlineTex_ST.zw);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = (tmpvar_19 * (_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_6).xyz));
  xlv_TEXCOORD5 = tmpvar_20;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _FaceTex;
uniform highp float _FaceUVSpeedX;
uniform highp float _FaceUVSpeedY;
uniform lowp vec4 _FaceColor;
uniform highp float _OutlineSoftness;
uniform sampler2D _OutlineTex;
uniform highp float _OutlineUVSpeedX;
uniform highp float _OutlineUVSpeedY;
uniform lowp vec4 _OutlineColor;
uniform highp float _OutlineWidth;
uniform highp float _ScaleRatioA;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 outlineColor_2;
  mediump vec4 faceColor_3;
  highp float c_4;
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  c_4 = tmpvar_5;
  highp float x_6;
  x_6 = (c_4 - xlv_TEXCOORD1.x);
  if ((x_6 < 0.0)) {
    discard;
  };
  highp float tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD1.z - c_4) * xlv_TEXCOORD1.y);
  highp float tmpvar_8;
  tmpvar_8 = ((_OutlineWidth * _ScaleRatioA) * xlv_TEXCOORD1.y);
  highp float tmpvar_9;
  tmpvar_9 = ((_OutlineSoftness * _ScaleRatioA) * xlv_TEXCOORD1.y);
  faceColor_3 = _FaceColor;
  outlineColor_2 = _OutlineColor;
  faceColor_3.xyz = (faceColor_3.xyz * xlv_COLOR.xyz);
  highp vec2 tmpvar_10;
  tmpvar_10.x = _FaceUVSpeedX;
  tmpvar_10.y = _FaceUVSpeedY;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD5.xy + (tmpvar_10 * _Time.y));
  tmpvar_11 = texture2D (_FaceTex, P_12);
  faceColor_3 = (faceColor_3 * tmpvar_11);
  highp vec2 tmpvar_13;
  tmpvar_13.x = _OutlineUVSpeedX;
  tmpvar_13.y = _OutlineUVSpeedY;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD5.zw + (tmpvar_13 * _Time.y));
  tmpvar_14 = texture2D (_OutlineTex, P_15);
  outlineColor_2 = (outlineColor_2 * tmpvar_14);
  mediump float d_16;
  d_16 = tmpvar_7;
  lowp vec4 faceColor_17;
  faceColor_17 = faceColor_3;
  lowp vec4 outlineColor_18;
  outlineColor_18 = outlineColor_2;
  mediump float outline_19;
  outline_19 = tmpvar_8;
  mediump float softness_20;
  softness_20 = tmpvar_9;
  mediump float tmpvar_21;
  tmpvar_21 = (1.0 - clamp ((
    ((d_16 - (outline_19 * 0.5)) + (softness_20 * 0.5))
   / 
    (1.0 + softness_20)
  ), 0.0, 1.0));
  faceColor_17.xyz = (faceColor_17.xyz * faceColor_17.w);
  outlineColor_18.xyz = (outlineColor_18.xyz * outlineColor_18.w);
  mediump vec4 tmpvar_22;
  tmpvar_22 = mix (faceColor_17, outlineColor_18, vec4((clamp (
    (d_16 + (outline_19 * 0.5))
  , 0.0, 1.0) * sqrt(
    min (1.0, outline_19)
  ))));
  faceColor_17 = tmpvar_22;
  faceColor_17 = (faceColor_17 * tmpvar_21);
  faceColor_3 = faceColor_17;
  tmpvar_1 = (faceColor_3 * xlv_COLOR.w);
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixVP;
uniform highp float _FaceDilate;
uniform highp float _OutlineSoftness;
uniform highp float _OutlineWidth;
uniform highp mat4 _EnvMatrix;
uniform highp float _WeightNormal;
uniform highp float _WeightBold;
uniform highp float _ScaleRatioA;
uniform highp float _VertexOffsetX;
uniform highp float _VertexOffsetY;
uniform highp vec4 _ClipRect;
uniform highp float _MaskSoftnessX;
uniform highp float _MaskSoftnessY;
uniform highp float _GradientScale;
uniform highp float _ScaleX;
uniform highp float _ScaleY;
uniform highp float _PerspectiveFilter;
uniform highp vec4 _FaceTex_ST;
uniform highp vec4 _OutlineTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp float weight_3;
  highp float scale_4;
  highp vec2 pixelSize_5;
  highp vec4 vert_6;
  highp float tmpvar_7;
  tmpvar_7 = float((0.0 >= _glesMultiTexCoord1.y));
  vert_6.zw = _glesVertex.zw;
  vert_6.x = (_glesVertex.x + _VertexOffsetX);
  vert_6.y = (_glesVertex.y + _VertexOffsetY);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = vert_6.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp vec2 tmpvar_10;
  tmpvar_10.x = _ScaleX;
  tmpvar_10.y = _ScaleY;
  highp mat2 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_projection[0].xy;
  tmpvar_11[1] = glstate_matrix_projection[1].xy;
  pixelSize_5 = (tmpvar_8.ww / (tmpvar_10 * abs(
    (tmpvar_11 * _ScreenParams.xy)
  )));
  scale_4 = (inversesqrt(dot (pixelSize_5, pixelSize_5)) * ((
    abs(_glesMultiTexCoord1.y)
   * _GradientScale) * 1.5));
  if ((glstate_matrix_projection[3].w == 0.0)) {
    highp mat3 tmpvar_12;
    tmpvar_12[0] = unity_WorldToObject[0].xyz;
    tmpvar_12[1] = unity_WorldToObject[1].xyz;
    tmpvar_12[2] = unity_WorldToObject[2].xyz;
    scale_4 = mix ((abs(scale_4) * (1.0 - _PerspectiveFilter)), scale_4, abs(dot (
      normalize((_glesNormal * tmpvar_12))
    , 
      normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_6).xyz))
    )));
  };
  weight_3 = (((
    (mix (_WeightNormal, _WeightBold, tmpvar_7) / 4.0)
   + _FaceDilate) * _ScaleRatioA) * 0.5);
  highp vec4 tmpvar_13;
  tmpvar_13 = clamp (_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10), vec4(2e+10, 2e+10, 2e+10, 2e+10));
  highp vec2 tmpvar_14;
  highp vec2 xlat_varoutput_15;
  xlat_varoutput_15.x = floor((_glesMultiTexCoord1.x / 4096.0));
  xlat_varoutput_15.y = (_glesMultiTexCoord1.x - (4096.0 * xlat_varoutput_15.x));
  tmpvar_14 = (xlat_varoutput_15 * 0.001953125);
  highp vec4 tmpvar_16;
  tmpvar_16.x = (((
    ((1.0 - (_OutlineWidth * _ScaleRatioA)) - (_OutlineSoftness * _ScaleRatioA))
   / 2.0) - (0.5 / scale_4)) - weight_3);
  tmpvar_16.y = scale_4;
  tmpvar_16.z = ((0.5 - weight_3) + (0.5 / scale_4));
  tmpvar_16.w = weight_3;
  highp vec2 tmpvar_17;
  tmpvar_17.x = _MaskSoftnessX;
  tmpvar_17.y = _MaskSoftnessY;
  highp vec4 tmpvar_18;
  tmpvar_18.xy = (((vert_6.xy * 2.0) - tmpvar_13.xy) - tmpvar_13.zw);
  tmpvar_18.zw = (0.25 / ((0.25 * tmpvar_17) + pixelSize_5));
  highp mat3 tmpvar_19;
  tmpvar_19[0] = _EnvMatrix[0].xyz;
  tmpvar_19[1] = _EnvMatrix[1].xyz;
  tmpvar_19[2] = _EnvMatrix[2].xyz;
  highp vec4 tmpvar_20;
  tmpvar_20.xy = ((tmpvar_14 * _FaceTex_ST.xy) + _FaceTex_ST.zw);
  tmpvar_20.zw = ((tmpvar_14 * _OutlineTex_ST.xy) + _OutlineTex_ST.zw);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = (tmpvar_19 * (_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_6).xyz));
  xlv_TEXCOORD5 = tmpvar_20;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _FaceTex;
uniform highp float _FaceUVSpeedX;
uniform highp float _FaceUVSpeedY;
uniform lowp vec4 _FaceColor;
uniform highp float _OutlineSoftness;
uniform sampler2D _OutlineTex;
uniform highp float _OutlineUVSpeedX;
uniform highp float _OutlineUVSpeedY;
uniform lowp vec4 _OutlineColor;
uniform highp float _OutlineWidth;
uniform highp float _ScaleRatioA;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 outlineColor_2;
  mediump vec4 faceColor_3;
  highp float c_4;
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  c_4 = tmpvar_5;
  highp float x_6;
  x_6 = (c_4 - xlv_TEXCOORD1.x);
  if ((x_6 < 0.0)) {
    discard;
  };
  highp float tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD1.z - c_4) * xlv_TEXCOORD1.y);
  highp float tmpvar_8;
  tmpvar_8 = ((_OutlineWidth * _ScaleRatioA) * xlv_TEXCOORD1.y);
  highp float tmpvar_9;
  tmpvar_9 = ((_OutlineSoftness * _ScaleRatioA) * xlv_TEXCOORD1.y);
  faceColor_3 = _FaceColor;
  outlineColor_2 = _OutlineColor;
  faceColor_3.xyz = (faceColor_3.xyz * xlv_COLOR.xyz);
  highp vec2 tmpvar_10;
  tmpvar_10.x = _FaceUVSpeedX;
  tmpvar_10.y = _FaceUVSpeedY;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD5.xy + (tmpvar_10 * _Time.y));
  tmpvar_11 = texture2D (_FaceTex, P_12);
  faceColor_3 = (faceColor_3 * tmpvar_11);
  highp vec2 tmpvar_13;
  tmpvar_13.x = _OutlineUVSpeedX;
  tmpvar_13.y = _OutlineUVSpeedY;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD5.zw + (tmpvar_13 * _Time.y));
  tmpvar_14 = texture2D (_OutlineTex, P_15);
  outlineColor_2 = (outlineColor_2 * tmpvar_14);
  mediump float d_16;
  d_16 = tmpvar_7;
  lowp vec4 faceColor_17;
  faceColor_17 = faceColor_3;
  lowp vec4 outlineColor_18;
  outlineColor_18 = outlineColor_2;
  mediump float outline_19;
  outline_19 = tmpvar_8;
  mediump float softness_20;
  softness_20 = tmpvar_9;
  mediump float tmpvar_21;
  tmpvar_21 = (1.0 - clamp ((
    ((d_16 - (outline_19 * 0.5)) + (softness_20 * 0.5))
   / 
    (1.0 + softness_20)
  ), 0.0, 1.0));
  faceColor_17.xyz = (faceColor_17.xyz * faceColor_17.w);
  outlineColor_18.xyz = (outlineColor_18.xyz * outlineColor_18.w);
  mediump vec4 tmpvar_22;
  tmpvar_22 = mix (faceColor_17, outlineColor_18, vec4((clamp (
    (d_16 + (outline_19 * 0.5))
  , 0.0, 1.0) * sqrt(
    min (1.0, outline_19)
  ))));
  faceColor_17 = tmpvar_22;
  faceColor_17 = (faceColor_17 * tmpvar_21);
  faceColor_3 = faceColor_17;
  tmpvar_1 = (faceColor_3 * xlv_COLOR.w);
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixVP;
uniform highp float _FaceDilate;
uniform highp float _OutlineSoftness;
uniform highp float _OutlineWidth;
uniform highp mat4 _EnvMatrix;
uniform highp float _WeightNormal;
uniform highp float _WeightBold;
uniform highp float _ScaleRatioA;
uniform highp float _VertexOffsetX;
uniform highp float _VertexOffsetY;
uniform highp vec4 _ClipRect;
uniform highp float _MaskSoftnessX;
uniform highp float _MaskSoftnessY;
uniform highp float _GradientScale;
uniform highp float _ScaleX;
uniform highp float _ScaleY;
uniform highp float _PerspectiveFilter;
uniform highp vec4 _FaceTex_ST;
uniform highp vec4 _OutlineTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp float weight_3;
  highp float scale_4;
  highp vec2 pixelSize_5;
  highp vec4 vert_6;
  highp float tmpvar_7;
  tmpvar_7 = float((0.0 >= _glesMultiTexCoord1.y));
  vert_6.zw = _glesVertex.zw;
  vert_6.x = (_glesVertex.x + _VertexOffsetX);
  vert_6.y = (_glesVertex.y + _VertexOffsetY);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = vert_6.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp vec2 tmpvar_10;
  tmpvar_10.x = _ScaleX;
  tmpvar_10.y = _ScaleY;
  highp mat2 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_projection[0].xy;
  tmpvar_11[1] = glstate_matrix_projection[1].xy;
  pixelSize_5 = (tmpvar_8.ww / (tmpvar_10 * abs(
    (tmpvar_11 * _ScreenParams.xy)
  )));
  scale_4 = (inversesqrt(dot (pixelSize_5, pixelSize_5)) * ((
    abs(_glesMultiTexCoord1.y)
   * _GradientScale) * 1.5));
  if ((glstate_matrix_projection[3].w == 0.0)) {
    highp mat3 tmpvar_12;
    tmpvar_12[0] = unity_WorldToObject[0].xyz;
    tmpvar_12[1] = unity_WorldToObject[1].xyz;
    tmpvar_12[2] = unity_WorldToObject[2].xyz;
    scale_4 = mix ((abs(scale_4) * (1.0 - _PerspectiveFilter)), scale_4, abs(dot (
      normalize((_glesNormal * tmpvar_12))
    , 
      normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_6).xyz))
    )));
  };
  weight_3 = (((
    (mix (_WeightNormal, _WeightBold, tmpvar_7) / 4.0)
   + _FaceDilate) * _ScaleRatioA) * 0.5);
  highp vec4 tmpvar_13;
  tmpvar_13 = clamp (_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10), vec4(2e+10, 2e+10, 2e+10, 2e+10));
  highp vec2 tmpvar_14;
  highp vec2 xlat_varoutput_15;
  xlat_varoutput_15.x = floor((_glesMultiTexCoord1.x / 4096.0));
  xlat_varoutput_15.y = (_glesMultiTexCoord1.x - (4096.0 * xlat_varoutput_15.x));
  tmpvar_14 = (xlat_varoutput_15 * 0.001953125);
  highp vec4 tmpvar_16;
  tmpvar_16.x = (((
    ((1.0 - (_OutlineWidth * _ScaleRatioA)) - (_OutlineSoftness * _ScaleRatioA))
   / 2.0) - (0.5 / scale_4)) - weight_3);
  tmpvar_16.y = scale_4;
  tmpvar_16.z = ((0.5 - weight_3) + (0.5 / scale_4));
  tmpvar_16.w = weight_3;
  highp vec2 tmpvar_17;
  tmpvar_17.x = _MaskSoftnessX;
  tmpvar_17.y = _MaskSoftnessY;
  highp vec4 tmpvar_18;
  tmpvar_18.xy = (((vert_6.xy * 2.0) - tmpvar_13.xy) - tmpvar_13.zw);
  tmpvar_18.zw = (0.25 / ((0.25 * tmpvar_17) + pixelSize_5));
  highp mat3 tmpvar_19;
  tmpvar_19[0] = _EnvMatrix[0].xyz;
  tmpvar_19[1] = _EnvMatrix[1].xyz;
  tmpvar_19[2] = _EnvMatrix[2].xyz;
  highp vec4 tmpvar_20;
  tmpvar_20.xy = ((tmpvar_14 * _FaceTex_ST.xy) + _FaceTex_ST.zw);
  tmpvar_20.zw = ((tmpvar_14 * _OutlineTex_ST.xy) + _OutlineTex_ST.zw);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = (tmpvar_19 * (_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_6).xyz));
  xlv_TEXCOORD5 = tmpvar_20;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _FaceTex;
uniform highp float _FaceUVSpeedX;
uniform highp float _FaceUVSpeedY;
uniform lowp vec4 _FaceColor;
uniform highp float _OutlineSoftness;
uniform sampler2D _OutlineTex;
uniform highp float _OutlineUVSpeedX;
uniform highp float _OutlineUVSpeedY;
uniform lowp vec4 _OutlineColor;
uniform highp float _OutlineWidth;
uniform highp float _ScaleRatioA;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 outlineColor_2;
  mediump vec4 faceColor_3;
  highp float c_4;
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  c_4 = tmpvar_5;
  highp float x_6;
  x_6 = (c_4 - xlv_TEXCOORD1.x);
  if ((x_6 < 0.0)) {
    discard;
  };
  highp float tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD1.z - c_4) * xlv_TEXCOORD1.y);
  highp float tmpvar_8;
  tmpvar_8 = ((_OutlineWidth * _ScaleRatioA) * xlv_TEXCOORD1.y);
  highp float tmpvar_9;
  tmpvar_9 = ((_OutlineSoftness * _ScaleRatioA) * xlv_TEXCOORD1.y);
  faceColor_3 = _FaceColor;
  outlineColor_2 = _OutlineColor;
  faceColor_3.xyz = (faceColor_3.xyz * xlv_COLOR.xyz);
  highp vec2 tmpvar_10;
  tmpvar_10.x = _FaceUVSpeedX;
  tmpvar_10.y = _FaceUVSpeedY;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD5.xy + (tmpvar_10 * _Time.y));
  tmpvar_11 = texture2D (_FaceTex, P_12);
  faceColor_3 = (faceColor_3 * tmpvar_11);
  highp vec2 tmpvar_13;
  tmpvar_13.x = _OutlineUVSpeedX;
  tmpvar_13.y = _OutlineUVSpeedY;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD5.zw + (tmpvar_13 * _Time.y));
  tmpvar_14 = texture2D (_OutlineTex, P_15);
  outlineColor_2 = (outlineColor_2 * tmpvar_14);
  mediump float d_16;
  d_16 = tmpvar_7;
  lowp vec4 faceColor_17;
  faceColor_17 = faceColor_3;
  lowp vec4 outlineColor_18;
  outlineColor_18 = outlineColor_2;
  mediump float outline_19;
  outline_19 = tmpvar_8;
  mediump float softness_20;
  softness_20 = tmpvar_9;
  mediump float tmpvar_21;
  tmpvar_21 = (1.0 - clamp ((
    ((d_16 - (outline_19 * 0.5)) + (softness_20 * 0.5))
   / 
    (1.0 + softness_20)
  ), 0.0, 1.0));
  faceColor_17.xyz = (faceColor_17.xyz * faceColor_17.w);
  outlineColor_18.xyz = (outlineColor_18.xyz * outlineColor_18.w);
  mediump vec4 tmpvar_22;
  tmpvar_22 = mix (faceColor_17, outlineColor_18, vec4((clamp (
    (d_16 + (outline_19 * 0.5))
  , 0.0, 1.0) * sqrt(
    min (1.0, outline_19)
  ))));
  faceColor_17 = tmpvar_22;
  faceColor_17 = (faceColor_17 * tmpvar_21);
  faceColor_3 = faceColor_17;
  tmpvar_1 = (faceColor_3 * xlv_COLOR.w);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _FaceDilate;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineWidth;
uniform 	vec4 hlslcc_mtx4x4_EnvMatrix[4];
uniform 	float _WeightNormal;
uniform 	float _WeightBold;
uniform 	float _ScaleRatioA;
uniform 	float _VertexOffsetX;
uniform 	float _VertexOffsetY;
uniform 	vec4 _ClipRect;
uniform 	float _MaskSoftnessX;
uniform 	float _MaskSoftnessY;
uniform 	float _GradientScale;
uniform 	float _ScaleX;
uniform 	float _ScaleY;
uniform 	float _PerspectiveFilter;
uniform 	vec4 _FaceTex_ST;
uniform 	vec4 _OutlineTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat6;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0.xy = vec2(in_POSITION0.x + float(_VertexOffsetX), in_POSITION0.y + float(_VertexOffsetY));
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat2.xyz = u_xlat8.xxx * u_xlat2.xyz;
    u_xlat8.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat2.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat2.xy;
    u_xlat2.xy = vec2(abs(u_xlat2.x) * float(_ScaleX), abs(u_xlat2.y) * float(_ScaleY));
    u_xlat2.xy = u_xlat2.ww / u_xlat2.xy;
    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat2.xy;
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat2.xy;
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat13 = abs(in_TEXCOORD1.y) * _GradientScale;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * 1.5;
    u_xlat2.x = (-_PerspectiveFilter) + 1.0;
    u_xlat2.x = abs(u_xlat13) * u_xlat2.x;
    u_xlat12 = u_xlat12 * 1.5 + (-u_xlat2.x);
    u_xlat8.x = abs(u_xlat8.x) * u_xlat12 + u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0);
#else
    u_xlatb12 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
#endif
    u_xlat6.x = (u_xlatb12) ? u_xlat8.x : u_xlat13;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.0>=in_TEXCOORD1.y);
#else
    u_xlatb8 = 0.0>=in_TEXCOORD1.y;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat12 = (-_WeightNormal) + _WeightBold;
    u_xlat8.x = u_xlat8.x * u_xlat12 + _WeightNormal;
    u_xlat8.x = u_xlat8.x * 0.25 + _FaceDilate;
    u_xlat8.x = u_xlat8.x * _ScaleRatioA;
    u_xlat6.z = u_xlat8.x * 0.5;
    vs_TEXCOORD1.yw = u_xlat6.xz;
    u_xlat12 = 0.5 / u_xlat6.x;
    u_xlat13 = (-_OutlineWidth) * _ScaleRatioA + 1.0;
    u_xlat13 = (-_OutlineSoftness) * _ScaleRatioA + u_xlat13;
    u_xlat13 = u_xlat13 * 0.5 + (-u_xlat12);
    vs_TEXCOORD1.x = (-u_xlat8.x) * 0.5 + u_xlat13;
    u_xlat8.x = (-u_xlat8.x) * 0.5 + 0.5;
    vs_TEXCOORD1.z = u_xlat12 + u_xlat8.x;
    u_xlat2 = max(_ClipRect, vec4(-2e+010, -2e+010, -2e+010, -2e+010));
    u_xlat2 = min(u_xlat2, vec4(2e+010, 2e+010, 2e+010, 2e+010));
    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat2.xy);
    vs_TEXCOORD2.xy = vec2((-u_xlat2.z) + u_xlat0.x, (-u_xlat2.w) + u_xlat0.y);
    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4x4_EnvMatrix[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_EnvMatrix[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4_EnvMatrix[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x * 0.000244140625;
    u_xlat8.x = floor(u_xlat0.x);
    u_xlat8.y = (-u_xlat8.x) * 4096.0 + in_TEXCOORD1.x;
    u_xlat0.xy = u_xlat8.xy * vec2(0.001953125, 0.001953125);
    vs_TEXCOORD5.xy = u_xlat0.xy * _FaceTex_ST.xy + _FaceTex_ST.zw;
    vs_TEXCOORD5.zw = u_xlat0.xy * _OutlineTex_ST.xy + _OutlineTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _FaceUVSpeedX;
uniform 	float _FaceUVSpeedY;
uniform 	mediump vec4 _FaceColor;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineUVSpeedX;
uniform 	float _OutlineUVSpeedY;
uniform 	mediump vec4 _OutlineColor;
uniform 	float _OutlineWidth;
uniform 	float _ScaleRatioA;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FaceTex;
uniform lowp sampler2D _OutlineTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_4;
lowp vec4 u_xlat10_4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_6;
float u_xlat9;
mediump float u_xlat16_11;
void main()
{
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat5 = u_xlat10_0.x + (-vs_TEXCOORD1.x);
    u_xlat0.x = (-u_xlat10_0.x) + vs_TEXCOORD1.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5<0.0);
#else
    u_xlatb5 = u_xlat5<0.0;
#endif
    if((int(u_xlatb5) * int(0xffffffffu))!=0){discard;}
    u_xlat5 = _OutlineWidth * _ScaleRatioA;
    u_xlat5 = u_xlat5 * vs_TEXCOORD1.y;
    u_xlat16_1 = min(u_xlat5, 1.0);
    u_xlat16_6 = u_xlat5 * 0.5;
    u_xlat16_1 = sqrt(u_xlat16_1);
    u_xlat16_11 = u_xlat0.x * vs_TEXCOORD1.y + u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat0.x * vs_TEXCOORD1.y + (-u_xlat16_6);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_11;
    u_xlat0.xy = vec2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy + vs_TEXCOORD5.zw;
    u_xlat10_0 = texture(_OutlineTex, u_xlat0.xy);
    u_xlat16_2 = u_xlat10_0 * _OutlineColor;
    u_xlat16_3.xyz = vs_COLOR0.xyz * _FaceColor.xyz;
    u_xlat0.xy = vec2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy + vs_TEXCOORD5.xy;
    u_xlat10_4 = texture(_FaceTex, u_xlat0.xy);
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat10_4.xyz;
    u_xlat16_4 = u_xlat10_4.w * _FaceColor.w;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vec3(u_xlat16_4);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_2.www + (-u_xlat16_3.xyz);
    u_xlat16_2.w = _OutlineColor.w * u_xlat10_0.w + (-u_xlat16_4);
    u_xlat16_2 = vec4(u_xlat16_1) * u_xlat16_2;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_4) + u_xlat16_2.xyz;
    u_xlat16_0.w = _FaceColor.w * u_xlat10_4.w + u_xlat16_2.w;
    u_xlat4 = _OutlineSoftness * _ScaleRatioA;
    u_xlat9 = u_xlat4 * vs_TEXCOORD1.y;
    u_xlat16_1 = u_xlat4 * vs_TEXCOORD1.y + 1.0;
    u_xlat16_6 = u_xlat9 * 0.5 + u_xlat16_6;
    u_xlat16_1 = u_xlat16_6 / u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_0 = u_xlat16_0 * vec4(u_xlat16_1);
    SV_Target0 = u_xlat16_0 * vs_COLOR0.wwww;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _FaceDilate;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineWidth;
uniform 	vec4 hlslcc_mtx4x4_EnvMatrix[4];
uniform 	float _WeightNormal;
uniform 	float _WeightBold;
uniform 	float _ScaleRatioA;
uniform 	float _VertexOffsetX;
uniform 	float _VertexOffsetY;
uniform 	vec4 _ClipRect;
uniform 	float _MaskSoftnessX;
uniform 	float _MaskSoftnessY;
uniform 	float _GradientScale;
uniform 	float _ScaleX;
uniform 	float _ScaleY;
uniform 	float _PerspectiveFilter;
uniform 	vec4 _FaceTex_ST;
uniform 	vec4 _OutlineTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat6;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0.xy = vec2(in_POSITION0.x + float(_VertexOffsetX), in_POSITION0.y + float(_VertexOffsetY));
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat2.xyz = u_xlat8.xxx * u_xlat2.xyz;
    u_xlat8.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat2.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat2.xy;
    u_xlat2.xy = vec2(abs(u_xlat2.x) * float(_ScaleX), abs(u_xlat2.y) * float(_ScaleY));
    u_xlat2.xy = u_xlat2.ww / u_xlat2.xy;
    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat2.xy;
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat2.xy;
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat13 = abs(in_TEXCOORD1.y) * _GradientScale;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * 1.5;
    u_xlat2.x = (-_PerspectiveFilter) + 1.0;
    u_xlat2.x = abs(u_xlat13) * u_xlat2.x;
    u_xlat12 = u_xlat12 * 1.5 + (-u_xlat2.x);
    u_xlat8.x = abs(u_xlat8.x) * u_xlat12 + u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0);
#else
    u_xlatb12 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
#endif
    u_xlat6.x = (u_xlatb12) ? u_xlat8.x : u_xlat13;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.0>=in_TEXCOORD1.y);
#else
    u_xlatb8 = 0.0>=in_TEXCOORD1.y;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat12 = (-_WeightNormal) + _WeightBold;
    u_xlat8.x = u_xlat8.x * u_xlat12 + _WeightNormal;
    u_xlat8.x = u_xlat8.x * 0.25 + _FaceDilate;
    u_xlat8.x = u_xlat8.x * _ScaleRatioA;
    u_xlat6.z = u_xlat8.x * 0.5;
    vs_TEXCOORD1.yw = u_xlat6.xz;
    u_xlat12 = 0.5 / u_xlat6.x;
    u_xlat13 = (-_OutlineWidth) * _ScaleRatioA + 1.0;
    u_xlat13 = (-_OutlineSoftness) * _ScaleRatioA + u_xlat13;
    u_xlat13 = u_xlat13 * 0.5 + (-u_xlat12);
    vs_TEXCOORD1.x = (-u_xlat8.x) * 0.5 + u_xlat13;
    u_xlat8.x = (-u_xlat8.x) * 0.5 + 0.5;
    vs_TEXCOORD1.z = u_xlat12 + u_xlat8.x;
    u_xlat2 = max(_ClipRect, vec4(-2e+010, -2e+010, -2e+010, -2e+010));
    u_xlat2 = min(u_xlat2, vec4(2e+010, 2e+010, 2e+010, 2e+010));
    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat2.xy);
    vs_TEXCOORD2.xy = vec2((-u_xlat2.z) + u_xlat0.x, (-u_xlat2.w) + u_xlat0.y);
    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4x4_EnvMatrix[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_EnvMatrix[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4_EnvMatrix[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x * 0.000244140625;
    u_xlat8.x = floor(u_xlat0.x);
    u_xlat8.y = (-u_xlat8.x) * 4096.0 + in_TEXCOORD1.x;
    u_xlat0.xy = u_xlat8.xy * vec2(0.001953125, 0.001953125);
    vs_TEXCOORD5.xy = u_xlat0.xy * _FaceTex_ST.xy + _FaceTex_ST.zw;
    vs_TEXCOORD5.zw = u_xlat0.xy * _OutlineTex_ST.xy + _OutlineTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _FaceUVSpeedX;
uniform 	float _FaceUVSpeedY;
uniform 	mediump vec4 _FaceColor;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineUVSpeedX;
uniform 	float _OutlineUVSpeedY;
uniform 	mediump vec4 _OutlineColor;
uniform 	float _OutlineWidth;
uniform 	float _ScaleRatioA;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FaceTex;
uniform lowp sampler2D _OutlineTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_4;
lowp vec4 u_xlat10_4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_6;
float u_xlat9;
mediump float u_xlat16_11;
void main()
{
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat5 = u_xlat10_0.x + (-vs_TEXCOORD1.x);
    u_xlat0.x = (-u_xlat10_0.x) + vs_TEXCOORD1.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5<0.0);
#else
    u_xlatb5 = u_xlat5<0.0;
#endif
    if((int(u_xlatb5) * int(0xffffffffu))!=0){discard;}
    u_xlat5 = _OutlineWidth * _ScaleRatioA;
    u_xlat5 = u_xlat5 * vs_TEXCOORD1.y;
    u_xlat16_1 = min(u_xlat5, 1.0);
    u_xlat16_6 = u_xlat5 * 0.5;
    u_xlat16_1 = sqrt(u_xlat16_1);
    u_xlat16_11 = u_xlat0.x * vs_TEXCOORD1.y + u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat0.x * vs_TEXCOORD1.y + (-u_xlat16_6);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_11;
    u_xlat0.xy = vec2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy + vs_TEXCOORD5.zw;
    u_xlat10_0 = texture(_OutlineTex, u_xlat0.xy);
    u_xlat16_2 = u_xlat10_0 * _OutlineColor;
    u_xlat16_3.xyz = vs_COLOR0.xyz * _FaceColor.xyz;
    u_xlat0.xy = vec2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy + vs_TEXCOORD5.xy;
    u_xlat10_4 = texture(_FaceTex, u_xlat0.xy);
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat10_4.xyz;
    u_xlat16_4 = u_xlat10_4.w * _FaceColor.w;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vec3(u_xlat16_4);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_2.www + (-u_xlat16_3.xyz);
    u_xlat16_2.w = _OutlineColor.w * u_xlat10_0.w + (-u_xlat16_4);
    u_xlat16_2 = vec4(u_xlat16_1) * u_xlat16_2;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_4) + u_xlat16_2.xyz;
    u_xlat16_0.w = _FaceColor.w * u_xlat10_4.w + u_xlat16_2.w;
    u_xlat4 = _OutlineSoftness * _ScaleRatioA;
    u_xlat9 = u_xlat4 * vs_TEXCOORD1.y;
    u_xlat16_1 = u_xlat4 * vs_TEXCOORD1.y + 1.0;
    u_xlat16_6 = u_xlat9 * 0.5 + u_xlat16_6;
    u_xlat16_1 = u_xlat16_6 / u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_0 = u_xlat16_0 * vec4(u_xlat16_1);
    SV_Target0 = u_xlat16_0 * vs_COLOR0.wwww;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _FaceDilate;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineWidth;
uniform 	vec4 hlslcc_mtx4x4_EnvMatrix[4];
uniform 	float _WeightNormal;
uniform 	float _WeightBold;
uniform 	float _ScaleRatioA;
uniform 	float _VertexOffsetX;
uniform 	float _VertexOffsetY;
uniform 	vec4 _ClipRect;
uniform 	float _MaskSoftnessX;
uniform 	float _MaskSoftnessY;
uniform 	float _GradientScale;
uniform 	float _ScaleX;
uniform 	float _ScaleY;
uniform 	float _PerspectiveFilter;
uniform 	vec4 _FaceTex_ST;
uniform 	vec4 _OutlineTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat6;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0.xy = vec2(in_POSITION0.x + float(_VertexOffsetX), in_POSITION0.y + float(_VertexOffsetY));
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat2.xyz = u_xlat8.xxx * u_xlat2.xyz;
    u_xlat8.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat2.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat2.xy;
    u_xlat2.xy = vec2(abs(u_xlat2.x) * float(_ScaleX), abs(u_xlat2.y) * float(_ScaleY));
    u_xlat2.xy = u_xlat2.ww / u_xlat2.xy;
    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat2.xy;
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat2.xy;
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat13 = abs(in_TEXCOORD1.y) * _GradientScale;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * 1.5;
    u_xlat2.x = (-_PerspectiveFilter) + 1.0;
    u_xlat2.x = abs(u_xlat13) * u_xlat2.x;
    u_xlat12 = u_xlat12 * 1.5 + (-u_xlat2.x);
    u_xlat8.x = abs(u_xlat8.x) * u_xlat12 + u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0);
#else
    u_xlatb12 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
#endif
    u_xlat6.x = (u_xlatb12) ? u_xlat8.x : u_xlat13;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.0>=in_TEXCOORD1.y);
#else
    u_xlatb8 = 0.0>=in_TEXCOORD1.y;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat12 = (-_WeightNormal) + _WeightBold;
    u_xlat8.x = u_xlat8.x * u_xlat12 + _WeightNormal;
    u_xlat8.x = u_xlat8.x * 0.25 + _FaceDilate;
    u_xlat8.x = u_xlat8.x * _ScaleRatioA;
    u_xlat6.z = u_xlat8.x * 0.5;
    vs_TEXCOORD1.yw = u_xlat6.xz;
    u_xlat12 = 0.5 / u_xlat6.x;
    u_xlat13 = (-_OutlineWidth) * _ScaleRatioA + 1.0;
    u_xlat13 = (-_OutlineSoftness) * _ScaleRatioA + u_xlat13;
    u_xlat13 = u_xlat13 * 0.5 + (-u_xlat12);
    vs_TEXCOORD1.x = (-u_xlat8.x) * 0.5 + u_xlat13;
    u_xlat8.x = (-u_xlat8.x) * 0.5 + 0.5;
    vs_TEXCOORD1.z = u_xlat12 + u_xlat8.x;
    u_xlat2 = max(_ClipRect, vec4(-2e+010, -2e+010, -2e+010, -2e+010));
    u_xlat2 = min(u_xlat2, vec4(2e+010, 2e+010, 2e+010, 2e+010));
    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat2.xy);
    vs_TEXCOORD2.xy = vec2((-u_xlat2.z) + u_xlat0.x, (-u_xlat2.w) + u_xlat0.y);
    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4x4_EnvMatrix[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_EnvMatrix[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4_EnvMatrix[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x * 0.000244140625;
    u_xlat8.x = floor(u_xlat0.x);
    u_xlat8.y = (-u_xlat8.x) * 4096.0 + in_TEXCOORD1.x;
    u_xlat0.xy = u_xlat8.xy * vec2(0.001953125, 0.001953125);
    vs_TEXCOORD5.xy = u_xlat0.xy * _FaceTex_ST.xy + _FaceTex_ST.zw;
    vs_TEXCOORD5.zw = u_xlat0.xy * _OutlineTex_ST.xy + _OutlineTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _FaceUVSpeedX;
uniform 	float _FaceUVSpeedY;
uniform 	mediump vec4 _FaceColor;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineUVSpeedX;
uniform 	float _OutlineUVSpeedY;
uniform 	mediump vec4 _OutlineColor;
uniform 	float _OutlineWidth;
uniform 	float _ScaleRatioA;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FaceTex;
uniform lowp sampler2D _OutlineTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
float u_xlat4;
mediump float u_xlat16_4;
lowp vec4 u_xlat10_4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_6;
float u_xlat9;
mediump float u_xlat16_11;
void main()
{
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat5 = u_xlat10_0.x + (-vs_TEXCOORD1.x);
    u_xlat0.x = (-u_xlat10_0.x) + vs_TEXCOORD1.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5<0.0);
#else
    u_xlatb5 = u_xlat5<0.0;
#endif
    if((int(u_xlatb5) * int(0xffffffffu))!=0){discard;}
    u_xlat5 = _OutlineWidth * _ScaleRatioA;
    u_xlat5 = u_xlat5 * vs_TEXCOORD1.y;
    u_xlat16_1 = min(u_xlat5, 1.0);
    u_xlat16_6 = u_xlat5 * 0.5;
    u_xlat16_1 = sqrt(u_xlat16_1);
    u_xlat16_11 = u_xlat0.x * vs_TEXCOORD1.y + u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat0.x * vs_TEXCOORD1.y + (-u_xlat16_6);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_11;
    u_xlat0.xy = vec2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy + vs_TEXCOORD5.zw;
    u_xlat10_0 = texture(_OutlineTex, u_xlat0.xy);
    u_xlat16_2 = u_xlat10_0 * _OutlineColor;
    u_xlat16_3.xyz = vs_COLOR0.xyz * _FaceColor.xyz;
    u_xlat0.xy = vec2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy + vs_TEXCOORD5.xy;
    u_xlat10_4 = texture(_FaceTex, u_xlat0.xy);
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat10_4.xyz;
    u_xlat16_4 = u_xlat10_4.w * _FaceColor.w;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vec3(u_xlat16_4);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_2.www + (-u_xlat16_3.xyz);
    u_xlat16_2.w = _OutlineColor.w * u_xlat10_0.w + (-u_xlat16_4);
    u_xlat16_2 = vec4(u_xlat16_1) * u_xlat16_2;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_4) + u_xlat16_2.xyz;
    u_xlat16_0.w = _FaceColor.w * u_xlat10_4.w + u_xlat16_2.w;
    u_xlat4 = _OutlineSoftness * _ScaleRatioA;
    u_xlat9 = u_xlat4 * vs_TEXCOORD1.y;
    u_xlat16_1 = u_xlat4 * vs_TEXCOORD1.y + 1.0;
    u_xlat16_6 = u_xlat9 * 0.5 + u_xlat16_6;
    u_xlat16_1 = u_xlat16_6 / u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_0 = u_xlat16_0 * vec4(u_xlat16_1);
    SV_Target0 = u_xlat16_0 * vs_COLOR0.wwww;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixVP;
uniform highp float _FaceDilate;
uniform highp float _OutlineSoftness;
uniform highp float _OutlineWidth;
uniform highp mat4 _EnvMatrix;
uniform lowp vec4 _UnderlayColor;
uniform highp float _UnderlayOffsetX;
uniform highp float _UnderlayOffsetY;
uniform highp float _UnderlayDilate;
uniform highp float _UnderlaySoftness;
uniform highp float _GlowOffset;
uniform highp float _GlowOuter;
uniform highp float _WeightNormal;
uniform highp float _WeightBold;
uniform highp float _ScaleRatioA;
uniform highp float _ScaleRatioB;
uniform highp float _ScaleRatioC;
uniform highp float _VertexOffsetX;
uniform highp float _VertexOffsetY;
uniform highp vec4 _ClipRect;
uniform highp float _MaskSoftnessX;
uniform highp float _MaskSoftnessY;
uniform highp float _TextureWidth;
uniform highp float _TextureHeight;
uniform highp float _GradientScale;
uniform highp float _ScaleX;
uniform highp float _ScaleY;
uniform highp float _PerspectiveFilter;
uniform highp vec4 _FaceTex_ST;
uniform highp vec4 _OutlineTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp float bScale_3;
  highp vec4 underlayColor_4;
  highp float weight_5;
  highp float scale_6;
  highp vec2 pixelSize_7;
  highp vec4 vert_8;
  highp float tmpvar_9;
  tmpvar_9 = float((0.0 >= _glesMultiTexCoord1.y));
  vert_8.zw = _glesVertex.zw;
  vert_8.x = (_glesVertex.x + _VertexOffsetX);
  vert_8.y = (_glesVertex.y + _VertexOffsetY);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = vert_8.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec2 tmpvar_12;
  tmpvar_12.x = _ScaleX;
  tmpvar_12.y = _ScaleY;
  highp mat2 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_projection[0].xy;
  tmpvar_13[1] = glstate_matrix_projection[1].xy;
  pixelSize_7 = (tmpvar_10.ww / (tmpvar_12 * abs(
    (tmpvar_13 * _ScreenParams.xy)
  )));
  scale_6 = (inversesqrt(dot (pixelSize_7, pixelSize_7)) * ((
    abs(_glesMultiTexCoord1.y)
   * _GradientScale) * 1.5));
  if ((glstate_matrix_projection[3].w == 0.0)) {
    highp mat3 tmpvar_14;
    tmpvar_14[0] = unity_WorldToObject[0].xyz;
    tmpvar_14[1] = unity_WorldToObject[1].xyz;
    tmpvar_14[2] = unity_WorldToObject[2].xyz;
    scale_6 = mix ((abs(scale_6) * (1.0 - _PerspectiveFilter)), scale_6, abs(dot (
      normalize((_glesNormal * tmpvar_14))
    , 
      normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_8).xyz))
    )));
  };
  weight_5 = (((
    (mix (_WeightNormal, _WeightBold, tmpvar_9) / 4.0)
   + _FaceDilate) * _ScaleRatioA) * 0.5);
  underlayColor_4 = _UnderlayColor;
  underlayColor_4.xyz = (underlayColor_4.xyz * underlayColor_4.w);
  bScale_3 = (scale_6 / (1.0 + (
    (_UnderlaySoftness * _ScaleRatioC)
   * scale_6)));
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((-(
    (_UnderlayOffsetX * _ScaleRatioC)
  ) * _GradientScale) / _TextureWidth);
  tmpvar_15.y = ((-(
    (_UnderlayOffsetY * _ScaleRatioC)
  ) * _GradientScale) / _TextureHeight);
  highp vec4 tmpvar_16;
  tmpvar_16 = clamp (_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10), vec4(2e+10, 2e+10, 2e+10, 2e+10));
  highp vec2 tmpvar_17;
  highp vec2 xlat_varoutput_18;
  xlat_varoutput_18.x = floor((_glesMultiTexCoord1.x / 4096.0));
  xlat_varoutput_18.y = (_glesMultiTexCoord1.x - (4096.0 * xlat_varoutput_18.x));
  tmpvar_17 = (xlat_varoutput_18 * 0.001953125);
  highp vec4 tmpvar_19;
  tmpvar_19.x = (((
    min (((1.0 - (_OutlineWidth * _ScaleRatioA)) - (_OutlineSoftness * _ScaleRatioA)), ((1.0 - (_GlowOffset * _ScaleRatioB)) - (_GlowOuter * _ScaleRatioB)))
   / 2.0) - (0.5 / scale_6)) - weight_5);
  tmpvar_19.y = scale_6;
  tmpvar_19.z = ((0.5 - weight_5) + (0.5 / scale_6));
  tmpvar_19.w = weight_5;
  highp vec2 tmpvar_20;
  tmpvar_20.x = _MaskSoftnessX;
  tmpvar_20.y = _MaskSoftnessY;
  highp vec4 tmpvar_21;
  tmpvar_21.xy = (((vert_8.xy * 2.0) - tmpvar_16.xy) - tmpvar_16.zw);
  tmpvar_21.zw = (0.25 / ((0.25 * tmpvar_20) + pixelSize_7));
  highp mat3 tmpvar_22;
  tmpvar_22[0] = _EnvMatrix[0].xyz;
  tmpvar_22[1] = _EnvMatrix[1].xyz;
  tmpvar_22[2] = _EnvMatrix[2].xyz;
  highp vec4 tmpvar_23;
  tmpvar_23.xy = (_glesMultiTexCoord0.xy + tmpvar_15);
  tmpvar_23.z = bScale_3;
  tmpvar_23.w = (((
    (0.5 - weight_5)
   * bScale_3) - 0.5) - ((_UnderlayDilate * _ScaleRatioC) * (0.5 * bScale_3)));
  highp vec4 tmpvar_24;
  tmpvar_24.xy = ((tmpvar_17 * _FaceTex_ST.xy) + _FaceTex_ST.zw);
  tmpvar_24.zw = ((tmpvar_17 * _OutlineTex_ST.xy) + _OutlineTex_ST.zw);
  lowp vec4 tmpvar_25;
  tmpvar_25 = underlayColor_4;
  gl_Position = tmpvar_10;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_19;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = (tmpvar_22 * (_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_8).xyz));
  xlv_TEXCOORD4 = tmpvar_23;
  xlv_COLOR1 = tmpvar_25;
  xlv_TEXCOORD5 = tmpvar_24;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _FaceTex;
uniform highp float _FaceUVSpeedX;
uniform highp float _FaceUVSpeedY;
uniform lowp vec4 _FaceColor;
uniform highp float _OutlineSoftness;
uniform sampler2D _OutlineTex;
uniform highp float _OutlineUVSpeedX;
uniform highp float _OutlineUVSpeedY;
uniform lowp vec4 _OutlineColor;
uniform highp float _OutlineWidth;
uniform highp float _Bevel;
uniform highp float _BevelOffset;
uniform highp float _BevelWidth;
uniform highp float _BevelClamp;
uniform highp float _BevelRoundness;
uniform sampler2D _BumpMap;
uniform highp float _BumpOutline;
uniform highp float _BumpFace;
uniform lowp samplerCube _Cube;
uniform lowp vec4 _ReflectFaceColor;
uniform lowp vec4 _ReflectOutlineColor;
uniform lowp vec4 _SpecularColor;
uniform highp float _LightAngle;
uniform highp float _SpecularPower;
uniform highp float _Reflectivity;
uniform highp float _Diffuse;
uniform highp float _Ambient;
uniform lowp vec4 _GlowColor;
uniform highp float _GlowOffset;
uniform highp float _GlowOuter;
uniform highp float _GlowInner;
uniform highp float _GlowPower;
uniform highp float _ShaderFlags;
uniform highp float _ScaleRatioA;
uniform highp float _ScaleRatioB;
uniform sampler2D _MainTex;
uniform highp float _TextureWidth;
uniform highp float _TextureHeight;
uniform highp float _GradientScale;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 bump_2;
  mediump vec4 outlineColor_3;
  mediump vec4 faceColor_4;
  highp float c_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  c_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD1.z - c_5) * xlv_TEXCOORD1.y);
  highp float tmpvar_8;
  tmpvar_8 = ((_OutlineWidth * _ScaleRatioA) * xlv_TEXCOORD1.y);
  highp float tmpvar_9;
  tmpvar_9 = ((_OutlineSoftness * _ScaleRatioA) * xlv_TEXCOORD1.y);
  faceColor_4 = _FaceColor;
  outlineColor_3 = _OutlineColor;
  faceColor_4.xyz = (faceColor_4.xyz * xlv_COLOR.xyz);
  highp vec2 tmpvar_10;
  tmpvar_10.x = _FaceUVSpeedX;
  tmpvar_10.y = _FaceUVSpeedY;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD5.xy + (tmpvar_10 * _Time.y));
  tmpvar_11 = texture2D (_FaceTex, P_12);
  faceColor_4 = (faceColor_4 * tmpvar_11);
  highp vec2 tmpvar_13;
  tmpvar_13.x = _OutlineUVSpeedX;
  tmpvar_13.y = _OutlineUVSpeedY;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD5.zw + (tmpvar_13 * _Time.y));
  tmpvar_14 = texture2D (_OutlineTex, P_15);
  outlineColor_3 = (outlineColor_3 * tmpvar_14);
  mediump float d_16;
  d_16 = tmpvar_7;
  lowp vec4 faceColor_17;
  faceColor_17 = faceColor_4;
  lowp vec4 outlineColor_18;
  outlineColor_18 = outlineColor_3;
  mediump float outline_19;
  outline_19 = tmpvar_8;
  mediump float softness_20;
  softness_20 = tmpvar_9;
  mediump float tmpvar_21;
  tmpvar_21 = (1.0 - clamp ((
    ((d_16 - (outline_19 * 0.5)) + (softness_20 * 0.5))
   / 
    (1.0 + softness_20)
  ), 0.0, 1.0));
  faceColor_17.xyz = (faceColor_17.xyz * faceColor_17.w);
  outlineColor_18.xyz = (outlineColor_18.xyz * outlineColor_18.w);
  mediump vec4 tmpvar_22;
  tmpvar_22 = mix (faceColor_17, outlineColor_18, vec4((clamp (
    (d_16 + (outline_19 * 0.5))
  , 0.0, 1.0) * sqrt(
    min (1.0, outline_19)
  ))));
  faceColor_17 = tmpvar_22;
  faceColor_17 = (faceColor_17 * tmpvar_21);
  faceColor_4 = faceColor_17;
  highp vec3 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.x = (0.5 / _TextureWidth);
  tmpvar_23.y = (0.5 / _TextureHeight);
  highp vec4 h_24;
  highp vec2 P_25;
  P_25 = (xlv_TEXCOORD0 - tmpvar_23.xz);
  highp vec2 P_26;
  P_26 = (xlv_TEXCOORD0 + tmpvar_23.xz);
  highp vec2 P_27;
  P_27 = (xlv_TEXCOORD0 - tmpvar_23.zy);
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_23.zy);
  lowp vec4 tmpvar_29;
  tmpvar_29.x = texture2D (_MainTex, P_25).w;
  tmpvar_29.y = texture2D (_MainTex, P_26).w;
  tmpvar_29.z = texture2D (_MainTex, P_27).w;
  tmpvar_29.w = texture2D (_MainTex, P_28).w;
  h_24 = tmpvar_29;
  highp vec4 h_30;
  h_30 = h_24;
  highp float tmpvar_31;
  tmpvar_31 = (_ShaderFlags / 2.0);
  highp float tmpvar_32;
  tmpvar_32 = (fract(abs(tmpvar_31)) * 2.0);
  highp float tmpvar_33;
  if ((tmpvar_31 >= 0.0)) {
    tmpvar_33 = tmpvar_32;
  } else {
    tmpvar_33 = -(tmpvar_32);
  };
  h_30 = (h_24 + (xlv_TEXCOORD1.w + _BevelOffset));
  highp float tmpvar_34;
  tmpvar_34 = max (0.01, (_OutlineWidth + _BevelWidth));
  h_30 = (h_30 - 0.5);
  h_30 = (h_30 / tmpvar_34);
  highp vec4 tmpvar_35;
  tmpvar_35 = clamp ((h_30 + 0.5), 0.0, 1.0);
  h_30 = tmpvar_35;
  if (bool(float((tmpvar_33 >= 1.0)))) {
    h_30 = (1.0 - abs((
      (tmpvar_35 * 2.0)
     - 1.0)));
  };
  h_30 = (min (mix (h_30, 
    sin(((h_30 * 3.141592) / 2.0))
  , vec4(_BevelRoundness)), vec4((1.0 - _BevelClamp))) * ((_Bevel * tmpvar_34) * (_GradientScale * -2.0)));
  highp vec3 tmpvar_36;
  tmpvar_36.xy = vec2(1.0, 0.0);
  tmpvar_36.z = (h_30.y - h_30.x);
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(tmpvar_36);
  highp vec3 tmpvar_38;
  tmpvar_38.xy = vec2(0.0, -1.0);
  tmpvar_38.z = (h_30.w - h_30.z);
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(tmpvar_38);
  highp vec2 tmpvar_40;
  tmpvar_40.x = _FaceUVSpeedX;
  tmpvar_40.y = _FaceUVSpeedY;
  highp vec2 P_41;
  P_41 = (xlv_TEXCOORD5.xy + (tmpvar_40 * _Time.y));
  lowp vec3 tmpvar_42;
  tmpvar_42 = ((texture2D (_BumpMap, P_41).xyz * 2.0) - 1.0);
  bump_2 = tmpvar_42;
  bump_2 = (bump_2 * mix (_BumpFace, _BumpOutline, clamp (
    (tmpvar_7 + (tmpvar_8 * 0.5))
  , 0.0, 1.0)));
  highp vec3 tmpvar_43;
  tmpvar_43 = normalize(((
    (tmpvar_37.yzx * tmpvar_39.zxy)
   - 
    (tmpvar_37.zxy * tmpvar_39.yzx)
  ) - bump_2));
  highp vec3 tmpvar_44;
  tmpvar_44.z = -1.0;
  tmpvar_44.x = sin(_LightAngle);
  tmpvar_44.y = cos(_LightAngle);
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize(tmpvar_44);
  highp vec3 tmpvar_46;
  tmpvar_46 = ((_SpecularColor.xyz * pow (
    max (0.0, dot (tmpvar_43, tmpvar_45))
  , _Reflectivity)) * _SpecularPower);
  faceColor_4.xyz = (faceColor_4.xyz + (tmpvar_46 * faceColor_4.w));
  highp float tmpvar_47;
  tmpvar_47 = dot (tmpvar_43, tmpvar_45);
  faceColor_4.xyz = (faceColor_4.xyz * (1.0 - (tmpvar_47 * _Diffuse)));
  highp float tmpvar_48;
  tmpvar_48 = mix (_Ambient, 1.0, (tmpvar_43.z * tmpvar_43.z));
  faceColor_4.xyz = (faceColor_4.xyz * tmpvar_48);
  highp vec3 tmpvar_49;
  highp vec3 N_50;
  N_50 = -(tmpvar_43);
  tmpvar_49 = (xlv_TEXCOORD3 - (2.0 * (
    dot (N_50, xlv_TEXCOORD3)
   * N_50)));
  lowp vec4 tmpvar_51;
  tmpvar_51 = textureCube (_Cube, tmpvar_49);
  highp float tmpvar_52;
  tmpvar_52 = clamp ((tmpvar_7 + (tmpvar_8 * 0.5)), 0.0, 1.0);
  lowp vec3 tmpvar_53;
  tmpvar_53 = mix (_ReflectFaceColor.xyz, _ReflectOutlineColor.xyz, vec3(tmpvar_52));
  faceColor_4.xyz = (faceColor_4.xyz + ((tmpvar_51.xyz * tmpvar_53) * faceColor_4.w));
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_MainTex, xlv_TEXCOORD4.xy);
  highp float tmpvar_55;
  tmpvar_55 = clamp (((tmpvar_54.w * xlv_TEXCOORD4.z) - xlv_TEXCOORD4.w), 0.0, 1.0);
  faceColor_4 = (faceColor_4 + ((xlv_COLOR1 * tmpvar_55) * (1.0 - faceColor_4.w)));
  highp vec4 tmpvar_56;
  highp float glow_57;
  highp float tmpvar_58;
  tmpvar_58 = (tmpvar_7 - ((_GlowOffset * _ScaleRatioB) * (0.5 * xlv_TEXCOORD1.y)));
  highp float tmpvar_59;
  tmpvar_59 = ((mix (_GlowInner, 
    (_GlowOuter * _ScaleRatioB)
  , 
    float((tmpvar_58 >= 0.0))
  ) * 0.5) * xlv_TEXCOORD1.y);
  glow_57 = (1.0 - pow (clamp (
    abs((tmpvar_58 / (1.0 + tmpvar_59)))
  , 0.0, 1.0), _GlowPower));
  glow_57 = (glow_57 * sqrt(min (1.0, tmpvar_59)));
  highp float tmpvar_60;
  tmpvar_60 = clamp (((_GlowColor.w * glow_57) * 2.0), 0.0, 1.0);
  lowp vec4 tmpvar_61;
  tmpvar_61.xyz = _GlowColor.xyz;
  tmpvar_61.w = tmpvar_60;
  tmpvar_56 = tmpvar_61;
  faceColor_4.xyz = (faceColor_4.xyz + (tmpvar_56.xyz * tmpvar_56.w));
  tmpvar_1 = (faceColor_4 * xlv_COLOR.w);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixVP;
uniform highp float _FaceDilate;
uniform highp float _OutlineSoftness;
uniform highp float _OutlineWidth;
uniform highp mat4 _EnvMatrix;
uniform lowp vec4 _UnderlayColor;
uniform highp float _UnderlayOffsetX;
uniform highp float _UnderlayOffsetY;
uniform highp float _UnderlayDilate;
uniform highp float _UnderlaySoftness;
uniform highp float _GlowOffset;
uniform highp float _GlowOuter;
uniform highp float _WeightNormal;
uniform highp float _WeightBold;
uniform highp float _ScaleRatioA;
uniform highp float _ScaleRatioB;
uniform highp float _ScaleRatioC;
uniform highp float _VertexOffsetX;
uniform highp float _VertexOffsetY;
uniform highp vec4 _ClipRect;
uniform highp float _MaskSoftnessX;
uniform highp float _MaskSoftnessY;
uniform highp float _TextureWidth;
uniform highp float _TextureHeight;
uniform highp float _GradientScale;
uniform highp float _ScaleX;
uniform highp float _ScaleY;
uniform highp float _PerspectiveFilter;
uniform highp vec4 _FaceTex_ST;
uniform highp vec4 _OutlineTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp float bScale_3;
  highp vec4 underlayColor_4;
  highp float weight_5;
  highp float scale_6;
  highp vec2 pixelSize_7;
  highp vec4 vert_8;
  highp float tmpvar_9;
  tmpvar_9 = float((0.0 >= _glesMultiTexCoord1.y));
  vert_8.zw = _glesVertex.zw;
  vert_8.x = (_glesVertex.x + _VertexOffsetX);
  vert_8.y = (_glesVertex.y + _VertexOffsetY);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = vert_8.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec2 tmpvar_12;
  tmpvar_12.x = _ScaleX;
  tmpvar_12.y = _ScaleY;
  highp mat2 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_projection[0].xy;
  tmpvar_13[1] = glstate_matrix_projection[1].xy;
  pixelSize_7 = (tmpvar_10.ww / (tmpvar_12 * abs(
    (tmpvar_13 * _ScreenParams.xy)
  )));
  scale_6 = (inversesqrt(dot (pixelSize_7, pixelSize_7)) * ((
    abs(_glesMultiTexCoord1.y)
   * _GradientScale) * 1.5));
  if ((glstate_matrix_projection[3].w == 0.0)) {
    highp mat3 tmpvar_14;
    tmpvar_14[0] = unity_WorldToObject[0].xyz;
    tmpvar_14[1] = unity_WorldToObject[1].xyz;
    tmpvar_14[2] = unity_WorldToObject[2].xyz;
    scale_6 = mix ((abs(scale_6) * (1.0 - _PerspectiveFilter)), scale_6, abs(dot (
      normalize((_glesNormal * tmpvar_14))
    , 
      normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_8).xyz))
    )));
  };
  weight_5 = (((
    (mix (_WeightNormal, _WeightBold, tmpvar_9) / 4.0)
   + _FaceDilate) * _ScaleRatioA) * 0.5);
  underlayColor_4 = _UnderlayColor;
  underlayColor_4.xyz = (underlayColor_4.xyz * underlayColor_4.w);
  bScale_3 = (scale_6 / (1.0 + (
    (_UnderlaySoftness * _ScaleRatioC)
   * scale_6)));
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((-(
    (_UnderlayOffsetX * _ScaleRatioC)
  ) * _GradientScale) / _TextureWidth);
  tmpvar_15.y = ((-(
    (_UnderlayOffsetY * _ScaleRatioC)
  ) * _GradientScale) / _TextureHeight);
  highp vec4 tmpvar_16;
  tmpvar_16 = clamp (_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10), vec4(2e+10, 2e+10, 2e+10, 2e+10));
  highp vec2 tmpvar_17;
  highp vec2 xlat_varoutput_18;
  xlat_varoutput_18.x = floor((_glesMultiTexCoord1.x / 4096.0));
  xlat_varoutput_18.y = (_glesMultiTexCoord1.x - (4096.0 * xlat_varoutput_18.x));
  tmpvar_17 = (xlat_varoutput_18 * 0.001953125);
  highp vec4 tmpvar_19;
  tmpvar_19.x = (((
    min (((1.0 - (_OutlineWidth * _ScaleRatioA)) - (_OutlineSoftness * _ScaleRatioA)), ((1.0 - (_GlowOffset * _ScaleRatioB)) - (_GlowOuter * _ScaleRatioB)))
   / 2.0) - (0.5 / scale_6)) - weight_5);
  tmpvar_19.y = scale_6;
  tmpvar_19.z = ((0.5 - weight_5) + (0.5 / scale_6));
  tmpvar_19.w = weight_5;
  highp vec2 tmpvar_20;
  tmpvar_20.x = _MaskSoftnessX;
  tmpvar_20.y = _MaskSoftnessY;
  highp vec4 tmpvar_21;
  tmpvar_21.xy = (((vert_8.xy * 2.0) - tmpvar_16.xy) - tmpvar_16.zw);
  tmpvar_21.zw = (0.25 / ((0.25 * tmpvar_20) + pixelSize_7));
  highp mat3 tmpvar_22;
  tmpvar_22[0] = _EnvMatrix[0].xyz;
  tmpvar_22[1] = _EnvMatrix[1].xyz;
  tmpvar_22[2] = _EnvMatrix[2].xyz;
  highp vec4 tmpvar_23;
  tmpvar_23.xy = (_glesMultiTexCoord0.xy + tmpvar_15);
  tmpvar_23.z = bScale_3;
  tmpvar_23.w = (((
    (0.5 - weight_5)
   * bScale_3) - 0.5) - ((_UnderlayDilate * _ScaleRatioC) * (0.5 * bScale_3)));
  highp vec4 tmpvar_24;
  tmpvar_24.xy = ((tmpvar_17 * _FaceTex_ST.xy) + _FaceTex_ST.zw);
  tmpvar_24.zw = ((tmpvar_17 * _OutlineTex_ST.xy) + _OutlineTex_ST.zw);
  lowp vec4 tmpvar_25;
  tmpvar_25 = underlayColor_4;
  gl_Position = tmpvar_10;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_19;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = (tmpvar_22 * (_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_8).xyz));
  xlv_TEXCOORD4 = tmpvar_23;
  xlv_COLOR1 = tmpvar_25;
  xlv_TEXCOORD5 = tmpvar_24;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _FaceTex;
uniform highp float _FaceUVSpeedX;
uniform highp float _FaceUVSpeedY;
uniform lowp vec4 _FaceColor;
uniform highp float _OutlineSoftness;
uniform sampler2D _OutlineTex;
uniform highp float _OutlineUVSpeedX;
uniform highp float _OutlineUVSpeedY;
uniform lowp vec4 _OutlineColor;
uniform highp float _OutlineWidth;
uniform highp float _Bevel;
uniform highp float _BevelOffset;
uniform highp float _BevelWidth;
uniform highp float _BevelClamp;
uniform highp float _BevelRoundness;
uniform sampler2D _BumpMap;
uniform highp float _BumpOutline;
uniform highp float _BumpFace;
uniform lowp samplerCube _Cube;
uniform lowp vec4 _ReflectFaceColor;
uniform lowp vec4 _ReflectOutlineColor;
uniform lowp vec4 _SpecularColor;
uniform highp float _LightAngle;
uniform highp float _SpecularPower;
uniform highp float _Reflectivity;
uniform highp float _Diffuse;
uniform highp float _Ambient;
uniform lowp vec4 _GlowColor;
uniform highp float _GlowOffset;
uniform highp float _GlowOuter;
uniform highp float _GlowInner;
uniform highp float _GlowPower;
uniform highp float _ShaderFlags;
uniform highp float _ScaleRatioA;
uniform highp float _ScaleRatioB;
uniform sampler2D _MainTex;
uniform highp float _TextureWidth;
uniform highp float _TextureHeight;
uniform highp float _GradientScale;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 bump_2;
  mediump vec4 outlineColor_3;
  mediump vec4 faceColor_4;
  highp float c_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  c_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD1.z - c_5) * xlv_TEXCOORD1.y);
  highp float tmpvar_8;
  tmpvar_8 = ((_OutlineWidth * _ScaleRatioA) * xlv_TEXCOORD1.y);
  highp float tmpvar_9;
  tmpvar_9 = ((_OutlineSoftness * _ScaleRatioA) * xlv_TEXCOORD1.y);
  faceColor_4 = _FaceColor;
  outlineColor_3 = _OutlineColor;
  faceColor_4.xyz = (faceColor_4.xyz * xlv_COLOR.xyz);
  highp vec2 tmpvar_10;
  tmpvar_10.x = _FaceUVSpeedX;
  tmpvar_10.y = _FaceUVSpeedY;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD5.xy + (tmpvar_10 * _Time.y));
  tmpvar_11 = texture2D (_FaceTex, P_12);
  faceColor_4 = (faceColor_4 * tmpvar_11);
  highp vec2 tmpvar_13;
  tmpvar_13.x = _OutlineUVSpeedX;
  tmpvar_13.y = _OutlineUVSpeedY;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD5.zw + (tmpvar_13 * _Time.y));
  tmpvar_14 = texture2D (_OutlineTex, P_15);
  outlineColor_3 = (outlineColor_3 * tmpvar_14);
  mediump float d_16;
  d_16 = tmpvar_7;
  lowp vec4 faceColor_17;
  faceColor_17 = faceColor_4;
  lowp vec4 outlineColor_18;
  outlineColor_18 = outlineColor_3;
  mediump float outline_19;
  outline_19 = tmpvar_8;
  mediump float softness_20;
  softness_20 = tmpvar_9;
  mediump float tmpvar_21;
  tmpvar_21 = (1.0 - clamp ((
    ((d_16 - (outline_19 * 0.5)) + (softness_20 * 0.5))
   / 
    (1.0 + softness_20)
  ), 0.0, 1.0));
  faceColor_17.xyz = (faceColor_17.xyz * faceColor_17.w);
  outlineColor_18.xyz = (outlineColor_18.xyz * outlineColor_18.w);
  mediump vec4 tmpvar_22;
  tmpvar_22 = mix (faceColor_17, outlineColor_18, vec4((clamp (
    (d_16 + (outline_19 * 0.5))
  , 0.0, 1.0) * sqrt(
    min (1.0, outline_19)
  ))));
  faceColor_17 = tmpvar_22;
  faceColor_17 = (faceColor_17 * tmpvar_21);
  faceColor_4 = faceColor_17;
  highp vec3 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.x = (0.5 / _TextureWidth);
  tmpvar_23.y = (0.5 / _TextureHeight);
  highp vec4 h_24;
  highp vec2 P_25;
  P_25 = (xlv_TEXCOORD0 - tmpvar_23.xz);
  highp vec2 P_26;
  P_26 = (xlv_TEXCOORD0 + tmpvar_23.xz);
  highp vec2 P_27;
  P_27 = (xlv_TEXCOORD0 - tmpvar_23.zy);
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_23.zy);
  lowp vec4 tmpvar_29;
  tmpvar_29.x = texture2D (_MainTex, P_25).w;
  tmpvar_29.y = texture2D (_MainTex, P_26).w;
  tmpvar_29.z = texture2D (_MainTex, P_27).w;
  tmpvar_29.w = texture2D (_MainTex, P_28).w;
  h_24 = tmpvar_29;
  highp vec4 h_30;
  h_30 = h_24;
  highp float tmpvar_31;
  tmpvar_31 = (_ShaderFlags / 2.0);
  highp float tmpvar_32;
  tmpvar_32 = (fract(abs(tmpvar_31)) * 2.0);
  highp float tmpvar_33;
  if ((tmpvar_31 >= 0.0)) {
    tmpvar_33 = tmpvar_32;
  } else {
    tmpvar_33 = -(tmpvar_32);
  };
  h_30 = (h_24 + (xlv_TEXCOORD1.w + _BevelOffset));
  highp float tmpvar_34;
  tmpvar_34 = max (0.01, (_OutlineWidth + _BevelWidth));
  h_30 = (h_30 - 0.5);
  h_30 = (h_30 / tmpvar_34);
  highp vec4 tmpvar_35;
  tmpvar_35 = clamp ((h_30 + 0.5), 0.0, 1.0);
  h_30 = tmpvar_35;
  if (bool(float((tmpvar_33 >= 1.0)))) {
    h_30 = (1.0 - abs((
      (tmpvar_35 * 2.0)
     - 1.0)));
  };
  h_30 = (min (mix (h_30, 
    sin(((h_30 * 3.141592) / 2.0))
  , vec4(_BevelRoundness)), vec4((1.0 - _BevelClamp))) * ((_Bevel * tmpvar_34) * (_GradientScale * -2.0)));
  highp vec3 tmpvar_36;
  tmpvar_36.xy = vec2(1.0, 0.0);
  tmpvar_36.z = (h_30.y - h_30.x);
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(tmpvar_36);
  highp vec3 tmpvar_38;
  tmpvar_38.xy = vec2(0.0, -1.0);
  tmpvar_38.z = (h_30.w - h_30.z);
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(tmpvar_38);
  highp vec2 tmpvar_40;
  tmpvar_40.x = _FaceUVSpeedX;
  tmpvar_40.y = _FaceUVSpeedY;
  highp vec2 P_41;
  P_41 = (xlv_TEXCOORD5.xy + (tmpvar_40 * _Time.y));
  lowp vec3 tmpvar_42;
  tmpvar_42 = ((texture2D (_BumpMap, P_41).xyz * 2.0) - 1.0);
  bump_2 = tmpvar_42;
  bump_2 = (bump_2 * mix (_BumpFace, _BumpOutline, clamp (
    (tmpvar_7 + (tmpvar_8 * 0.5))
  , 0.0, 1.0)));
  highp vec3 tmpvar_43;
  tmpvar_43 = normalize(((
    (tmpvar_37.yzx * tmpvar_39.zxy)
   - 
    (tmpvar_37.zxy * tmpvar_39.yzx)
  ) - bump_2));
  highp vec3 tmpvar_44;
  tmpvar_44.z = -1.0;
  tmpvar_44.x = sin(_LightAngle);
  tmpvar_44.y = cos(_LightAngle);
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize(tmpvar_44);
  highp vec3 tmpvar_46;
  tmpvar_46 = ((_SpecularColor.xyz * pow (
    max (0.0, dot (tmpvar_43, tmpvar_45))
  , _Reflectivity)) * _SpecularPower);
  faceColor_4.xyz = (faceColor_4.xyz + (tmpvar_46 * faceColor_4.w));
  highp float tmpvar_47;
  tmpvar_47 = dot (tmpvar_43, tmpvar_45);
  faceColor_4.xyz = (faceColor_4.xyz * (1.0 - (tmpvar_47 * _Diffuse)));
  highp float tmpvar_48;
  tmpvar_48 = mix (_Ambient, 1.0, (tmpvar_43.z * tmpvar_43.z));
  faceColor_4.xyz = (faceColor_4.xyz * tmpvar_48);
  highp vec3 tmpvar_49;
  highp vec3 N_50;
  N_50 = -(tmpvar_43);
  tmpvar_49 = (xlv_TEXCOORD3 - (2.0 * (
    dot (N_50, xlv_TEXCOORD3)
   * N_50)));
  lowp vec4 tmpvar_51;
  tmpvar_51 = textureCube (_Cube, tmpvar_49);
  highp float tmpvar_52;
  tmpvar_52 = clamp ((tmpvar_7 + (tmpvar_8 * 0.5)), 0.0, 1.0);
  lowp vec3 tmpvar_53;
  tmpvar_53 = mix (_ReflectFaceColor.xyz, _ReflectOutlineColor.xyz, vec3(tmpvar_52));
  faceColor_4.xyz = (faceColor_4.xyz + ((tmpvar_51.xyz * tmpvar_53) * faceColor_4.w));
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_MainTex, xlv_TEXCOORD4.xy);
  highp float tmpvar_55;
  tmpvar_55 = clamp (((tmpvar_54.w * xlv_TEXCOORD4.z) - xlv_TEXCOORD4.w), 0.0, 1.0);
  faceColor_4 = (faceColor_4 + ((xlv_COLOR1 * tmpvar_55) * (1.0 - faceColor_4.w)));
  highp vec4 tmpvar_56;
  highp float glow_57;
  highp float tmpvar_58;
  tmpvar_58 = (tmpvar_7 - ((_GlowOffset * _ScaleRatioB) * (0.5 * xlv_TEXCOORD1.y)));
  highp float tmpvar_59;
  tmpvar_59 = ((mix (_GlowInner, 
    (_GlowOuter * _ScaleRatioB)
  , 
    float((tmpvar_58 >= 0.0))
  ) * 0.5) * xlv_TEXCOORD1.y);
  glow_57 = (1.0 - pow (clamp (
    abs((tmpvar_58 / (1.0 + tmpvar_59)))
  , 0.0, 1.0), _GlowPower));
  glow_57 = (glow_57 * sqrt(min (1.0, tmpvar_59)));
  highp float tmpvar_60;
  tmpvar_60 = clamp (((_GlowColor.w * glow_57) * 2.0), 0.0, 1.0);
  lowp vec4 tmpvar_61;
  tmpvar_61.xyz = _GlowColor.xyz;
  tmpvar_61.w = tmpvar_60;
  tmpvar_56 = tmpvar_61;
  faceColor_4.xyz = (faceColor_4.xyz + (tmpvar_56.xyz * tmpvar_56.w));
  tmpvar_1 = (faceColor_4 * xlv_COLOR.w);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixVP;
uniform highp float _FaceDilate;
uniform highp float _OutlineSoftness;
uniform highp float _OutlineWidth;
uniform highp mat4 _EnvMatrix;
uniform lowp vec4 _UnderlayColor;
uniform highp float _UnderlayOffsetX;
uniform highp float _UnderlayOffsetY;
uniform highp float _UnderlayDilate;
uniform highp float _UnderlaySoftness;
uniform highp float _GlowOffset;
uniform highp float _GlowOuter;
uniform highp float _WeightNormal;
uniform highp float _WeightBold;
uniform highp float _ScaleRatioA;
uniform highp float _ScaleRatioB;
uniform highp float _ScaleRatioC;
uniform highp float _VertexOffsetX;
uniform highp float _VertexOffsetY;
uniform highp vec4 _ClipRect;
uniform highp float _MaskSoftnessX;
uniform highp float _MaskSoftnessY;
uniform highp float _TextureWidth;
uniform highp float _TextureHeight;
uniform highp float _GradientScale;
uniform highp float _ScaleX;
uniform highp float _ScaleY;
uniform highp float _PerspectiveFilter;
uniform highp vec4 _FaceTex_ST;
uniform highp vec4 _OutlineTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp float bScale_3;
  highp vec4 underlayColor_4;
  highp float weight_5;
  highp float scale_6;
  highp vec2 pixelSize_7;
  highp vec4 vert_8;
  highp float tmpvar_9;
  tmpvar_9 = float((0.0 >= _glesMultiTexCoord1.y));
  vert_8.zw = _glesVertex.zw;
  vert_8.x = (_glesVertex.x + _VertexOffsetX);
  vert_8.y = (_glesVertex.y + _VertexOffsetY);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = vert_8.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec2 tmpvar_12;
  tmpvar_12.x = _ScaleX;
  tmpvar_12.y = _ScaleY;
  highp mat2 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_projection[0].xy;
  tmpvar_13[1] = glstate_matrix_projection[1].xy;
  pixelSize_7 = (tmpvar_10.ww / (tmpvar_12 * abs(
    (tmpvar_13 * _ScreenParams.xy)
  )));
  scale_6 = (inversesqrt(dot (pixelSize_7, pixelSize_7)) * ((
    abs(_glesMultiTexCoord1.y)
   * _GradientScale) * 1.5));
  if ((glstate_matrix_projection[3].w == 0.0)) {
    highp mat3 tmpvar_14;
    tmpvar_14[0] = unity_WorldToObject[0].xyz;
    tmpvar_14[1] = unity_WorldToObject[1].xyz;
    tmpvar_14[2] = unity_WorldToObject[2].xyz;
    scale_6 = mix ((abs(scale_6) * (1.0 - _PerspectiveFilter)), scale_6, abs(dot (
      normalize((_glesNormal * tmpvar_14))
    , 
      normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_8).xyz))
    )));
  };
  weight_5 = (((
    (mix (_WeightNormal, _WeightBold, tmpvar_9) / 4.0)
   + _FaceDilate) * _ScaleRatioA) * 0.5);
  underlayColor_4 = _UnderlayColor;
  underlayColor_4.xyz = (underlayColor_4.xyz * underlayColor_4.w);
  bScale_3 = (scale_6 / (1.0 + (
    (_UnderlaySoftness * _ScaleRatioC)
   * scale_6)));
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((-(
    (_UnderlayOffsetX * _ScaleRatioC)
  ) * _GradientScale) / _TextureWidth);
  tmpvar_15.y = ((-(
    (_UnderlayOffsetY * _ScaleRatioC)
  ) * _GradientScale) / _TextureHeight);
  highp vec4 tmpvar_16;
  tmpvar_16 = clamp (_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10), vec4(2e+10, 2e+10, 2e+10, 2e+10));
  highp vec2 tmpvar_17;
  highp vec2 xlat_varoutput_18;
  xlat_varoutput_18.x = floor((_glesMultiTexCoord1.x / 4096.0));
  xlat_varoutput_18.y = (_glesMultiTexCoord1.x - (4096.0 * xlat_varoutput_18.x));
  tmpvar_17 = (xlat_varoutput_18 * 0.001953125);
  highp vec4 tmpvar_19;
  tmpvar_19.x = (((
    min (((1.0 - (_OutlineWidth * _ScaleRatioA)) - (_OutlineSoftness * _ScaleRatioA)), ((1.0 - (_GlowOffset * _ScaleRatioB)) - (_GlowOuter * _ScaleRatioB)))
   / 2.0) - (0.5 / scale_6)) - weight_5);
  tmpvar_19.y = scale_6;
  tmpvar_19.z = ((0.5 - weight_5) + (0.5 / scale_6));
  tmpvar_19.w = weight_5;
  highp vec2 tmpvar_20;
  tmpvar_20.x = _MaskSoftnessX;
  tmpvar_20.y = _MaskSoftnessY;
  highp vec4 tmpvar_21;
  tmpvar_21.xy = (((vert_8.xy * 2.0) - tmpvar_16.xy) - tmpvar_16.zw);
  tmpvar_21.zw = (0.25 / ((0.25 * tmpvar_20) + pixelSize_7));
  highp mat3 tmpvar_22;
  tmpvar_22[0] = _EnvMatrix[0].xyz;
  tmpvar_22[1] = _EnvMatrix[1].xyz;
  tmpvar_22[2] = _EnvMatrix[2].xyz;
  highp vec4 tmpvar_23;
  tmpvar_23.xy = (_glesMultiTexCoord0.xy + tmpvar_15);
  tmpvar_23.z = bScale_3;
  tmpvar_23.w = (((
    (0.5 - weight_5)
   * bScale_3) - 0.5) - ((_UnderlayDilate * _ScaleRatioC) * (0.5 * bScale_3)));
  highp vec4 tmpvar_24;
  tmpvar_24.xy = ((tmpvar_17 * _FaceTex_ST.xy) + _FaceTex_ST.zw);
  tmpvar_24.zw = ((tmpvar_17 * _OutlineTex_ST.xy) + _OutlineTex_ST.zw);
  lowp vec4 tmpvar_25;
  tmpvar_25 = underlayColor_4;
  gl_Position = tmpvar_10;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_19;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = (tmpvar_22 * (_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_8).xyz));
  xlv_TEXCOORD4 = tmpvar_23;
  xlv_COLOR1 = tmpvar_25;
  xlv_TEXCOORD5 = tmpvar_24;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _FaceTex;
uniform highp float _FaceUVSpeedX;
uniform highp float _FaceUVSpeedY;
uniform lowp vec4 _FaceColor;
uniform highp float _OutlineSoftness;
uniform sampler2D _OutlineTex;
uniform highp float _OutlineUVSpeedX;
uniform highp float _OutlineUVSpeedY;
uniform lowp vec4 _OutlineColor;
uniform highp float _OutlineWidth;
uniform highp float _Bevel;
uniform highp float _BevelOffset;
uniform highp float _BevelWidth;
uniform highp float _BevelClamp;
uniform highp float _BevelRoundness;
uniform sampler2D _BumpMap;
uniform highp float _BumpOutline;
uniform highp float _BumpFace;
uniform lowp samplerCube _Cube;
uniform lowp vec4 _ReflectFaceColor;
uniform lowp vec4 _ReflectOutlineColor;
uniform lowp vec4 _SpecularColor;
uniform highp float _LightAngle;
uniform highp float _SpecularPower;
uniform highp float _Reflectivity;
uniform highp float _Diffuse;
uniform highp float _Ambient;
uniform lowp vec4 _GlowColor;
uniform highp float _GlowOffset;
uniform highp float _GlowOuter;
uniform highp float _GlowInner;
uniform highp float _GlowPower;
uniform highp float _ShaderFlags;
uniform highp float _ScaleRatioA;
uniform highp float _ScaleRatioB;
uniform sampler2D _MainTex;
uniform highp float _TextureWidth;
uniform highp float _TextureHeight;
uniform highp float _GradientScale;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 bump_2;
  mediump vec4 outlineColor_3;
  mediump vec4 faceColor_4;
  highp float c_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  c_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD1.z - c_5) * xlv_TEXCOORD1.y);
  highp float tmpvar_8;
  tmpvar_8 = ((_OutlineWidth * _ScaleRatioA) * xlv_TEXCOORD1.y);
  highp float tmpvar_9;
  tmpvar_9 = ((_OutlineSoftness * _ScaleRatioA) * xlv_TEXCOORD1.y);
  faceColor_4 = _FaceColor;
  outlineColor_3 = _OutlineColor;
  faceColor_4.xyz = (faceColor_4.xyz * xlv_COLOR.xyz);
  highp vec2 tmpvar_10;
  tmpvar_10.x = _FaceUVSpeedX;
  tmpvar_10.y = _FaceUVSpeedY;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD5.xy + (tmpvar_10 * _Time.y));
  tmpvar_11 = texture2D (_FaceTex, P_12);
  faceColor_4 = (faceColor_4 * tmpvar_11);
  highp vec2 tmpvar_13;
  tmpvar_13.x = _OutlineUVSpeedX;
  tmpvar_13.y = _OutlineUVSpeedY;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD5.zw + (tmpvar_13 * _Time.y));
  tmpvar_14 = texture2D (_OutlineTex, P_15);
  outlineColor_3 = (outlineColor_3 * tmpvar_14);
  mediump float d_16;
  d_16 = tmpvar_7;
  lowp vec4 faceColor_17;
  faceColor_17 = faceColor_4;
  lowp vec4 outlineColor_18;
  outlineColor_18 = outlineColor_3;
  mediump float outline_19;
  outline_19 = tmpvar_8;
  mediump float softness_20;
  softness_20 = tmpvar_9;
  mediump float tmpvar_21;
  tmpvar_21 = (1.0 - clamp ((
    ((d_16 - (outline_19 * 0.5)) + (softness_20 * 0.5))
   / 
    (1.0 + softness_20)
  ), 0.0, 1.0));
  faceColor_17.xyz = (faceColor_17.xyz * faceColor_17.w);
  outlineColor_18.xyz = (outlineColor_18.xyz * outlineColor_18.w);
  mediump vec4 tmpvar_22;
  tmpvar_22 = mix (faceColor_17, outlineColor_18, vec4((clamp (
    (d_16 + (outline_19 * 0.5))
  , 0.0, 1.0) * sqrt(
    min (1.0, outline_19)
  ))));
  faceColor_17 = tmpvar_22;
  faceColor_17 = (faceColor_17 * tmpvar_21);
  faceColor_4 = faceColor_17;
  highp vec3 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.x = (0.5 / _TextureWidth);
  tmpvar_23.y = (0.5 / _TextureHeight);
  highp vec4 h_24;
  highp vec2 P_25;
  P_25 = (xlv_TEXCOORD0 - tmpvar_23.xz);
  highp vec2 P_26;
  P_26 = (xlv_TEXCOORD0 + tmpvar_23.xz);
  highp vec2 P_27;
  P_27 = (xlv_TEXCOORD0 - tmpvar_23.zy);
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_23.zy);
  lowp vec4 tmpvar_29;
  tmpvar_29.x = texture2D (_MainTex, P_25).w;
  tmpvar_29.y = texture2D (_MainTex, P_26).w;
  tmpvar_29.z = texture2D (_MainTex, P_27).w;
  tmpvar_29.w = texture2D (_MainTex, P_28).w;
  h_24 = tmpvar_29;
  highp vec4 h_30;
  h_30 = h_24;
  highp float tmpvar_31;
  tmpvar_31 = (_ShaderFlags / 2.0);
  highp float tmpvar_32;
  tmpvar_32 = (fract(abs(tmpvar_31)) * 2.0);
  highp float tmpvar_33;
  if ((tmpvar_31 >= 0.0)) {
    tmpvar_33 = tmpvar_32;
  } else {
    tmpvar_33 = -(tmpvar_32);
  };
  h_30 = (h_24 + (xlv_TEXCOORD1.w + _BevelOffset));
  highp float tmpvar_34;
  tmpvar_34 = max (0.01, (_OutlineWidth + _BevelWidth));
  h_30 = (h_30 - 0.5);
  h_30 = (h_30 / tmpvar_34);
  highp vec4 tmpvar_35;
  tmpvar_35 = clamp ((h_30 + 0.5), 0.0, 1.0);
  h_30 = tmpvar_35;
  if (bool(float((tmpvar_33 >= 1.0)))) {
    h_30 = (1.0 - abs((
      (tmpvar_35 * 2.0)
     - 1.0)));
  };
  h_30 = (min (mix (h_30, 
    sin(((h_30 * 3.141592) / 2.0))
  , vec4(_BevelRoundness)), vec4((1.0 - _BevelClamp))) * ((_Bevel * tmpvar_34) * (_GradientScale * -2.0)));
  highp vec3 tmpvar_36;
  tmpvar_36.xy = vec2(1.0, 0.0);
  tmpvar_36.z = (h_30.y - h_30.x);
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(tmpvar_36);
  highp vec3 tmpvar_38;
  tmpvar_38.xy = vec2(0.0, -1.0);
  tmpvar_38.z = (h_30.w - h_30.z);
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(tmpvar_38);
  highp vec2 tmpvar_40;
  tmpvar_40.x = _FaceUVSpeedX;
  tmpvar_40.y = _FaceUVSpeedY;
  highp vec2 P_41;
  P_41 = (xlv_TEXCOORD5.xy + (tmpvar_40 * _Time.y));
  lowp vec3 tmpvar_42;
  tmpvar_42 = ((texture2D (_BumpMap, P_41).xyz * 2.0) - 1.0);
  bump_2 = tmpvar_42;
  bump_2 = (bump_2 * mix (_BumpFace, _BumpOutline, clamp (
    (tmpvar_7 + (tmpvar_8 * 0.5))
  , 0.0, 1.0)));
  highp vec3 tmpvar_43;
  tmpvar_43 = normalize(((
    (tmpvar_37.yzx * tmpvar_39.zxy)
   - 
    (tmpvar_37.zxy * tmpvar_39.yzx)
  ) - bump_2));
  highp vec3 tmpvar_44;
  tmpvar_44.z = -1.0;
  tmpvar_44.x = sin(_LightAngle);
  tmpvar_44.y = cos(_LightAngle);
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize(tmpvar_44);
  highp vec3 tmpvar_46;
  tmpvar_46 = ((_SpecularColor.xyz * pow (
    max (0.0, dot (tmpvar_43, tmpvar_45))
  , _Reflectivity)) * _SpecularPower);
  faceColor_4.xyz = (faceColor_4.xyz + (tmpvar_46 * faceColor_4.w));
  highp float tmpvar_47;
  tmpvar_47 = dot (tmpvar_43, tmpvar_45);
  faceColor_4.xyz = (faceColor_4.xyz * (1.0 - (tmpvar_47 * _Diffuse)));
  highp float tmpvar_48;
  tmpvar_48 = mix (_Ambient, 1.0, (tmpvar_43.z * tmpvar_43.z));
  faceColor_4.xyz = (faceColor_4.xyz * tmpvar_48);
  highp vec3 tmpvar_49;
  highp vec3 N_50;
  N_50 = -(tmpvar_43);
  tmpvar_49 = (xlv_TEXCOORD3 - (2.0 * (
    dot (N_50, xlv_TEXCOORD3)
   * N_50)));
  lowp vec4 tmpvar_51;
  tmpvar_51 = textureCube (_Cube, tmpvar_49);
  highp float tmpvar_52;
  tmpvar_52 = clamp ((tmpvar_7 + (tmpvar_8 * 0.5)), 0.0, 1.0);
  lowp vec3 tmpvar_53;
  tmpvar_53 = mix (_ReflectFaceColor.xyz, _ReflectOutlineColor.xyz, vec3(tmpvar_52));
  faceColor_4.xyz = (faceColor_4.xyz + ((tmpvar_51.xyz * tmpvar_53) * faceColor_4.w));
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_MainTex, xlv_TEXCOORD4.xy);
  highp float tmpvar_55;
  tmpvar_55 = clamp (((tmpvar_54.w * xlv_TEXCOORD4.z) - xlv_TEXCOORD4.w), 0.0, 1.0);
  faceColor_4 = (faceColor_4 + ((xlv_COLOR1 * tmpvar_55) * (1.0 - faceColor_4.w)));
  highp vec4 tmpvar_56;
  highp float glow_57;
  highp float tmpvar_58;
  tmpvar_58 = (tmpvar_7 - ((_GlowOffset * _ScaleRatioB) * (0.5 * xlv_TEXCOORD1.y)));
  highp float tmpvar_59;
  tmpvar_59 = ((mix (_GlowInner, 
    (_GlowOuter * _ScaleRatioB)
  , 
    float((tmpvar_58 >= 0.0))
  ) * 0.5) * xlv_TEXCOORD1.y);
  glow_57 = (1.0 - pow (clamp (
    abs((tmpvar_58 / (1.0 + tmpvar_59)))
  , 0.0, 1.0), _GlowPower));
  glow_57 = (glow_57 * sqrt(min (1.0, tmpvar_59)));
  highp float tmpvar_60;
  tmpvar_60 = clamp (((_GlowColor.w * glow_57) * 2.0), 0.0, 1.0);
  lowp vec4 tmpvar_61;
  tmpvar_61.xyz = _GlowColor.xyz;
  tmpvar_61.w = tmpvar_60;
  tmpvar_56 = tmpvar_61;
  faceColor_4.xyz = (faceColor_4.xyz + (tmpvar_56.xyz * tmpvar_56.w));
  tmpvar_1 = (faceColor_4 * xlv_COLOR.w);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _FaceDilate;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineWidth;
uniform 	vec4 hlslcc_mtx4x4_EnvMatrix[4];
uniform 	mediump vec4 _UnderlayColor;
uniform 	float _UnderlayOffsetX;
uniform 	float _UnderlayOffsetY;
uniform 	float _UnderlayDilate;
uniform 	float _UnderlaySoftness;
uniform 	float _GlowOffset;
uniform 	float _GlowOuter;
uniform 	float _WeightNormal;
uniform 	float _WeightBold;
uniform 	float _ScaleRatioA;
uniform 	float _ScaleRatioB;
uniform 	float _ScaleRatioC;
uniform 	float _VertexOffsetX;
uniform 	float _VertexOffsetY;
uniform 	vec4 _ClipRect;
uniform 	float _MaskSoftnessX;
uniform 	float _MaskSoftnessY;
uniform 	float _TextureWidth;
uniform 	float _TextureHeight;
uniform 	float _GradientScale;
uniform 	float _ScaleX;
uniform 	float _ScaleY;
uniform 	float _PerspectiveFilter;
uniform 	vec4 _FaceTex_ST;
uniform 	vec4 _OutlineTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat4;
vec3 u_xlat6;
vec2 u_xlat8;
float u_xlat12;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat0.xy = vec2(in_POSITION0.x + float(_VertexOffsetX), in_POSITION0.y + float(_VertexOffsetY));
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat8.x = (-_OutlineWidth) * _ScaleRatioA + 1.0;
    u_xlat8.x = (-_OutlineSoftness) * _ScaleRatioA + u_xlat8.x;
    u_xlat12 = (-_GlowOffset) * _ScaleRatioB + 1.0;
    u_xlat12 = (-_GlowOuter) * _ScaleRatioB + u_xlat12;
    u_xlat8.x = min(u_xlat12, u_xlat8.x);
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat2.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat2.xy;
    u_xlat2.xy = vec2(abs(u_xlat2.x) * float(_ScaleX), abs(u_xlat2.y) * float(_ScaleY));
    u_xlat2.xy = u_xlat2.ww / u_xlat2.xy;
    u_xlat13 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat2.xy;
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat2.xy;
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.x = abs(in_TEXCOORD1.y) * _GradientScale;
    u_xlat13 = u_xlat13 * u_xlat2.x;
    u_xlat2.x = u_xlat13 * 1.5;
    u_xlat6.x = (-_PerspectiveFilter) + 1.0;
    u_xlat6.x = u_xlat6.x * abs(u_xlat2.x);
    u_xlat13 = u_xlat13 * 1.5 + (-u_xlat6.x);
    u_xlat12 = abs(u_xlat12) * u_xlat13 + u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0);
#else
    u_xlatb13 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
#endif
    u_xlat6.x = (u_xlatb13) ? u_xlat12 : u_xlat2.x;
    u_xlat12 = 0.5 / u_xlat6.x;
    u_xlat8.x = u_xlat8.x * 0.5 + (-u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.0>=in_TEXCOORD1.y);
#else
    u_xlatb13 = 0.0>=in_TEXCOORD1.y;
#endif
    u_xlat13 = u_xlatb13 ? 1.0 : float(0.0);
    u_xlat2.x = (-_WeightNormal) + _WeightBold;
    u_xlat13 = u_xlat13 * u_xlat2.x + _WeightNormal;
    u_xlat13 = u_xlat13 * 0.25 + _FaceDilate;
    u_xlat13 = u_xlat13 * _ScaleRatioA;
    vs_TEXCOORD1.x = (-u_xlat13) * 0.5 + u_xlat8.x;
    u_xlat6.z = u_xlat13 * 0.5;
    u_xlat8.x = (-u_xlat13) * 0.5 + 0.5;
    vs_TEXCOORD1.yw = u_xlat6.xz;
    vs_TEXCOORD1.z = u_xlat12 + u_xlat8.x;
    u_xlat3 = max(_ClipRect, vec4(-2e+010, -2e+010, -2e+010, -2e+010));
    u_xlat3 = min(u_xlat3, vec4(2e+010, 2e+010, 2e+010, 2e+010));
    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat3.xy);
    vs_TEXCOORD2.xy = vec2((-u_xlat3.z) + u_xlat0.x, (-u_xlat3.w) + u_xlat0.y);
    u_xlat0.xyw = u_xlat1.yyy * hlslcc_mtx4x4_EnvMatrix[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_EnvMatrix[0].xyz * u_xlat1.xxx + u_xlat0.xyw;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4_EnvMatrix[2].xyz * u_xlat1.zzz + u_xlat0.xyw;
    u_xlat1 = vec4(_UnderlaySoftness, _UnderlayDilate, _UnderlayOffsetX, _UnderlayOffsetY) * vec4(vec4(_ScaleRatioC, _ScaleRatioC, _ScaleRatioC, _ScaleRatioC));
    u_xlat0.x = u_xlat1.x * u_xlat6.x + 1.0;
    u_xlat0.x = u_xlat6.x / u_xlat0.x;
    u_xlat4 = u_xlat8.x * u_xlat0.x + -0.5;
    u_xlat8.x = u_xlat0.x * u_xlat1.y;
    u_xlat1.xy = vec2((-u_xlat1.z) * _GradientScale, (-u_xlat1.w) * _GradientScale);
    u_xlat1.xy = vec2(u_xlat1.x / float(_TextureWidth), u_xlat1.y / float(_TextureHeight));
    vs_TEXCOORD4.xy = u_xlat1.xy + in_TEXCOORD0.xy;
    vs_TEXCOORD4.z = u_xlat0.x;
    vs_TEXCOORD4.w = (-u_xlat8.x) * 0.5 + u_xlat4;
    u_xlat0.xyz = _UnderlayColor.www * _UnderlayColor.xyz;
    vs_COLOR1.xyz = u_xlat0.xyz;
    vs_COLOR1.w = _UnderlayColor.w;
    u_xlat0.x = in_TEXCOORD1.x * 0.000244140625;
    u_xlat8.x = floor(u_xlat0.x);
    u_xlat8.y = (-u_xlat8.x) * 4096.0 + in_TEXCOORD1.x;
    u_xlat0.xy = u_xlat8.xy * vec2(0.001953125, 0.001953125);
    vs_TEXCOORD5.xy = u_xlat0.xy * _FaceTex_ST.xy + _FaceTex_ST.zw;
    vs_TEXCOORD5.zw = u_xlat0.xy * _OutlineTex_ST.xy + _OutlineTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _FaceUVSpeedX;
uniform 	float _FaceUVSpeedY;
uniform 	mediump vec4 _FaceColor;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineUVSpeedX;
uniform 	float _OutlineUVSpeedY;
uniform 	mediump vec4 _OutlineColor;
uniform 	float _OutlineWidth;
uniform 	float _Bevel;
uniform 	float _BevelOffset;
uniform 	float _BevelWidth;
uniform 	float _BevelClamp;
uniform 	float _BevelRoundness;
uniform 	float _BumpOutline;
uniform 	float _BumpFace;
uniform 	mediump vec4 _ReflectFaceColor;
uniform 	mediump vec4 _ReflectOutlineColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	float _LightAngle;
uniform 	float _SpecularPower;
uniform 	float _Reflectivity;
uniform 	float _Diffuse;
uniform 	float _Ambient;
uniform 	mediump vec4 _GlowColor;
uniform 	float _GlowOffset;
uniform 	float _GlowOuter;
uniform 	float _GlowInner;
uniform 	float _GlowPower;
uniform 	float _ShaderFlags;
uniform 	float _ScaleRatioA;
uniform 	float _ScaleRatioB;
uniform 	float _TextureWidth;
uniform 	float _TextureHeight;
uniform 	float _GradientScale;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FaceTex;
uniform lowp sampler2D _OutlineTex;
uniform lowp sampler2D _BumpMap;
uniform lowp samplerCube _Cube;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
vec4 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec4 u_xlat16_5;
lowp vec4 u_xlat10_5;
mediump vec4 u_xlat16_6;
float u_xlat7;
mediump vec4 u_xlat16_7;
float u_xlat8;
float u_xlat9;
bool u_xlatb9;
vec2 u_xlat10;
mediump float u_xlat16_12;
float u_xlat16;
bool u_xlatb17;
mediump float u_xlat16_20;
float u_xlat24;
mediump float u_xlat16_24;
lowp float u_xlat10_24;
float u_xlat26;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w + _BevelOffset;
    u_xlat1.xy = vec2(float(0.5) / float(_TextureWidth), float(0.5) / float(_TextureHeight));
    u_xlat1.z = 0.0;
    u_xlat2 = (-u_xlat1.xzzy) + vs_TEXCOORD0.xyxy;
    u_xlat1 = u_xlat1.xzzy + vs_TEXCOORD0.xyxy;
    u_xlat3.x = texture(_MainTex, u_xlat2.xy).w;
    u_xlat3.z = texture(_MainTex, u_xlat2.zw).w;
    u_xlat3.y = texture(_MainTex, u_xlat1.xy).w;
    u_xlat3.w = texture(_MainTex, u_xlat1.zw).w;
    u_xlat0 = u_xlat0.xxxx + u_xlat3;
    u_xlat0 = u_xlat0 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat1.x = _BevelWidth + _OutlineWidth;
    u_xlat1.x = max(u_xlat1.x, 0.00999999978);
    u_xlat0 = u_xlat0 / u_xlat1.xxxx;
    u_xlat1.x = u_xlat1.x * _Bevel;
    u_xlat1.x = u_xlat1.x * _GradientScale;
    u_xlat1.x = u_xlat1.x * -2.0;
    u_xlat0 = u_xlat0 + vec4(0.5, 0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat2 = u_xlat0 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = -abs(u_xlat2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat9 = _ShaderFlags * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb17 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat9 = fract(abs(u_xlat9));
    u_xlat9 = (u_xlatb17) ? u_xlat9 : (-u_xlat9);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=0.5);
#else
    u_xlatb9 = u_xlat9>=0.5;
#endif
    u_xlat0 = (bool(u_xlatb9)) ? u_xlat2 : u_xlat0;
    u_xlat2 = u_xlat0 * vec4(1.57079601, 1.57079601, 1.57079601, 1.57079601);
    u_xlat2 = sin(u_xlat2);
    u_xlat2 = (-u_xlat0) + u_xlat2;
    u_xlat0 = vec4(vec4(_BevelRoundness, _BevelRoundness, _BevelRoundness, _BevelRoundness)) * u_xlat2 + u_xlat0;
    u_xlat9 = (-_BevelClamp) + 1.0;
    u_xlat0 = min(u_xlat0, vec4(u_xlat9));
    u_xlat0.xz = u_xlat1.xx * u_xlat0.xz;
    u_xlat0.yz = u_xlat0.wy * u_xlat1.xx + (-u_xlat0.zx);
    u_xlat0.x = float(-1.0);
    u_xlat0.w = float(1.0);
    u_xlat1.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat24 = dot(u_xlat0.zw, u_xlat0.zw);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.x = u_xlat24 * u_xlat0.z;
    u_xlat2.yz = vec2(u_xlat24) * vec2(1.0, 0.0);
    u_xlat0.z = 0.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat2.zxy * u_xlat0.yzx + (-u_xlat1.xyz);
    u_xlat1.xy = vec2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy + vs_TEXCOORD5.xy;
    u_xlat10_2.xyz = texture(_BumpMap, u_xlat1.xy).xyz;
    u_xlat10_1 = texture(_FaceTex, u_xlat1.xy);
    u_xlat16_4.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat24 = (-_BumpFace) + _BumpOutline;
    u_xlat10_2.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat2.x = (-u_xlat10_2.x) + vs_TEXCOORD1.z;
    u_xlat2.z = _OutlineWidth * _ScaleRatioA;
    u_xlat10.xy = u_xlat2.xz * vs_TEXCOORD1.yy;
    u_xlat26 = u_xlat10.y * 0.5 + u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat26 * u_xlat24 + _BumpFace;
    u_xlat0.xyz = (-u_xlat16_4.xyz) * vec3(u_xlat24) + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(vs_TEXCOORD3.xyz, (-u_xlat0.xyz));
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat3.xyz = u_xlat0.xyz * vec3(u_xlat24) + vs_TEXCOORD3.xyz;
    u_xlat10_3.xyz = texture(_Cube, u_xlat3.xyz).xyz;
    u_xlat16_5.xyz = (-_ReflectFaceColor.xyz) + _ReflectOutlineColor.xyz;
    u_xlat5.xyz = vec3(u_xlat26) * u_xlat16_5.xyz + _ReflectFaceColor.xyz;
    u_xlat3.xyz = u_xlat10_3.xyz * u_xlat5.xyz;
    u_xlat16_4.x = min(u_xlat10.y, 1.0);
    u_xlat16_12 = u_xlat10.y * 0.5;
    u_xlat16_4.x = sqrt(u_xlat16_4.x);
    u_xlat16_20 = u_xlat2.x * vs_TEXCOORD1.y + u_xlat16_12;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat2.x * vs_TEXCOORD1.y + (-u_xlat16_12);
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_20;
    u_xlat16_6.xyz = vs_COLOR0.xyz * _FaceColor.xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_6.xyz;
    u_xlat16_24 = u_xlat10_1.w * _FaceColor.w;
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_1.xyz;
    u_xlat2.xz = vec2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy + vs_TEXCOORD5.zw;
    u_xlat10_5 = texture(_OutlineTex, u_xlat2.xz);
    u_xlat16_7 = u_xlat10_5 * _OutlineColor;
    u_xlat16_5.w = _OutlineColor.w * u_xlat10_5.w + (-u_xlat16_24);
    u_xlat16_5.xyz = u_xlat16_7.xyz * u_xlat16_7.www + (-u_xlat16_6.xyz);
    u_xlat16_5 = u_xlat16_4.xxxx * u_xlat16_5;
    u_xlat16_6.xyz = u_xlat16_1.xyz * vec3(u_xlat16_24) + u_xlat16_5.xyz;
    u_xlat16_6.w = _FaceColor.w * u_xlat10_1.w + u_xlat16_5.w;
    u_xlat24 = _OutlineSoftness * _ScaleRatioA;
    u_xlat1.x = u_xlat24 * vs_TEXCOORD1.y;
    u_xlat16_4.x = u_xlat24 * vs_TEXCOORD1.y + 1.0;
    u_xlat16_12 = u_xlat1.x * 0.5 + u_xlat16_12;
    u_xlat16_4.x = u_xlat16_12 / u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_1 = u_xlat16_4.xxxx * u_xlat16_6;
    u_xlat16_4.x = (-u_xlat16_6.w) * u_xlat16_4.x + 1.0;
    u_xlat2.xzw = u_xlat16_1.www * u_xlat3.xyz;
    u_xlat3.x = sin(_LightAngle);
    u_xlat7 = cos(_LightAngle);
    u_xlat3.y = u_xlat7;
    u_xlat3.z = -1.0;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat8 = u_xlat0.z * u_xlat0.z;
    u_xlat16 = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-u_xlat0.x) * _Diffuse + 1.0;
    u_xlat16 = log2(u_xlat16);
    u_xlat16 = u_xlat16 * _Reflectivity;
    u_xlat16 = exp2(u_xlat16);
    u_xlat3.xyz = vec3(u_xlat16) * _SpecularColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_SpecularPower, _SpecularPower, _SpecularPower));
    u_xlat3.xyz = u_xlat3.xyz * u_xlat16_1.www + u_xlat16_1.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat3.x = (-_Ambient) + 1.0;
    u_xlat8 = u_xlat8 * u_xlat3.x + _Ambient;
    u_xlat0.xyz = u_xlat0.xzw * vec3(u_xlat8) + u_xlat2.xzw;
    u_xlat10_24 = texture(_MainTex, vs_TEXCOORD4.xy).w;
    u_xlat24 = u_xlat10_24 * vs_TEXCOORD4.z + (-vs_TEXCOORD4.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat3 = vec4(u_xlat24) * vs_COLOR1;
    u_xlat0.xyz = u_xlat3.xyz * u_xlat16_4.xxx + u_xlat0.xyz;
    u_xlat1.w = u_xlat3.w * u_xlat16_4.x + u_xlat16_1.w;
    u_xlat24 = _GlowOffset * _ScaleRatioB;
    u_xlat24 = u_xlat24 * vs_TEXCOORD1.y;
    u_xlat24 = (-u_xlat24) * 0.5 + u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat24>=0.0);
#else
    u_xlatb2 = u_xlat24>=0.0;
#endif
    u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat10.x = _GlowOuter * _ScaleRatioB + (-_GlowInner);
    u_xlat2.x = u_xlat2.x * u_xlat10.x + _GlowInner;
    u_xlat2.x = u_xlat2.x * vs_TEXCOORD1.y;
    u_xlat10.x = u_xlat2.x * 0.5 + 1.0;
    u_xlat2.x = u_xlat2.x * 0.5;
    u_xlat2.x = min(u_xlat2.x, 1.0);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat24 = u_xlat24 / u_xlat10.x;
    u_xlat24 = min(abs(u_xlat24), 1.0);
    u_xlat24 = log2(u_xlat24);
    u_xlat24 = u_xlat24 * _GlowPower;
    u_xlat24 = exp2(u_xlat24);
    u_xlat24 = (-u_xlat24) + 1.0;
    u_xlat24 = u_xlat2.x * u_xlat24;
    u_xlat24 = dot(_GlowColor.ww, vec2(u_xlat24));
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat1.xyz = _GlowColor.xyz * vec3(u_xlat24) + u_xlat0.xyz;
    SV_Target0 = u_xlat1 * vs_COLOR0.wwww;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _FaceDilate;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineWidth;
uniform 	vec4 hlslcc_mtx4x4_EnvMatrix[4];
uniform 	mediump vec4 _UnderlayColor;
uniform 	float _UnderlayOffsetX;
uniform 	float _UnderlayOffsetY;
uniform 	float _UnderlayDilate;
uniform 	float _UnderlaySoftness;
uniform 	float _GlowOffset;
uniform 	float _GlowOuter;
uniform 	float _WeightNormal;
uniform 	float _WeightBold;
uniform 	float _ScaleRatioA;
uniform 	float _ScaleRatioB;
uniform 	float _ScaleRatioC;
uniform 	float _VertexOffsetX;
uniform 	float _VertexOffsetY;
uniform 	vec4 _ClipRect;
uniform 	float _MaskSoftnessX;
uniform 	float _MaskSoftnessY;
uniform 	float _TextureWidth;
uniform 	float _TextureHeight;
uniform 	float _GradientScale;
uniform 	float _ScaleX;
uniform 	float _ScaleY;
uniform 	float _PerspectiveFilter;
uniform 	vec4 _FaceTex_ST;
uniform 	vec4 _OutlineTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat4;
vec3 u_xlat6;
vec2 u_xlat8;
float u_xlat12;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat0.xy = vec2(in_POSITION0.x + float(_VertexOffsetX), in_POSITION0.y + float(_VertexOffsetY));
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat8.x = (-_OutlineWidth) * _ScaleRatioA + 1.0;
    u_xlat8.x = (-_OutlineSoftness) * _ScaleRatioA + u_xlat8.x;
    u_xlat12 = (-_GlowOffset) * _ScaleRatioB + 1.0;
    u_xlat12 = (-_GlowOuter) * _ScaleRatioB + u_xlat12;
    u_xlat8.x = min(u_xlat12, u_xlat8.x);
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat2.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat2.xy;
    u_xlat2.xy = vec2(abs(u_xlat2.x) * float(_ScaleX), abs(u_xlat2.y) * float(_ScaleY));
    u_xlat2.xy = u_xlat2.ww / u_xlat2.xy;
    u_xlat13 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat2.xy;
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat2.xy;
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.x = abs(in_TEXCOORD1.y) * _GradientScale;
    u_xlat13 = u_xlat13 * u_xlat2.x;
    u_xlat2.x = u_xlat13 * 1.5;
    u_xlat6.x = (-_PerspectiveFilter) + 1.0;
    u_xlat6.x = u_xlat6.x * abs(u_xlat2.x);
    u_xlat13 = u_xlat13 * 1.5 + (-u_xlat6.x);
    u_xlat12 = abs(u_xlat12) * u_xlat13 + u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0);
#else
    u_xlatb13 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
#endif
    u_xlat6.x = (u_xlatb13) ? u_xlat12 : u_xlat2.x;
    u_xlat12 = 0.5 / u_xlat6.x;
    u_xlat8.x = u_xlat8.x * 0.5 + (-u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.0>=in_TEXCOORD1.y);
#else
    u_xlatb13 = 0.0>=in_TEXCOORD1.y;
#endif
    u_xlat13 = u_xlatb13 ? 1.0 : float(0.0);
    u_xlat2.x = (-_WeightNormal) + _WeightBold;
    u_xlat13 = u_xlat13 * u_xlat2.x + _WeightNormal;
    u_xlat13 = u_xlat13 * 0.25 + _FaceDilate;
    u_xlat13 = u_xlat13 * _ScaleRatioA;
    vs_TEXCOORD1.x = (-u_xlat13) * 0.5 + u_xlat8.x;
    u_xlat6.z = u_xlat13 * 0.5;
    u_xlat8.x = (-u_xlat13) * 0.5 + 0.5;
    vs_TEXCOORD1.yw = u_xlat6.xz;
    vs_TEXCOORD1.z = u_xlat12 + u_xlat8.x;
    u_xlat3 = max(_ClipRect, vec4(-2e+010, -2e+010, -2e+010, -2e+010));
    u_xlat3 = min(u_xlat3, vec4(2e+010, 2e+010, 2e+010, 2e+010));
    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat3.xy);
    vs_TEXCOORD2.xy = vec2((-u_xlat3.z) + u_xlat0.x, (-u_xlat3.w) + u_xlat0.y);
    u_xlat0.xyw = u_xlat1.yyy * hlslcc_mtx4x4_EnvMatrix[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_EnvMatrix[0].xyz * u_xlat1.xxx + u_xlat0.xyw;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4_EnvMatrix[2].xyz * u_xlat1.zzz + u_xlat0.xyw;
    u_xlat1 = vec4(_UnderlaySoftness, _UnderlayDilate, _UnderlayOffsetX, _UnderlayOffsetY) * vec4(vec4(_ScaleRatioC, _ScaleRatioC, _ScaleRatioC, _ScaleRatioC));
    u_xlat0.x = u_xlat1.x * u_xlat6.x + 1.0;
    u_xlat0.x = u_xlat6.x / u_xlat0.x;
    u_xlat4 = u_xlat8.x * u_xlat0.x + -0.5;
    u_xlat8.x = u_xlat0.x * u_xlat1.y;
    u_xlat1.xy = vec2((-u_xlat1.z) * _GradientScale, (-u_xlat1.w) * _GradientScale);
    u_xlat1.xy = vec2(u_xlat1.x / float(_TextureWidth), u_xlat1.y / float(_TextureHeight));
    vs_TEXCOORD4.xy = u_xlat1.xy + in_TEXCOORD0.xy;
    vs_TEXCOORD4.z = u_xlat0.x;
    vs_TEXCOORD4.w = (-u_xlat8.x) * 0.5 + u_xlat4;
    u_xlat0.xyz = _UnderlayColor.www * _UnderlayColor.xyz;
    vs_COLOR1.xyz = u_xlat0.xyz;
    vs_COLOR1.w = _UnderlayColor.w;
    u_xlat0.x = in_TEXCOORD1.x * 0.000244140625;
    u_xlat8.x = floor(u_xlat0.x);
    u_xlat8.y = (-u_xlat8.x) * 4096.0 + in_TEXCOORD1.x;
    u_xlat0.xy = u_xlat8.xy * vec2(0.001953125, 0.001953125);
    vs_TEXCOORD5.xy = u_xlat0.xy * _FaceTex_ST.xy + _FaceTex_ST.zw;
    vs_TEXCOORD5.zw = u_xlat0.xy * _OutlineTex_ST.xy + _OutlineTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _FaceUVSpeedX;
uniform 	float _FaceUVSpeedY;
uniform 	mediump vec4 _FaceColor;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineUVSpeedX;
uniform 	float _OutlineUVSpeedY;
uniform 	mediump vec4 _OutlineColor;
uniform 	float _OutlineWidth;
uniform 	float _Bevel;
uniform 	float _BevelOffset;
uniform 	float _BevelWidth;
uniform 	float _BevelClamp;
uniform 	float _BevelRoundness;
uniform 	float _BumpOutline;
uniform 	float _BumpFace;
uniform 	mediump vec4 _ReflectFaceColor;
uniform 	mediump vec4 _ReflectOutlineColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	float _LightAngle;
uniform 	float _SpecularPower;
uniform 	float _Reflectivity;
uniform 	float _Diffuse;
uniform 	float _Ambient;
uniform 	mediump vec4 _GlowColor;
uniform 	float _GlowOffset;
uniform 	float _GlowOuter;
uniform 	float _GlowInner;
uniform 	float _GlowPower;
uniform 	float _ShaderFlags;
uniform 	float _ScaleRatioA;
uniform 	float _ScaleRatioB;
uniform 	float _TextureWidth;
uniform 	float _TextureHeight;
uniform 	float _GradientScale;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FaceTex;
uniform lowp sampler2D _OutlineTex;
uniform lowp sampler2D _BumpMap;
uniform lowp samplerCube _Cube;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
vec4 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec4 u_xlat16_5;
lowp vec4 u_xlat10_5;
mediump vec4 u_xlat16_6;
float u_xlat7;
mediump vec4 u_xlat16_7;
float u_xlat8;
float u_xlat9;
bool u_xlatb9;
vec2 u_xlat10;
mediump float u_xlat16_12;
float u_xlat16;
bool u_xlatb17;
mediump float u_xlat16_20;
float u_xlat24;
mediump float u_xlat16_24;
lowp float u_xlat10_24;
float u_xlat26;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w + _BevelOffset;
    u_xlat1.xy = vec2(float(0.5) / float(_TextureWidth), float(0.5) / float(_TextureHeight));
    u_xlat1.z = 0.0;
    u_xlat2 = (-u_xlat1.xzzy) + vs_TEXCOORD0.xyxy;
    u_xlat1 = u_xlat1.xzzy + vs_TEXCOORD0.xyxy;
    u_xlat3.x = texture(_MainTex, u_xlat2.xy).w;
    u_xlat3.z = texture(_MainTex, u_xlat2.zw).w;
    u_xlat3.y = texture(_MainTex, u_xlat1.xy).w;
    u_xlat3.w = texture(_MainTex, u_xlat1.zw).w;
    u_xlat0 = u_xlat0.xxxx + u_xlat3;
    u_xlat0 = u_xlat0 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat1.x = _BevelWidth + _OutlineWidth;
    u_xlat1.x = max(u_xlat1.x, 0.00999999978);
    u_xlat0 = u_xlat0 / u_xlat1.xxxx;
    u_xlat1.x = u_xlat1.x * _Bevel;
    u_xlat1.x = u_xlat1.x * _GradientScale;
    u_xlat1.x = u_xlat1.x * -2.0;
    u_xlat0 = u_xlat0 + vec4(0.5, 0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat2 = u_xlat0 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = -abs(u_xlat2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat9 = _ShaderFlags * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb17 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat9 = fract(abs(u_xlat9));
    u_xlat9 = (u_xlatb17) ? u_xlat9 : (-u_xlat9);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=0.5);
#else
    u_xlatb9 = u_xlat9>=0.5;
#endif
    u_xlat0 = (bool(u_xlatb9)) ? u_xlat2 : u_xlat0;
    u_xlat2 = u_xlat0 * vec4(1.57079601, 1.57079601, 1.57079601, 1.57079601);
    u_xlat2 = sin(u_xlat2);
    u_xlat2 = (-u_xlat0) + u_xlat2;
    u_xlat0 = vec4(vec4(_BevelRoundness, _BevelRoundness, _BevelRoundness, _BevelRoundness)) * u_xlat2 + u_xlat0;
    u_xlat9 = (-_BevelClamp) + 1.0;
    u_xlat0 = min(u_xlat0, vec4(u_xlat9));
    u_xlat0.xz = u_xlat1.xx * u_xlat0.xz;
    u_xlat0.yz = u_xlat0.wy * u_xlat1.xx + (-u_xlat0.zx);
    u_xlat0.x = float(-1.0);
    u_xlat0.w = float(1.0);
    u_xlat1.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat24 = dot(u_xlat0.zw, u_xlat0.zw);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.x = u_xlat24 * u_xlat0.z;
    u_xlat2.yz = vec2(u_xlat24) * vec2(1.0, 0.0);
    u_xlat0.z = 0.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat2.zxy * u_xlat0.yzx + (-u_xlat1.xyz);
    u_xlat1.xy = vec2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy + vs_TEXCOORD5.xy;
    u_xlat10_2.xyz = texture(_BumpMap, u_xlat1.xy).xyz;
    u_xlat10_1 = texture(_FaceTex, u_xlat1.xy);
    u_xlat16_4.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat24 = (-_BumpFace) + _BumpOutline;
    u_xlat10_2.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat2.x = (-u_xlat10_2.x) + vs_TEXCOORD1.z;
    u_xlat2.z = _OutlineWidth * _ScaleRatioA;
    u_xlat10.xy = u_xlat2.xz * vs_TEXCOORD1.yy;
    u_xlat26 = u_xlat10.y * 0.5 + u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat26 * u_xlat24 + _BumpFace;
    u_xlat0.xyz = (-u_xlat16_4.xyz) * vec3(u_xlat24) + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(vs_TEXCOORD3.xyz, (-u_xlat0.xyz));
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat3.xyz = u_xlat0.xyz * vec3(u_xlat24) + vs_TEXCOORD3.xyz;
    u_xlat10_3.xyz = texture(_Cube, u_xlat3.xyz).xyz;
    u_xlat16_5.xyz = (-_ReflectFaceColor.xyz) + _ReflectOutlineColor.xyz;
    u_xlat5.xyz = vec3(u_xlat26) * u_xlat16_5.xyz + _ReflectFaceColor.xyz;
    u_xlat3.xyz = u_xlat10_3.xyz * u_xlat5.xyz;
    u_xlat16_4.x = min(u_xlat10.y, 1.0);
    u_xlat16_12 = u_xlat10.y * 0.5;
    u_xlat16_4.x = sqrt(u_xlat16_4.x);
    u_xlat16_20 = u_xlat2.x * vs_TEXCOORD1.y + u_xlat16_12;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat2.x * vs_TEXCOORD1.y + (-u_xlat16_12);
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_20;
    u_xlat16_6.xyz = vs_COLOR0.xyz * _FaceColor.xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_6.xyz;
    u_xlat16_24 = u_xlat10_1.w * _FaceColor.w;
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_1.xyz;
    u_xlat2.xz = vec2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy + vs_TEXCOORD5.zw;
    u_xlat10_5 = texture(_OutlineTex, u_xlat2.xz);
    u_xlat16_7 = u_xlat10_5 * _OutlineColor;
    u_xlat16_5.w = _OutlineColor.w * u_xlat10_5.w + (-u_xlat16_24);
    u_xlat16_5.xyz = u_xlat16_7.xyz * u_xlat16_7.www + (-u_xlat16_6.xyz);
    u_xlat16_5 = u_xlat16_4.xxxx * u_xlat16_5;
    u_xlat16_6.xyz = u_xlat16_1.xyz * vec3(u_xlat16_24) + u_xlat16_5.xyz;
    u_xlat16_6.w = _FaceColor.w * u_xlat10_1.w + u_xlat16_5.w;
    u_xlat24 = _OutlineSoftness * _ScaleRatioA;
    u_xlat1.x = u_xlat24 * vs_TEXCOORD1.y;
    u_xlat16_4.x = u_xlat24 * vs_TEXCOORD1.y + 1.0;
    u_xlat16_12 = u_xlat1.x * 0.5 + u_xlat16_12;
    u_xlat16_4.x = u_xlat16_12 / u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_1 = u_xlat16_4.xxxx * u_xlat16_6;
    u_xlat16_4.x = (-u_xlat16_6.w) * u_xlat16_4.x + 1.0;
    u_xlat2.xzw = u_xlat16_1.www * u_xlat3.xyz;
    u_xlat3.x = sin(_LightAngle);
    u_xlat7 = cos(_LightAngle);
    u_xlat3.y = u_xlat7;
    u_xlat3.z = -1.0;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat8 = u_xlat0.z * u_xlat0.z;
    u_xlat16 = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-u_xlat0.x) * _Diffuse + 1.0;
    u_xlat16 = log2(u_xlat16);
    u_xlat16 = u_xlat16 * _Reflectivity;
    u_xlat16 = exp2(u_xlat16);
    u_xlat3.xyz = vec3(u_xlat16) * _SpecularColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_SpecularPower, _SpecularPower, _SpecularPower));
    u_xlat3.xyz = u_xlat3.xyz * u_xlat16_1.www + u_xlat16_1.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat3.x = (-_Ambient) + 1.0;
    u_xlat8 = u_xlat8 * u_xlat3.x + _Ambient;
    u_xlat0.xyz = u_xlat0.xzw * vec3(u_xlat8) + u_xlat2.xzw;
    u_xlat10_24 = texture(_MainTex, vs_TEXCOORD4.xy).w;
    u_xlat24 = u_xlat10_24 * vs_TEXCOORD4.z + (-vs_TEXCOORD4.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat3 = vec4(u_xlat24) * vs_COLOR1;
    u_xlat0.xyz = u_xlat3.xyz * u_xlat16_4.xxx + u_xlat0.xyz;
    u_xlat1.w = u_xlat3.w * u_xlat16_4.x + u_xlat16_1.w;
    u_xlat24 = _GlowOffset * _ScaleRatioB;
    u_xlat24 = u_xlat24 * vs_TEXCOORD1.y;
    u_xlat24 = (-u_xlat24) * 0.5 + u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat24>=0.0);
#else
    u_xlatb2 = u_xlat24>=0.0;
#endif
    u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat10.x = _GlowOuter * _ScaleRatioB + (-_GlowInner);
    u_xlat2.x = u_xlat2.x * u_xlat10.x + _GlowInner;
    u_xlat2.x = u_xlat2.x * vs_TEXCOORD1.y;
    u_xlat10.x = u_xlat2.x * 0.5 + 1.0;
    u_xlat2.x = u_xlat2.x * 0.5;
    u_xlat2.x = min(u_xlat2.x, 1.0);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat24 = u_xlat24 / u_xlat10.x;
    u_xlat24 = min(abs(u_xlat24), 1.0);
    u_xlat24 = log2(u_xlat24);
    u_xlat24 = u_xlat24 * _GlowPower;
    u_xlat24 = exp2(u_xlat24);
    u_xlat24 = (-u_xlat24) + 1.0;
    u_xlat24 = u_xlat2.x * u_xlat24;
    u_xlat24 = dot(_GlowColor.ww, vec2(u_xlat24));
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat1.xyz = _GlowColor.xyz * vec3(u_xlat24) + u_xlat0.xyz;
    SV_Target0 = u_xlat1 * vs_COLOR0.wwww;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _FaceDilate;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineWidth;
uniform 	vec4 hlslcc_mtx4x4_EnvMatrix[4];
uniform 	mediump vec4 _UnderlayColor;
uniform 	float _UnderlayOffsetX;
uniform 	float _UnderlayOffsetY;
uniform 	float _UnderlayDilate;
uniform 	float _UnderlaySoftness;
uniform 	float _GlowOffset;
uniform 	float _GlowOuter;
uniform 	float _WeightNormal;
uniform 	float _WeightBold;
uniform 	float _ScaleRatioA;
uniform 	float _ScaleRatioB;
uniform 	float _ScaleRatioC;
uniform 	float _VertexOffsetX;
uniform 	float _VertexOffsetY;
uniform 	vec4 _ClipRect;
uniform 	float _MaskSoftnessX;
uniform 	float _MaskSoftnessY;
uniform 	float _TextureWidth;
uniform 	float _TextureHeight;
uniform 	float _GradientScale;
uniform 	float _ScaleX;
uniform 	float _ScaleY;
uniform 	float _PerspectiveFilter;
uniform 	vec4 _FaceTex_ST;
uniform 	vec4 _OutlineTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat4;
vec3 u_xlat6;
vec2 u_xlat8;
float u_xlat12;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat0.xy = vec2(in_POSITION0.x + float(_VertexOffsetX), in_POSITION0.y + float(_VertexOffsetY));
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat8.x = (-_OutlineWidth) * _ScaleRatioA + 1.0;
    u_xlat8.x = (-_OutlineSoftness) * _ScaleRatioA + u_xlat8.x;
    u_xlat12 = (-_GlowOffset) * _ScaleRatioB + 1.0;
    u_xlat12 = (-_GlowOuter) * _ScaleRatioB + u_xlat12;
    u_xlat8.x = min(u_xlat12, u_xlat8.x);
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat2.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat2.xy;
    u_xlat2.xy = vec2(abs(u_xlat2.x) * float(_ScaleX), abs(u_xlat2.y) * float(_ScaleY));
    u_xlat2.xy = u_xlat2.ww / u_xlat2.xy;
    u_xlat13 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat2.xy;
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat2.xy;
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.x = abs(in_TEXCOORD1.y) * _GradientScale;
    u_xlat13 = u_xlat13 * u_xlat2.x;
    u_xlat2.x = u_xlat13 * 1.5;
    u_xlat6.x = (-_PerspectiveFilter) + 1.0;
    u_xlat6.x = u_xlat6.x * abs(u_xlat2.x);
    u_xlat13 = u_xlat13 * 1.5 + (-u_xlat6.x);
    u_xlat12 = abs(u_xlat12) * u_xlat13 + u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0);
#else
    u_xlatb13 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
#endif
    u_xlat6.x = (u_xlatb13) ? u_xlat12 : u_xlat2.x;
    u_xlat12 = 0.5 / u_xlat6.x;
    u_xlat8.x = u_xlat8.x * 0.5 + (-u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.0>=in_TEXCOORD1.y);
#else
    u_xlatb13 = 0.0>=in_TEXCOORD1.y;
#endif
    u_xlat13 = u_xlatb13 ? 1.0 : float(0.0);
    u_xlat2.x = (-_WeightNormal) + _WeightBold;
    u_xlat13 = u_xlat13 * u_xlat2.x + _WeightNormal;
    u_xlat13 = u_xlat13 * 0.25 + _FaceDilate;
    u_xlat13 = u_xlat13 * _ScaleRatioA;
    vs_TEXCOORD1.x = (-u_xlat13) * 0.5 + u_xlat8.x;
    u_xlat6.z = u_xlat13 * 0.5;
    u_xlat8.x = (-u_xlat13) * 0.5 + 0.5;
    vs_TEXCOORD1.yw = u_xlat6.xz;
    vs_TEXCOORD1.z = u_xlat12 + u_xlat8.x;
    u_xlat3 = max(_ClipRect, vec4(-2e+010, -2e+010, -2e+010, -2e+010));
    u_xlat3 = min(u_xlat3, vec4(2e+010, 2e+010, 2e+010, 2e+010));
    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat3.xy);
    vs_TEXCOORD2.xy = vec2((-u_xlat3.z) + u_xlat0.x, (-u_xlat3.w) + u_xlat0.y);
    u_xlat0.xyw = u_xlat1.yyy * hlslcc_mtx4x4_EnvMatrix[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_EnvMatrix[0].xyz * u_xlat1.xxx + u_xlat0.xyw;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4_EnvMatrix[2].xyz * u_xlat1.zzz + u_xlat0.xyw;
    u_xlat1 = vec4(_UnderlaySoftness, _UnderlayDilate, _UnderlayOffsetX, _UnderlayOffsetY) * vec4(vec4(_ScaleRatioC, _ScaleRatioC, _ScaleRatioC, _ScaleRatioC));
    u_xlat0.x = u_xlat1.x * u_xlat6.x + 1.0;
    u_xlat0.x = u_xlat6.x / u_xlat0.x;
    u_xlat4 = u_xlat8.x * u_xlat0.x + -0.5;
    u_xlat8.x = u_xlat0.x * u_xlat1.y;
    u_xlat1.xy = vec2((-u_xlat1.z) * _GradientScale, (-u_xlat1.w) * _GradientScale);
    u_xlat1.xy = vec2(u_xlat1.x / float(_TextureWidth), u_xlat1.y / float(_TextureHeight));
    vs_TEXCOORD4.xy = u_xlat1.xy + in_TEXCOORD0.xy;
    vs_TEXCOORD4.z = u_xlat0.x;
    vs_TEXCOORD4.w = (-u_xlat8.x) * 0.5 + u_xlat4;
    u_xlat0.xyz = _UnderlayColor.www * _UnderlayColor.xyz;
    vs_COLOR1.xyz = u_xlat0.xyz;
    vs_COLOR1.w = _UnderlayColor.w;
    u_xlat0.x = in_TEXCOORD1.x * 0.000244140625;
    u_xlat8.x = floor(u_xlat0.x);
    u_xlat8.y = (-u_xlat8.x) * 4096.0 + in_TEXCOORD1.x;
    u_xlat0.xy = u_xlat8.xy * vec2(0.001953125, 0.001953125);
    vs_TEXCOORD5.xy = u_xlat0.xy * _FaceTex_ST.xy + _FaceTex_ST.zw;
    vs_TEXCOORD5.zw = u_xlat0.xy * _OutlineTex_ST.xy + _OutlineTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _FaceUVSpeedX;
uniform 	float _FaceUVSpeedY;
uniform 	mediump vec4 _FaceColor;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineUVSpeedX;
uniform 	float _OutlineUVSpeedY;
uniform 	mediump vec4 _OutlineColor;
uniform 	float _OutlineWidth;
uniform 	float _Bevel;
uniform 	float _BevelOffset;
uniform 	float _BevelWidth;
uniform 	float _BevelClamp;
uniform 	float _BevelRoundness;
uniform 	float _BumpOutline;
uniform 	float _BumpFace;
uniform 	mediump vec4 _ReflectFaceColor;
uniform 	mediump vec4 _ReflectOutlineColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	float _LightAngle;
uniform 	float _SpecularPower;
uniform 	float _Reflectivity;
uniform 	float _Diffuse;
uniform 	float _Ambient;
uniform 	mediump vec4 _GlowColor;
uniform 	float _GlowOffset;
uniform 	float _GlowOuter;
uniform 	float _GlowInner;
uniform 	float _GlowPower;
uniform 	float _ShaderFlags;
uniform 	float _ScaleRatioA;
uniform 	float _ScaleRatioB;
uniform 	float _TextureWidth;
uniform 	float _TextureHeight;
uniform 	float _GradientScale;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FaceTex;
uniform lowp sampler2D _OutlineTex;
uniform lowp sampler2D _BumpMap;
uniform lowp samplerCube _Cube;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
vec4 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec4 u_xlat16_5;
lowp vec4 u_xlat10_5;
mediump vec4 u_xlat16_6;
float u_xlat7;
mediump vec4 u_xlat16_7;
float u_xlat8;
float u_xlat9;
bool u_xlatb9;
vec2 u_xlat10;
mediump float u_xlat16_12;
float u_xlat16;
bool u_xlatb17;
mediump float u_xlat16_20;
float u_xlat24;
mediump float u_xlat16_24;
lowp float u_xlat10_24;
float u_xlat26;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w + _BevelOffset;
    u_xlat1.xy = vec2(float(0.5) / float(_TextureWidth), float(0.5) / float(_TextureHeight));
    u_xlat1.z = 0.0;
    u_xlat2 = (-u_xlat1.xzzy) + vs_TEXCOORD0.xyxy;
    u_xlat1 = u_xlat1.xzzy + vs_TEXCOORD0.xyxy;
    u_xlat3.x = texture(_MainTex, u_xlat2.xy).w;
    u_xlat3.z = texture(_MainTex, u_xlat2.zw).w;
    u_xlat3.y = texture(_MainTex, u_xlat1.xy).w;
    u_xlat3.w = texture(_MainTex, u_xlat1.zw).w;
    u_xlat0 = u_xlat0.xxxx + u_xlat3;
    u_xlat0 = u_xlat0 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat1.x = _BevelWidth + _OutlineWidth;
    u_xlat1.x = max(u_xlat1.x, 0.00999999978);
    u_xlat0 = u_xlat0 / u_xlat1.xxxx;
    u_xlat1.x = u_xlat1.x * _Bevel;
    u_xlat1.x = u_xlat1.x * _GradientScale;
    u_xlat1.x = u_xlat1.x * -2.0;
    u_xlat0 = u_xlat0 + vec4(0.5, 0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat2 = u_xlat0 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = -abs(u_xlat2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat9 = _ShaderFlags * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb17 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat9 = fract(abs(u_xlat9));
    u_xlat9 = (u_xlatb17) ? u_xlat9 : (-u_xlat9);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=0.5);
#else
    u_xlatb9 = u_xlat9>=0.5;
#endif
    u_xlat0 = (bool(u_xlatb9)) ? u_xlat2 : u_xlat0;
    u_xlat2 = u_xlat0 * vec4(1.57079601, 1.57079601, 1.57079601, 1.57079601);
    u_xlat2 = sin(u_xlat2);
    u_xlat2 = (-u_xlat0) + u_xlat2;
    u_xlat0 = vec4(vec4(_BevelRoundness, _BevelRoundness, _BevelRoundness, _BevelRoundness)) * u_xlat2 + u_xlat0;
    u_xlat9 = (-_BevelClamp) + 1.0;
    u_xlat0 = min(u_xlat0, vec4(u_xlat9));
    u_xlat0.xz = u_xlat1.xx * u_xlat0.xz;
    u_xlat0.yz = u_xlat0.wy * u_xlat1.xx + (-u_xlat0.zx);
    u_xlat0.x = float(-1.0);
    u_xlat0.w = float(1.0);
    u_xlat1.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat24 = dot(u_xlat0.zw, u_xlat0.zw);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.x = u_xlat24 * u_xlat0.z;
    u_xlat2.yz = vec2(u_xlat24) * vec2(1.0, 0.0);
    u_xlat0.z = 0.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat2.zxy * u_xlat0.yzx + (-u_xlat1.xyz);
    u_xlat1.xy = vec2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy + vs_TEXCOORD5.xy;
    u_xlat10_2.xyz = texture(_BumpMap, u_xlat1.xy).xyz;
    u_xlat10_1 = texture(_FaceTex, u_xlat1.xy);
    u_xlat16_4.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat24 = (-_BumpFace) + _BumpOutline;
    u_xlat10_2.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat2.x = (-u_xlat10_2.x) + vs_TEXCOORD1.z;
    u_xlat2.z = _OutlineWidth * _ScaleRatioA;
    u_xlat10.xy = u_xlat2.xz * vs_TEXCOORD1.yy;
    u_xlat26 = u_xlat10.y * 0.5 + u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat26 * u_xlat24 + _BumpFace;
    u_xlat0.xyz = (-u_xlat16_4.xyz) * vec3(u_xlat24) + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(vs_TEXCOORD3.xyz, (-u_xlat0.xyz));
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat3.xyz = u_xlat0.xyz * vec3(u_xlat24) + vs_TEXCOORD3.xyz;
    u_xlat10_3.xyz = texture(_Cube, u_xlat3.xyz).xyz;
    u_xlat16_5.xyz = (-_ReflectFaceColor.xyz) + _ReflectOutlineColor.xyz;
    u_xlat5.xyz = vec3(u_xlat26) * u_xlat16_5.xyz + _ReflectFaceColor.xyz;
    u_xlat3.xyz = u_xlat10_3.xyz * u_xlat5.xyz;
    u_xlat16_4.x = min(u_xlat10.y, 1.0);
    u_xlat16_12 = u_xlat10.y * 0.5;
    u_xlat16_4.x = sqrt(u_xlat16_4.x);
    u_xlat16_20 = u_xlat2.x * vs_TEXCOORD1.y + u_xlat16_12;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat2.x * vs_TEXCOORD1.y + (-u_xlat16_12);
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_20;
    u_xlat16_6.xyz = vs_COLOR0.xyz * _FaceColor.xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_6.xyz;
    u_xlat16_24 = u_xlat10_1.w * _FaceColor.w;
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_1.xyz;
    u_xlat2.xz = vec2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy + vs_TEXCOORD5.zw;
    u_xlat10_5 = texture(_OutlineTex, u_xlat2.xz);
    u_xlat16_7 = u_xlat10_5 * _OutlineColor;
    u_xlat16_5.w = _OutlineColor.w * u_xlat10_5.w + (-u_xlat16_24);
    u_xlat16_5.xyz = u_xlat16_7.xyz * u_xlat16_7.www + (-u_xlat16_6.xyz);
    u_xlat16_5 = u_xlat16_4.xxxx * u_xlat16_5;
    u_xlat16_6.xyz = u_xlat16_1.xyz * vec3(u_xlat16_24) + u_xlat16_5.xyz;
    u_xlat16_6.w = _FaceColor.w * u_xlat10_1.w + u_xlat16_5.w;
    u_xlat24 = _OutlineSoftness * _ScaleRatioA;
    u_xlat1.x = u_xlat24 * vs_TEXCOORD1.y;
    u_xlat16_4.x = u_xlat24 * vs_TEXCOORD1.y + 1.0;
    u_xlat16_12 = u_xlat1.x * 0.5 + u_xlat16_12;
    u_xlat16_4.x = u_xlat16_12 / u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_1 = u_xlat16_4.xxxx * u_xlat16_6;
    u_xlat16_4.x = (-u_xlat16_6.w) * u_xlat16_4.x + 1.0;
    u_xlat2.xzw = u_xlat16_1.www * u_xlat3.xyz;
    u_xlat3.x = sin(_LightAngle);
    u_xlat7 = cos(_LightAngle);
    u_xlat3.y = u_xlat7;
    u_xlat3.z = -1.0;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat8 = u_xlat0.z * u_xlat0.z;
    u_xlat16 = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-u_xlat0.x) * _Diffuse + 1.0;
    u_xlat16 = log2(u_xlat16);
    u_xlat16 = u_xlat16 * _Reflectivity;
    u_xlat16 = exp2(u_xlat16);
    u_xlat3.xyz = vec3(u_xlat16) * _SpecularColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_SpecularPower, _SpecularPower, _SpecularPower));
    u_xlat3.xyz = u_xlat3.xyz * u_xlat16_1.www + u_xlat16_1.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat3.x = (-_Ambient) + 1.0;
    u_xlat8 = u_xlat8 * u_xlat3.x + _Ambient;
    u_xlat0.xyz = u_xlat0.xzw * vec3(u_xlat8) + u_xlat2.xzw;
    u_xlat10_24 = texture(_MainTex, vs_TEXCOORD4.xy).w;
    u_xlat24 = u_xlat10_24 * vs_TEXCOORD4.z + (-vs_TEXCOORD4.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat3 = vec4(u_xlat24) * vs_COLOR1;
    u_xlat0.xyz = u_xlat3.xyz * u_xlat16_4.xxx + u_xlat0.xyz;
    u_xlat1.w = u_xlat3.w * u_xlat16_4.x + u_xlat16_1.w;
    u_xlat24 = _GlowOffset * _ScaleRatioB;
    u_xlat24 = u_xlat24 * vs_TEXCOORD1.y;
    u_xlat24 = (-u_xlat24) * 0.5 + u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat24>=0.0);
#else
    u_xlatb2 = u_xlat24>=0.0;
#endif
    u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat10.x = _GlowOuter * _ScaleRatioB + (-_GlowInner);
    u_xlat2.x = u_xlat2.x * u_xlat10.x + _GlowInner;
    u_xlat2.x = u_xlat2.x * vs_TEXCOORD1.y;
    u_xlat10.x = u_xlat2.x * 0.5 + 1.0;
    u_xlat2.x = u_xlat2.x * 0.5;
    u_xlat2.x = min(u_xlat2.x, 1.0);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat24 = u_xlat24 / u_xlat10.x;
    u_xlat24 = min(abs(u_xlat24), 1.0);
    u_xlat24 = log2(u_xlat24);
    u_xlat24 = u_xlat24 * _GlowPower;
    u_xlat24 = exp2(u_xlat24);
    u_xlat24 = (-u_xlat24) + 1.0;
    u_xlat24 = u_xlat2.x * u_xlat24;
    u_xlat24 = dot(_GlowColor.ww, vec2(u_xlat24));
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat1.xyz = _GlowColor.xyz * vec3(u_xlat24) + u_xlat0.xyz;
    SV_Target0 = u_xlat1 * vs_COLOR0.wwww;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixVP;
uniform highp float _FaceDilate;
uniform highp float _OutlineSoftness;
uniform highp float _OutlineWidth;
uniform highp mat4 _EnvMatrix;
uniform highp float _WeightNormal;
uniform highp float _WeightBold;
uniform highp float _ScaleRatioA;
uniform highp float _VertexOffsetX;
uniform highp float _VertexOffsetY;
uniform highp vec4 _ClipRect;
uniform highp float _MaskSoftnessX;
uniform highp float _MaskSoftnessY;
uniform highp float _GradientScale;
uniform highp float _ScaleX;
uniform highp float _ScaleY;
uniform highp float _PerspectiveFilter;
uniform highp vec4 _FaceTex_ST;
uniform highp vec4 _OutlineTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp float weight_3;
  highp float scale_4;
  highp vec2 pixelSize_5;
  highp vec4 vert_6;
  highp float tmpvar_7;
  tmpvar_7 = float((0.0 >= _glesMultiTexCoord1.y));
  vert_6.zw = _glesVertex.zw;
  vert_6.x = (_glesVertex.x + _VertexOffsetX);
  vert_6.y = (_glesVertex.y + _VertexOffsetY);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = vert_6.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp vec2 tmpvar_10;
  tmpvar_10.x = _ScaleX;
  tmpvar_10.y = _ScaleY;
  highp mat2 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_projection[0].xy;
  tmpvar_11[1] = glstate_matrix_projection[1].xy;
  pixelSize_5 = (tmpvar_8.ww / (tmpvar_10 * abs(
    (tmpvar_11 * _ScreenParams.xy)
  )));
  scale_4 = (inversesqrt(dot (pixelSize_5, pixelSize_5)) * ((
    abs(_glesMultiTexCoord1.y)
   * _GradientScale) * 1.5));
  if ((glstate_matrix_projection[3].w == 0.0)) {
    highp mat3 tmpvar_12;
    tmpvar_12[0] = unity_WorldToObject[0].xyz;
    tmpvar_12[1] = unity_WorldToObject[1].xyz;
    tmpvar_12[2] = unity_WorldToObject[2].xyz;
    scale_4 = mix ((abs(scale_4) * (1.0 - _PerspectiveFilter)), scale_4, abs(dot (
      normalize((_glesNormal * tmpvar_12))
    , 
      normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_6).xyz))
    )));
  };
  weight_3 = (((
    (mix (_WeightNormal, _WeightBold, tmpvar_7) / 4.0)
   + _FaceDilate) * _ScaleRatioA) * 0.5);
  highp vec4 tmpvar_13;
  tmpvar_13 = clamp (_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10), vec4(2e+10, 2e+10, 2e+10, 2e+10));
  highp vec2 tmpvar_14;
  highp vec2 xlat_varoutput_15;
  xlat_varoutput_15.x = floor((_glesMultiTexCoord1.x / 4096.0));
  xlat_varoutput_15.y = (_glesMultiTexCoord1.x - (4096.0 * xlat_varoutput_15.x));
  tmpvar_14 = (xlat_varoutput_15 * 0.001953125);
  highp vec4 tmpvar_16;
  tmpvar_16.x = (((
    ((1.0 - (_OutlineWidth * _ScaleRatioA)) - (_OutlineSoftness * _ScaleRatioA))
   / 2.0) - (0.5 / scale_4)) - weight_3);
  tmpvar_16.y = scale_4;
  tmpvar_16.z = ((0.5 - weight_3) + (0.5 / scale_4));
  tmpvar_16.w = weight_3;
  highp vec2 tmpvar_17;
  tmpvar_17.x = _MaskSoftnessX;
  tmpvar_17.y = _MaskSoftnessY;
  highp vec4 tmpvar_18;
  tmpvar_18.xy = (((vert_6.xy * 2.0) - tmpvar_13.xy) - tmpvar_13.zw);
  tmpvar_18.zw = (0.25 / ((0.25 * tmpvar_17) + pixelSize_5));
  highp mat3 tmpvar_19;
  tmpvar_19[0] = _EnvMatrix[0].xyz;
  tmpvar_19[1] = _EnvMatrix[1].xyz;
  tmpvar_19[2] = _EnvMatrix[2].xyz;
  highp vec4 tmpvar_20;
  tmpvar_20.xy = ((tmpvar_14 * _FaceTex_ST.xy) + _FaceTex_ST.zw);
  tmpvar_20.zw = ((tmpvar_14 * _OutlineTex_ST.xy) + _OutlineTex_ST.zw);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = (tmpvar_19 * (_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_6).xyz));
  xlv_TEXCOORD5 = tmpvar_20;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _FaceTex;
uniform highp float _FaceUVSpeedX;
uniform highp float _FaceUVSpeedY;
uniform lowp vec4 _FaceColor;
uniform highp float _OutlineSoftness;
uniform sampler2D _OutlineTex;
uniform highp float _OutlineUVSpeedX;
uniform highp float _OutlineUVSpeedY;
uniform lowp vec4 _OutlineColor;
uniform highp float _OutlineWidth;
uniform highp float _ScaleRatioA;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 outlineColor_2;
  mediump vec4 faceColor_3;
  highp float c_4;
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  c_4 = tmpvar_5;
  highp float x_6;
  x_6 = (c_4 - xlv_TEXCOORD1.x);
  if ((x_6 < 0.0)) {
    discard;
  };
  highp float tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD1.z - c_4) * xlv_TEXCOORD1.y);
  highp float tmpvar_8;
  tmpvar_8 = ((_OutlineWidth * _ScaleRatioA) * xlv_TEXCOORD1.y);
  highp float tmpvar_9;
  tmpvar_9 = ((_OutlineSoftness * _ScaleRatioA) * xlv_TEXCOORD1.y);
  faceColor_3 = _FaceColor;
  outlineColor_2 = _OutlineColor;
  faceColor_3.xyz = (faceColor_3.xyz * xlv_COLOR.xyz);
  highp vec2 tmpvar_10;
  tmpvar_10.x = _FaceUVSpeedX;
  tmpvar_10.y = _FaceUVSpeedY;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD5.xy + (tmpvar_10 * _Time.y));
  tmpvar_11 = texture2D (_FaceTex, P_12);
  faceColor_3 = (faceColor_3 * tmpvar_11);
  highp vec2 tmpvar_13;
  tmpvar_13.x = _OutlineUVSpeedX;
  tmpvar_13.y = _OutlineUVSpeedY;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD5.zw + (tmpvar_13 * _Time.y));
  tmpvar_14 = texture2D (_OutlineTex, P_15);
  outlineColor_2 = (outlineColor_2 * tmpvar_14);
  mediump float d_16;
  d_16 = tmpvar_7;
  lowp vec4 faceColor_17;
  faceColor_17 = faceColor_3;
  lowp vec4 outlineColor_18;
  outlineColor_18 = outlineColor_2;
  mediump float outline_19;
  outline_19 = tmpvar_8;
  mediump float softness_20;
  softness_20 = tmpvar_9;
  mediump float tmpvar_21;
  tmpvar_21 = (1.0 - clamp ((
    ((d_16 - (outline_19 * 0.5)) + (softness_20 * 0.5))
   / 
    (1.0 + softness_20)
  ), 0.0, 1.0));
  faceColor_17.xyz = (faceColor_17.xyz * faceColor_17.w);
  outlineColor_18.xyz = (outlineColor_18.xyz * outlineColor_18.w);
  mediump vec4 tmpvar_22;
  tmpvar_22 = mix (faceColor_17, outlineColor_18, vec4((clamp (
    (d_16 + (outline_19 * 0.5))
  , 0.0, 1.0) * sqrt(
    min (1.0, outline_19)
  ))));
  faceColor_17 = tmpvar_22;
  faceColor_17 = (faceColor_17 * tmpvar_21);
  faceColor_3 = faceColor_17;
  mediump float x_23;
  x_23 = (faceColor_3.w - 0.001);
  if ((x_23 < 0.0)) {
    discard;
  };
  tmpvar_1 = (faceColor_3 * xlv_COLOR.w);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixVP;
uniform highp float _FaceDilate;
uniform highp float _OutlineSoftness;
uniform highp float _OutlineWidth;
uniform highp mat4 _EnvMatrix;
uniform highp float _WeightNormal;
uniform highp float _WeightBold;
uniform highp float _ScaleRatioA;
uniform highp float _VertexOffsetX;
uniform highp float _VertexOffsetY;
uniform highp vec4 _ClipRect;
uniform highp float _MaskSoftnessX;
uniform highp float _MaskSoftnessY;
uniform highp float _GradientScale;
uniform highp float _ScaleX;
uniform highp float _ScaleY;
uniform highp float _PerspectiveFilter;
uniform highp vec4 _FaceTex_ST;
uniform highp vec4 _OutlineTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp float weight_3;
  highp float scale_4;
  highp vec2 pixelSize_5;
  highp vec4 vert_6;
  highp float tmpvar_7;
  tmpvar_7 = float((0.0 >= _glesMultiTexCoord1.y));
  vert_6.zw = _glesVertex.zw;
  vert_6.x = (_glesVertex.x + _VertexOffsetX);
  vert_6.y = (_glesVertex.y + _VertexOffsetY);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = vert_6.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp vec2 tmpvar_10;
  tmpvar_10.x = _ScaleX;
  tmpvar_10.y = _ScaleY;
  highp mat2 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_projection[0].xy;
  tmpvar_11[1] = glstate_matrix_projection[1].xy;
  pixelSize_5 = (tmpvar_8.ww / (tmpvar_10 * abs(
    (tmpvar_11 * _ScreenParams.xy)
  )));
  scale_4 = (inversesqrt(dot (pixelSize_5, pixelSize_5)) * ((
    abs(_glesMultiTexCoord1.y)
   * _GradientScale) * 1.5));
  if ((glstate_matrix_projection[3].w == 0.0)) {
    highp mat3 tmpvar_12;
    tmpvar_12[0] = unity_WorldToObject[0].xyz;
    tmpvar_12[1] = unity_WorldToObject[1].xyz;
    tmpvar_12[2] = unity_WorldToObject[2].xyz;
    scale_4 = mix ((abs(scale_4) * (1.0 - _PerspectiveFilter)), scale_4, abs(dot (
      normalize((_glesNormal * tmpvar_12))
    , 
      normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_6).xyz))
    )));
  };
  weight_3 = (((
    (mix (_WeightNormal, _WeightBold, tmpvar_7) / 4.0)
   + _FaceDilate) * _ScaleRatioA) * 0.5);
  highp vec4 tmpvar_13;
  tmpvar_13 = clamp (_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10), vec4(2e+10, 2e+10, 2e+10, 2e+10));
  highp vec2 tmpvar_14;
  highp vec2 xlat_varoutput_15;
  xlat_varoutput_15.x = floor((_glesMultiTexCoord1.x / 4096.0));
  xlat_varoutput_15.y = (_glesMultiTexCoord1.x - (4096.0 * xlat_varoutput_15.x));
  tmpvar_14 = (xlat_varoutput_15 * 0.001953125);
  highp vec4 tmpvar_16;
  tmpvar_16.x = (((
    ((1.0 - (_OutlineWidth * _ScaleRatioA)) - (_OutlineSoftness * _ScaleRatioA))
   / 2.0) - (0.5 / scale_4)) - weight_3);
  tmpvar_16.y = scale_4;
  tmpvar_16.z = ((0.5 - weight_3) + (0.5 / scale_4));
  tmpvar_16.w = weight_3;
  highp vec2 tmpvar_17;
  tmpvar_17.x = _MaskSoftnessX;
  tmpvar_17.y = _MaskSoftnessY;
  highp vec4 tmpvar_18;
  tmpvar_18.xy = (((vert_6.xy * 2.0) - tmpvar_13.xy) - tmpvar_13.zw);
  tmpvar_18.zw = (0.25 / ((0.25 * tmpvar_17) + pixelSize_5));
  highp mat3 tmpvar_19;
  tmpvar_19[0] = _EnvMatrix[0].xyz;
  tmpvar_19[1] = _EnvMatrix[1].xyz;
  tmpvar_19[2] = _EnvMatrix[2].xyz;
  highp vec4 tmpvar_20;
  tmpvar_20.xy = ((tmpvar_14 * _FaceTex_ST.xy) + _FaceTex_ST.zw);
  tmpvar_20.zw = ((tmpvar_14 * _OutlineTex_ST.xy) + _OutlineTex_ST.zw);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = (tmpvar_19 * (_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_6).xyz));
  xlv_TEXCOORD5 = tmpvar_20;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _FaceTex;
uniform highp float _FaceUVSpeedX;
uniform highp float _FaceUVSpeedY;
uniform lowp vec4 _FaceColor;
uniform highp float _OutlineSoftness;
uniform sampler2D _OutlineTex;
uniform highp float _OutlineUVSpeedX;
uniform highp float _OutlineUVSpeedY;
uniform lowp vec4 _OutlineColor;
uniform highp float _OutlineWidth;
uniform highp float _ScaleRatioA;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 outlineColor_2;
  mediump vec4 faceColor_3;
  highp float c_4;
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  c_4 = tmpvar_5;
  highp float x_6;
  x_6 = (c_4 - xlv_TEXCOORD1.x);
  if ((x_6 < 0.0)) {
    discard;
  };
  highp float tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD1.z - c_4) * xlv_TEXCOORD1.y);
  highp float tmpvar_8;
  tmpvar_8 = ((_OutlineWidth * _ScaleRatioA) * xlv_TEXCOORD1.y);
  highp float tmpvar_9;
  tmpvar_9 = ((_OutlineSoftness * _ScaleRatioA) * xlv_TEXCOORD1.y);
  faceColor_3 = _FaceColor;
  outlineColor_2 = _OutlineColor;
  faceColor_3.xyz = (faceColor_3.xyz * xlv_COLOR.xyz);
  highp vec2 tmpvar_10;
  tmpvar_10.x = _FaceUVSpeedX;
  tmpvar_10.y = _FaceUVSpeedY;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD5.xy + (tmpvar_10 * _Time.y));
  tmpvar_11 = texture2D (_FaceTex, P_12);
  faceColor_3 = (faceColor_3 * tmpvar_11);
  highp vec2 tmpvar_13;
  tmpvar_13.x = _OutlineUVSpeedX;
  tmpvar_13.y = _OutlineUVSpeedY;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD5.zw + (tmpvar_13 * _Time.y));
  tmpvar_14 = texture2D (_OutlineTex, P_15);
  outlineColor_2 = (outlineColor_2 * tmpvar_14);
  mediump float d_16;
  d_16 = tmpvar_7;
  lowp vec4 faceColor_17;
  faceColor_17 = faceColor_3;
  lowp vec4 outlineColor_18;
  outlineColor_18 = outlineColor_2;
  mediump float outline_19;
  outline_19 = tmpvar_8;
  mediump float softness_20;
  softness_20 = tmpvar_9;
  mediump float tmpvar_21;
  tmpvar_21 = (1.0 - clamp ((
    ((d_16 - (outline_19 * 0.5)) + (softness_20 * 0.5))
   / 
    (1.0 + softness_20)
  ), 0.0, 1.0));
  faceColor_17.xyz = (faceColor_17.xyz * faceColor_17.w);
  outlineColor_18.xyz = (outlineColor_18.xyz * outlineColor_18.w);
  mediump vec4 tmpvar_22;
  tmpvar_22 = mix (faceColor_17, outlineColor_18, vec4((clamp (
    (d_16 + (outline_19 * 0.5))
  , 0.0, 1.0) * sqrt(
    min (1.0, outline_19)
  ))));
  faceColor_17 = tmpvar_22;
  faceColor_17 = (faceColor_17 * tmpvar_21);
  faceColor_3 = faceColor_17;
  mediump float x_23;
  x_23 = (faceColor_3.w - 0.001);
  if ((x_23 < 0.0)) {
    discard;
  };
  tmpvar_1 = (faceColor_3 * xlv_COLOR.w);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixVP;
uniform highp float _FaceDilate;
uniform highp float _OutlineSoftness;
uniform highp float _OutlineWidth;
uniform highp mat4 _EnvMatrix;
uniform highp float _WeightNormal;
uniform highp float _WeightBold;
uniform highp float _ScaleRatioA;
uniform highp float _VertexOffsetX;
uniform highp float _VertexOffsetY;
uniform highp vec4 _ClipRect;
uniform highp float _MaskSoftnessX;
uniform highp float _MaskSoftnessY;
uniform highp float _GradientScale;
uniform highp float _ScaleX;
uniform highp float _ScaleY;
uniform highp float _PerspectiveFilter;
uniform highp vec4 _FaceTex_ST;
uniform highp vec4 _OutlineTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp float weight_3;
  highp float scale_4;
  highp vec2 pixelSize_5;
  highp vec4 vert_6;
  highp float tmpvar_7;
  tmpvar_7 = float((0.0 >= _glesMultiTexCoord1.y));
  vert_6.zw = _glesVertex.zw;
  vert_6.x = (_glesVertex.x + _VertexOffsetX);
  vert_6.y = (_glesVertex.y + _VertexOffsetY);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = vert_6.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp vec2 tmpvar_10;
  tmpvar_10.x = _ScaleX;
  tmpvar_10.y = _ScaleY;
  highp mat2 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_projection[0].xy;
  tmpvar_11[1] = glstate_matrix_projection[1].xy;
  pixelSize_5 = (tmpvar_8.ww / (tmpvar_10 * abs(
    (tmpvar_11 * _ScreenParams.xy)
  )));
  scale_4 = (inversesqrt(dot (pixelSize_5, pixelSize_5)) * ((
    abs(_glesMultiTexCoord1.y)
   * _GradientScale) * 1.5));
  if ((glstate_matrix_projection[3].w == 0.0)) {
    highp mat3 tmpvar_12;
    tmpvar_12[0] = unity_WorldToObject[0].xyz;
    tmpvar_12[1] = unity_WorldToObject[1].xyz;
    tmpvar_12[2] = unity_WorldToObject[2].xyz;
    scale_4 = mix ((abs(scale_4) * (1.0 - _PerspectiveFilter)), scale_4, abs(dot (
      normalize((_glesNormal * tmpvar_12))
    , 
      normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_6).xyz))
    )));
  };
  weight_3 = (((
    (mix (_WeightNormal, _WeightBold, tmpvar_7) / 4.0)
   + _FaceDilate) * _ScaleRatioA) * 0.5);
  highp vec4 tmpvar_13;
  tmpvar_13 = clamp (_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10), vec4(2e+10, 2e+10, 2e+10, 2e+10));
  highp vec2 tmpvar_14;
  highp vec2 xlat_varoutput_15;
  xlat_varoutput_15.x = floor((_glesMultiTexCoord1.x / 4096.0));
  xlat_varoutput_15.y = (_glesMultiTexCoord1.x - (4096.0 * xlat_varoutput_15.x));
  tmpvar_14 = (xlat_varoutput_15 * 0.001953125);
  highp vec4 tmpvar_16;
  tmpvar_16.x = (((
    ((1.0 - (_OutlineWidth * _ScaleRatioA)) - (_OutlineSoftness * _ScaleRatioA))
   / 2.0) - (0.5 / scale_4)) - weight_3);
  tmpvar_16.y = scale_4;
  tmpvar_16.z = ((0.5 - weight_3) + (0.5 / scale_4));
  tmpvar_16.w = weight_3;
  highp vec2 tmpvar_17;
  tmpvar_17.x = _MaskSoftnessX;
  tmpvar_17.y = _MaskSoftnessY;
  highp vec4 tmpvar_18;
  tmpvar_18.xy = (((vert_6.xy * 2.0) - tmpvar_13.xy) - tmpvar_13.zw);
  tmpvar_18.zw = (0.25 / ((0.25 * tmpvar_17) + pixelSize_5));
  highp mat3 tmpvar_19;
  tmpvar_19[0] = _EnvMatrix[0].xyz;
  tmpvar_19[1] = _EnvMatrix[1].xyz;
  tmpvar_19[2] = _EnvMatrix[2].xyz;
  highp vec4 tmpvar_20;
  tmpvar_20.xy = ((tmpvar_14 * _FaceTex_ST.xy) + _FaceTex_ST.zw);
  tmpvar_20.zw = ((tmpvar_14 * _OutlineTex_ST.xy) + _OutlineTex_ST.zw);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = (tmpvar_19 * (_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_6).xyz));
  xlv_TEXCOORD5 = tmpvar_20;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _FaceTex;
uniform highp float _FaceUVSpeedX;
uniform highp float _FaceUVSpeedY;
uniform lowp vec4 _FaceColor;
uniform highp float _OutlineSoftness;
uniform sampler2D _OutlineTex;
uniform highp float _OutlineUVSpeedX;
uniform highp float _OutlineUVSpeedY;
uniform lowp vec4 _OutlineColor;
uniform highp float _OutlineWidth;
uniform highp float _ScaleRatioA;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 outlineColor_2;
  mediump vec4 faceColor_3;
  highp float c_4;
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  c_4 = tmpvar_5;
  highp float x_6;
  x_6 = (c_4 - xlv_TEXCOORD1.x);
  if ((x_6 < 0.0)) {
    discard;
  };
  highp float tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD1.z - c_4) * xlv_TEXCOORD1.y);
  highp float tmpvar_8;
  tmpvar_8 = ((_OutlineWidth * _ScaleRatioA) * xlv_TEXCOORD1.y);
  highp float tmpvar_9;
  tmpvar_9 = ((_OutlineSoftness * _ScaleRatioA) * xlv_TEXCOORD1.y);
  faceColor_3 = _FaceColor;
  outlineColor_2 = _OutlineColor;
  faceColor_3.xyz = (faceColor_3.xyz * xlv_COLOR.xyz);
  highp vec2 tmpvar_10;
  tmpvar_10.x = _FaceUVSpeedX;
  tmpvar_10.y = _FaceUVSpeedY;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD5.xy + (tmpvar_10 * _Time.y));
  tmpvar_11 = texture2D (_FaceTex, P_12);
  faceColor_3 = (faceColor_3 * tmpvar_11);
  highp vec2 tmpvar_13;
  tmpvar_13.x = _OutlineUVSpeedX;
  tmpvar_13.y = _OutlineUVSpeedY;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD5.zw + (tmpvar_13 * _Time.y));
  tmpvar_14 = texture2D (_OutlineTex, P_15);
  outlineColor_2 = (outlineColor_2 * tmpvar_14);
  mediump float d_16;
  d_16 = tmpvar_7;
  lowp vec4 faceColor_17;
  faceColor_17 = faceColor_3;
  lowp vec4 outlineColor_18;
  outlineColor_18 = outlineColor_2;
  mediump float outline_19;
  outline_19 = tmpvar_8;
  mediump float softness_20;
  softness_20 = tmpvar_9;
  mediump float tmpvar_21;
  tmpvar_21 = (1.0 - clamp ((
    ((d_16 - (outline_19 * 0.5)) + (softness_20 * 0.5))
   / 
    (1.0 + softness_20)
  ), 0.0, 1.0));
  faceColor_17.xyz = (faceColor_17.xyz * faceColor_17.w);
  outlineColor_18.xyz = (outlineColor_18.xyz * outlineColor_18.w);
  mediump vec4 tmpvar_22;
  tmpvar_22 = mix (faceColor_17, outlineColor_18, vec4((clamp (
    (d_16 + (outline_19 * 0.5))
  , 0.0, 1.0) * sqrt(
    min (1.0, outline_19)
  ))));
  faceColor_17 = tmpvar_22;
  faceColor_17 = (faceColor_17 * tmpvar_21);
  faceColor_3 = faceColor_17;
  mediump float x_23;
  x_23 = (faceColor_3.w - 0.001);
  if ((x_23 < 0.0)) {
    discard;
  };
  tmpvar_1 = (faceColor_3 * xlv_COLOR.w);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _FaceDilate;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineWidth;
uniform 	vec4 hlslcc_mtx4x4_EnvMatrix[4];
uniform 	float _WeightNormal;
uniform 	float _WeightBold;
uniform 	float _ScaleRatioA;
uniform 	float _VertexOffsetX;
uniform 	float _VertexOffsetY;
uniform 	vec4 _ClipRect;
uniform 	float _MaskSoftnessX;
uniform 	float _MaskSoftnessY;
uniform 	float _GradientScale;
uniform 	float _ScaleX;
uniform 	float _ScaleY;
uniform 	float _PerspectiveFilter;
uniform 	vec4 _FaceTex_ST;
uniform 	vec4 _OutlineTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat6;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0.xy = vec2(in_POSITION0.x + float(_VertexOffsetX), in_POSITION0.y + float(_VertexOffsetY));
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat2.xyz = u_xlat8.xxx * u_xlat2.xyz;
    u_xlat8.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat2.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat2.xy;
    u_xlat2.xy = vec2(abs(u_xlat2.x) * float(_ScaleX), abs(u_xlat2.y) * float(_ScaleY));
    u_xlat2.xy = u_xlat2.ww / u_xlat2.xy;
    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat2.xy;
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat2.xy;
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat13 = abs(in_TEXCOORD1.y) * _GradientScale;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * 1.5;
    u_xlat2.x = (-_PerspectiveFilter) + 1.0;
    u_xlat2.x = abs(u_xlat13) * u_xlat2.x;
    u_xlat12 = u_xlat12 * 1.5 + (-u_xlat2.x);
    u_xlat8.x = abs(u_xlat8.x) * u_xlat12 + u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0);
#else
    u_xlatb12 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
#endif
    u_xlat6.x = (u_xlatb12) ? u_xlat8.x : u_xlat13;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.0>=in_TEXCOORD1.y);
#else
    u_xlatb8 = 0.0>=in_TEXCOORD1.y;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat12 = (-_WeightNormal) + _WeightBold;
    u_xlat8.x = u_xlat8.x * u_xlat12 + _WeightNormal;
    u_xlat8.x = u_xlat8.x * 0.25 + _FaceDilate;
    u_xlat8.x = u_xlat8.x * _ScaleRatioA;
    u_xlat6.z = u_xlat8.x * 0.5;
    vs_TEXCOORD1.yw = u_xlat6.xz;
    u_xlat12 = 0.5 / u_xlat6.x;
    u_xlat13 = (-_OutlineWidth) * _ScaleRatioA + 1.0;
    u_xlat13 = (-_OutlineSoftness) * _ScaleRatioA + u_xlat13;
    u_xlat13 = u_xlat13 * 0.5 + (-u_xlat12);
    vs_TEXCOORD1.x = (-u_xlat8.x) * 0.5 + u_xlat13;
    u_xlat8.x = (-u_xlat8.x) * 0.5 + 0.5;
    vs_TEXCOORD1.z = u_xlat12 + u_xlat8.x;
    u_xlat2 = max(_ClipRect, vec4(-2e+010, -2e+010, -2e+010, -2e+010));
    u_xlat2 = min(u_xlat2, vec4(2e+010, 2e+010, 2e+010, 2e+010));
    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat2.xy);
    vs_TEXCOORD2.xy = vec2((-u_xlat2.z) + u_xlat0.x, (-u_xlat2.w) + u_xlat0.y);
    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4x4_EnvMatrix[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_EnvMatrix[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4_EnvMatrix[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x * 0.000244140625;
    u_xlat8.x = floor(u_xlat0.x);
    u_xlat8.y = (-u_xlat8.x) * 4096.0 + in_TEXCOORD1.x;
    u_xlat0.xy = u_xlat8.xy * vec2(0.001953125, 0.001953125);
    vs_TEXCOORD5.xy = u_xlat0.xy * _FaceTex_ST.xy + _FaceTex_ST.zw;
    vs_TEXCOORD5.zw = u_xlat0.xy * _OutlineTex_ST.xy + _OutlineTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _FaceUVSpeedX;
uniform 	float _FaceUVSpeedY;
uniform 	mediump vec4 _FaceColor;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineUVSpeedX;
uniform 	float _OutlineUVSpeedY;
uniform 	mediump vec4 _OutlineColor;
uniform 	float _OutlineWidth;
uniform 	float _ScaleRatioA;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FaceTex;
uniform lowp sampler2D _OutlineTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump float u_xlat16_4;
lowp vec4 u_xlat10_4;
bool u_xlatb4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_6;
mediump float u_xlat16_11;
void main()
{
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat5 = u_xlat10_0.x + (-vs_TEXCOORD1.x);
    u_xlat0.x = (-u_xlat10_0.x) + vs_TEXCOORD1.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5<0.0);
#else
    u_xlatb5 = u_xlat5<0.0;
#endif
    if((int(u_xlatb5) * int(0xffffffffu))!=0){discard;}
    u_xlat5 = _OutlineWidth * _ScaleRatioA;
    u_xlat5 = u_xlat5 * vs_TEXCOORD1.y;
    u_xlat16_1 = min(u_xlat5, 1.0);
    u_xlat16_6 = u_xlat5 * 0.5;
    u_xlat16_1 = sqrt(u_xlat16_1);
    u_xlat16_11 = u_xlat0.x * vs_TEXCOORD1.y + u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat0.x * vs_TEXCOORD1.y + (-u_xlat16_6);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_11;
    u_xlat0.xy = vec2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy + vs_TEXCOORD5.zw;
    u_xlat10_0 = texture(_OutlineTex, u_xlat0.xy);
    u_xlat16_2 = u_xlat10_0 * _OutlineColor;
    u_xlat16_3.xyz = vs_COLOR0.xyz * _FaceColor.xyz;
    u_xlat0.xy = vec2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy + vs_TEXCOORD5.xy;
    u_xlat10_4 = texture(_FaceTex, u_xlat0.xy);
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat10_4.xyz;
    u_xlat16_4 = u_xlat10_4.w * _FaceColor.w;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vec3(u_xlat16_4);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_2.www + (-u_xlat16_3.xyz);
    u_xlat16_2.w = _OutlineColor.w * u_xlat10_0.w + (-u_xlat16_4);
    u_xlat16_2 = vec4(u_xlat16_1) * u_xlat16_2;
    u_xlat16_3.w = _FaceColor.w * u_xlat10_4.w + u_xlat16_2.w;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vec3(u_xlat16_4) + u_xlat16_2.xyz;
    u_xlat0.x = _OutlineSoftness * _ScaleRatioA;
    u_xlat5 = u_xlat0.x * vs_TEXCOORD1.y;
    u_xlat16_1 = u_xlat0.x * vs_TEXCOORD1.y + 1.0;
    u_xlat16_6 = u_xlat5 * 0.5 + u_xlat16_6;
    u_xlat16_1 = u_xlat16_6 / u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_6 = u_xlat16_3.w * u_xlat16_1 + -0.00100000005;
    u_xlat16_0 = vec4(u_xlat16_1) * u_xlat16_3;
    SV_Target0 = u_xlat16_0 * vs_COLOR0.wwww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat16_6<0.0);
#else
    u_xlatb4 = u_xlat16_6<0.0;
#endif
    if((int(u_xlatb4) * int(0xffffffffu))!=0){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _FaceDilate;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineWidth;
uniform 	vec4 hlslcc_mtx4x4_EnvMatrix[4];
uniform 	float _WeightNormal;
uniform 	float _WeightBold;
uniform 	float _ScaleRatioA;
uniform 	float _VertexOffsetX;
uniform 	float _VertexOffsetY;
uniform 	vec4 _ClipRect;
uniform 	float _MaskSoftnessX;
uniform 	float _MaskSoftnessY;
uniform 	float _GradientScale;
uniform 	float _ScaleX;
uniform 	float _ScaleY;
uniform 	float _PerspectiveFilter;
uniform 	vec4 _FaceTex_ST;
uniform 	vec4 _OutlineTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat6;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0.xy = vec2(in_POSITION0.x + float(_VertexOffsetX), in_POSITION0.y + float(_VertexOffsetY));
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat2.xyz = u_xlat8.xxx * u_xlat2.xyz;
    u_xlat8.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat2.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat2.xy;
    u_xlat2.xy = vec2(abs(u_xlat2.x) * float(_ScaleX), abs(u_xlat2.y) * float(_ScaleY));
    u_xlat2.xy = u_xlat2.ww / u_xlat2.xy;
    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat2.xy;
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat2.xy;
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat13 = abs(in_TEXCOORD1.y) * _GradientScale;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * 1.5;
    u_xlat2.x = (-_PerspectiveFilter) + 1.0;
    u_xlat2.x = abs(u_xlat13) * u_xlat2.x;
    u_xlat12 = u_xlat12 * 1.5 + (-u_xlat2.x);
    u_xlat8.x = abs(u_xlat8.x) * u_xlat12 + u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0);
#else
    u_xlatb12 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
#endif
    u_xlat6.x = (u_xlatb12) ? u_xlat8.x : u_xlat13;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.0>=in_TEXCOORD1.y);
#else
    u_xlatb8 = 0.0>=in_TEXCOORD1.y;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat12 = (-_WeightNormal) + _WeightBold;
    u_xlat8.x = u_xlat8.x * u_xlat12 + _WeightNormal;
    u_xlat8.x = u_xlat8.x * 0.25 + _FaceDilate;
    u_xlat8.x = u_xlat8.x * _ScaleRatioA;
    u_xlat6.z = u_xlat8.x * 0.5;
    vs_TEXCOORD1.yw = u_xlat6.xz;
    u_xlat12 = 0.5 / u_xlat6.x;
    u_xlat13 = (-_OutlineWidth) * _ScaleRatioA + 1.0;
    u_xlat13 = (-_OutlineSoftness) * _ScaleRatioA + u_xlat13;
    u_xlat13 = u_xlat13 * 0.5 + (-u_xlat12);
    vs_TEXCOORD1.x = (-u_xlat8.x) * 0.5 + u_xlat13;
    u_xlat8.x = (-u_xlat8.x) * 0.5 + 0.5;
    vs_TEXCOORD1.z = u_xlat12 + u_xlat8.x;
    u_xlat2 = max(_ClipRect, vec4(-2e+010, -2e+010, -2e+010, -2e+010));
    u_xlat2 = min(u_xlat2, vec4(2e+010, 2e+010, 2e+010, 2e+010));
    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat2.xy);
    vs_TEXCOORD2.xy = vec2((-u_xlat2.z) + u_xlat0.x, (-u_xlat2.w) + u_xlat0.y);
    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4x4_EnvMatrix[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_EnvMatrix[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4_EnvMatrix[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x * 0.000244140625;
    u_xlat8.x = floor(u_xlat0.x);
    u_xlat8.y = (-u_xlat8.x) * 4096.0 + in_TEXCOORD1.x;
    u_xlat0.xy = u_xlat8.xy * vec2(0.001953125, 0.001953125);
    vs_TEXCOORD5.xy = u_xlat0.xy * _FaceTex_ST.xy + _FaceTex_ST.zw;
    vs_TEXCOORD5.zw = u_xlat0.xy * _OutlineTex_ST.xy + _OutlineTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _FaceUVSpeedX;
uniform 	float _FaceUVSpeedY;
uniform 	mediump vec4 _FaceColor;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineUVSpeedX;
uniform 	float _OutlineUVSpeedY;
uniform 	mediump vec4 _OutlineColor;
uniform 	float _OutlineWidth;
uniform 	float _ScaleRatioA;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FaceTex;
uniform lowp sampler2D _OutlineTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump float u_xlat16_4;
lowp vec4 u_xlat10_4;
bool u_xlatb4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_6;
mediump float u_xlat16_11;
void main()
{
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat5 = u_xlat10_0.x + (-vs_TEXCOORD1.x);
    u_xlat0.x = (-u_xlat10_0.x) + vs_TEXCOORD1.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5<0.0);
#else
    u_xlatb5 = u_xlat5<0.0;
#endif
    if((int(u_xlatb5) * int(0xffffffffu))!=0){discard;}
    u_xlat5 = _OutlineWidth * _ScaleRatioA;
    u_xlat5 = u_xlat5 * vs_TEXCOORD1.y;
    u_xlat16_1 = min(u_xlat5, 1.0);
    u_xlat16_6 = u_xlat5 * 0.5;
    u_xlat16_1 = sqrt(u_xlat16_1);
    u_xlat16_11 = u_xlat0.x * vs_TEXCOORD1.y + u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat0.x * vs_TEXCOORD1.y + (-u_xlat16_6);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_11;
    u_xlat0.xy = vec2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy + vs_TEXCOORD5.zw;
    u_xlat10_0 = texture(_OutlineTex, u_xlat0.xy);
    u_xlat16_2 = u_xlat10_0 * _OutlineColor;
    u_xlat16_3.xyz = vs_COLOR0.xyz * _FaceColor.xyz;
    u_xlat0.xy = vec2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy + vs_TEXCOORD5.xy;
    u_xlat10_4 = texture(_FaceTex, u_xlat0.xy);
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat10_4.xyz;
    u_xlat16_4 = u_xlat10_4.w * _FaceColor.w;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vec3(u_xlat16_4);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_2.www + (-u_xlat16_3.xyz);
    u_xlat16_2.w = _OutlineColor.w * u_xlat10_0.w + (-u_xlat16_4);
    u_xlat16_2 = vec4(u_xlat16_1) * u_xlat16_2;
    u_xlat16_3.w = _FaceColor.w * u_xlat10_4.w + u_xlat16_2.w;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vec3(u_xlat16_4) + u_xlat16_2.xyz;
    u_xlat0.x = _OutlineSoftness * _ScaleRatioA;
    u_xlat5 = u_xlat0.x * vs_TEXCOORD1.y;
    u_xlat16_1 = u_xlat0.x * vs_TEXCOORD1.y + 1.0;
    u_xlat16_6 = u_xlat5 * 0.5 + u_xlat16_6;
    u_xlat16_1 = u_xlat16_6 / u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_6 = u_xlat16_3.w * u_xlat16_1 + -0.00100000005;
    u_xlat16_0 = vec4(u_xlat16_1) * u_xlat16_3;
    SV_Target0 = u_xlat16_0 * vs_COLOR0.wwww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat16_6<0.0);
#else
    u_xlatb4 = u_xlat16_6<0.0;
#endif
    if((int(u_xlatb4) * int(0xffffffffu))!=0){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _FaceDilate;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineWidth;
uniform 	vec4 hlslcc_mtx4x4_EnvMatrix[4];
uniform 	float _WeightNormal;
uniform 	float _WeightBold;
uniform 	float _ScaleRatioA;
uniform 	float _VertexOffsetX;
uniform 	float _VertexOffsetY;
uniform 	vec4 _ClipRect;
uniform 	float _MaskSoftnessX;
uniform 	float _MaskSoftnessY;
uniform 	float _GradientScale;
uniform 	float _ScaleX;
uniform 	float _ScaleY;
uniform 	float _PerspectiveFilter;
uniform 	vec4 _FaceTex_ST;
uniform 	vec4 _OutlineTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat6;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0.xy = vec2(in_POSITION0.x + float(_VertexOffsetX), in_POSITION0.y + float(_VertexOffsetY));
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat2.xyz = u_xlat8.xxx * u_xlat2.xyz;
    u_xlat8.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat2.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat2.xy;
    u_xlat2.xy = vec2(abs(u_xlat2.x) * float(_ScaleX), abs(u_xlat2.y) * float(_ScaleY));
    u_xlat2.xy = u_xlat2.ww / u_xlat2.xy;
    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat2.xy;
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat2.xy;
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat13 = abs(in_TEXCOORD1.y) * _GradientScale;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * 1.5;
    u_xlat2.x = (-_PerspectiveFilter) + 1.0;
    u_xlat2.x = abs(u_xlat13) * u_xlat2.x;
    u_xlat12 = u_xlat12 * 1.5 + (-u_xlat2.x);
    u_xlat8.x = abs(u_xlat8.x) * u_xlat12 + u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0);
#else
    u_xlatb12 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
#endif
    u_xlat6.x = (u_xlatb12) ? u_xlat8.x : u_xlat13;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.0>=in_TEXCOORD1.y);
#else
    u_xlatb8 = 0.0>=in_TEXCOORD1.y;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat12 = (-_WeightNormal) + _WeightBold;
    u_xlat8.x = u_xlat8.x * u_xlat12 + _WeightNormal;
    u_xlat8.x = u_xlat8.x * 0.25 + _FaceDilate;
    u_xlat8.x = u_xlat8.x * _ScaleRatioA;
    u_xlat6.z = u_xlat8.x * 0.5;
    vs_TEXCOORD1.yw = u_xlat6.xz;
    u_xlat12 = 0.5 / u_xlat6.x;
    u_xlat13 = (-_OutlineWidth) * _ScaleRatioA + 1.0;
    u_xlat13 = (-_OutlineSoftness) * _ScaleRatioA + u_xlat13;
    u_xlat13 = u_xlat13 * 0.5 + (-u_xlat12);
    vs_TEXCOORD1.x = (-u_xlat8.x) * 0.5 + u_xlat13;
    u_xlat8.x = (-u_xlat8.x) * 0.5 + 0.5;
    vs_TEXCOORD1.z = u_xlat12 + u_xlat8.x;
    u_xlat2 = max(_ClipRect, vec4(-2e+010, -2e+010, -2e+010, -2e+010));
    u_xlat2 = min(u_xlat2, vec4(2e+010, 2e+010, 2e+010, 2e+010));
    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat2.xy);
    vs_TEXCOORD2.xy = vec2((-u_xlat2.z) + u_xlat0.x, (-u_xlat2.w) + u_xlat0.y);
    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4x4_EnvMatrix[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_EnvMatrix[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4_EnvMatrix[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x * 0.000244140625;
    u_xlat8.x = floor(u_xlat0.x);
    u_xlat8.y = (-u_xlat8.x) * 4096.0 + in_TEXCOORD1.x;
    u_xlat0.xy = u_xlat8.xy * vec2(0.001953125, 0.001953125);
    vs_TEXCOORD5.xy = u_xlat0.xy * _FaceTex_ST.xy + _FaceTex_ST.zw;
    vs_TEXCOORD5.zw = u_xlat0.xy * _OutlineTex_ST.xy + _OutlineTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _FaceUVSpeedX;
uniform 	float _FaceUVSpeedY;
uniform 	mediump vec4 _FaceColor;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineUVSpeedX;
uniform 	float _OutlineUVSpeedY;
uniform 	mediump vec4 _OutlineColor;
uniform 	float _OutlineWidth;
uniform 	float _ScaleRatioA;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FaceTex;
uniform lowp sampler2D _OutlineTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec4 u_xlat16_3;
mediump float u_xlat16_4;
lowp vec4 u_xlat10_4;
bool u_xlatb4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_6;
mediump float u_xlat16_11;
void main()
{
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat5 = u_xlat10_0.x + (-vs_TEXCOORD1.x);
    u_xlat0.x = (-u_xlat10_0.x) + vs_TEXCOORD1.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5<0.0);
#else
    u_xlatb5 = u_xlat5<0.0;
#endif
    if((int(u_xlatb5) * int(0xffffffffu))!=0){discard;}
    u_xlat5 = _OutlineWidth * _ScaleRatioA;
    u_xlat5 = u_xlat5 * vs_TEXCOORD1.y;
    u_xlat16_1 = min(u_xlat5, 1.0);
    u_xlat16_6 = u_xlat5 * 0.5;
    u_xlat16_1 = sqrt(u_xlat16_1);
    u_xlat16_11 = u_xlat0.x * vs_TEXCOORD1.y + u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat0.x * vs_TEXCOORD1.y + (-u_xlat16_6);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_11;
    u_xlat0.xy = vec2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy + vs_TEXCOORD5.zw;
    u_xlat10_0 = texture(_OutlineTex, u_xlat0.xy);
    u_xlat16_2 = u_xlat10_0 * _OutlineColor;
    u_xlat16_3.xyz = vs_COLOR0.xyz * _FaceColor.xyz;
    u_xlat0.xy = vec2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy + vs_TEXCOORD5.xy;
    u_xlat10_4 = texture(_FaceTex, u_xlat0.xy);
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat10_4.xyz;
    u_xlat16_4 = u_xlat10_4.w * _FaceColor.w;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vec3(u_xlat16_4);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_2.www + (-u_xlat16_3.xyz);
    u_xlat16_2.w = _OutlineColor.w * u_xlat10_0.w + (-u_xlat16_4);
    u_xlat16_2 = vec4(u_xlat16_1) * u_xlat16_2;
    u_xlat16_3.w = _FaceColor.w * u_xlat10_4.w + u_xlat16_2.w;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vec3(u_xlat16_4) + u_xlat16_2.xyz;
    u_xlat0.x = _OutlineSoftness * _ScaleRatioA;
    u_xlat5 = u_xlat0.x * vs_TEXCOORD1.y;
    u_xlat16_1 = u_xlat0.x * vs_TEXCOORD1.y + 1.0;
    u_xlat16_6 = u_xlat5 * 0.5 + u_xlat16_6;
    u_xlat16_1 = u_xlat16_6 / u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_6 = u_xlat16_3.w * u_xlat16_1 + -0.00100000005;
    u_xlat16_0 = vec4(u_xlat16_1) * u_xlat16_3;
    SV_Target0 = u_xlat16_0 * vs_COLOR0.wwww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat16_6<0.0);
#else
    u_xlatb4 = u_xlat16_6<0.0;
#endif
    if((int(u_xlatb4) * int(0xffffffffu))!=0){discard;}
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixVP;
uniform highp float _FaceDilate;
uniform highp float _OutlineSoftness;
uniform highp float _OutlineWidth;
uniform highp mat4 _EnvMatrix;
uniform lowp vec4 _UnderlayColor;
uniform highp float _UnderlayOffsetX;
uniform highp float _UnderlayOffsetY;
uniform highp float _UnderlayDilate;
uniform highp float _UnderlaySoftness;
uniform highp float _GlowOffset;
uniform highp float _GlowOuter;
uniform highp float _WeightNormal;
uniform highp float _WeightBold;
uniform highp float _ScaleRatioA;
uniform highp float _ScaleRatioB;
uniform highp float _ScaleRatioC;
uniform highp float _VertexOffsetX;
uniform highp float _VertexOffsetY;
uniform highp vec4 _ClipRect;
uniform highp float _MaskSoftnessX;
uniform highp float _MaskSoftnessY;
uniform highp float _TextureWidth;
uniform highp float _TextureHeight;
uniform highp float _GradientScale;
uniform highp float _ScaleX;
uniform highp float _ScaleY;
uniform highp float _PerspectiveFilter;
uniform highp vec4 _FaceTex_ST;
uniform highp vec4 _OutlineTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp float bScale_3;
  highp vec4 underlayColor_4;
  highp float weight_5;
  highp float scale_6;
  highp vec2 pixelSize_7;
  highp vec4 vert_8;
  highp float tmpvar_9;
  tmpvar_9 = float((0.0 >= _glesMultiTexCoord1.y));
  vert_8.zw = _glesVertex.zw;
  vert_8.x = (_glesVertex.x + _VertexOffsetX);
  vert_8.y = (_glesVertex.y + _VertexOffsetY);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = vert_8.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec2 tmpvar_12;
  tmpvar_12.x = _ScaleX;
  tmpvar_12.y = _ScaleY;
  highp mat2 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_projection[0].xy;
  tmpvar_13[1] = glstate_matrix_projection[1].xy;
  pixelSize_7 = (tmpvar_10.ww / (tmpvar_12 * abs(
    (tmpvar_13 * _ScreenParams.xy)
  )));
  scale_6 = (inversesqrt(dot (pixelSize_7, pixelSize_7)) * ((
    abs(_glesMultiTexCoord1.y)
   * _GradientScale) * 1.5));
  if ((glstate_matrix_projection[3].w == 0.0)) {
    highp mat3 tmpvar_14;
    tmpvar_14[0] = unity_WorldToObject[0].xyz;
    tmpvar_14[1] = unity_WorldToObject[1].xyz;
    tmpvar_14[2] = unity_WorldToObject[2].xyz;
    scale_6 = mix ((abs(scale_6) * (1.0 - _PerspectiveFilter)), scale_6, abs(dot (
      normalize((_glesNormal * tmpvar_14))
    , 
      normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_8).xyz))
    )));
  };
  weight_5 = (((
    (mix (_WeightNormal, _WeightBold, tmpvar_9) / 4.0)
   + _FaceDilate) * _ScaleRatioA) * 0.5);
  underlayColor_4 = _UnderlayColor;
  underlayColor_4.xyz = (underlayColor_4.xyz * underlayColor_4.w);
  bScale_3 = (scale_6 / (1.0 + (
    (_UnderlaySoftness * _ScaleRatioC)
   * scale_6)));
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((-(
    (_UnderlayOffsetX * _ScaleRatioC)
  ) * _GradientScale) / _TextureWidth);
  tmpvar_15.y = ((-(
    (_UnderlayOffsetY * _ScaleRatioC)
  ) * _GradientScale) / _TextureHeight);
  highp vec4 tmpvar_16;
  tmpvar_16 = clamp (_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10), vec4(2e+10, 2e+10, 2e+10, 2e+10));
  highp vec2 tmpvar_17;
  highp vec2 xlat_varoutput_18;
  xlat_varoutput_18.x = floor((_glesMultiTexCoord1.x / 4096.0));
  xlat_varoutput_18.y = (_glesMultiTexCoord1.x - (4096.0 * xlat_varoutput_18.x));
  tmpvar_17 = (xlat_varoutput_18 * 0.001953125);
  highp vec4 tmpvar_19;
  tmpvar_19.x = (((
    min (((1.0 - (_OutlineWidth * _ScaleRatioA)) - (_OutlineSoftness * _ScaleRatioA)), ((1.0 - (_GlowOffset * _ScaleRatioB)) - (_GlowOuter * _ScaleRatioB)))
   / 2.0) - (0.5 / scale_6)) - weight_5);
  tmpvar_19.y = scale_6;
  tmpvar_19.z = ((0.5 - weight_5) + (0.5 / scale_6));
  tmpvar_19.w = weight_5;
  highp vec2 tmpvar_20;
  tmpvar_20.x = _MaskSoftnessX;
  tmpvar_20.y = _MaskSoftnessY;
  highp vec4 tmpvar_21;
  tmpvar_21.xy = (((vert_8.xy * 2.0) - tmpvar_16.xy) - tmpvar_16.zw);
  tmpvar_21.zw = (0.25 / ((0.25 * tmpvar_20) + pixelSize_7));
  highp mat3 tmpvar_22;
  tmpvar_22[0] = _EnvMatrix[0].xyz;
  tmpvar_22[1] = _EnvMatrix[1].xyz;
  tmpvar_22[2] = _EnvMatrix[2].xyz;
  highp vec4 tmpvar_23;
  tmpvar_23.xy = (_glesMultiTexCoord0.xy + tmpvar_15);
  tmpvar_23.z = bScale_3;
  tmpvar_23.w = (((
    (0.5 - weight_5)
   * bScale_3) - 0.5) - ((_UnderlayDilate * _ScaleRatioC) * (0.5 * bScale_3)));
  highp vec4 tmpvar_24;
  tmpvar_24.xy = ((tmpvar_17 * _FaceTex_ST.xy) + _FaceTex_ST.zw);
  tmpvar_24.zw = ((tmpvar_17 * _OutlineTex_ST.xy) + _OutlineTex_ST.zw);
  lowp vec4 tmpvar_25;
  tmpvar_25 = underlayColor_4;
  gl_Position = tmpvar_10;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_19;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = (tmpvar_22 * (_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_8).xyz));
  xlv_TEXCOORD4 = tmpvar_23;
  xlv_COLOR1 = tmpvar_25;
  xlv_TEXCOORD5 = tmpvar_24;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _FaceTex;
uniform highp float _FaceUVSpeedX;
uniform highp float _FaceUVSpeedY;
uniform lowp vec4 _FaceColor;
uniform highp float _OutlineSoftness;
uniform sampler2D _OutlineTex;
uniform highp float _OutlineUVSpeedX;
uniform highp float _OutlineUVSpeedY;
uniform lowp vec4 _OutlineColor;
uniform highp float _OutlineWidth;
uniform highp float _Bevel;
uniform highp float _BevelOffset;
uniform highp float _BevelWidth;
uniform highp float _BevelClamp;
uniform highp float _BevelRoundness;
uniform sampler2D _BumpMap;
uniform highp float _BumpOutline;
uniform highp float _BumpFace;
uniform lowp samplerCube _Cube;
uniform lowp vec4 _ReflectFaceColor;
uniform lowp vec4 _ReflectOutlineColor;
uniform lowp vec4 _SpecularColor;
uniform highp float _LightAngle;
uniform highp float _SpecularPower;
uniform highp float _Reflectivity;
uniform highp float _Diffuse;
uniform highp float _Ambient;
uniform lowp vec4 _GlowColor;
uniform highp float _GlowOffset;
uniform highp float _GlowOuter;
uniform highp float _GlowInner;
uniform highp float _GlowPower;
uniform highp float _ShaderFlags;
uniform highp float _ScaleRatioA;
uniform highp float _ScaleRatioB;
uniform sampler2D _MainTex;
uniform highp float _TextureWidth;
uniform highp float _TextureHeight;
uniform highp float _GradientScale;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 bump_2;
  mediump vec4 outlineColor_3;
  mediump vec4 faceColor_4;
  highp float c_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  c_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD1.z - c_5) * xlv_TEXCOORD1.y);
  highp float tmpvar_8;
  tmpvar_8 = ((_OutlineWidth * _ScaleRatioA) * xlv_TEXCOORD1.y);
  highp float tmpvar_9;
  tmpvar_9 = ((_OutlineSoftness * _ScaleRatioA) * xlv_TEXCOORD1.y);
  faceColor_4 = _FaceColor;
  outlineColor_3 = _OutlineColor;
  faceColor_4.xyz = (faceColor_4.xyz * xlv_COLOR.xyz);
  highp vec2 tmpvar_10;
  tmpvar_10.x = _FaceUVSpeedX;
  tmpvar_10.y = _FaceUVSpeedY;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD5.xy + (tmpvar_10 * _Time.y));
  tmpvar_11 = texture2D (_FaceTex, P_12);
  faceColor_4 = (faceColor_4 * tmpvar_11);
  highp vec2 tmpvar_13;
  tmpvar_13.x = _OutlineUVSpeedX;
  tmpvar_13.y = _OutlineUVSpeedY;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD5.zw + (tmpvar_13 * _Time.y));
  tmpvar_14 = texture2D (_OutlineTex, P_15);
  outlineColor_3 = (outlineColor_3 * tmpvar_14);
  mediump float d_16;
  d_16 = tmpvar_7;
  lowp vec4 faceColor_17;
  faceColor_17 = faceColor_4;
  lowp vec4 outlineColor_18;
  outlineColor_18 = outlineColor_3;
  mediump float outline_19;
  outline_19 = tmpvar_8;
  mediump float softness_20;
  softness_20 = tmpvar_9;
  mediump float tmpvar_21;
  tmpvar_21 = (1.0 - clamp ((
    ((d_16 - (outline_19 * 0.5)) + (softness_20 * 0.5))
   / 
    (1.0 + softness_20)
  ), 0.0, 1.0));
  faceColor_17.xyz = (faceColor_17.xyz * faceColor_17.w);
  outlineColor_18.xyz = (outlineColor_18.xyz * outlineColor_18.w);
  mediump vec4 tmpvar_22;
  tmpvar_22 = mix (faceColor_17, outlineColor_18, vec4((clamp (
    (d_16 + (outline_19 * 0.5))
  , 0.0, 1.0) * sqrt(
    min (1.0, outline_19)
  ))));
  faceColor_17 = tmpvar_22;
  faceColor_17 = (faceColor_17 * tmpvar_21);
  faceColor_4 = faceColor_17;
  highp vec3 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.x = (0.5 / _TextureWidth);
  tmpvar_23.y = (0.5 / _TextureHeight);
  highp vec4 h_24;
  highp vec2 P_25;
  P_25 = (xlv_TEXCOORD0 - tmpvar_23.xz);
  highp vec2 P_26;
  P_26 = (xlv_TEXCOORD0 + tmpvar_23.xz);
  highp vec2 P_27;
  P_27 = (xlv_TEXCOORD0 - tmpvar_23.zy);
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_23.zy);
  lowp vec4 tmpvar_29;
  tmpvar_29.x = texture2D (_MainTex, P_25).w;
  tmpvar_29.y = texture2D (_MainTex, P_26).w;
  tmpvar_29.z = texture2D (_MainTex, P_27).w;
  tmpvar_29.w = texture2D (_MainTex, P_28).w;
  h_24 = tmpvar_29;
  highp vec4 h_30;
  h_30 = h_24;
  highp float tmpvar_31;
  tmpvar_31 = (_ShaderFlags / 2.0);
  highp float tmpvar_32;
  tmpvar_32 = (fract(abs(tmpvar_31)) * 2.0);
  highp float tmpvar_33;
  if ((tmpvar_31 >= 0.0)) {
    tmpvar_33 = tmpvar_32;
  } else {
    tmpvar_33 = -(tmpvar_32);
  };
  h_30 = (h_24 + (xlv_TEXCOORD1.w + _BevelOffset));
  highp float tmpvar_34;
  tmpvar_34 = max (0.01, (_OutlineWidth + _BevelWidth));
  h_30 = (h_30 - 0.5);
  h_30 = (h_30 / tmpvar_34);
  highp vec4 tmpvar_35;
  tmpvar_35 = clamp ((h_30 + 0.5), 0.0, 1.0);
  h_30 = tmpvar_35;
  if (bool(float((tmpvar_33 >= 1.0)))) {
    h_30 = (1.0 - abs((
      (tmpvar_35 * 2.0)
     - 1.0)));
  };
  h_30 = (min (mix (h_30, 
    sin(((h_30 * 3.141592) / 2.0))
  , vec4(_BevelRoundness)), vec4((1.0 - _BevelClamp))) * ((_Bevel * tmpvar_34) * (_GradientScale * -2.0)));
  highp vec3 tmpvar_36;
  tmpvar_36.xy = vec2(1.0, 0.0);
  tmpvar_36.z = (h_30.y - h_30.x);
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(tmpvar_36);
  highp vec3 tmpvar_38;
  tmpvar_38.xy = vec2(0.0, -1.0);
  tmpvar_38.z = (h_30.w - h_30.z);
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(tmpvar_38);
  highp vec2 tmpvar_40;
  tmpvar_40.x = _FaceUVSpeedX;
  tmpvar_40.y = _FaceUVSpeedY;
  highp vec2 P_41;
  P_41 = (xlv_TEXCOORD5.xy + (tmpvar_40 * _Time.y));
  lowp vec3 tmpvar_42;
  tmpvar_42 = ((texture2D (_BumpMap, P_41).xyz * 2.0) - 1.0);
  bump_2 = tmpvar_42;
  bump_2 = (bump_2 * mix (_BumpFace, _BumpOutline, clamp (
    (tmpvar_7 + (tmpvar_8 * 0.5))
  , 0.0, 1.0)));
  highp vec3 tmpvar_43;
  tmpvar_43 = normalize(((
    (tmpvar_37.yzx * tmpvar_39.zxy)
   - 
    (tmpvar_37.zxy * tmpvar_39.yzx)
  ) - bump_2));
  highp vec3 tmpvar_44;
  tmpvar_44.z = -1.0;
  tmpvar_44.x = sin(_LightAngle);
  tmpvar_44.y = cos(_LightAngle);
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize(tmpvar_44);
  highp vec3 tmpvar_46;
  tmpvar_46 = ((_SpecularColor.xyz * pow (
    max (0.0, dot (tmpvar_43, tmpvar_45))
  , _Reflectivity)) * _SpecularPower);
  faceColor_4.xyz = (faceColor_4.xyz + (tmpvar_46 * faceColor_4.w));
  highp float tmpvar_47;
  tmpvar_47 = dot (tmpvar_43, tmpvar_45);
  faceColor_4.xyz = (faceColor_4.xyz * (1.0 - (tmpvar_47 * _Diffuse)));
  highp float tmpvar_48;
  tmpvar_48 = mix (_Ambient, 1.0, (tmpvar_43.z * tmpvar_43.z));
  faceColor_4.xyz = (faceColor_4.xyz * tmpvar_48);
  highp vec3 tmpvar_49;
  highp vec3 N_50;
  N_50 = -(tmpvar_43);
  tmpvar_49 = (xlv_TEXCOORD3 - (2.0 * (
    dot (N_50, xlv_TEXCOORD3)
   * N_50)));
  lowp vec4 tmpvar_51;
  tmpvar_51 = textureCube (_Cube, tmpvar_49);
  highp float tmpvar_52;
  tmpvar_52 = clamp ((tmpvar_7 + (tmpvar_8 * 0.5)), 0.0, 1.0);
  lowp vec3 tmpvar_53;
  tmpvar_53 = mix (_ReflectFaceColor.xyz, _ReflectOutlineColor.xyz, vec3(tmpvar_52));
  faceColor_4.xyz = (faceColor_4.xyz + ((tmpvar_51.xyz * tmpvar_53) * faceColor_4.w));
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_MainTex, xlv_TEXCOORD4.xy);
  highp float tmpvar_55;
  tmpvar_55 = clamp (((tmpvar_54.w * xlv_TEXCOORD4.z) - xlv_TEXCOORD4.w), 0.0, 1.0);
  faceColor_4 = (faceColor_4 + ((xlv_COLOR1 * tmpvar_55) * (1.0 - faceColor_4.w)));
  highp vec4 tmpvar_56;
  highp float glow_57;
  highp float tmpvar_58;
  tmpvar_58 = (tmpvar_7 - ((_GlowOffset * _ScaleRatioB) * (0.5 * xlv_TEXCOORD1.y)));
  highp float tmpvar_59;
  tmpvar_59 = ((mix (_GlowInner, 
    (_GlowOuter * _ScaleRatioB)
  , 
    float((tmpvar_58 >= 0.0))
  ) * 0.5) * xlv_TEXCOORD1.y);
  glow_57 = (1.0 - pow (clamp (
    abs((tmpvar_58 / (1.0 + tmpvar_59)))
  , 0.0, 1.0), _GlowPower));
  glow_57 = (glow_57 * sqrt(min (1.0, tmpvar_59)));
  highp float tmpvar_60;
  tmpvar_60 = clamp (((_GlowColor.w * glow_57) * 2.0), 0.0, 1.0);
  lowp vec4 tmpvar_61;
  tmpvar_61.xyz = _GlowColor.xyz;
  tmpvar_61.w = tmpvar_60;
  tmpvar_56 = tmpvar_61;
  faceColor_4.xyz = (faceColor_4.xyz + (tmpvar_56.xyz * tmpvar_56.w));
  mediump float x_62;
  x_62 = (faceColor_4.w - 0.001);
  if ((x_62 < 0.0)) {
    discard;
  };
  tmpvar_1 = (faceColor_4 * xlv_COLOR.w);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixVP;
uniform highp float _FaceDilate;
uniform highp float _OutlineSoftness;
uniform highp float _OutlineWidth;
uniform highp mat4 _EnvMatrix;
uniform lowp vec4 _UnderlayColor;
uniform highp float _UnderlayOffsetX;
uniform highp float _UnderlayOffsetY;
uniform highp float _UnderlayDilate;
uniform highp float _UnderlaySoftness;
uniform highp float _GlowOffset;
uniform highp float _GlowOuter;
uniform highp float _WeightNormal;
uniform highp float _WeightBold;
uniform highp float _ScaleRatioA;
uniform highp float _ScaleRatioB;
uniform highp float _ScaleRatioC;
uniform highp float _VertexOffsetX;
uniform highp float _VertexOffsetY;
uniform highp vec4 _ClipRect;
uniform highp float _MaskSoftnessX;
uniform highp float _MaskSoftnessY;
uniform highp float _TextureWidth;
uniform highp float _TextureHeight;
uniform highp float _GradientScale;
uniform highp float _ScaleX;
uniform highp float _ScaleY;
uniform highp float _PerspectiveFilter;
uniform highp vec4 _FaceTex_ST;
uniform highp vec4 _OutlineTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp float bScale_3;
  highp vec4 underlayColor_4;
  highp float weight_5;
  highp float scale_6;
  highp vec2 pixelSize_7;
  highp vec4 vert_8;
  highp float tmpvar_9;
  tmpvar_9 = float((0.0 >= _glesMultiTexCoord1.y));
  vert_8.zw = _glesVertex.zw;
  vert_8.x = (_glesVertex.x + _VertexOffsetX);
  vert_8.y = (_glesVertex.y + _VertexOffsetY);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = vert_8.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec2 tmpvar_12;
  tmpvar_12.x = _ScaleX;
  tmpvar_12.y = _ScaleY;
  highp mat2 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_projection[0].xy;
  tmpvar_13[1] = glstate_matrix_projection[1].xy;
  pixelSize_7 = (tmpvar_10.ww / (tmpvar_12 * abs(
    (tmpvar_13 * _ScreenParams.xy)
  )));
  scale_6 = (inversesqrt(dot (pixelSize_7, pixelSize_7)) * ((
    abs(_glesMultiTexCoord1.y)
   * _GradientScale) * 1.5));
  if ((glstate_matrix_projection[3].w == 0.0)) {
    highp mat3 tmpvar_14;
    tmpvar_14[0] = unity_WorldToObject[0].xyz;
    tmpvar_14[1] = unity_WorldToObject[1].xyz;
    tmpvar_14[2] = unity_WorldToObject[2].xyz;
    scale_6 = mix ((abs(scale_6) * (1.0 - _PerspectiveFilter)), scale_6, abs(dot (
      normalize((_glesNormal * tmpvar_14))
    , 
      normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_8).xyz))
    )));
  };
  weight_5 = (((
    (mix (_WeightNormal, _WeightBold, tmpvar_9) / 4.0)
   + _FaceDilate) * _ScaleRatioA) * 0.5);
  underlayColor_4 = _UnderlayColor;
  underlayColor_4.xyz = (underlayColor_4.xyz * underlayColor_4.w);
  bScale_3 = (scale_6 / (1.0 + (
    (_UnderlaySoftness * _ScaleRatioC)
   * scale_6)));
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((-(
    (_UnderlayOffsetX * _ScaleRatioC)
  ) * _GradientScale) / _TextureWidth);
  tmpvar_15.y = ((-(
    (_UnderlayOffsetY * _ScaleRatioC)
  ) * _GradientScale) / _TextureHeight);
  highp vec4 tmpvar_16;
  tmpvar_16 = clamp (_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10), vec4(2e+10, 2e+10, 2e+10, 2e+10));
  highp vec2 tmpvar_17;
  highp vec2 xlat_varoutput_18;
  xlat_varoutput_18.x = floor((_glesMultiTexCoord1.x / 4096.0));
  xlat_varoutput_18.y = (_glesMultiTexCoord1.x - (4096.0 * xlat_varoutput_18.x));
  tmpvar_17 = (xlat_varoutput_18 * 0.001953125);
  highp vec4 tmpvar_19;
  tmpvar_19.x = (((
    min (((1.0 - (_OutlineWidth * _ScaleRatioA)) - (_OutlineSoftness * _ScaleRatioA)), ((1.0 - (_GlowOffset * _ScaleRatioB)) - (_GlowOuter * _ScaleRatioB)))
   / 2.0) - (0.5 / scale_6)) - weight_5);
  tmpvar_19.y = scale_6;
  tmpvar_19.z = ((0.5 - weight_5) + (0.5 / scale_6));
  tmpvar_19.w = weight_5;
  highp vec2 tmpvar_20;
  tmpvar_20.x = _MaskSoftnessX;
  tmpvar_20.y = _MaskSoftnessY;
  highp vec4 tmpvar_21;
  tmpvar_21.xy = (((vert_8.xy * 2.0) - tmpvar_16.xy) - tmpvar_16.zw);
  tmpvar_21.zw = (0.25 / ((0.25 * tmpvar_20) + pixelSize_7));
  highp mat3 tmpvar_22;
  tmpvar_22[0] = _EnvMatrix[0].xyz;
  tmpvar_22[1] = _EnvMatrix[1].xyz;
  tmpvar_22[2] = _EnvMatrix[2].xyz;
  highp vec4 tmpvar_23;
  tmpvar_23.xy = (_glesMultiTexCoord0.xy + tmpvar_15);
  tmpvar_23.z = bScale_3;
  tmpvar_23.w = (((
    (0.5 - weight_5)
   * bScale_3) - 0.5) - ((_UnderlayDilate * _ScaleRatioC) * (0.5 * bScale_3)));
  highp vec4 tmpvar_24;
  tmpvar_24.xy = ((tmpvar_17 * _FaceTex_ST.xy) + _FaceTex_ST.zw);
  tmpvar_24.zw = ((tmpvar_17 * _OutlineTex_ST.xy) + _OutlineTex_ST.zw);
  lowp vec4 tmpvar_25;
  tmpvar_25 = underlayColor_4;
  gl_Position = tmpvar_10;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_19;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = (tmpvar_22 * (_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_8).xyz));
  xlv_TEXCOORD4 = tmpvar_23;
  xlv_COLOR1 = tmpvar_25;
  xlv_TEXCOORD5 = tmpvar_24;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _FaceTex;
uniform highp float _FaceUVSpeedX;
uniform highp float _FaceUVSpeedY;
uniform lowp vec4 _FaceColor;
uniform highp float _OutlineSoftness;
uniform sampler2D _OutlineTex;
uniform highp float _OutlineUVSpeedX;
uniform highp float _OutlineUVSpeedY;
uniform lowp vec4 _OutlineColor;
uniform highp float _OutlineWidth;
uniform highp float _Bevel;
uniform highp float _BevelOffset;
uniform highp float _BevelWidth;
uniform highp float _BevelClamp;
uniform highp float _BevelRoundness;
uniform sampler2D _BumpMap;
uniform highp float _BumpOutline;
uniform highp float _BumpFace;
uniform lowp samplerCube _Cube;
uniform lowp vec4 _ReflectFaceColor;
uniform lowp vec4 _ReflectOutlineColor;
uniform lowp vec4 _SpecularColor;
uniform highp float _LightAngle;
uniform highp float _SpecularPower;
uniform highp float _Reflectivity;
uniform highp float _Diffuse;
uniform highp float _Ambient;
uniform lowp vec4 _GlowColor;
uniform highp float _GlowOffset;
uniform highp float _GlowOuter;
uniform highp float _GlowInner;
uniform highp float _GlowPower;
uniform highp float _ShaderFlags;
uniform highp float _ScaleRatioA;
uniform highp float _ScaleRatioB;
uniform sampler2D _MainTex;
uniform highp float _TextureWidth;
uniform highp float _TextureHeight;
uniform highp float _GradientScale;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 bump_2;
  mediump vec4 outlineColor_3;
  mediump vec4 faceColor_4;
  highp float c_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  c_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD1.z - c_5) * xlv_TEXCOORD1.y);
  highp float tmpvar_8;
  tmpvar_8 = ((_OutlineWidth * _ScaleRatioA) * xlv_TEXCOORD1.y);
  highp float tmpvar_9;
  tmpvar_9 = ((_OutlineSoftness * _ScaleRatioA) * xlv_TEXCOORD1.y);
  faceColor_4 = _FaceColor;
  outlineColor_3 = _OutlineColor;
  faceColor_4.xyz = (faceColor_4.xyz * xlv_COLOR.xyz);
  highp vec2 tmpvar_10;
  tmpvar_10.x = _FaceUVSpeedX;
  tmpvar_10.y = _FaceUVSpeedY;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD5.xy + (tmpvar_10 * _Time.y));
  tmpvar_11 = texture2D (_FaceTex, P_12);
  faceColor_4 = (faceColor_4 * tmpvar_11);
  highp vec2 tmpvar_13;
  tmpvar_13.x = _OutlineUVSpeedX;
  tmpvar_13.y = _OutlineUVSpeedY;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD5.zw + (tmpvar_13 * _Time.y));
  tmpvar_14 = texture2D (_OutlineTex, P_15);
  outlineColor_3 = (outlineColor_3 * tmpvar_14);
  mediump float d_16;
  d_16 = tmpvar_7;
  lowp vec4 faceColor_17;
  faceColor_17 = faceColor_4;
  lowp vec4 outlineColor_18;
  outlineColor_18 = outlineColor_3;
  mediump float outline_19;
  outline_19 = tmpvar_8;
  mediump float softness_20;
  softness_20 = tmpvar_9;
  mediump float tmpvar_21;
  tmpvar_21 = (1.0 - clamp ((
    ((d_16 - (outline_19 * 0.5)) + (softness_20 * 0.5))
   / 
    (1.0 + softness_20)
  ), 0.0, 1.0));
  faceColor_17.xyz = (faceColor_17.xyz * faceColor_17.w);
  outlineColor_18.xyz = (outlineColor_18.xyz * outlineColor_18.w);
  mediump vec4 tmpvar_22;
  tmpvar_22 = mix (faceColor_17, outlineColor_18, vec4((clamp (
    (d_16 + (outline_19 * 0.5))
  , 0.0, 1.0) * sqrt(
    min (1.0, outline_19)
  ))));
  faceColor_17 = tmpvar_22;
  faceColor_17 = (faceColor_17 * tmpvar_21);
  faceColor_4 = faceColor_17;
  highp vec3 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.x = (0.5 / _TextureWidth);
  tmpvar_23.y = (0.5 / _TextureHeight);
  highp vec4 h_24;
  highp vec2 P_25;
  P_25 = (xlv_TEXCOORD0 - tmpvar_23.xz);
  highp vec2 P_26;
  P_26 = (xlv_TEXCOORD0 + tmpvar_23.xz);
  highp vec2 P_27;
  P_27 = (xlv_TEXCOORD0 - tmpvar_23.zy);
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_23.zy);
  lowp vec4 tmpvar_29;
  tmpvar_29.x = texture2D (_MainTex, P_25).w;
  tmpvar_29.y = texture2D (_MainTex, P_26).w;
  tmpvar_29.z = texture2D (_MainTex, P_27).w;
  tmpvar_29.w = texture2D (_MainTex, P_28).w;
  h_24 = tmpvar_29;
  highp vec4 h_30;
  h_30 = h_24;
  highp float tmpvar_31;
  tmpvar_31 = (_ShaderFlags / 2.0);
  highp float tmpvar_32;
  tmpvar_32 = (fract(abs(tmpvar_31)) * 2.0);
  highp float tmpvar_33;
  if ((tmpvar_31 >= 0.0)) {
    tmpvar_33 = tmpvar_32;
  } else {
    tmpvar_33 = -(tmpvar_32);
  };
  h_30 = (h_24 + (xlv_TEXCOORD1.w + _BevelOffset));
  highp float tmpvar_34;
  tmpvar_34 = max (0.01, (_OutlineWidth + _BevelWidth));
  h_30 = (h_30 - 0.5);
  h_30 = (h_30 / tmpvar_34);
  highp vec4 tmpvar_35;
  tmpvar_35 = clamp ((h_30 + 0.5), 0.0, 1.0);
  h_30 = tmpvar_35;
  if (bool(float((tmpvar_33 >= 1.0)))) {
    h_30 = (1.0 - abs((
      (tmpvar_35 * 2.0)
     - 1.0)));
  };
  h_30 = (min (mix (h_30, 
    sin(((h_30 * 3.141592) / 2.0))
  , vec4(_BevelRoundness)), vec4((1.0 - _BevelClamp))) * ((_Bevel * tmpvar_34) * (_GradientScale * -2.0)));
  highp vec3 tmpvar_36;
  tmpvar_36.xy = vec2(1.0, 0.0);
  tmpvar_36.z = (h_30.y - h_30.x);
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(tmpvar_36);
  highp vec3 tmpvar_38;
  tmpvar_38.xy = vec2(0.0, -1.0);
  tmpvar_38.z = (h_30.w - h_30.z);
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(tmpvar_38);
  highp vec2 tmpvar_40;
  tmpvar_40.x = _FaceUVSpeedX;
  tmpvar_40.y = _FaceUVSpeedY;
  highp vec2 P_41;
  P_41 = (xlv_TEXCOORD5.xy + (tmpvar_40 * _Time.y));
  lowp vec3 tmpvar_42;
  tmpvar_42 = ((texture2D (_BumpMap, P_41).xyz * 2.0) - 1.0);
  bump_2 = tmpvar_42;
  bump_2 = (bump_2 * mix (_BumpFace, _BumpOutline, clamp (
    (tmpvar_7 + (tmpvar_8 * 0.5))
  , 0.0, 1.0)));
  highp vec3 tmpvar_43;
  tmpvar_43 = normalize(((
    (tmpvar_37.yzx * tmpvar_39.zxy)
   - 
    (tmpvar_37.zxy * tmpvar_39.yzx)
  ) - bump_2));
  highp vec3 tmpvar_44;
  tmpvar_44.z = -1.0;
  tmpvar_44.x = sin(_LightAngle);
  tmpvar_44.y = cos(_LightAngle);
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize(tmpvar_44);
  highp vec3 tmpvar_46;
  tmpvar_46 = ((_SpecularColor.xyz * pow (
    max (0.0, dot (tmpvar_43, tmpvar_45))
  , _Reflectivity)) * _SpecularPower);
  faceColor_4.xyz = (faceColor_4.xyz + (tmpvar_46 * faceColor_4.w));
  highp float tmpvar_47;
  tmpvar_47 = dot (tmpvar_43, tmpvar_45);
  faceColor_4.xyz = (faceColor_4.xyz * (1.0 - (tmpvar_47 * _Diffuse)));
  highp float tmpvar_48;
  tmpvar_48 = mix (_Ambient, 1.0, (tmpvar_43.z * tmpvar_43.z));
  faceColor_4.xyz = (faceColor_4.xyz * tmpvar_48);
  highp vec3 tmpvar_49;
  highp vec3 N_50;
  N_50 = -(tmpvar_43);
  tmpvar_49 = (xlv_TEXCOORD3 - (2.0 * (
    dot (N_50, xlv_TEXCOORD3)
   * N_50)));
  lowp vec4 tmpvar_51;
  tmpvar_51 = textureCube (_Cube, tmpvar_49);
  highp float tmpvar_52;
  tmpvar_52 = clamp ((tmpvar_7 + (tmpvar_8 * 0.5)), 0.0, 1.0);
  lowp vec3 tmpvar_53;
  tmpvar_53 = mix (_ReflectFaceColor.xyz, _ReflectOutlineColor.xyz, vec3(tmpvar_52));
  faceColor_4.xyz = (faceColor_4.xyz + ((tmpvar_51.xyz * tmpvar_53) * faceColor_4.w));
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_MainTex, xlv_TEXCOORD4.xy);
  highp float tmpvar_55;
  tmpvar_55 = clamp (((tmpvar_54.w * xlv_TEXCOORD4.z) - xlv_TEXCOORD4.w), 0.0, 1.0);
  faceColor_4 = (faceColor_4 + ((xlv_COLOR1 * tmpvar_55) * (1.0 - faceColor_4.w)));
  highp vec4 tmpvar_56;
  highp float glow_57;
  highp float tmpvar_58;
  tmpvar_58 = (tmpvar_7 - ((_GlowOffset * _ScaleRatioB) * (0.5 * xlv_TEXCOORD1.y)));
  highp float tmpvar_59;
  tmpvar_59 = ((mix (_GlowInner, 
    (_GlowOuter * _ScaleRatioB)
  , 
    float((tmpvar_58 >= 0.0))
  ) * 0.5) * xlv_TEXCOORD1.y);
  glow_57 = (1.0 - pow (clamp (
    abs((tmpvar_58 / (1.0 + tmpvar_59)))
  , 0.0, 1.0), _GlowPower));
  glow_57 = (glow_57 * sqrt(min (1.0, tmpvar_59)));
  highp float tmpvar_60;
  tmpvar_60 = clamp (((_GlowColor.w * glow_57) * 2.0), 0.0, 1.0);
  lowp vec4 tmpvar_61;
  tmpvar_61.xyz = _GlowColor.xyz;
  tmpvar_61.w = tmpvar_60;
  tmpvar_56 = tmpvar_61;
  faceColor_4.xyz = (faceColor_4.xyz + (tmpvar_56.xyz * tmpvar_56.w));
  mediump float x_62;
  x_62 = (faceColor_4.w - 0.001);
  if ((x_62 < 0.0)) {
    discard;
  };
  tmpvar_1 = (faceColor_4 * xlv_COLOR.w);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixVP;
uniform highp float _FaceDilate;
uniform highp float _OutlineSoftness;
uniform highp float _OutlineWidth;
uniform highp mat4 _EnvMatrix;
uniform lowp vec4 _UnderlayColor;
uniform highp float _UnderlayOffsetX;
uniform highp float _UnderlayOffsetY;
uniform highp float _UnderlayDilate;
uniform highp float _UnderlaySoftness;
uniform highp float _GlowOffset;
uniform highp float _GlowOuter;
uniform highp float _WeightNormal;
uniform highp float _WeightBold;
uniform highp float _ScaleRatioA;
uniform highp float _ScaleRatioB;
uniform highp float _ScaleRatioC;
uniform highp float _VertexOffsetX;
uniform highp float _VertexOffsetY;
uniform highp vec4 _ClipRect;
uniform highp float _MaskSoftnessX;
uniform highp float _MaskSoftnessY;
uniform highp float _TextureWidth;
uniform highp float _TextureHeight;
uniform highp float _GradientScale;
uniform highp float _ScaleX;
uniform highp float _ScaleY;
uniform highp float _PerspectiveFilter;
uniform highp vec4 _FaceTex_ST;
uniform highp vec4 _OutlineTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp float bScale_3;
  highp vec4 underlayColor_4;
  highp float weight_5;
  highp float scale_6;
  highp vec2 pixelSize_7;
  highp vec4 vert_8;
  highp float tmpvar_9;
  tmpvar_9 = float((0.0 >= _glesMultiTexCoord1.y));
  vert_8.zw = _glesVertex.zw;
  vert_8.x = (_glesVertex.x + _VertexOffsetX);
  vert_8.y = (_glesVertex.y + _VertexOffsetY);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = vert_8.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec2 tmpvar_12;
  tmpvar_12.x = _ScaleX;
  tmpvar_12.y = _ScaleY;
  highp mat2 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_projection[0].xy;
  tmpvar_13[1] = glstate_matrix_projection[1].xy;
  pixelSize_7 = (tmpvar_10.ww / (tmpvar_12 * abs(
    (tmpvar_13 * _ScreenParams.xy)
  )));
  scale_6 = (inversesqrt(dot (pixelSize_7, pixelSize_7)) * ((
    abs(_glesMultiTexCoord1.y)
   * _GradientScale) * 1.5));
  if ((glstate_matrix_projection[3].w == 0.0)) {
    highp mat3 tmpvar_14;
    tmpvar_14[0] = unity_WorldToObject[0].xyz;
    tmpvar_14[1] = unity_WorldToObject[1].xyz;
    tmpvar_14[2] = unity_WorldToObject[2].xyz;
    scale_6 = mix ((abs(scale_6) * (1.0 - _PerspectiveFilter)), scale_6, abs(dot (
      normalize((_glesNormal * tmpvar_14))
    , 
      normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_8).xyz))
    )));
  };
  weight_5 = (((
    (mix (_WeightNormal, _WeightBold, tmpvar_9) / 4.0)
   + _FaceDilate) * _ScaleRatioA) * 0.5);
  underlayColor_4 = _UnderlayColor;
  underlayColor_4.xyz = (underlayColor_4.xyz * underlayColor_4.w);
  bScale_3 = (scale_6 / (1.0 + (
    (_UnderlaySoftness * _ScaleRatioC)
   * scale_6)));
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((-(
    (_UnderlayOffsetX * _ScaleRatioC)
  ) * _GradientScale) / _TextureWidth);
  tmpvar_15.y = ((-(
    (_UnderlayOffsetY * _ScaleRatioC)
  ) * _GradientScale) / _TextureHeight);
  highp vec4 tmpvar_16;
  tmpvar_16 = clamp (_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10), vec4(2e+10, 2e+10, 2e+10, 2e+10));
  highp vec2 tmpvar_17;
  highp vec2 xlat_varoutput_18;
  xlat_varoutput_18.x = floor((_glesMultiTexCoord1.x / 4096.0));
  xlat_varoutput_18.y = (_glesMultiTexCoord1.x - (4096.0 * xlat_varoutput_18.x));
  tmpvar_17 = (xlat_varoutput_18 * 0.001953125);
  highp vec4 tmpvar_19;
  tmpvar_19.x = (((
    min (((1.0 - (_OutlineWidth * _ScaleRatioA)) - (_OutlineSoftness * _ScaleRatioA)), ((1.0 - (_GlowOffset * _ScaleRatioB)) - (_GlowOuter * _ScaleRatioB)))
   / 2.0) - (0.5 / scale_6)) - weight_5);
  tmpvar_19.y = scale_6;
  tmpvar_19.z = ((0.5 - weight_5) + (0.5 / scale_6));
  tmpvar_19.w = weight_5;
  highp vec2 tmpvar_20;
  tmpvar_20.x = _MaskSoftnessX;
  tmpvar_20.y = _MaskSoftnessY;
  highp vec4 tmpvar_21;
  tmpvar_21.xy = (((vert_8.xy * 2.0) - tmpvar_16.xy) - tmpvar_16.zw);
  tmpvar_21.zw = (0.25 / ((0.25 * tmpvar_20) + pixelSize_7));
  highp mat3 tmpvar_22;
  tmpvar_22[0] = _EnvMatrix[0].xyz;
  tmpvar_22[1] = _EnvMatrix[1].xyz;
  tmpvar_22[2] = _EnvMatrix[2].xyz;
  highp vec4 tmpvar_23;
  tmpvar_23.xy = (_glesMultiTexCoord0.xy + tmpvar_15);
  tmpvar_23.z = bScale_3;
  tmpvar_23.w = (((
    (0.5 - weight_5)
   * bScale_3) - 0.5) - ((_UnderlayDilate * _ScaleRatioC) * (0.5 * bScale_3)));
  highp vec4 tmpvar_24;
  tmpvar_24.xy = ((tmpvar_17 * _FaceTex_ST.xy) + _FaceTex_ST.zw);
  tmpvar_24.zw = ((tmpvar_17 * _OutlineTex_ST.xy) + _OutlineTex_ST.zw);
  lowp vec4 tmpvar_25;
  tmpvar_25 = underlayColor_4;
  gl_Position = tmpvar_10;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_19;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = (tmpvar_22 * (_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_8).xyz));
  xlv_TEXCOORD4 = tmpvar_23;
  xlv_COLOR1 = tmpvar_25;
  xlv_TEXCOORD5 = tmpvar_24;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _FaceTex;
uniform highp float _FaceUVSpeedX;
uniform highp float _FaceUVSpeedY;
uniform lowp vec4 _FaceColor;
uniform highp float _OutlineSoftness;
uniform sampler2D _OutlineTex;
uniform highp float _OutlineUVSpeedX;
uniform highp float _OutlineUVSpeedY;
uniform lowp vec4 _OutlineColor;
uniform highp float _OutlineWidth;
uniform highp float _Bevel;
uniform highp float _BevelOffset;
uniform highp float _BevelWidth;
uniform highp float _BevelClamp;
uniform highp float _BevelRoundness;
uniform sampler2D _BumpMap;
uniform highp float _BumpOutline;
uniform highp float _BumpFace;
uniform lowp samplerCube _Cube;
uniform lowp vec4 _ReflectFaceColor;
uniform lowp vec4 _ReflectOutlineColor;
uniform lowp vec4 _SpecularColor;
uniform highp float _LightAngle;
uniform highp float _SpecularPower;
uniform highp float _Reflectivity;
uniform highp float _Diffuse;
uniform highp float _Ambient;
uniform lowp vec4 _GlowColor;
uniform highp float _GlowOffset;
uniform highp float _GlowOuter;
uniform highp float _GlowInner;
uniform highp float _GlowPower;
uniform highp float _ShaderFlags;
uniform highp float _ScaleRatioA;
uniform highp float _ScaleRatioB;
uniform sampler2D _MainTex;
uniform highp float _TextureWidth;
uniform highp float _TextureHeight;
uniform highp float _GradientScale;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 bump_2;
  mediump vec4 outlineColor_3;
  mediump vec4 faceColor_4;
  highp float c_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  c_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD1.z - c_5) * xlv_TEXCOORD1.y);
  highp float tmpvar_8;
  tmpvar_8 = ((_OutlineWidth * _ScaleRatioA) * xlv_TEXCOORD1.y);
  highp float tmpvar_9;
  tmpvar_9 = ((_OutlineSoftness * _ScaleRatioA) * xlv_TEXCOORD1.y);
  faceColor_4 = _FaceColor;
  outlineColor_3 = _OutlineColor;
  faceColor_4.xyz = (faceColor_4.xyz * xlv_COLOR.xyz);
  highp vec2 tmpvar_10;
  tmpvar_10.x = _FaceUVSpeedX;
  tmpvar_10.y = _FaceUVSpeedY;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD5.xy + (tmpvar_10 * _Time.y));
  tmpvar_11 = texture2D (_FaceTex, P_12);
  faceColor_4 = (faceColor_4 * tmpvar_11);
  highp vec2 tmpvar_13;
  tmpvar_13.x = _OutlineUVSpeedX;
  tmpvar_13.y = _OutlineUVSpeedY;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD5.zw + (tmpvar_13 * _Time.y));
  tmpvar_14 = texture2D (_OutlineTex, P_15);
  outlineColor_3 = (outlineColor_3 * tmpvar_14);
  mediump float d_16;
  d_16 = tmpvar_7;
  lowp vec4 faceColor_17;
  faceColor_17 = faceColor_4;
  lowp vec4 outlineColor_18;
  outlineColor_18 = outlineColor_3;
  mediump float outline_19;
  outline_19 = tmpvar_8;
  mediump float softness_20;
  softness_20 = tmpvar_9;
  mediump float tmpvar_21;
  tmpvar_21 = (1.0 - clamp ((
    ((d_16 - (outline_19 * 0.5)) + (softness_20 * 0.5))
   / 
    (1.0 + softness_20)
  ), 0.0, 1.0));
  faceColor_17.xyz = (faceColor_17.xyz * faceColor_17.w);
  outlineColor_18.xyz = (outlineColor_18.xyz * outlineColor_18.w);
  mediump vec4 tmpvar_22;
  tmpvar_22 = mix (faceColor_17, outlineColor_18, vec4((clamp (
    (d_16 + (outline_19 * 0.5))
  , 0.0, 1.0) * sqrt(
    min (1.0, outline_19)
  ))));
  faceColor_17 = tmpvar_22;
  faceColor_17 = (faceColor_17 * tmpvar_21);
  faceColor_4 = faceColor_17;
  highp vec3 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.x = (0.5 / _TextureWidth);
  tmpvar_23.y = (0.5 / _TextureHeight);
  highp vec4 h_24;
  highp vec2 P_25;
  P_25 = (xlv_TEXCOORD0 - tmpvar_23.xz);
  highp vec2 P_26;
  P_26 = (xlv_TEXCOORD0 + tmpvar_23.xz);
  highp vec2 P_27;
  P_27 = (xlv_TEXCOORD0 - tmpvar_23.zy);
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_23.zy);
  lowp vec4 tmpvar_29;
  tmpvar_29.x = texture2D (_MainTex, P_25).w;
  tmpvar_29.y = texture2D (_MainTex, P_26).w;
  tmpvar_29.z = texture2D (_MainTex, P_27).w;
  tmpvar_29.w = texture2D (_MainTex, P_28).w;
  h_24 = tmpvar_29;
  highp vec4 h_30;
  h_30 = h_24;
  highp float tmpvar_31;
  tmpvar_31 = (_ShaderFlags / 2.0);
  highp float tmpvar_32;
  tmpvar_32 = (fract(abs(tmpvar_31)) * 2.0);
  highp float tmpvar_33;
  if ((tmpvar_31 >= 0.0)) {
    tmpvar_33 = tmpvar_32;
  } else {
    tmpvar_33 = -(tmpvar_32);
  };
  h_30 = (h_24 + (xlv_TEXCOORD1.w + _BevelOffset));
  highp float tmpvar_34;
  tmpvar_34 = max (0.01, (_OutlineWidth + _BevelWidth));
  h_30 = (h_30 - 0.5);
  h_30 = (h_30 / tmpvar_34);
  highp vec4 tmpvar_35;
  tmpvar_35 = clamp ((h_30 + 0.5), 0.0, 1.0);
  h_30 = tmpvar_35;
  if (bool(float((tmpvar_33 >= 1.0)))) {
    h_30 = (1.0 - abs((
      (tmpvar_35 * 2.0)
     - 1.0)));
  };
  h_30 = (min (mix (h_30, 
    sin(((h_30 * 3.141592) / 2.0))
  , vec4(_BevelRoundness)), vec4((1.0 - _BevelClamp))) * ((_Bevel * tmpvar_34) * (_GradientScale * -2.0)));
  highp vec3 tmpvar_36;
  tmpvar_36.xy = vec2(1.0, 0.0);
  tmpvar_36.z = (h_30.y - h_30.x);
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(tmpvar_36);
  highp vec3 tmpvar_38;
  tmpvar_38.xy = vec2(0.0, -1.0);
  tmpvar_38.z = (h_30.w - h_30.z);
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(tmpvar_38);
  highp vec2 tmpvar_40;
  tmpvar_40.x = _FaceUVSpeedX;
  tmpvar_40.y = _FaceUVSpeedY;
  highp vec2 P_41;
  P_41 = (xlv_TEXCOORD5.xy + (tmpvar_40 * _Time.y));
  lowp vec3 tmpvar_42;
  tmpvar_42 = ((texture2D (_BumpMap, P_41).xyz * 2.0) - 1.0);
  bump_2 = tmpvar_42;
  bump_2 = (bump_2 * mix (_BumpFace, _BumpOutline, clamp (
    (tmpvar_7 + (tmpvar_8 * 0.5))
  , 0.0, 1.0)));
  highp vec3 tmpvar_43;
  tmpvar_43 = normalize(((
    (tmpvar_37.yzx * tmpvar_39.zxy)
   - 
    (tmpvar_37.zxy * tmpvar_39.yzx)
  ) - bump_2));
  highp vec3 tmpvar_44;
  tmpvar_44.z = -1.0;
  tmpvar_44.x = sin(_LightAngle);
  tmpvar_44.y = cos(_LightAngle);
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize(tmpvar_44);
  highp vec3 tmpvar_46;
  tmpvar_46 = ((_SpecularColor.xyz * pow (
    max (0.0, dot (tmpvar_43, tmpvar_45))
  , _Reflectivity)) * _SpecularPower);
  faceColor_4.xyz = (faceColor_4.xyz + (tmpvar_46 * faceColor_4.w));
  highp float tmpvar_47;
  tmpvar_47 = dot (tmpvar_43, tmpvar_45);
  faceColor_4.xyz = (faceColor_4.xyz * (1.0 - (tmpvar_47 * _Diffuse)));
  highp float tmpvar_48;
  tmpvar_48 = mix (_Ambient, 1.0, (tmpvar_43.z * tmpvar_43.z));
  faceColor_4.xyz = (faceColor_4.xyz * tmpvar_48);
  highp vec3 tmpvar_49;
  highp vec3 N_50;
  N_50 = -(tmpvar_43);
  tmpvar_49 = (xlv_TEXCOORD3 - (2.0 * (
    dot (N_50, xlv_TEXCOORD3)
   * N_50)));
  lowp vec4 tmpvar_51;
  tmpvar_51 = textureCube (_Cube, tmpvar_49);
  highp float tmpvar_52;
  tmpvar_52 = clamp ((tmpvar_7 + (tmpvar_8 * 0.5)), 0.0, 1.0);
  lowp vec3 tmpvar_53;
  tmpvar_53 = mix (_ReflectFaceColor.xyz, _ReflectOutlineColor.xyz, vec3(tmpvar_52));
  faceColor_4.xyz = (faceColor_4.xyz + ((tmpvar_51.xyz * tmpvar_53) * faceColor_4.w));
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_MainTex, xlv_TEXCOORD4.xy);
  highp float tmpvar_55;
  tmpvar_55 = clamp (((tmpvar_54.w * xlv_TEXCOORD4.z) - xlv_TEXCOORD4.w), 0.0, 1.0);
  faceColor_4 = (faceColor_4 + ((xlv_COLOR1 * tmpvar_55) * (1.0 - faceColor_4.w)));
  highp vec4 tmpvar_56;
  highp float glow_57;
  highp float tmpvar_58;
  tmpvar_58 = (tmpvar_7 - ((_GlowOffset * _ScaleRatioB) * (0.5 * xlv_TEXCOORD1.y)));
  highp float tmpvar_59;
  tmpvar_59 = ((mix (_GlowInner, 
    (_GlowOuter * _ScaleRatioB)
  , 
    float((tmpvar_58 >= 0.0))
  ) * 0.5) * xlv_TEXCOORD1.y);
  glow_57 = (1.0 - pow (clamp (
    abs((tmpvar_58 / (1.0 + tmpvar_59)))
  , 0.0, 1.0), _GlowPower));
  glow_57 = (glow_57 * sqrt(min (1.0, tmpvar_59)));
  highp float tmpvar_60;
  tmpvar_60 = clamp (((_GlowColor.w * glow_57) * 2.0), 0.0, 1.0);
  lowp vec4 tmpvar_61;
  tmpvar_61.xyz = _GlowColor.xyz;
  tmpvar_61.w = tmpvar_60;
  tmpvar_56 = tmpvar_61;
  faceColor_4.xyz = (faceColor_4.xyz + (tmpvar_56.xyz * tmpvar_56.w));
  mediump float x_62;
  x_62 = (faceColor_4.w - 0.001);
  if ((x_62 < 0.0)) {
    discard;
  };
  tmpvar_1 = (faceColor_4 * xlv_COLOR.w);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _FaceDilate;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineWidth;
uniform 	vec4 hlslcc_mtx4x4_EnvMatrix[4];
uniform 	mediump vec4 _UnderlayColor;
uniform 	float _UnderlayOffsetX;
uniform 	float _UnderlayOffsetY;
uniform 	float _UnderlayDilate;
uniform 	float _UnderlaySoftness;
uniform 	float _GlowOffset;
uniform 	float _GlowOuter;
uniform 	float _WeightNormal;
uniform 	float _WeightBold;
uniform 	float _ScaleRatioA;
uniform 	float _ScaleRatioB;
uniform 	float _ScaleRatioC;
uniform 	float _VertexOffsetX;
uniform 	float _VertexOffsetY;
uniform 	vec4 _ClipRect;
uniform 	float _MaskSoftnessX;
uniform 	float _MaskSoftnessY;
uniform 	float _TextureWidth;
uniform 	float _TextureHeight;
uniform 	float _GradientScale;
uniform 	float _ScaleX;
uniform 	float _ScaleY;
uniform 	float _PerspectiveFilter;
uniform 	vec4 _FaceTex_ST;
uniform 	vec4 _OutlineTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat4;
vec3 u_xlat6;
vec2 u_xlat8;
float u_xlat12;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat0.xy = vec2(in_POSITION0.x + float(_VertexOffsetX), in_POSITION0.y + float(_VertexOffsetY));
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat8.x = (-_OutlineWidth) * _ScaleRatioA + 1.0;
    u_xlat8.x = (-_OutlineSoftness) * _ScaleRatioA + u_xlat8.x;
    u_xlat12 = (-_GlowOffset) * _ScaleRatioB + 1.0;
    u_xlat12 = (-_GlowOuter) * _ScaleRatioB + u_xlat12;
    u_xlat8.x = min(u_xlat12, u_xlat8.x);
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat2.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat2.xy;
    u_xlat2.xy = vec2(abs(u_xlat2.x) * float(_ScaleX), abs(u_xlat2.y) * float(_ScaleY));
    u_xlat2.xy = u_xlat2.ww / u_xlat2.xy;
    u_xlat13 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat2.xy;
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat2.xy;
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.x = abs(in_TEXCOORD1.y) * _GradientScale;
    u_xlat13 = u_xlat13 * u_xlat2.x;
    u_xlat2.x = u_xlat13 * 1.5;
    u_xlat6.x = (-_PerspectiveFilter) + 1.0;
    u_xlat6.x = u_xlat6.x * abs(u_xlat2.x);
    u_xlat13 = u_xlat13 * 1.5 + (-u_xlat6.x);
    u_xlat12 = abs(u_xlat12) * u_xlat13 + u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0);
#else
    u_xlatb13 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
#endif
    u_xlat6.x = (u_xlatb13) ? u_xlat12 : u_xlat2.x;
    u_xlat12 = 0.5 / u_xlat6.x;
    u_xlat8.x = u_xlat8.x * 0.5 + (-u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.0>=in_TEXCOORD1.y);
#else
    u_xlatb13 = 0.0>=in_TEXCOORD1.y;
#endif
    u_xlat13 = u_xlatb13 ? 1.0 : float(0.0);
    u_xlat2.x = (-_WeightNormal) + _WeightBold;
    u_xlat13 = u_xlat13 * u_xlat2.x + _WeightNormal;
    u_xlat13 = u_xlat13 * 0.25 + _FaceDilate;
    u_xlat13 = u_xlat13 * _ScaleRatioA;
    vs_TEXCOORD1.x = (-u_xlat13) * 0.5 + u_xlat8.x;
    u_xlat6.z = u_xlat13 * 0.5;
    u_xlat8.x = (-u_xlat13) * 0.5 + 0.5;
    vs_TEXCOORD1.yw = u_xlat6.xz;
    vs_TEXCOORD1.z = u_xlat12 + u_xlat8.x;
    u_xlat3 = max(_ClipRect, vec4(-2e+010, -2e+010, -2e+010, -2e+010));
    u_xlat3 = min(u_xlat3, vec4(2e+010, 2e+010, 2e+010, 2e+010));
    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat3.xy);
    vs_TEXCOORD2.xy = vec2((-u_xlat3.z) + u_xlat0.x, (-u_xlat3.w) + u_xlat0.y);
    u_xlat0.xyw = u_xlat1.yyy * hlslcc_mtx4x4_EnvMatrix[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_EnvMatrix[0].xyz * u_xlat1.xxx + u_xlat0.xyw;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4_EnvMatrix[2].xyz * u_xlat1.zzz + u_xlat0.xyw;
    u_xlat1 = vec4(_UnderlaySoftness, _UnderlayDilate, _UnderlayOffsetX, _UnderlayOffsetY) * vec4(vec4(_ScaleRatioC, _ScaleRatioC, _ScaleRatioC, _ScaleRatioC));
    u_xlat0.x = u_xlat1.x * u_xlat6.x + 1.0;
    u_xlat0.x = u_xlat6.x / u_xlat0.x;
    u_xlat4 = u_xlat8.x * u_xlat0.x + -0.5;
    u_xlat8.x = u_xlat0.x * u_xlat1.y;
    u_xlat1.xy = vec2((-u_xlat1.z) * _GradientScale, (-u_xlat1.w) * _GradientScale);
    u_xlat1.xy = vec2(u_xlat1.x / float(_TextureWidth), u_xlat1.y / float(_TextureHeight));
    vs_TEXCOORD4.xy = u_xlat1.xy + in_TEXCOORD0.xy;
    vs_TEXCOORD4.z = u_xlat0.x;
    vs_TEXCOORD4.w = (-u_xlat8.x) * 0.5 + u_xlat4;
    u_xlat0.xyz = _UnderlayColor.www * _UnderlayColor.xyz;
    vs_COLOR1.xyz = u_xlat0.xyz;
    vs_COLOR1.w = _UnderlayColor.w;
    u_xlat0.x = in_TEXCOORD1.x * 0.000244140625;
    u_xlat8.x = floor(u_xlat0.x);
    u_xlat8.y = (-u_xlat8.x) * 4096.0 + in_TEXCOORD1.x;
    u_xlat0.xy = u_xlat8.xy * vec2(0.001953125, 0.001953125);
    vs_TEXCOORD5.xy = u_xlat0.xy * _FaceTex_ST.xy + _FaceTex_ST.zw;
    vs_TEXCOORD5.zw = u_xlat0.xy * _OutlineTex_ST.xy + _OutlineTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _FaceUVSpeedX;
uniform 	float _FaceUVSpeedY;
uniform 	mediump vec4 _FaceColor;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineUVSpeedX;
uniform 	float _OutlineUVSpeedY;
uniform 	mediump vec4 _OutlineColor;
uniform 	float _OutlineWidth;
uniform 	float _Bevel;
uniform 	float _BevelOffset;
uniform 	float _BevelWidth;
uniform 	float _BevelClamp;
uniform 	float _BevelRoundness;
uniform 	float _BumpOutline;
uniform 	float _BumpFace;
uniform 	mediump vec4 _ReflectFaceColor;
uniform 	mediump vec4 _ReflectOutlineColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	float _LightAngle;
uniform 	float _SpecularPower;
uniform 	float _Reflectivity;
uniform 	float _Diffuse;
uniform 	float _Ambient;
uniform 	mediump vec4 _GlowColor;
uniform 	float _GlowOffset;
uniform 	float _GlowOuter;
uniform 	float _GlowInner;
uniform 	float _GlowPower;
uniform 	float _ShaderFlags;
uniform 	float _ScaleRatioA;
uniform 	float _ScaleRatioB;
uniform 	float _TextureWidth;
uniform 	float _TextureHeight;
uniform 	float _GradientScale;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FaceTex;
uniform lowp sampler2D _OutlineTex;
uniform lowp sampler2D _BumpMap;
uniform lowp samplerCube _Cube;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec4 u_xlat16_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
lowp vec4 u_xlat10_5;
bool u_xlatb5;
mediump vec3 u_xlat16_6;
vec4 u_xlat7;
lowp vec3 u_xlat10_7;
vec4 u_xlat8;
mediump vec3 u_xlat16_8;
bool u_xlatb8;
vec3 u_xlat9;
lowp float u_xlat10_9;
mediump float u_xlat16_10;
float u_xlat14;
vec2 u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
bool u_xlatb18;
mediump float u_xlat16_19;
float u_xlat23;
float u_xlat27;
bool u_xlatb27;
float u_xlat32;
void main()
{
    u_xlat0.x = _OutlineWidth * _ScaleRatioA;
    u_xlat0.x = u_xlat0.x * vs_TEXCOORD1.y;
    u_xlat16_1 = min(u_xlat0.x, 1.0);
    u_xlat16_1 = sqrt(u_xlat16_1);
    u_xlat16_10 = u_xlat0.x * 0.5;
    u_xlat10_9 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat9.x = (-u_xlat10_9) + vs_TEXCOORD1.z;
    u_xlat16_19 = u_xlat9.x * vs_TEXCOORD1.y + u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat9.x * vs_TEXCOORD1.y + (-u_xlat16_10);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_19;
    u_xlat18.xy = vec2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy + vs_TEXCOORD5.zw;
    u_xlat10_2 = texture(_OutlineTex, u_xlat18.xy);
    u_xlat16_3 = u_xlat10_2 * _OutlineColor;
    u_xlat16_4.xyz = vs_COLOR0.xyz * _FaceColor.xyz;
    u_xlat18.xy = vec2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy + vs_TEXCOORD5.xy;
    u_xlat10_5 = texture(_FaceTex, u_xlat18.xy);
    u_xlat10_2.xyz = texture(_BumpMap, u_xlat18.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat10_5.xyz;
    u_xlat16_18 = u_xlat10_5.w * _FaceColor.w;
    u_xlat16_4.xyz = vec3(u_xlat16_18) * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_3.www + (-u_xlat16_4.xyz);
    u_xlat16_3.w = _OutlineColor.w * u_xlat10_2.w + (-u_xlat16_18);
    u_xlat16_3 = vec4(u_xlat16_1) * u_xlat16_3;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_18) + u_xlat16_3.xyz;
    u_xlat16_2.w = _FaceColor.w * u_xlat10_5.w + u_xlat16_3.w;
    u_xlat9.y = _OutlineSoftness * _ScaleRatioA;
    u_xlat9.xz = u_xlat9.xy * vs_TEXCOORD1.yy;
    u_xlat16_1 = u_xlat9.y * vs_TEXCOORD1.y + 1.0;
    u_xlat16_10 = u_xlat9.z * 0.5 + u_xlat16_10;
    u_xlat16_1 = u_xlat16_10 / u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_3 = vec4(u_xlat16_1) * u_xlat16_2;
    u_xlat16_1 = (-u_xlat16_2.w) * u_xlat16_1 + 1.0;
    u_xlat10_18 = texture(_MainTex, vs_TEXCOORD4.xy).w;
    u_xlat18.x = u_xlat10_18 * vs_TEXCOORD4.z + (-vs_TEXCOORD4.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat18.x = min(max(u_xlat18.x, 0.0), 1.0);
#else
    u_xlat18.x = clamp(u_xlat18.x, 0.0, 1.0);
#endif
    u_xlat2 = u_xlat18.xxxx * vs_COLOR1;
    u_xlat4.w = u_xlat2.w * u_xlat16_1 + u_xlat16_3.w;
    u_xlat16_10 = u_xlat4.w + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat16_10<0.0);
#else
    u_xlatb18 = u_xlat16_10<0.0;
#endif
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat18.x = vs_TEXCOORD1.w + _BevelOffset;
    u_xlat5.xy = vec2(float(0.5) / float(_TextureWidth), float(0.5) / float(_TextureHeight));
    u_xlat5.z = 0.0;
    u_xlat7 = (-u_xlat5.xzzy) + vs_TEXCOORD0.xyxy;
    u_xlat5 = u_xlat5.xzzy + vs_TEXCOORD0.xyxy;
    u_xlat8.x = texture(_MainTex, u_xlat7.xy).w;
    u_xlat8.z = texture(_MainTex, u_xlat7.zw).w;
    u_xlat8.y = texture(_MainTex, u_xlat5.xy).w;
    u_xlat8.w = texture(_MainTex, u_xlat5.zw).w;
    u_xlat5 = u_xlat18.xxxx + u_xlat8;
    u_xlat5 = u_xlat5 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat18.x = _BevelWidth + _OutlineWidth;
    u_xlat18.x = max(u_xlat18.x, 0.00999999978);
    u_xlat5 = u_xlat5 / u_xlat18.xxxx;
    u_xlat18.x = u_xlat18.x * _Bevel;
    u_xlat18.x = u_xlat18.x * _GradientScale;
    u_xlat18.x = u_xlat18.x * -2.0;
    u_xlat5 = u_xlat5 + vec4(0.5, 0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat7 = u_xlat5 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat7 = -abs(u_xlat7) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat27 = _ShaderFlags * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat27>=(-u_xlat27));
#else
    u_xlatb8 = u_xlat27>=(-u_xlat27);
#endif
    u_xlat27 = fract(abs(u_xlat27));
    u_xlat27 = (u_xlatb8) ? u_xlat27 : (-u_xlat27);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat27>=0.5);
#else
    u_xlatb27 = u_xlat27>=0.5;
#endif
    u_xlat5 = (bool(u_xlatb27)) ? u_xlat7 : u_xlat5;
    u_xlat7 = u_xlat5 * vec4(1.57079601, 1.57079601, 1.57079601, 1.57079601);
    u_xlat7 = sin(u_xlat7);
    u_xlat7 = (-u_xlat5) + u_xlat7;
    u_xlat5 = vec4(vec4(_BevelRoundness, _BevelRoundness, _BevelRoundness, _BevelRoundness)) * u_xlat7 + u_xlat5;
    u_xlat27 = (-_BevelClamp) + 1.0;
    u_xlat5 = min(vec4(u_xlat27), u_xlat5);
    u_xlat5.xz = u_xlat18.xx * u_xlat5.xz;
    u_xlat5.yz = u_xlat5.wy * u_xlat18.xx + (-u_xlat5.zx);
    u_xlat5.x = float(-1.0);
    u_xlat5.w = float(1.0);
    u_xlat18.x = dot(u_xlat5.xy, u_xlat5.xy);
    u_xlat18.x = inversesqrt(u_xlat18.x);
    u_xlat27 = dot(u_xlat5.zw, u_xlat5.zw);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat7.x = u_xlat27 * u_xlat5.z;
    u_xlat7.yz = vec2(u_xlat27) * vec2(1.0, 0.0);
    u_xlat5.z = 0.0;
    u_xlat5.xyz = u_xlat18.xxx * u_xlat5.xyz;
    u_xlat8.xyz = u_xlat5.xyz * u_xlat7.xyz;
    u_xlat5.xyz = u_xlat7.zxy * u_xlat5.yzx + (-u_xlat8.xyz);
    u_xlat0.x = u_xlat0.x * 0.5 + u_xlat9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat18.x = (-_BumpFace) + _BumpOutline;
    u_xlat18.x = u_xlat0.x * u_xlat18.x + _BumpFace;
    u_xlat5.xyz = (-u_xlat16_6.xyz) * u_xlat18.xxx + u_xlat5.xyz;
    u_xlat18.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18.x = inversesqrt(u_xlat18.x);
    u_xlat5.xyz = u_xlat18.xxx * u_xlat5.xyz;
    u_xlat18.x = dot(vs_TEXCOORD3.xyz, (-u_xlat5.xyz));
    u_xlat18.x = u_xlat18.x + u_xlat18.x;
    u_xlat7.xyz = u_xlat5.xyz * u_xlat18.xxx + vs_TEXCOORD3.xyz;
    u_xlat10_7.xyz = texture(_Cube, u_xlat7.xyz).xyz;
    u_xlat16_8.xyz = (-_ReflectFaceColor.xyz) + _ReflectOutlineColor.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_8.xyz + _ReflectFaceColor.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat10_7.xyz;
    u_xlat0.xzw = u_xlat16_3.www * u_xlat0.xzw;
    u_xlat7.x = sin(_LightAngle);
    u_xlat8.x = cos(_LightAngle);
    u_xlat7.y = u_xlat8.x;
    u_xlat7.z = -1.0;
    u_xlat32 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat32 = inversesqrt(u_xlat32);
    u_xlat7.xyz = vec3(u_xlat32) * u_xlat7.xyz;
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat14 = u_xlat5.z * u_xlat5.z;
    u_xlat23 = max(u_xlat5.x, 0.0);
    u_xlat5.x = (-u_xlat5.x) * _Diffuse + 1.0;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Reflectivity;
    u_xlat23 = exp2(u_xlat23);
    u_xlat7.xyz = vec3(u_xlat23) * _SpecularColor.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecularPower, _SpecularPower, _SpecularPower));
    u_xlat7.xyz = u_xlat7.xyz * u_xlat16_3.www + u_xlat16_3.xyz;
    u_xlat5.xzw = u_xlat5.xxx * u_xlat7.xyz;
    u_xlat7.x = (-_Ambient) + 1.0;
    u_xlat14 = u_xlat14 * u_xlat7.x + _Ambient;
    u_xlat0.xzw = u_xlat5.xzw * vec3(u_xlat14) + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat2.xyz * vec3(u_xlat16_1) + u_xlat0.xzw;
    u_xlat5.x = _GlowOffset * _ScaleRatioB;
    u_xlat5.x = u_xlat5.x * vs_TEXCOORD1.y;
    u_xlat9.x = (-u_xlat5.x) * 0.5 + u_xlat9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat9.x>=0.0);
#else
    u_xlatb5 = u_xlat9.x>=0.0;
#endif
    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat14 = _GlowOuter * _ScaleRatioB + (-_GlowInner);
    u_xlat5.x = u_xlat5.x * u_xlat14 + _GlowInner;
    u_xlat5.x = u_xlat5.x * vs_TEXCOORD1.y;
    u_xlat14 = u_xlat5.x * 0.5 + 1.0;
    u_xlat5.x = u_xlat5.x * 0.5;
    u_xlat5.x = min(u_xlat5.x, 1.0);
    u_xlat5.x = sqrt(u_xlat5.x);
    u_xlat9.x = u_xlat9.x / u_xlat14;
    u_xlat9.x = min(abs(u_xlat9.x), 1.0);
    u_xlat9.x = log2(u_xlat9.x);
    u_xlat9.x = u_xlat9.x * _GlowPower;
    u_xlat9.x = exp2(u_xlat9.x);
    u_xlat9.x = (-u_xlat9.x) + 1.0;
    u_xlat9.x = u_xlat5.x * u_xlat9.x;
    u_xlat9.x = dot(_GlowColor.ww, u_xlat9.xx);
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = _GlowColor.xyz * u_xlat9.xxx + u_xlat0.xzw;
    SV_Target0 = u_xlat4 * vs_COLOR0.wwww;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _FaceDilate;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineWidth;
uniform 	vec4 hlslcc_mtx4x4_EnvMatrix[4];
uniform 	mediump vec4 _UnderlayColor;
uniform 	float _UnderlayOffsetX;
uniform 	float _UnderlayOffsetY;
uniform 	float _UnderlayDilate;
uniform 	float _UnderlaySoftness;
uniform 	float _GlowOffset;
uniform 	float _GlowOuter;
uniform 	float _WeightNormal;
uniform 	float _WeightBold;
uniform 	float _ScaleRatioA;
uniform 	float _ScaleRatioB;
uniform 	float _ScaleRatioC;
uniform 	float _VertexOffsetX;
uniform 	float _VertexOffsetY;
uniform 	vec4 _ClipRect;
uniform 	float _MaskSoftnessX;
uniform 	float _MaskSoftnessY;
uniform 	float _TextureWidth;
uniform 	float _TextureHeight;
uniform 	float _GradientScale;
uniform 	float _ScaleX;
uniform 	float _ScaleY;
uniform 	float _PerspectiveFilter;
uniform 	vec4 _FaceTex_ST;
uniform 	vec4 _OutlineTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat4;
vec3 u_xlat6;
vec2 u_xlat8;
float u_xlat12;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat0.xy = vec2(in_POSITION0.x + float(_VertexOffsetX), in_POSITION0.y + float(_VertexOffsetY));
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat8.x = (-_OutlineWidth) * _ScaleRatioA + 1.0;
    u_xlat8.x = (-_OutlineSoftness) * _ScaleRatioA + u_xlat8.x;
    u_xlat12 = (-_GlowOffset) * _ScaleRatioB + 1.0;
    u_xlat12 = (-_GlowOuter) * _ScaleRatioB + u_xlat12;
    u_xlat8.x = min(u_xlat12, u_xlat8.x);
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat2.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat2.xy;
    u_xlat2.xy = vec2(abs(u_xlat2.x) * float(_ScaleX), abs(u_xlat2.y) * float(_ScaleY));
    u_xlat2.xy = u_xlat2.ww / u_xlat2.xy;
    u_xlat13 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat2.xy;
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat2.xy;
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.x = abs(in_TEXCOORD1.y) * _GradientScale;
    u_xlat13 = u_xlat13 * u_xlat2.x;
    u_xlat2.x = u_xlat13 * 1.5;
    u_xlat6.x = (-_PerspectiveFilter) + 1.0;
    u_xlat6.x = u_xlat6.x * abs(u_xlat2.x);
    u_xlat13 = u_xlat13 * 1.5 + (-u_xlat6.x);
    u_xlat12 = abs(u_xlat12) * u_xlat13 + u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0);
#else
    u_xlatb13 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
#endif
    u_xlat6.x = (u_xlatb13) ? u_xlat12 : u_xlat2.x;
    u_xlat12 = 0.5 / u_xlat6.x;
    u_xlat8.x = u_xlat8.x * 0.5 + (-u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.0>=in_TEXCOORD1.y);
#else
    u_xlatb13 = 0.0>=in_TEXCOORD1.y;
#endif
    u_xlat13 = u_xlatb13 ? 1.0 : float(0.0);
    u_xlat2.x = (-_WeightNormal) + _WeightBold;
    u_xlat13 = u_xlat13 * u_xlat2.x + _WeightNormal;
    u_xlat13 = u_xlat13 * 0.25 + _FaceDilate;
    u_xlat13 = u_xlat13 * _ScaleRatioA;
    vs_TEXCOORD1.x = (-u_xlat13) * 0.5 + u_xlat8.x;
    u_xlat6.z = u_xlat13 * 0.5;
    u_xlat8.x = (-u_xlat13) * 0.5 + 0.5;
    vs_TEXCOORD1.yw = u_xlat6.xz;
    vs_TEXCOORD1.z = u_xlat12 + u_xlat8.x;
    u_xlat3 = max(_ClipRect, vec4(-2e+010, -2e+010, -2e+010, -2e+010));
    u_xlat3 = min(u_xlat3, vec4(2e+010, 2e+010, 2e+010, 2e+010));
    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat3.xy);
    vs_TEXCOORD2.xy = vec2((-u_xlat3.z) + u_xlat0.x, (-u_xlat3.w) + u_xlat0.y);
    u_xlat0.xyw = u_xlat1.yyy * hlslcc_mtx4x4_EnvMatrix[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_EnvMatrix[0].xyz * u_xlat1.xxx + u_xlat0.xyw;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4_EnvMatrix[2].xyz * u_xlat1.zzz + u_xlat0.xyw;
    u_xlat1 = vec4(_UnderlaySoftness, _UnderlayDilate, _UnderlayOffsetX, _UnderlayOffsetY) * vec4(vec4(_ScaleRatioC, _ScaleRatioC, _ScaleRatioC, _ScaleRatioC));
    u_xlat0.x = u_xlat1.x * u_xlat6.x + 1.0;
    u_xlat0.x = u_xlat6.x / u_xlat0.x;
    u_xlat4 = u_xlat8.x * u_xlat0.x + -0.5;
    u_xlat8.x = u_xlat0.x * u_xlat1.y;
    u_xlat1.xy = vec2((-u_xlat1.z) * _GradientScale, (-u_xlat1.w) * _GradientScale);
    u_xlat1.xy = vec2(u_xlat1.x / float(_TextureWidth), u_xlat1.y / float(_TextureHeight));
    vs_TEXCOORD4.xy = u_xlat1.xy + in_TEXCOORD0.xy;
    vs_TEXCOORD4.z = u_xlat0.x;
    vs_TEXCOORD4.w = (-u_xlat8.x) * 0.5 + u_xlat4;
    u_xlat0.xyz = _UnderlayColor.www * _UnderlayColor.xyz;
    vs_COLOR1.xyz = u_xlat0.xyz;
    vs_COLOR1.w = _UnderlayColor.w;
    u_xlat0.x = in_TEXCOORD1.x * 0.000244140625;
    u_xlat8.x = floor(u_xlat0.x);
    u_xlat8.y = (-u_xlat8.x) * 4096.0 + in_TEXCOORD1.x;
    u_xlat0.xy = u_xlat8.xy * vec2(0.001953125, 0.001953125);
    vs_TEXCOORD5.xy = u_xlat0.xy * _FaceTex_ST.xy + _FaceTex_ST.zw;
    vs_TEXCOORD5.zw = u_xlat0.xy * _OutlineTex_ST.xy + _OutlineTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _FaceUVSpeedX;
uniform 	float _FaceUVSpeedY;
uniform 	mediump vec4 _FaceColor;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineUVSpeedX;
uniform 	float _OutlineUVSpeedY;
uniform 	mediump vec4 _OutlineColor;
uniform 	float _OutlineWidth;
uniform 	float _Bevel;
uniform 	float _BevelOffset;
uniform 	float _BevelWidth;
uniform 	float _BevelClamp;
uniform 	float _BevelRoundness;
uniform 	float _BumpOutline;
uniform 	float _BumpFace;
uniform 	mediump vec4 _ReflectFaceColor;
uniform 	mediump vec4 _ReflectOutlineColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	float _LightAngle;
uniform 	float _SpecularPower;
uniform 	float _Reflectivity;
uniform 	float _Diffuse;
uniform 	float _Ambient;
uniform 	mediump vec4 _GlowColor;
uniform 	float _GlowOffset;
uniform 	float _GlowOuter;
uniform 	float _GlowInner;
uniform 	float _GlowPower;
uniform 	float _ShaderFlags;
uniform 	float _ScaleRatioA;
uniform 	float _ScaleRatioB;
uniform 	float _TextureWidth;
uniform 	float _TextureHeight;
uniform 	float _GradientScale;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FaceTex;
uniform lowp sampler2D _OutlineTex;
uniform lowp sampler2D _BumpMap;
uniform lowp samplerCube _Cube;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec4 u_xlat16_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
lowp vec4 u_xlat10_5;
bool u_xlatb5;
mediump vec3 u_xlat16_6;
vec4 u_xlat7;
lowp vec3 u_xlat10_7;
vec4 u_xlat8;
mediump vec3 u_xlat16_8;
bool u_xlatb8;
vec3 u_xlat9;
lowp float u_xlat10_9;
mediump float u_xlat16_10;
float u_xlat14;
vec2 u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
bool u_xlatb18;
mediump float u_xlat16_19;
float u_xlat23;
float u_xlat27;
bool u_xlatb27;
float u_xlat32;
void main()
{
    u_xlat0.x = _OutlineWidth * _ScaleRatioA;
    u_xlat0.x = u_xlat0.x * vs_TEXCOORD1.y;
    u_xlat16_1 = min(u_xlat0.x, 1.0);
    u_xlat16_1 = sqrt(u_xlat16_1);
    u_xlat16_10 = u_xlat0.x * 0.5;
    u_xlat10_9 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat9.x = (-u_xlat10_9) + vs_TEXCOORD1.z;
    u_xlat16_19 = u_xlat9.x * vs_TEXCOORD1.y + u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat9.x * vs_TEXCOORD1.y + (-u_xlat16_10);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_19;
    u_xlat18.xy = vec2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy + vs_TEXCOORD5.zw;
    u_xlat10_2 = texture(_OutlineTex, u_xlat18.xy);
    u_xlat16_3 = u_xlat10_2 * _OutlineColor;
    u_xlat16_4.xyz = vs_COLOR0.xyz * _FaceColor.xyz;
    u_xlat18.xy = vec2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy + vs_TEXCOORD5.xy;
    u_xlat10_5 = texture(_FaceTex, u_xlat18.xy);
    u_xlat10_2.xyz = texture(_BumpMap, u_xlat18.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat10_5.xyz;
    u_xlat16_18 = u_xlat10_5.w * _FaceColor.w;
    u_xlat16_4.xyz = vec3(u_xlat16_18) * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_3.www + (-u_xlat16_4.xyz);
    u_xlat16_3.w = _OutlineColor.w * u_xlat10_2.w + (-u_xlat16_18);
    u_xlat16_3 = vec4(u_xlat16_1) * u_xlat16_3;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_18) + u_xlat16_3.xyz;
    u_xlat16_2.w = _FaceColor.w * u_xlat10_5.w + u_xlat16_3.w;
    u_xlat9.y = _OutlineSoftness * _ScaleRatioA;
    u_xlat9.xz = u_xlat9.xy * vs_TEXCOORD1.yy;
    u_xlat16_1 = u_xlat9.y * vs_TEXCOORD1.y + 1.0;
    u_xlat16_10 = u_xlat9.z * 0.5 + u_xlat16_10;
    u_xlat16_1 = u_xlat16_10 / u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_3 = vec4(u_xlat16_1) * u_xlat16_2;
    u_xlat16_1 = (-u_xlat16_2.w) * u_xlat16_1 + 1.0;
    u_xlat10_18 = texture(_MainTex, vs_TEXCOORD4.xy).w;
    u_xlat18.x = u_xlat10_18 * vs_TEXCOORD4.z + (-vs_TEXCOORD4.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat18.x = min(max(u_xlat18.x, 0.0), 1.0);
#else
    u_xlat18.x = clamp(u_xlat18.x, 0.0, 1.0);
#endif
    u_xlat2 = u_xlat18.xxxx * vs_COLOR1;
    u_xlat4.w = u_xlat2.w * u_xlat16_1 + u_xlat16_3.w;
    u_xlat16_10 = u_xlat4.w + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat16_10<0.0);
#else
    u_xlatb18 = u_xlat16_10<0.0;
#endif
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat18.x = vs_TEXCOORD1.w + _BevelOffset;
    u_xlat5.xy = vec2(float(0.5) / float(_TextureWidth), float(0.5) / float(_TextureHeight));
    u_xlat5.z = 0.0;
    u_xlat7 = (-u_xlat5.xzzy) + vs_TEXCOORD0.xyxy;
    u_xlat5 = u_xlat5.xzzy + vs_TEXCOORD0.xyxy;
    u_xlat8.x = texture(_MainTex, u_xlat7.xy).w;
    u_xlat8.z = texture(_MainTex, u_xlat7.zw).w;
    u_xlat8.y = texture(_MainTex, u_xlat5.xy).w;
    u_xlat8.w = texture(_MainTex, u_xlat5.zw).w;
    u_xlat5 = u_xlat18.xxxx + u_xlat8;
    u_xlat5 = u_xlat5 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat18.x = _BevelWidth + _OutlineWidth;
    u_xlat18.x = max(u_xlat18.x, 0.00999999978);
    u_xlat5 = u_xlat5 / u_xlat18.xxxx;
    u_xlat18.x = u_xlat18.x * _Bevel;
    u_xlat18.x = u_xlat18.x * _GradientScale;
    u_xlat18.x = u_xlat18.x * -2.0;
    u_xlat5 = u_xlat5 + vec4(0.5, 0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat7 = u_xlat5 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat7 = -abs(u_xlat7) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat27 = _ShaderFlags * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat27>=(-u_xlat27));
#else
    u_xlatb8 = u_xlat27>=(-u_xlat27);
#endif
    u_xlat27 = fract(abs(u_xlat27));
    u_xlat27 = (u_xlatb8) ? u_xlat27 : (-u_xlat27);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat27>=0.5);
#else
    u_xlatb27 = u_xlat27>=0.5;
#endif
    u_xlat5 = (bool(u_xlatb27)) ? u_xlat7 : u_xlat5;
    u_xlat7 = u_xlat5 * vec4(1.57079601, 1.57079601, 1.57079601, 1.57079601);
    u_xlat7 = sin(u_xlat7);
    u_xlat7 = (-u_xlat5) + u_xlat7;
    u_xlat5 = vec4(vec4(_BevelRoundness, _BevelRoundness, _BevelRoundness, _BevelRoundness)) * u_xlat7 + u_xlat5;
    u_xlat27 = (-_BevelClamp) + 1.0;
    u_xlat5 = min(vec4(u_xlat27), u_xlat5);
    u_xlat5.xz = u_xlat18.xx * u_xlat5.xz;
    u_xlat5.yz = u_xlat5.wy * u_xlat18.xx + (-u_xlat5.zx);
    u_xlat5.x = float(-1.0);
    u_xlat5.w = float(1.0);
    u_xlat18.x = dot(u_xlat5.xy, u_xlat5.xy);
    u_xlat18.x = inversesqrt(u_xlat18.x);
    u_xlat27 = dot(u_xlat5.zw, u_xlat5.zw);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat7.x = u_xlat27 * u_xlat5.z;
    u_xlat7.yz = vec2(u_xlat27) * vec2(1.0, 0.0);
    u_xlat5.z = 0.0;
    u_xlat5.xyz = u_xlat18.xxx * u_xlat5.xyz;
    u_xlat8.xyz = u_xlat5.xyz * u_xlat7.xyz;
    u_xlat5.xyz = u_xlat7.zxy * u_xlat5.yzx + (-u_xlat8.xyz);
    u_xlat0.x = u_xlat0.x * 0.5 + u_xlat9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat18.x = (-_BumpFace) + _BumpOutline;
    u_xlat18.x = u_xlat0.x * u_xlat18.x + _BumpFace;
    u_xlat5.xyz = (-u_xlat16_6.xyz) * u_xlat18.xxx + u_xlat5.xyz;
    u_xlat18.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18.x = inversesqrt(u_xlat18.x);
    u_xlat5.xyz = u_xlat18.xxx * u_xlat5.xyz;
    u_xlat18.x = dot(vs_TEXCOORD3.xyz, (-u_xlat5.xyz));
    u_xlat18.x = u_xlat18.x + u_xlat18.x;
    u_xlat7.xyz = u_xlat5.xyz * u_xlat18.xxx + vs_TEXCOORD3.xyz;
    u_xlat10_7.xyz = texture(_Cube, u_xlat7.xyz).xyz;
    u_xlat16_8.xyz = (-_ReflectFaceColor.xyz) + _ReflectOutlineColor.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_8.xyz + _ReflectFaceColor.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat10_7.xyz;
    u_xlat0.xzw = u_xlat16_3.www * u_xlat0.xzw;
    u_xlat7.x = sin(_LightAngle);
    u_xlat8.x = cos(_LightAngle);
    u_xlat7.y = u_xlat8.x;
    u_xlat7.z = -1.0;
    u_xlat32 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat32 = inversesqrt(u_xlat32);
    u_xlat7.xyz = vec3(u_xlat32) * u_xlat7.xyz;
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat14 = u_xlat5.z * u_xlat5.z;
    u_xlat23 = max(u_xlat5.x, 0.0);
    u_xlat5.x = (-u_xlat5.x) * _Diffuse + 1.0;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Reflectivity;
    u_xlat23 = exp2(u_xlat23);
    u_xlat7.xyz = vec3(u_xlat23) * _SpecularColor.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecularPower, _SpecularPower, _SpecularPower));
    u_xlat7.xyz = u_xlat7.xyz * u_xlat16_3.www + u_xlat16_3.xyz;
    u_xlat5.xzw = u_xlat5.xxx * u_xlat7.xyz;
    u_xlat7.x = (-_Ambient) + 1.0;
    u_xlat14 = u_xlat14 * u_xlat7.x + _Ambient;
    u_xlat0.xzw = u_xlat5.xzw * vec3(u_xlat14) + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat2.xyz * vec3(u_xlat16_1) + u_xlat0.xzw;
    u_xlat5.x = _GlowOffset * _ScaleRatioB;
    u_xlat5.x = u_xlat5.x * vs_TEXCOORD1.y;
    u_xlat9.x = (-u_xlat5.x) * 0.5 + u_xlat9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat9.x>=0.0);
#else
    u_xlatb5 = u_xlat9.x>=0.0;
#endif
    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat14 = _GlowOuter * _ScaleRatioB + (-_GlowInner);
    u_xlat5.x = u_xlat5.x * u_xlat14 + _GlowInner;
    u_xlat5.x = u_xlat5.x * vs_TEXCOORD1.y;
    u_xlat14 = u_xlat5.x * 0.5 + 1.0;
    u_xlat5.x = u_xlat5.x * 0.5;
    u_xlat5.x = min(u_xlat5.x, 1.0);
    u_xlat5.x = sqrt(u_xlat5.x);
    u_xlat9.x = u_xlat9.x / u_xlat14;
    u_xlat9.x = min(abs(u_xlat9.x), 1.0);
    u_xlat9.x = log2(u_xlat9.x);
    u_xlat9.x = u_xlat9.x * _GlowPower;
    u_xlat9.x = exp2(u_xlat9.x);
    u_xlat9.x = (-u_xlat9.x) + 1.0;
    u_xlat9.x = u_xlat5.x * u_xlat9.x;
    u_xlat9.x = dot(_GlowColor.ww, u_xlat9.xx);
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = _GlowColor.xyz * u_xlat9.xxx + u_xlat0.xzw;
    SV_Target0 = u_xlat4 * vs_COLOR0.wwww;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _FaceDilate;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineWidth;
uniform 	vec4 hlslcc_mtx4x4_EnvMatrix[4];
uniform 	mediump vec4 _UnderlayColor;
uniform 	float _UnderlayOffsetX;
uniform 	float _UnderlayOffsetY;
uniform 	float _UnderlayDilate;
uniform 	float _UnderlaySoftness;
uniform 	float _GlowOffset;
uniform 	float _GlowOuter;
uniform 	float _WeightNormal;
uniform 	float _WeightBold;
uniform 	float _ScaleRatioA;
uniform 	float _ScaleRatioB;
uniform 	float _ScaleRatioC;
uniform 	float _VertexOffsetX;
uniform 	float _VertexOffsetY;
uniform 	vec4 _ClipRect;
uniform 	float _MaskSoftnessX;
uniform 	float _MaskSoftnessY;
uniform 	float _TextureWidth;
uniform 	float _TextureHeight;
uniform 	float _GradientScale;
uniform 	float _ScaleX;
uniform 	float _ScaleY;
uniform 	float _PerspectiveFilter;
uniform 	vec4 _FaceTex_ST;
uniform 	vec4 _OutlineTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat4;
vec3 u_xlat6;
vec2 u_xlat8;
float u_xlat12;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat0.xy = vec2(in_POSITION0.x + float(_VertexOffsetX), in_POSITION0.y + float(_VertexOffsetY));
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat8.x = (-_OutlineWidth) * _ScaleRatioA + 1.0;
    u_xlat8.x = (-_OutlineSoftness) * _ScaleRatioA + u_xlat8.x;
    u_xlat12 = (-_GlowOffset) * _ScaleRatioB + 1.0;
    u_xlat12 = (-_GlowOuter) * _ScaleRatioB + u_xlat12;
    u_xlat8.x = min(u_xlat12, u_xlat8.x);
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat2.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat2.xy;
    u_xlat2.xy = vec2(abs(u_xlat2.x) * float(_ScaleX), abs(u_xlat2.y) * float(_ScaleY));
    u_xlat2.xy = u_xlat2.ww / u_xlat2.xy;
    u_xlat13 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat2.xy;
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat2.xy;
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.x = abs(in_TEXCOORD1.y) * _GradientScale;
    u_xlat13 = u_xlat13 * u_xlat2.x;
    u_xlat2.x = u_xlat13 * 1.5;
    u_xlat6.x = (-_PerspectiveFilter) + 1.0;
    u_xlat6.x = u_xlat6.x * abs(u_xlat2.x);
    u_xlat13 = u_xlat13 * 1.5 + (-u_xlat6.x);
    u_xlat12 = abs(u_xlat12) * u_xlat13 + u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0);
#else
    u_xlatb13 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
#endif
    u_xlat6.x = (u_xlatb13) ? u_xlat12 : u_xlat2.x;
    u_xlat12 = 0.5 / u_xlat6.x;
    u_xlat8.x = u_xlat8.x * 0.5 + (-u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.0>=in_TEXCOORD1.y);
#else
    u_xlatb13 = 0.0>=in_TEXCOORD1.y;
#endif
    u_xlat13 = u_xlatb13 ? 1.0 : float(0.0);
    u_xlat2.x = (-_WeightNormal) + _WeightBold;
    u_xlat13 = u_xlat13 * u_xlat2.x + _WeightNormal;
    u_xlat13 = u_xlat13 * 0.25 + _FaceDilate;
    u_xlat13 = u_xlat13 * _ScaleRatioA;
    vs_TEXCOORD1.x = (-u_xlat13) * 0.5 + u_xlat8.x;
    u_xlat6.z = u_xlat13 * 0.5;
    u_xlat8.x = (-u_xlat13) * 0.5 + 0.5;
    vs_TEXCOORD1.yw = u_xlat6.xz;
    vs_TEXCOORD1.z = u_xlat12 + u_xlat8.x;
    u_xlat3 = max(_ClipRect, vec4(-2e+010, -2e+010, -2e+010, -2e+010));
    u_xlat3 = min(u_xlat3, vec4(2e+010, 2e+010, 2e+010, 2e+010));
    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat3.xy);
    vs_TEXCOORD2.xy = vec2((-u_xlat3.z) + u_xlat0.x, (-u_xlat3.w) + u_xlat0.y);
    u_xlat0.xyw = u_xlat1.yyy * hlslcc_mtx4x4_EnvMatrix[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_EnvMatrix[0].xyz * u_xlat1.xxx + u_xlat0.xyw;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4_EnvMatrix[2].xyz * u_xlat1.zzz + u_xlat0.xyw;
    u_xlat1 = vec4(_UnderlaySoftness, _UnderlayDilate, _UnderlayOffsetX, _UnderlayOffsetY) * vec4(vec4(_ScaleRatioC, _ScaleRatioC, _ScaleRatioC, _ScaleRatioC));
    u_xlat0.x = u_xlat1.x * u_xlat6.x + 1.0;
    u_xlat0.x = u_xlat6.x / u_xlat0.x;
    u_xlat4 = u_xlat8.x * u_xlat0.x + -0.5;
    u_xlat8.x = u_xlat0.x * u_xlat1.y;
    u_xlat1.xy = vec2((-u_xlat1.z) * _GradientScale, (-u_xlat1.w) * _GradientScale);
    u_xlat1.xy = vec2(u_xlat1.x / float(_TextureWidth), u_xlat1.y / float(_TextureHeight));
    vs_TEXCOORD4.xy = u_xlat1.xy + in_TEXCOORD0.xy;
    vs_TEXCOORD4.z = u_xlat0.x;
    vs_TEXCOORD4.w = (-u_xlat8.x) * 0.5 + u_xlat4;
    u_xlat0.xyz = _UnderlayColor.www * _UnderlayColor.xyz;
    vs_COLOR1.xyz = u_xlat0.xyz;
    vs_COLOR1.w = _UnderlayColor.w;
    u_xlat0.x = in_TEXCOORD1.x * 0.000244140625;
    u_xlat8.x = floor(u_xlat0.x);
    u_xlat8.y = (-u_xlat8.x) * 4096.0 + in_TEXCOORD1.x;
    u_xlat0.xy = u_xlat8.xy * vec2(0.001953125, 0.001953125);
    vs_TEXCOORD5.xy = u_xlat0.xy * _FaceTex_ST.xy + _FaceTex_ST.zw;
    vs_TEXCOORD5.zw = u_xlat0.xy * _OutlineTex_ST.xy + _OutlineTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _FaceUVSpeedX;
uniform 	float _FaceUVSpeedY;
uniform 	mediump vec4 _FaceColor;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineUVSpeedX;
uniform 	float _OutlineUVSpeedY;
uniform 	mediump vec4 _OutlineColor;
uniform 	float _OutlineWidth;
uniform 	float _Bevel;
uniform 	float _BevelOffset;
uniform 	float _BevelWidth;
uniform 	float _BevelClamp;
uniform 	float _BevelRoundness;
uniform 	float _BumpOutline;
uniform 	float _BumpFace;
uniform 	mediump vec4 _ReflectFaceColor;
uniform 	mediump vec4 _ReflectOutlineColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	float _LightAngle;
uniform 	float _SpecularPower;
uniform 	float _Reflectivity;
uniform 	float _Diffuse;
uniform 	float _Ambient;
uniform 	mediump vec4 _GlowColor;
uniform 	float _GlowOffset;
uniform 	float _GlowOuter;
uniform 	float _GlowInner;
uniform 	float _GlowPower;
uniform 	float _ShaderFlags;
uniform 	float _ScaleRatioA;
uniform 	float _ScaleRatioB;
uniform 	float _TextureWidth;
uniform 	float _TextureHeight;
uniform 	float _GradientScale;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FaceTex;
uniform lowp sampler2D _OutlineTex;
uniform lowp sampler2D _BumpMap;
uniform lowp samplerCube _Cube;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec4 u_xlat16_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
lowp vec4 u_xlat10_5;
bool u_xlatb5;
mediump vec3 u_xlat16_6;
vec4 u_xlat7;
lowp vec3 u_xlat10_7;
vec4 u_xlat8;
mediump vec3 u_xlat16_8;
bool u_xlatb8;
vec3 u_xlat9;
lowp float u_xlat10_9;
mediump float u_xlat16_10;
float u_xlat14;
vec2 u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
bool u_xlatb18;
mediump float u_xlat16_19;
float u_xlat23;
float u_xlat27;
bool u_xlatb27;
float u_xlat32;
void main()
{
    u_xlat0.x = _OutlineWidth * _ScaleRatioA;
    u_xlat0.x = u_xlat0.x * vs_TEXCOORD1.y;
    u_xlat16_1 = min(u_xlat0.x, 1.0);
    u_xlat16_1 = sqrt(u_xlat16_1);
    u_xlat16_10 = u_xlat0.x * 0.5;
    u_xlat10_9 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat9.x = (-u_xlat10_9) + vs_TEXCOORD1.z;
    u_xlat16_19 = u_xlat9.x * vs_TEXCOORD1.y + u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat9.x * vs_TEXCOORD1.y + (-u_xlat16_10);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_19;
    u_xlat18.xy = vec2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy + vs_TEXCOORD5.zw;
    u_xlat10_2 = texture(_OutlineTex, u_xlat18.xy);
    u_xlat16_3 = u_xlat10_2 * _OutlineColor;
    u_xlat16_4.xyz = vs_COLOR0.xyz * _FaceColor.xyz;
    u_xlat18.xy = vec2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy + vs_TEXCOORD5.xy;
    u_xlat10_5 = texture(_FaceTex, u_xlat18.xy);
    u_xlat10_2.xyz = texture(_BumpMap, u_xlat18.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat10_5.xyz;
    u_xlat16_18 = u_xlat10_5.w * _FaceColor.w;
    u_xlat16_4.xyz = vec3(u_xlat16_18) * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_3.www + (-u_xlat16_4.xyz);
    u_xlat16_3.w = _OutlineColor.w * u_xlat10_2.w + (-u_xlat16_18);
    u_xlat16_3 = vec4(u_xlat16_1) * u_xlat16_3;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_18) + u_xlat16_3.xyz;
    u_xlat16_2.w = _FaceColor.w * u_xlat10_5.w + u_xlat16_3.w;
    u_xlat9.y = _OutlineSoftness * _ScaleRatioA;
    u_xlat9.xz = u_xlat9.xy * vs_TEXCOORD1.yy;
    u_xlat16_1 = u_xlat9.y * vs_TEXCOORD1.y + 1.0;
    u_xlat16_10 = u_xlat9.z * 0.5 + u_xlat16_10;
    u_xlat16_1 = u_xlat16_10 / u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_3 = vec4(u_xlat16_1) * u_xlat16_2;
    u_xlat16_1 = (-u_xlat16_2.w) * u_xlat16_1 + 1.0;
    u_xlat10_18 = texture(_MainTex, vs_TEXCOORD4.xy).w;
    u_xlat18.x = u_xlat10_18 * vs_TEXCOORD4.z + (-vs_TEXCOORD4.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat18.x = min(max(u_xlat18.x, 0.0), 1.0);
#else
    u_xlat18.x = clamp(u_xlat18.x, 0.0, 1.0);
#endif
    u_xlat2 = u_xlat18.xxxx * vs_COLOR1;
    u_xlat4.w = u_xlat2.w * u_xlat16_1 + u_xlat16_3.w;
    u_xlat16_10 = u_xlat4.w + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat16_10<0.0);
#else
    u_xlatb18 = u_xlat16_10<0.0;
#endif
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat18.x = vs_TEXCOORD1.w + _BevelOffset;
    u_xlat5.xy = vec2(float(0.5) / float(_TextureWidth), float(0.5) / float(_TextureHeight));
    u_xlat5.z = 0.0;
    u_xlat7 = (-u_xlat5.xzzy) + vs_TEXCOORD0.xyxy;
    u_xlat5 = u_xlat5.xzzy + vs_TEXCOORD0.xyxy;
    u_xlat8.x = texture(_MainTex, u_xlat7.xy).w;
    u_xlat8.z = texture(_MainTex, u_xlat7.zw).w;
    u_xlat8.y = texture(_MainTex, u_xlat5.xy).w;
    u_xlat8.w = texture(_MainTex, u_xlat5.zw).w;
    u_xlat5 = u_xlat18.xxxx + u_xlat8;
    u_xlat5 = u_xlat5 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat18.x = _BevelWidth + _OutlineWidth;
    u_xlat18.x = max(u_xlat18.x, 0.00999999978);
    u_xlat5 = u_xlat5 / u_xlat18.xxxx;
    u_xlat18.x = u_xlat18.x * _Bevel;
    u_xlat18.x = u_xlat18.x * _GradientScale;
    u_xlat18.x = u_xlat18.x * -2.0;
    u_xlat5 = u_xlat5 + vec4(0.5, 0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat7 = u_xlat5 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat7 = -abs(u_xlat7) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat27 = _ShaderFlags * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat27>=(-u_xlat27));
#else
    u_xlatb8 = u_xlat27>=(-u_xlat27);
#endif
    u_xlat27 = fract(abs(u_xlat27));
    u_xlat27 = (u_xlatb8) ? u_xlat27 : (-u_xlat27);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat27>=0.5);
#else
    u_xlatb27 = u_xlat27>=0.5;
#endif
    u_xlat5 = (bool(u_xlatb27)) ? u_xlat7 : u_xlat5;
    u_xlat7 = u_xlat5 * vec4(1.57079601, 1.57079601, 1.57079601, 1.57079601);
    u_xlat7 = sin(u_xlat7);
    u_xlat7 = (-u_xlat5) + u_xlat7;
    u_xlat5 = vec4(vec4(_BevelRoundness, _BevelRoundness, _BevelRoundness, _BevelRoundness)) * u_xlat7 + u_xlat5;
    u_xlat27 = (-_BevelClamp) + 1.0;
    u_xlat5 = min(vec4(u_xlat27), u_xlat5);
    u_xlat5.xz = u_xlat18.xx * u_xlat5.xz;
    u_xlat5.yz = u_xlat5.wy * u_xlat18.xx + (-u_xlat5.zx);
    u_xlat5.x = float(-1.0);
    u_xlat5.w = float(1.0);
    u_xlat18.x = dot(u_xlat5.xy, u_xlat5.xy);
    u_xlat18.x = inversesqrt(u_xlat18.x);
    u_xlat27 = dot(u_xlat5.zw, u_xlat5.zw);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat7.x = u_xlat27 * u_xlat5.z;
    u_xlat7.yz = vec2(u_xlat27) * vec2(1.0, 0.0);
    u_xlat5.z = 0.0;
    u_xlat5.xyz = u_xlat18.xxx * u_xlat5.xyz;
    u_xlat8.xyz = u_xlat5.xyz * u_xlat7.xyz;
    u_xlat5.xyz = u_xlat7.zxy * u_xlat5.yzx + (-u_xlat8.xyz);
    u_xlat0.x = u_xlat0.x * 0.5 + u_xlat9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat18.x = (-_BumpFace) + _BumpOutline;
    u_xlat18.x = u_xlat0.x * u_xlat18.x + _BumpFace;
    u_xlat5.xyz = (-u_xlat16_6.xyz) * u_xlat18.xxx + u_xlat5.xyz;
    u_xlat18.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18.x = inversesqrt(u_xlat18.x);
    u_xlat5.xyz = u_xlat18.xxx * u_xlat5.xyz;
    u_xlat18.x = dot(vs_TEXCOORD3.xyz, (-u_xlat5.xyz));
    u_xlat18.x = u_xlat18.x + u_xlat18.x;
    u_xlat7.xyz = u_xlat5.xyz * u_xlat18.xxx + vs_TEXCOORD3.xyz;
    u_xlat10_7.xyz = texture(_Cube, u_xlat7.xyz).xyz;
    u_xlat16_8.xyz = (-_ReflectFaceColor.xyz) + _ReflectOutlineColor.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_8.xyz + _ReflectFaceColor.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat10_7.xyz;
    u_xlat0.xzw = u_xlat16_3.www * u_xlat0.xzw;
    u_xlat7.x = sin(_LightAngle);
    u_xlat8.x = cos(_LightAngle);
    u_xlat7.y = u_xlat8.x;
    u_xlat7.z = -1.0;
    u_xlat32 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat32 = inversesqrt(u_xlat32);
    u_xlat7.xyz = vec3(u_xlat32) * u_xlat7.xyz;
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat14 = u_xlat5.z * u_xlat5.z;
    u_xlat23 = max(u_xlat5.x, 0.0);
    u_xlat5.x = (-u_xlat5.x) * _Diffuse + 1.0;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Reflectivity;
    u_xlat23 = exp2(u_xlat23);
    u_xlat7.xyz = vec3(u_xlat23) * _SpecularColor.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecularPower, _SpecularPower, _SpecularPower));
    u_xlat7.xyz = u_xlat7.xyz * u_xlat16_3.www + u_xlat16_3.xyz;
    u_xlat5.xzw = u_xlat5.xxx * u_xlat7.xyz;
    u_xlat7.x = (-_Ambient) + 1.0;
    u_xlat14 = u_xlat14 * u_xlat7.x + _Ambient;
    u_xlat0.xzw = u_xlat5.xzw * vec3(u_xlat14) + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat2.xyz * vec3(u_xlat16_1) + u_xlat0.xzw;
    u_xlat5.x = _GlowOffset * _ScaleRatioB;
    u_xlat5.x = u_xlat5.x * vs_TEXCOORD1.y;
    u_xlat9.x = (-u_xlat5.x) * 0.5 + u_xlat9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat9.x>=0.0);
#else
    u_xlatb5 = u_xlat9.x>=0.0;
#endif
    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat14 = _GlowOuter * _ScaleRatioB + (-_GlowInner);
    u_xlat5.x = u_xlat5.x * u_xlat14 + _GlowInner;
    u_xlat5.x = u_xlat5.x * vs_TEXCOORD1.y;
    u_xlat14 = u_xlat5.x * 0.5 + 1.0;
    u_xlat5.x = u_xlat5.x * 0.5;
    u_xlat5.x = min(u_xlat5.x, 1.0);
    u_xlat5.x = sqrt(u_xlat5.x);
    u_xlat9.x = u_xlat9.x / u_xlat14;
    u_xlat9.x = min(abs(u_xlat9.x), 1.0);
    u_xlat9.x = log2(u_xlat9.x);
    u_xlat9.x = u_xlat9.x * _GlowPower;
    u_xlat9.x = exp2(u_xlat9.x);
    u_xlat9.x = (-u_xlat9.x) + 1.0;
    u_xlat9.x = u_xlat5.x * u_xlat9.x;
    u_xlat9.x = dot(_GlowColor.ww, u_xlat9.xx);
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = _GlowColor.xyz * u_xlat9.xxx + u_xlat0.xzw;
    SV_Target0 = u_xlat4 * vs_COLOR0.wwww;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_CLIP_RECT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixVP;
uniform highp float _FaceDilate;
uniform highp float _OutlineSoftness;
uniform highp float _OutlineWidth;
uniform highp mat4 _EnvMatrix;
uniform highp float _WeightNormal;
uniform highp float _WeightBold;
uniform highp float _ScaleRatioA;
uniform highp float _VertexOffsetX;
uniform highp float _VertexOffsetY;
uniform highp vec4 _ClipRect;
uniform highp float _MaskSoftnessX;
uniform highp float _MaskSoftnessY;
uniform highp float _GradientScale;
uniform highp float _ScaleX;
uniform highp float _ScaleY;
uniform highp float _PerspectiveFilter;
uniform highp vec4 _FaceTex_ST;
uniform highp vec4 _OutlineTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp float weight_3;
  highp float scale_4;
  highp vec2 pixelSize_5;
  highp vec4 vert_6;
  highp float tmpvar_7;
  tmpvar_7 = float((0.0 >= _glesMultiTexCoord1.y));
  vert_6.zw = _glesVertex.zw;
  vert_6.x = (_glesVertex.x + _VertexOffsetX);
  vert_6.y = (_glesVertex.y + _VertexOffsetY);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = vert_6.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp vec2 tmpvar_10;
  tmpvar_10.x = _ScaleX;
  tmpvar_10.y = _ScaleY;
  highp mat2 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_projection[0].xy;
  tmpvar_11[1] = glstate_matrix_projection[1].xy;
  pixelSize_5 = (tmpvar_8.ww / (tmpvar_10 * abs(
    (tmpvar_11 * _ScreenParams.xy)
  )));
  scale_4 = (inversesqrt(dot (pixelSize_5, pixelSize_5)) * ((
    abs(_glesMultiTexCoord1.y)
   * _GradientScale) * 1.5));
  if ((glstate_matrix_projection[3].w == 0.0)) {
    highp mat3 tmpvar_12;
    tmpvar_12[0] = unity_WorldToObject[0].xyz;
    tmpvar_12[1] = unity_WorldToObject[1].xyz;
    tmpvar_12[2] = unity_WorldToObject[2].xyz;
    scale_4 = mix ((abs(scale_4) * (1.0 - _PerspectiveFilter)), scale_4, abs(dot (
      normalize((_glesNormal * tmpvar_12))
    , 
      normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_6).xyz))
    )));
  };
  weight_3 = (((
    (mix (_WeightNormal, _WeightBold, tmpvar_7) / 4.0)
   + _FaceDilate) * _ScaleRatioA) * 0.5);
  highp vec4 tmpvar_13;
  tmpvar_13 = clamp (_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10), vec4(2e+10, 2e+10, 2e+10, 2e+10));
  highp vec2 tmpvar_14;
  highp vec2 xlat_varoutput_15;
  xlat_varoutput_15.x = floor((_glesMultiTexCoord1.x / 4096.0));
  xlat_varoutput_15.y = (_glesMultiTexCoord1.x - (4096.0 * xlat_varoutput_15.x));
  tmpvar_14 = (xlat_varoutput_15 * 0.001953125);
  highp vec4 tmpvar_16;
  tmpvar_16.x = (((
    ((1.0 - (_OutlineWidth * _ScaleRatioA)) - (_OutlineSoftness * _ScaleRatioA))
   / 2.0) - (0.5 / scale_4)) - weight_3);
  tmpvar_16.y = scale_4;
  tmpvar_16.z = ((0.5 - weight_3) + (0.5 / scale_4));
  tmpvar_16.w = weight_3;
  highp vec2 tmpvar_17;
  tmpvar_17.x = _MaskSoftnessX;
  tmpvar_17.y = _MaskSoftnessY;
  highp vec4 tmpvar_18;
  tmpvar_18.xy = (((vert_6.xy * 2.0) - tmpvar_13.xy) - tmpvar_13.zw);
  tmpvar_18.zw = (0.25 / ((0.25 * tmpvar_17) + pixelSize_5));
  highp mat3 tmpvar_19;
  tmpvar_19[0] = _EnvMatrix[0].xyz;
  tmpvar_19[1] = _EnvMatrix[1].xyz;
  tmpvar_19[2] = _EnvMatrix[2].xyz;
  highp vec4 tmpvar_20;
  tmpvar_20.xy = ((tmpvar_14 * _FaceTex_ST.xy) + _FaceTex_ST.zw);
  tmpvar_20.zw = ((tmpvar_14 * _OutlineTex_ST.xy) + _OutlineTex_ST.zw);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = (tmpvar_19 * (_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_6).xyz));
  xlv_TEXCOORD5 = tmpvar_20;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _FaceTex;
uniform highp float _FaceUVSpeedX;
uniform highp float _FaceUVSpeedY;
uniform lowp vec4 _FaceColor;
uniform highp float _OutlineSoftness;
uniform sampler2D _OutlineTex;
uniform highp float _OutlineUVSpeedX;
uniform highp float _OutlineUVSpeedY;
uniform lowp vec4 _OutlineColor;
uniform highp float _OutlineWidth;
uniform highp float _ScaleRatioA;
uniform highp vec4 _ClipRect;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 outlineColor_2;
  mediump vec4 faceColor_3;
  highp float c_4;
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  c_4 = tmpvar_5;
  highp float x_6;
  x_6 = (c_4 - xlv_TEXCOORD1.x);
  if ((x_6 < 0.0)) {
    discard;
  };
  highp float tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD1.z - c_4) * xlv_TEXCOORD1.y);
  highp float tmpvar_8;
  tmpvar_8 = ((_OutlineWidth * _ScaleRatioA) * xlv_TEXCOORD1.y);
  highp float tmpvar_9;
  tmpvar_9 = ((_OutlineSoftness * _ScaleRatioA) * xlv_TEXCOORD1.y);
  faceColor_3 = _FaceColor;
  outlineColor_2 = _OutlineColor;
  faceColor_3.xyz = (faceColor_3.xyz * xlv_COLOR.xyz);
  highp vec2 tmpvar_10;
  tmpvar_10.x = _FaceUVSpeedX;
  tmpvar_10.y = _FaceUVSpeedY;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD5.xy + (tmpvar_10 * _Time.y));
  tmpvar_11 = texture2D (_FaceTex, P_12);
  faceColor_3 = (faceColor_3 * tmpvar_11);
  highp vec2 tmpvar_13;
  tmpvar_13.x = _OutlineUVSpeedX;
  tmpvar_13.y = _OutlineUVSpeedY;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD5.zw + (tmpvar_13 * _Time.y));
  tmpvar_14 = texture2D (_OutlineTex, P_15);
  outlineColor_2 = (outlineColor_2 * tmpvar_14);
  mediump float d_16;
  d_16 = tmpvar_7;
  lowp vec4 faceColor_17;
  faceColor_17 = faceColor_3;
  lowp vec4 outlineColor_18;
  outlineColor_18 = outlineColor_2;
  mediump float outline_19;
  outline_19 = tmpvar_8;
  mediump float softness_20;
  softness_20 = tmpvar_9;
  mediump float tmpvar_21;
  tmpvar_21 = (1.0 - clamp ((
    ((d_16 - (outline_19 * 0.5)) + (softness_20 * 0.5))
   / 
    (1.0 + softness_20)
  ), 0.0, 1.0));
  faceColor_17.xyz = (faceColor_17.xyz * faceColor_17.w);
  outlineColor_18.xyz = (outlineColor_18.xyz * outlineColor_18.w);
  mediump vec4 tmpvar_22;
  tmpvar_22 = mix (faceColor_17, outlineColor_18, vec4((clamp (
    (d_16 + (outline_19 * 0.5))
  , 0.0, 1.0) * sqrt(
    min (1.0, outline_19)
  ))));
  faceColor_17 = tmpvar_22;
  faceColor_17 = (faceColor_17 * tmpvar_21);
  faceColor_3 = faceColor_17;
  mediump vec2 tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = clamp (((
    (_ClipRect.zw - _ClipRect.xy)
   - 
    abs(xlv_TEXCOORD2.xy)
  ) * xlv_TEXCOORD2.zw), 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  faceColor_3 = (faceColor_3 * (tmpvar_23.x * tmpvar_23.y));
  tmpvar_1 = (faceColor_3 * xlv_COLOR.w);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_CLIP_RECT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixVP;
uniform highp float _FaceDilate;
uniform highp float _OutlineSoftness;
uniform highp float _OutlineWidth;
uniform highp mat4 _EnvMatrix;
uniform highp float _WeightNormal;
uniform highp float _WeightBold;
uniform highp float _ScaleRatioA;
uniform highp float _VertexOffsetX;
uniform highp float _VertexOffsetY;
uniform highp vec4 _ClipRect;
uniform highp float _MaskSoftnessX;
uniform highp float _MaskSoftnessY;
uniform highp float _GradientScale;
uniform highp float _ScaleX;
uniform highp float _ScaleY;
uniform highp float _PerspectiveFilter;
uniform highp vec4 _FaceTex_ST;
uniform highp vec4 _OutlineTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp float weight_3;
  highp float scale_4;
  highp vec2 pixelSize_5;
  highp vec4 vert_6;
  highp float tmpvar_7;
  tmpvar_7 = float((0.0 >= _glesMultiTexCoord1.y));
  vert_6.zw = _glesVertex.zw;
  vert_6.x = (_glesVertex.x + _VertexOffsetX);
  vert_6.y = (_glesVertex.y + _VertexOffsetY);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = vert_6.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp vec2 tmpvar_10;
  tmpvar_10.x = _ScaleX;
  tmpvar_10.y = _ScaleY;
  highp mat2 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_projection[0].xy;
  tmpvar_11[1] = glstate_matrix_projection[1].xy;
  pixelSize_5 = (tmpvar_8.ww / (tmpvar_10 * abs(
    (tmpvar_11 * _ScreenParams.xy)
  )));
  scale_4 = (inversesqrt(dot (pixelSize_5, pixelSize_5)) * ((
    abs(_glesMultiTexCoord1.y)
   * _GradientScale) * 1.5));
  if ((glstate_matrix_projection[3].w == 0.0)) {
    highp mat3 tmpvar_12;
    tmpvar_12[0] = unity_WorldToObject[0].xyz;
    tmpvar_12[1] = unity_WorldToObject[1].xyz;
    tmpvar_12[2] = unity_WorldToObject[2].xyz;
    scale_4 = mix ((abs(scale_4) * (1.0 - _PerspectiveFilter)), scale_4, abs(dot (
      normalize((_glesNormal * tmpvar_12))
    , 
      normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_6).xyz))
    )));
  };
  weight_3 = (((
    (mix (_WeightNormal, _WeightBold, tmpvar_7) / 4.0)
   + _FaceDilate) * _ScaleRatioA) * 0.5);
  highp vec4 tmpvar_13;
  tmpvar_13 = clamp (_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10), vec4(2e+10, 2e+10, 2e+10, 2e+10));
  highp vec2 tmpvar_14;
  highp vec2 xlat_varoutput_15;
  xlat_varoutput_15.x = floor((_glesMultiTexCoord1.x / 4096.0));
  xlat_varoutput_15.y = (_glesMultiTexCoord1.x - (4096.0 * xlat_varoutput_15.x));
  tmpvar_14 = (xlat_varoutput_15 * 0.001953125);
  highp vec4 tmpvar_16;
  tmpvar_16.x = (((
    ((1.0 - (_OutlineWidth * _ScaleRatioA)) - (_OutlineSoftness * _ScaleRatioA))
   / 2.0) - (0.5 / scale_4)) - weight_3);
  tmpvar_16.y = scale_4;
  tmpvar_16.z = ((0.5 - weight_3) + (0.5 / scale_4));
  tmpvar_16.w = weight_3;
  highp vec2 tmpvar_17;
  tmpvar_17.x = _MaskSoftnessX;
  tmpvar_17.y = _MaskSoftnessY;
  highp vec4 tmpvar_18;
  tmpvar_18.xy = (((vert_6.xy * 2.0) - tmpvar_13.xy) - tmpvar_13.zw);
  tmpvar_18.zw = (0.25 / ((0.25 * tmpvar_17) + pixelSize_5));
  highp mat3 tmpvar_19;
  tmpvar_19[0] = _EnvMatrix[0].xyz;
  tmpvar_19[1] = _EnvMatrix[1].xyz;
  tmpvar_19[2] = _EnvMatrix[2].xyz;
  highp vec4 tmpvar_20;
  tmpvar_20.xy = ((tmpvar_14 * _FaceTex_ST.xy) + _FaceTex_ST.zw);
  tmpvar_20.zw = ((tmpvar_14 * _OutlineTex_ST.xy) + _OutlineTex_ST.zw);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = (tmpvar_19 * (_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_6).xyz));
  xlv_TEXCOORD5 = tmpvar_20;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _FaceTex;
uniform highp float _FaceUVSpeedX;
uniform highp float _FaceUVSpeedY;
uniform lowp vec4 _FaceColor;
uniform highp float _OutlineSoftness;
uniform sampler2D _OutlineTex;
uniform highp float _OutlineUVSpeedX;
uniform highp float _OutlineUVSpeedY;
uniform lowp vec4 _OutlineColor;
uniform highp float _OutlineWidth;
uniform highp float _ScaleRatioA;
uniform highp vec4 _ClipRect;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 outlineColor_2;
  mediump vec4 faceColor_3;
  highp float c_4;
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  c_4 = tmpvar_5;
  highp float x_6;
  x_6 = (c_4 - xlv_TEXCOORD1.x);
  if ((x_6 < 0.0)) {
    discard;
  };
  highp float tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD1.z - c_4) * xlv_TEXCOORD1.y);
  highp float tmpvar_8;
  tmpvar_8 = ((_OutlineWidth * _ScaleRatioA) * xlv_TEXCOORD1.y);
  highp float tmpvar_9;
  tmpvar_9 = ((_OutlineSoftness * _ScaleRatioA) * xlv_TEXCOORD1.y);
  faceColor_3 = _FaceColor;
  outlineColor_2 = _OutlineColor;
  faceColor_3.xyz = (faceColor_3.xyz * xlv_COLOR.xyz);
  highp vec2 tmpvar_10;
  tmpvar_10.x = _FaceUVSpeedX;
  tmpvar_10.y = _FaceUVSpeedY;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD5.xy + (tmpvar_10 * _Time.y));
  tmpvar_11 = texture2D (_FaceTex, P_12);
  faceColor_3 = (faceColor_3 * tmpvar_11);
  highp vec2 tmpvar_13;
  tmpvar_13.x = _OutlineUVSpeedX;
  tmpvar_13.y = _OutlineUVSpeedY;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD5.zw + (tmpvar_13 * _Time.y));
  tmpvar_14 = texture2D (_OutlineTex, P_15);
  outlineColor_2 = (outlineColor_2 * tmpvar_14);
  mediump float d_16;
  d_16 = tmpvar_7;
  lowp vec4 faceColor_17;
  faceColor_17 = faceColor_3;
  lowp vec4 outlineColor_18;
  outlineColor_18 = outlineColor_2;
  mediump float outline_19;
  outline_19 = tmpvar_8;
  mediump float softness_20;
  softness_20 = tmpvar_9;
  mediump float tmpvar_21;
  tmpvar_21 = (1.0 - clamp ((
    ((d_16 - (outline_19 * 0.5)) + (softness_20 * 0.5))
   / 
    (1.0 + softness_20)
  ), 0.0, 1.0));
  faceColor_17.xyz = (faceColor_17.xyz * faceColor_17.w);
  outlineColor_18.xyz = (outlineColor_18.xyz * outlineColor_18.w);
  mediump vec4 tmpvar_22;
  tmpvar_22 = mix (faceColor_17, outlineColor_18, vec4((clamp (
    (d_16 + (outline_19 * 0.5))
  , 0.0, 1.0) * sqrt(
    min (1.0, outline_19)
  ))));
  faceColor_17 = tmpvar_22;
  faceColor_17 = (faceColor_17 * tmpvar_21);
  faceColor_3 = faceColor_17;
  mediump vec2 tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = clamp (((
    (_ClipRect.zw - _ClipRect.xy)
   - 
    abs(xlv_TEXCOORD2.xy)
  ) * xlv_TEXCOORD2.zw), 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  faceColor_3 = (faceColor_3 * (tmpvar_23.x * tmpvar_23.y));
  tmpvar_1 = (faceColor_3 * xlv_COLOR.w);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_CLIP_RECT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixVP;
uniform highp float _FaceDilate;
uniform highp float _OutlineSoftness;
uniform highp float _OutlineWidth;
uniform highp mat4 _EnvMatrix;
uniform highp float _WeightNormal;
uniform highp float _WeightBold;
uniform highp float _ScaleRatioA;
uniform highp float _VertexOffsetX;
uniform highp float _VertexOffsetY;
uniform highp vec4 _ClipRect;
uniform highp float _MaskSoftnessX;
uniform highp float _MaskSoftnessY;
uniform highp float _GradientScale;
uniform highp float _ScaleX;
uniform highp float _ScaleY;
uniform highp float _PerspectiveFilter;
uniform highp vec4 _FaceTex_ST;
uniform highp vec4 _OutlineTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp float weight_3;
  highp float scale_4;
  highp vec2 pixelSize_5;
  highp vec4 vert_6;
  highp float tmpvar_7;
  tmpvar_7 = float((0.0 >= _glesMultiTexCoord1.y));
  vert_6.zw = _glesVertex.zw;
  vert_6.x = (_glesVertex.x + _VertexOffsetX);
  vert_6.y = (_glesVertex.y + _VertexOffsetY);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = vert_6.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp vec2 tmpvar_10;
  tmpvar_10.x = _ScaleX;
  tmpvar_10.y = _ScaleY;
  highp mat2 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_projection[0].xy;
  tmpvar_11[1] = glstate_matrix_projection[1].xy;
  pixelSize_5 = (tmpvar_8.ww / (tmpvar_10 * abs(
    (tmpvar_11 * _ScreenParams.xy)
  )));
  scale_4 = (inversesqrt(dot (pixelSize_5, pixelSize_5)) * ((
    abs(_glesMultiTexCoord1.y)
   * _GradientScale) * 1.5));
  if ((glstate_matrix_projection[3].w == 0.0)) {
    highp mat3 tmpvar_12;
    tmpvar_12[0] = unity_WorldToObject[0].xyz;
    tmpvar_12[1] = unity_WorldToObject[1].xyz;
    tmpvar_12[2] = unity_WorldToObject[2].xyz;
    scale_4 = mix ((abs(scale_4) * (1.0 - _PerspectiveFilter)), scale_4, abs(dot (
      normalize((_glesNormal * tmpvar_12))
    , 
      normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_6).xyz))
    )));
  };
  weight_3 = (((
    (mix (_WeightNormal, _WeightBold, tmpvar_7) / 4.0)
   + _FaceDilate) * _ScaleRatioA) * 0.5);
  highp vec4 tmpvar_13;
  tmpvar_13 = clamp (_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10), vec4(2e+10, 2e+10, 2e+10, 2e+10));
  highp vec2 tmpvar_14;
  highp vec2 xlat_varoutput_15;
  xlat_varoutput_15.x = floor((_glesMultiTexCoord1.x / 4096.0));
  xlat_varoutput_15.y = (_glesMultiTexCoord1.x - (4096.0 * xlat_varoutput_15.x));
  tmpvar_14 = (xlat_varoutput_15 * 0.001953125);
  highp vec4 tmpvar_16;
  tmpvar_16.x = (((
    ((1.0 - (_OutlineWidth * _ScaleRatioA)) - (_OutlineSoftness * _ScaleRatioA))
   / 2.0) - (0.5 / scale_4)) - weight_3);
  tmpvar_16.y = scale_4;
  tmpvar_16.z = ((0.5 - weight_3) + (0.5 / scale_4));
  tmpvar_16.w = weight_3;
  highp vec2 tmpvar_17;
  tmpvar_17.x = _MaskSoftnessX;
  tmpvar_17.y = _MaskSoftnessY;
  highp vec4 tmpvar_18;
  tmpvar_18.xy = (((vert_6.xy * 2.0) - tmpvar_13.xy) - tmpvar_13.zw);
  tmpvar_18.zw = (0.25 / ((0.25 * tmpvar_17) + pixelSize_5));
  highp mat3 tmpvar_19;
  tmpvar_19[0] = _EnvMatrix[0].xyz;
  tmpvar_19[1] = _EnvMatrix[1].xyz;
  tmpvar_19[2] = _EnvMatrix[2].xyz;
  highp vec4 tmpvar_20;
  tmpvar_20.xy = ((tmpvar_14 * _FaceTex_ST.xy) + _FaceTex_ST.zw);
  tmpvar_20.zw = ((tmpvar_14 * _OutlineTex_ST.xy) + _OutlineTex_ST.zw);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = (tmpvar_19 * (_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_6).xyz));
  xlv_TEXCOORD5 = tmpvar_20;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _FaceTex;
uniform highp float _FaceUVSpeedX;
uniform highp float _FaceUVSpeedY;
uniform lowp vec4 _FaceColor;
uniform highp float _OutlineSoftness;
uniform sampler2D _OutlineTex;
uniform highp float _OutlineUVSpeedX;
uniform highp float _OutlineUVSpeedY;
uniform lowp vec4 _OutlineColor;
uniform highp float _OutlineWidth;
uniform highp float _ScaleRatioA;
uniform highp vec4 _ClipRect;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 outlineColor_2;
  mediump vec4 faceColor_3;
  highp float c_4;
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  c_4 = tmpvar_5;
  highp float x_6;
  x_6 = (c_4 - xlv_TEXCOORD1.x);
  if ((x_6 < 0.0)) {
    discard;
  };
  highp float tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD1.z - c_4) * xlv_TEXCOORD1.y);
  highp float tmpvar_8;
  tmpvar_8 = ((_OutlineWidth * _ScaleRatioA) * xlv_TEXCOORD1.y);
  highp float tmpvar_9;
  tmpvar_9 = ((_OutlineSoftness * _ScaleRatioA) * xlv_TEXCOORD1.y);
  faceColor_3 = _FaceColor;
  outlineColor_2 = _OutlineColor;
  faceColor_3.xyz = (faceColor_3.xyz * xlv_COLOR.xyz);
  highp vec2 tmpvar_10;
  tmpvar_10.x = _FaceUVSpeedX;
  tmpvar_10.y = _FaceUVSpeedY;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD5.xy + (tmpvar_10 * _Time.y));
  tmpvar_11 = texture2D (_FaceTex, P_12);
  faceColor_3 = (faceColor_3 * tmpvar_11);
  highp vec2 tmpvar_13;
  tmpvar_13.x = _OutlineUVSpeedX;
  tmpvar_13.y = _OutlineUVSpeedY;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD5.zw + (tmpvar_13 * _Time.y));
  tmpvar_14 = texture2D (_OutlineTex, P_15);
  outlineColor_2 = (outlineColor_2 * tmpvar_14);
  mediump float d_16;
  d_16 = tmpvar_7;
  lowp vec4 faceColor_17;
  faceColor_17 = faceColor_3;
  lowp vec4 outlineColor_18;
  outlineColor_18 = outlineColor_2;
  mediump float outline_19;
  outline_19 = tmpvar_8;
  mediump float softness_20;
  softness_20 = tmpvar_9;
  mediump float tmpvar_21;
  tmpvar_21 = (1.0 - clamp ((
    ((d_16 - (outline_19 * 0.5)) + (softness_20 * 0.5))
   / 
    (1.0 + softness_20)
  ), 0.0, 1.0));
  faceColor_17.xyz = (faceColor_17.xyz * faceColor_17.w);
  outlineColor_18.xyz = (outlineColor_18.xyz * outlineColor_18.w);
  mediump vec4 tmpvar_22;
  tmpvar_22 = mix (faceColor_17, outlineColor_18, vec4((clamp (
    (d_16 + (outline_19 * 0.5))
  , 0.0, 1.0) * sqrt(
    min (1.0, outline_19)
  ))));
  faceColor_17 = tmpvar_22;
  faceColor_17 = (faceColor_17 * tmpvar_21);
  faceColor_3 = faceColor_17;
  mediump vec2 tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = clamp (((
    (_ClipRect.zw - _ClipRect.xy)
   - 
    abs(xlv_TEXCOORD2.xy)
  ) * xlv_TEXCOORD2.zw), 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  faceColor_3 = (faceColor_3 * (tmpvar_23.x * tmpvar_23.y));
  tmpvar_1 = (faceColor_3 * xlv_COLOR.w);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _FaceDilate;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineWidth;
uniform 	vec4 hlslcc_mtx4x4_EnvMatrix[4];
uniform 	float _WeightNormal;
uniform 	float _WeightBold;
uniform 	float _ScaleRatioA;
uniform 	float _VertexOffsetX;
uniform 	float _VertexOffsetY;
uniform 	vec4 _ClipRect;
uniform 	float _MaskSoftnessX;
uniform 	float _MaskSoftnessY;
uniform 	float _GradientScale;
uniform 	float _ScaleX;
uniform 	float _ScaleY;
uniform 	float _PerspectiveFilter;
uniform 	vec4 _FaceTex_ST;
uniform 	vec4 _OutlineTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat6;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0.xy = vec2(in_POSITION0.x + float(_VertexOffsetX), in_POSITION0.y + float(_VertexOffsetY));
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat2.xyz = u_xlat8.xxx * u_xlat2.xyz;
    u_xlat8.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat2.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat2.xy;
    u_xlat2.xy = vec2(abs(u_xlat2.x) * float(_ScaleX), abs(u_xlat2.y) * float(_ScaleY));
    u_xlat2.xy = u_xlat2.ww / u_xlat2.xy;
    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat2.xy;
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat2.xy;
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat13 = abs(in_TEXCOORD1.y) * _GradientScale;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * 1.5;
    u_xlat2.x = (-_PerspectiveFilter) + 1.0;
    u_xlat2.x = abs(u_xlat13) * u_xlat2.x;
    u_xlat12 = u_xlat12 * 1.5 + (-u_xlat2.x);
    u_xlat8.x = abs(u_xlat8.x) * u_xlat12 + u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0);
#else
    u_xlatb12 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
#endif
    u_xlat6.x = (u_xlatb12) ? u_xlat8.x : u_xlat13;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.0>=in_TEXCOORD1.y);
#else
    u_xlatb8 = 0.0>=in_TEXCOORD1.y;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat12 = (-_WeightNormal) + _WeightBold;
    u_xlat8.x = u_xlat8.x * u_xlat12 + _WeightNormal;
    u_xlat8.x = u_xlat8.x * 0.25 + _FaceDilate;
    u_xlat8.x = u_xlat8.x * _ScaleRatioA;
    u_xlat6.z = u_xlat8.x * 0.5;
    vs_TEXCOORD1.yw = u_xlat6.xz;
    u_xlat12 = 0.5 / u_xlat6.x;
    u_xlat13 = (-_OutlineWidth) * _ScaleRatioA + 1.0;
    u_xlat13 = (-_OutlineSoftness) * _ScaleRatioA + u_xlat13;
    u_xlat13 = u_xlat13 * 0.5 + (-u_xlat12);
    vs_TEXCOORD1.x = (-u_xlat8.x) * 0.5 + u_xlat13;
    u_xlat8.x = (-u_xlat8.x) * 0.5 + 0.5;
    vs_TEXCOORD1.z = u_xlat12 + u_xlat8.x;
    u_xlat2 = max(_ClipRect, vec4(-2e+010, -2e+010, -2e+010, -2e+010));
    u_xlat2 = min(u_xlat2, vec4(2e+010, 2e+010, 2e+010, 2e+010));
    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat2.xy);
    vs_TEXCOORD2.xy = vec2((-u_xlat2.z) + u_xlat0.x, (-u_xlat2.w) + u_xlat0.y);
    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4x4_EnvMatrix[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_EnvMatrix[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4_EnvMatrix[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x * 0.000244140625;
    u_xlat8.x = floor(u_xlat0.x);
    u_xlat8.y = (-u_xlat8.x) * 4096.0 + in_TEXCOORD1.x;
    u_xlat0.xy = u_xlat8.xy * vec2(0.001953125, 0.001953125);
    vs_TEXCOORD5.xy = u_xlat0.xy * _FaceTex_ST.xy + _FaceTex_ST.zw;
    vs_TEXCOORD5.zw = u_xlat0.xy * _OutlineTex_ST.xy + _OutlineTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _FaceUVSpeedX;
uniform 	float _FaceUVSpeedY;
uniform 	mediump vec4 _FaceColor;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineUVSpeedX;
uniform 	float _OutlineUVSpeedY;
uniform 	mediump vec4 _OutlineColor;
uniform 	float _OutlineWidth;
uniform 	float _ScaleRatioA;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FaceTex;
uniform lowp sampler2D _OutlineTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
lowp vec4 u_xlat10_4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_6;
float u_xlat9;
mediump float u_xlat16_11;
void main()
{
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat5 = u_xlat10_0.x + (-vs_TEXCOORD1.x);
    u_xlat0.x = (-u_xlat10_0.x) + vs_TEXCOORD1.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5<0.0);
#else
    u_xlatb5 = u_xlat5<0.0;
#endif
    if((int(u_xlatb5) * int(0xffffffffu))!=0){discard;}
    u_xlat5 = _OutlineWidth * _ScaleRatioA;
    u_xlat5 = u_xlat5 * vs_TEXCOORD1.y;
    u_xlat16_1 = min(u_xlat5, 1.0);
    u_xlat16_6 = u_xlat5 * 0.5;
    u_xlat16_1 = sqrt(u_xlat16_1);
    u_xlat16_11 = u_xlat0.x * vs_TEXCOORD1.y + u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat0.x * vs_TEXCOORD1.y + (-u_xlat16_6);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_11;
    u_xlat0.xy = vec2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy + vs_TEXCOORD5.zw;
    u_xlat10_0 = texture(_OutlineTex, u_xlat0.xy);
    u_xlat16_2 = u_xlat10_0 * _OutlineColor;
    u_xlat16_3.xyz = vs_COLOR0.xyz * _FaceColor.xyz;
    u_xlat0.xy = vec2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy + vs_TEXCOORD5.xy;
    u_xlat10_4 = texture(_FaceTex, u_xlat0.xy);
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat10_4.xyz;
    u_xlat16_4 = u_xlat10_4.w * _FaceColor.w;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vec3(u_xlat16_4);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_2.www + (-u_xlat16_3.xyz);
    u_xlat16_2.w = _OutlineColor.w * u_xlat10_0.w + (-u_xlat16_4);
    u_xlat16_2 = vec4(u_xlat16_1) * u_xlat16_2;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_4) + u_xlat16_2.xyz;
    u_xlat16_0.w = _FaceColor.w * u_xlat10_4.w + u_xlat16_2.w;
    u_xlat4.x = _OutlineSoftness * _ScaleRatioA;
    u_xlat9 = u_xlat4.x * vs_TEXCOORD1.y;
    u_xlat16_1 = u_xlat4.x * vs_TEXCOORD1.y + 1.0;
    u_xlat16_6 = u_xlat9 * 0.5 + u_xlat16_6;
    u_xlat16_1 = u_xlat16_6 / u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_0 = u_xlat16_0 * vec4(u_xlat16_1);
    u_xlat4.xy = vec2((-_ClipRect.x) + _ClipRect.z, (-_ClipRect.y) + _ClipRect.w);
    u_xlat4.xy = u_xlat4.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat4.xy = vec2(u_xlat4.x * vs_TEXCOORD2.z, u_xlat4.y * vs_TEXCOORD2.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat4.y * u_xlat4.x;
    u_xlat16_0 = u_xlat16_0 * vec4(u_xlat16_1);
    SV_Target0 = u_xlat16_0 * vs_COLOR0.wwww;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _FaceDilate;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineWidth;
uniform 	vec4 hlslcc_mtx4x4_EnvMatrix[4];
uniform 	float _WeightNormal;
uniform 	float _WeightBold;
uniform 	float _ScaleRatioA;
uniform 	float _VertexOffsetX;
uniform 	float _VertexOffsetY;
uniform 	vec4 _ClipRect;
uniform 	float _MaskSoftnessX;
uniform 	float _MaskSoftnessY;
uniform 	float _GradientScale;
uniform 	float _ScaleX;
uniform 	float _ScaleY;
uniform 	float _PerspectiveFilter;
uniform 	vec4 _FaceTex_ST;
uniform 	vec4 _OutlineTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat6;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0.xy = vec2(in_POSITION0.x + float(_VertexOffsetX), in_POSITION0.y + float(_VertexOffsetY));
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat2.xyz = u_xlat8.xxx * u_xlat2.xyz;
    u_xlat8.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat2.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat2.xy;
    u_xlat2.xy = vec2(abs(u_xlat2.x) * float(_ScaleX), abs(u_xlat2.y) * float(_ScaleY));
    u_xlat2.xy = u_xlat2.ww / u_xlat2.xy;
    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat2.xy;
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat2.xy;
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat13 = abs(in_TEXCOORD1.y) * _GradientScale;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * 1.5;
    u_xlat2.x = (-_PerspectiveFilter) + 1.0;
    u_xlat2.x = abs(u_xlat13) * u_xlat2.x;
    u_xlat12 = u_xlat12 * 1.5 + (-u_xlat2.x);
    u_xlat8.x = abs(u_xlat8.x) * u_xlat12 + u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0);
#else
    u_xlatb12 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
#endif
    u_xlat6.x = (u_xlatb12) ? u_xlat8.x : u_xlat13;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.0>=in_TEXCOORD1.y);
#else
    u_xlatb8 = 0.0>=in_TEXCOORD1.y;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat12 = (-_WeightNormal) + _WeightBold;
    u_xlat8.x = u_xlat8.x * u_xlat12 + _WeightNormal;
    u_xlat8.x = u_xlat8.x * 0.25 + _FaceDilate;
    u_xlat8.x = u_xlat8.x * _ScaleRatioA;
    u_xlat6.z = u_xlat8.x * 0.5;
    vs_TEXCOORD1.yw = u_xlat6.xz;
    u_xlat12 = 0.5 / u_xlat6.x;
    u_xlat13 = (-_OutlineWidth) * _ScaleRatioA + 1.0;
    u_xlat13 = (-_OutlineSoftness) * _ScaleRatioA + u_xlat13;
    u_xlat13 = u_xlat13 * 0.5 + (-u_xlat12);
    vs_TEXCOORD1.x = (-u_xlat8.x) * 0.5 + u_xlat13;
    u_xlat8.x = (-u_xlat8.x) * 0.5 + 0.5;
    vs_TEXCOORD1.z = u_xlat12 + u_xlat8.x;
    u_xlat2 = max(_ClipRect, vec4(-2e+010, -2e+010, -2e+010, -2e+010));
    u_xlat2 = min(u_xlat2, vec4(2e+010, 2e+010, 2e+010, 2e+010));
    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat2.xy);
    vs_TEXCOORD2.xy = vec2((-u_xlat2.z) + u_xlat0.x, (-u_xlat2.w) + u_xlat0.y);
    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4x4_EnvMatrix[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_EnvMatrix[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4_EnvMatrix[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x * 0.000244140625;
    u_xlat8.x = floor(u_xlat0.x);
    u_xlat8.y = (-u_xlat8.x) * 4096.0 + in_TEXCOORD1.x;
    u_xlat0.xy = u_xlat8.xy * vec2(0.001953125, 0.001953125);
    vs_TEXCOORD5.xy = u_xlat0.xy * _FaceTex_ST.xy + _FaceTex_ST.zw;
    vs_TEXCOORD5.zw = u_xlat0.xy * _OutlineTex_ST.xy + _OutlineTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _FaceUVSpeedX;
uniform 	float _FaceUVSpeedY;
uniform 	mediump vec4 _FaceColor;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineUVSpeedX;
uniform 	float _OutlineUVSpeedY;
uniform 	mediump vec4 _OutlineColor;
uniform 	float _OutlineWidth;
uniform 	float _ScaleRatioA;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FaceTex;
uniform lowp sampler2D _OutlineTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
lowp vec4 u_xlat10_4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_6;
float u_xlat9;
mediump float u_xlat16_11;
void main()
{
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat5 = u_xlat10_0.x + (-vs_TEXCOORD1.x);
    u_xlat0.x = (-u_xlat10_0.x) + vs_TEXCOORD1.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5<0.0);
#else
    u_xlatb5 = u_xlat5<0.0;
#endif
    if((int(u_xlatb5) * int(0xffffffffu))!=0){discard;}
    u_xlat5 = _OutlineWidth * _ScaleRatioA;
    u_xlat5 = u_xlat5 * vs_TEXCOORD1.y;
    u_xlat16_1 = min(u_xlat5, 1.0);
    u_xlat16_6 = u_xlat5 * 0.5;
    u_xlat16_1 = sqrt(u_xlat16_1);
    u_xlat16_11 = u_xlat0.x * vs_TEXCOORD1.y + u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat0.x * vs_TEXCOORD1.y + (-u_xlat16_6);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_11;
    u_xlat0.xy = vec2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy + vs_TEXCOORD5.zw;
    u_xlat10_0 = texture(_OutlineTex, u_xlat0.xy);
    u_xlat16_2 = u_xlat10_0 * _OutlineColor;
    u_xlat16_3.xyz = vs_COLOR0.xyz * _FaceColor.xyz;
    u_xlat0.xy = vec2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy + vs_TEXCOORD5.xy;
    u_xlat10_4 = texture(_FaceTex, u_xlat0.xy);
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat10_4.xyz;
    u_xlat16_4 = u_xlat10_4.w * _FaceColor.w;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vec3(u_xlat16_4);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_2.www + (-u_xlat16_3.xyz);
    u_xlat16_2.w = _OutlineColor.w * u_xlat10_0.w + (-u_xlat16_4);
    u_xlat16_2 = vec4(u_xlat16_1) * u_xlat16_2;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_4) + u_xlat16_2.xyz;
    u_xlat16_0.w = _FaceColor.w * u_xlat10_4.w + u_xlat16_2.w;
    u_xlat4.x = _OutlineSoftness * _ScaleRatioA;
    u_xlat9 = u_xlat4.x * vs_TEXCOORD1.y;
    u_xlat16_1 = u_xlat4.x * vs_TEXCOORD1.y + 1.0;
    u_xlat16_6 = u_xlat9 * 0.5 + u_xlat16_6;
    u_xlat16_1 = u_xlat16_6 / u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_0 = u_xlat16_0 * vec4(u_xlat16_1);
    u_xlat4.xy = vec2((-_ClipRect.x) + _ClipRect.z, (-_ClipRect.y) + _ClipRect.w);
    u_xlat4.xy = u_xlat4.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat4.xy = vec2(u_xlat4.x * vs_TEXCOORD2.z, u_xlat4.y * vs_TEXCOORD2.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat4.y * u_xlat4.x;
    u_xlat16_0 = u_xlat16_0 * vec4(u_xlat16_1);
    SV_Target0 = u_xlat16_0 * vs_COLOR0.wwww;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNITY_UI_CLIP_RECT" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _FaceDilate;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineWidth;
uniform 	vec4 hlslcc_mtx4x4_EnvMatrix[4];
uniform 	float _WeightNormal;
uniform 	float _WeightBold;
uniform 	float _ScaleRatioA;
uniform 	float _VertexOffsetX;
uniform 	float _VertexOffsetY;
uniform 	vec4 _ClipRect;
uniform 	float _MaskSoftnessX;
uniform 	float _MaskSoftnessY;
uniform 	float _GradientScale;
uniform 	float _ScaleX;
uniform 	float _ScaleY;
uniform 	float _PerspectiveFilter;
uniform 	vec4 _FaceTex_ST;
uniform 	vec4 _OutlineTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat6;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0.xy = vec2(in_POSITION0.x + float(_VertexOffsetX), in_POSITION0.y + float(_VertexOffsetY));
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat2.xyz = u_xlat8.xxx * u_xlat2.xyz;
    u_xlat8.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat2.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat2.xy;
    u_xlat2.xy = vec2(abs(u_xlat2.x) * float(_ScaleX), abs(u_xlat2.y) * float(_ScaleY));
    u_xlat2.xy = u_xlat2.ww / u_xlat2.xy;
    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat2.xy;
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat2.xy;
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat13 = abs(in_TEXCOORD1.y) * _GradientScale;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * 1.5;
    u_xlat2.x = (-_PerspectiveFilter) + 1.0;
    u_xlat2.x = abs(u_xlat13) * u_xlat2.x;
    u_xlat12 = u_xlat12 * 1.5 + (-u_xlat2.x);
    u_xlat8.x = abs(u_xlat8.x) * u_xlat12 + u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0);
#else
    u_xlatb12 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
#endif
    u_xlat6.x = (u_xlatb12) ? u_xlat8.x : u_xlat13;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.0>=in_TEXCOORD1.y);
#else
    u_xlatb8 = 0.0>=in_TEXCOORD1.y;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat12 = (-_WeightNormal) + _WeightBold;
    u_xlat8.x = u_xlat8.x * u_xlat12 + _WeightNormal;
    u_xlat8.x = u_xlat8.x * 0.25 + _FaceDilate;
    u_xlat8.x = u_xlat8.x * _ScaleRatioA;
    u_xlat6.z = u_xlat8.x * 0.5;
    vs_TEXCOORD1.yw = u_xlat6.xz;
    u_xlat12 = 0.5 / u_xlat6.x;
    u_xlat13 = (-_OutlineWidth) * _ScaleRatioA + 1.0;
    u_xlat13 = (-_OutlineSoftness) * _ScaleRatioA + u_xlat13;
    u_xlat13 = u_xlat13 * 0.5 + (-u_xlat12);
    vs_TEXCOORD1.x = (-u_xlat8.x) * 0.5 + u_xlat13;
    u_xlat8.x = (-u_xlat8.x) * 0.5 + 0.5;
    vs_TEXCOORD1.z = u_xlat12 + u_xlat8.x;
    u_xlat2 = max(_ClipRect, vec4(-2e+010, -2e+010, -2e+010, -2e+010));
    u_xlat2 = min(u_xlat2, vec4(2e+010, 2e+010, 2e+010, 2e+010));
    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat2.xy);
    vs_TEXCOORD2.xy = vec2((-u_xlat2.z) + u_xlat0.x, (-u_xlat2.w) + u_xlat0.y);
    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4x4_EnvMatrix[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_EnvMatrix[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4_EnvMatrix[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x * 0.000244140625;
    u_xlat8.x = floor(u_xlat0.x);
    u_xlat8.y = (-u_xlat8.x) * 4096.0 + in_TEXCOORD1.x;
    u_xlat0.xy = u_xlat8.xy * vec2(0.001953125, 0.001953125);
    vs_TEXCOORD5.xy = u_xlat0.xy * _FaceTex_ST.xy + _FaceTex_ST.zw;
    vs_TEXCOORD5.zw = u_xlat0.xy * _OutlineTex_ST.xy + _OutlineTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _FaceUVSpeedX;
uniform 	float _FaceUVSpeedY;
uniform 	mediump vec4 _FaceColor;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineUVSpeedX;
uniform 	float _OutlineUVSpeedY;
uniform 	mediump vec4 _OutlineColor;
uniform 	float _OutlineWidth;
uniform 	float _ScaleRatioA;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FaceTex;
uniform lowp sampler2D _OutlineTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
lowp vec4 u_xlat10_4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_6;
float u_xlat9;
mediump float u_xlat16_11;
void main()
{
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat5 = u_xlat10_0.x + (-vs_TEXCOORD1.x);
    u_xlat0.x = (-u_xlat10_0.x) + vs_TEXCOORD1.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5<0.0);
#else
    u_xlatb5 = u_xlat5<0.0;
#endif
    if((int(u_xlatb5) * int(0xffffffffu))!=0){discard;}
    u_xlat5 = _OutlineWidth * _ScaleRatioA;
    u_xlat5 = u_xlat5 * vs_TEXCOORD1.y;
    u_xlat16_1 = min(u_xlat5, 1.0);
    u_xlat16_6 = u_xlat5 * 0.5;
    u_xlat16_1 = sqrt(u_xlat16_1);
    u_xlat16_11 = u_xlat0.x * vs_TEXCOORD1.y + u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat0.x * vs_TEXCOORD1.y + (-u_xlat16_6);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_11;
    u_xlat0.xy = vec2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy + vs_TEXCOORD5.zw;
    u_xlat10_0 = texture(_OutlineTex, u_xlat0.xy);
    u_xlat16_2 = u_xlat10_0 * _OutlineColor;
    u_xlat16_3.xyz = vs_COLOR0.xyz * _FaceColor.xyz;
    u_xlat0.xy = vec2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy + vs_TEXCOORD5.xy;
    u_xlat10_4 = texture(_FaceTex, u_xlat0.xy);
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat10_4.xyz;
    u_xlat16_4 = u_xlat10_4.w * _FaceColor.w;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vec3(u_xlat16_4);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_2.www + (-u_xlat16_3.xyz);
    u_xlat16_2.w = _OutlineColor.w * u_xlat10_0.w + (-u_xlat16_4);
    u_xlat16_2 = vec4(u_xlat16_1) * u_xlat16_2;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_4) + u_xlat16_2.xyz;
    u_xlat16_0.w = _FaceColor.w * u_xlat10_4.w + u_xlat16_2.w;
    u_xlat4.x = _OutlineSoftness * _ScaleRatioA;
    u_xlat9 = u_xlat4.x * vs_TEXCOORD1.y;
    u_xlat16_1 = u_xlat4.x * vs_TEXCOORD1.y + 1.0;
    u_xlat16_6 = u_xlat9 * 0.5 + u_xlat16_6;
    u_xlat16_1 = u_xlat16_6 / u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_0 = u_xlat16_0 * vec4(u_xlat16_1);
    u_xlat4.xy = vec2((-_ClipRect.x) + _ClipRect.z, (-_ClipRect.y) + _ClipRect.w);
    u_xlat4.xy = u_xlat4.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat4.xy = vec2(u_xlat4.x * vs_TEXCOORD2.z, u_xlat4.y * vs_TEXCOORD2.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat4.y * u_xlat4.x;
    u_xlat16_0 = u_xlat16_0 * vec4(u_xlat16_1);
    SV_Target0 = u_xlat16_0 * vs_COLOR0.wwww;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixVP;
uniform highp float _FaceDilate;
uniform highp float _OutlineSoftness;
uniform highp float _OutlineWidth;
uniform highp mat4 _EnvMatrix;
uniform lowp vec4 _UnderlayColor;
uniform highp float _UnderlayOffsetX;
uniform highp float _UnderlayOffsetY;
uniform highp float _UnderlayDilate;
uniform highp float _UnderlaySoftness;
uniform highp float _GlowOffset;
uniform highp float _GlowOuter;
uniform highp float _WeightNormal;
uniform highp float _WeightBold;
uniform highp float _ScaleRatioA;
uniform highp float _ScaleRatioB;
uniform highp float _ScaleRatioC;
uniform highp float _VertexOffsetX;
uniform highp float _VertexOffsetY;
uniform highp vec4 _ClipRect;
uniform highp float _MaskSoftnessX;
uniform highp float _MaskSoftnessY;
uniform highp float _TextureWidth;
uniform highp float _TextureHeight;
uniform highp float _GradientScale;
uniform highp float _ScaleX;
uniform highp float _ScaleY;
uniform highp float _PerspectiveFilter;
uniform highp vec4 _FaceTex_ST;
uniform highp vec4 _OutlineTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp float bScale_3;
  highp vec4 underlayColor_4;
  highp float weight_5;
  highp float scale_6;
  highp vec2 pixelSize_7;
  highp vec4 vert_8;
  highp float tmpvar_9;
  tmpvar_9 = float((0.0 >= _glesMultiTexCoord1.y));
  vert_8.zw = _glesVertex.zw;
  vert_8.x = (_glesVertex.x + _VertexOffsetX);
  vert_8.y = (_glesVertex.y + _VertexOffsetY);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = vert_8.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec2 tmpvar_12;
  tmpvar_12.x = _ScaleX;
  tmpvar_12.y = _ScaleY;
  highp mat2 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_projection[0].xy;
  tmpvar_13[1] = glstate_matrix_projection[1].xy;
  pixelSize_7 = (tmpvar_10.ww / (tmpvar_12 * abs(
    (tmpvar_13 * _ScreenParams.xy)
  )));
  scale_6 = (inversesqrt(dot (pixelSize_7, pixelSize_7)) * ((
    abs(_glesMultiTexCoord1.y)
   * _GradientScale) * 1.5));
  if ((glstate_matrix_projection[3].w == 0.0)) {
    highp mat3 tmpvar_14;
    tmpvar_14[0] = unity_WorldToObject[0].xyz;
    tmpvar_14[1] = unity_WorldToObject[1].xyz;
    tmpvar_14[2] = unity_WorldToObject[2].xyz;
    scale_6 = mix ((abs(scale_6) * (1.0 - _PerspectiveFilter)), scale_6, abs(dot (
      normalize((_glesNormal * tmpvar_14))
    , 
      normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_8).xyz))
    )));
  };
  weight_5 = (((
    (mix (_WeightNormal, _WeightBold, tmpvar_9) / 4.0)
   + _FaceDilate) * _ScaleRatioA) * 0.5);
  underlayColor_4 = _UnderlayColor;
  underlayColor_4.xyz = (underlayColor_4.xyz * underlayColor_4.w);
  bScale_3 = (scale_6 / (1.0 + (
    (_UnderlaySoftness * _ScaleRatioC)
   * scale_6)));
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((-(
    (_UnderlayOffsetX * _ScaleRatioC)
  ) * _GradientScale) / _TextureWidth);
  tmpvar_15.y = ((-(
    (_UnderlayOffsetY * _ScaleRatioC)
  ) * _GradientScale) / _TextureHeight);
  highp vec4 tmpvar_16;
  tmpvar_16 = clamp (_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10), vec4(2e+10, 2e+10, 2e+10, 2e+10));
  highp vec2 tmpvar_17;
  highp vec2 xlat_varoutput_18;
  xlat_varoutput_18.x = floor((_glesMultiTexCoord1.x / 4096.0));
  xlat_varoutput_18.y = (_glesMultiTexCoord1.x - (4096.0 * xlat_varoutput_18.x));
  tmpvar_17 = (xlat_varoutput_18 * 0.001953125);
  highp vec4 tmpvar_19;
  tmpvar_19.x = (((
    min (((1.0 - (_OutlineWidth * _ScaleRatioA)) - (_OutlineSoftness * _ScaleRatioA)), ((1.0 - (_GlowOffset * _ScaleRatioB)) - (_GlowOuter * _ScaleRatioB)))
   / 2.0) - (0.5 / scale_6)) - weight_5);
  tmpvar_19.y = scale_6;
  tmpvar_19.z = ((0.5 - weight_5) + (0.5 / scale_6));
  tmpvar_19.w = weight_5;
  highp vec2 tmpvar_20;
  tmpvar_20.x = _MaskSoftnessX;
  tmpvar_20.y = _MaskSoftnessY;
  highp vec4 tmpvar_21;
  tmpvar_21.xy = (((vert_8.xy * 2.0) - tmpvar_16.xy) - tmpvar_16.zw);
  tmpvar_21.zw = (0.25 / ((0.25 * tmpvar_20) + pixelSize_7));
  highp mat3 tmpvar_22;
  tmpvar_22[0] = _EnvMatrix[0].xyz;
  tmpvar_22[1] = _EnvMatrix[1].xyz;
  tmpvar_22[2] = _EnvMatrix[2].xyz;
  highp vec4 tmpvar_23;
  tmpvar_23.xy = (_glesMultiTexCoord0.xy + tmpvar_15);
  tmpvar_23.z = bScale_3;
  tmpvar_23.w = (((
    (0.5 - weight_5)
   * bScale_3) - 0.5) - ((_UnderlayDilate * _ScaleRatioC) * (0.5 * bScale_3)));
  highp vec4 tmpvar_24;
  tmpvar_24.xy = ((tmpvar_17 * _FaceTex_ST.xy) + _FaceTex_ST.zw);
  tmpvar_24.zw = ((tmpvar_17 * _OutlineTex_ST.xy) + _OutlineTex_ST.zw);
  lowp vec4 tmpvar_25;
  tmpvar_25 = underlayColor_4;
  gl_Position = tmpvar_10;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_19;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = (tmpvar_22 * (_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_8).xyz));
  xlv_TEXCOORD4 = tmpvar_23;
  xlv_COLOR1 = tmpvar_25;
  xlv_TEXCOORD5 = tmpvar_24;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _FaceTex;
uniform highp float _FaceUVSpeedX;
uniform highp float _FaceUVSpeedY;
uniform lowp vec4 _FaceColor;
uniform highp float _OutlineSoftness;
uniform sampler2D _OutlineTex;
uniform highp float _OutlineUVSpeedX;
uniform highp float _OutlineUVSpeedY;
uniform lowp vec4 _OutlineColor;
uniform highp float _OutlineWidth;
uniform highp float _Bevel;
uniform highp float _BevelOffset;
uniform highp float _BevelWidth;
uniform highp float _BevelClamp;
uniform highp float _BevelRoundness;
uniform sampler2D _BumpMap;
uniform highp float _BumpOutline;
uniform highp float _BumpFace;
uniform lowp samplerCube _Cube;
uniform lowp vec4 _ReflectFaceColor;
uniform lowp vec4 _ReflectOutlineColor;
uniform lowp vec4 _SpecularColor;
uniform highp float _LightAngle;
uniform highp float _SpecularPower;
uniform highp float _Reflectivity;
uniform highp float _Diffuse;
uniform highp float _Ambient;
uniform lowp vec4 _GlowColor;
uniform highp float _GlowOffset;
uniform highp float _GlowOuter;
uniform highp float _GlowInner;
uniform highp float _GlowPower;
uniform highp float _ShaderFlags;
uniform highp float _ScaleRatioA;
uniform highp float _ScaleRatioB;
uniform highp vec4 _ClipRect;
uniform sampler2D _MainTex;
uniform highp float _TextureWidth;
uniform highp float _TextureHeight;
uniform highp float _GradientScale;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 bump_2;
  mediump vec4 outlineColor_3;
  mediump vec4 faceColor_4;
  highp float c_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  c_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD1.z - c_5) * xlv_TEXCOORD1.y);
  highp float tmpvar_8;
  tmpvar_8 = ((_OutlineWidth * _ScaleRatioA) * xlv_TEXCOORD1.y);
  highp float tmpvar_9;
  tmpvar_9 = ((_OutlineSoftness * _ScaleRatioA) * xlv_TEXCOORD1.y);
  faceColor_4 = _FaceColor;
  outlineColor_3 = _OutlineColor;
  faceColor_4.xyz = (faceColor_4.xyz * xlv_COLOR.xyz);
  highp vec2 tmpvar_10;
  tmpvar_10.x = _FaceUVSpeedX;
  tmpvar_10.y = _FaceUVSpeedY;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD5.xy + (tmpvar_10 * _Time.y));
  tmpvar_11 = texture2D (_FaceTex, P_12);
  faceColor_4 = (faceColor_4 * tmpvar_11);
  highp vec2 tmpvar_13;
  tmpvar_13.x = _OutlineUVSpeedX;
  tmpvar_13.y = _OutlineUVSpeedY;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD5.zw + (tmpvar_13 * _Time.y));
  tmpvar_14 = texture2D (_OutlineTex, P_15);
  outlineColor_3 = (outlineColor_3 * tmpvar_14);
  mediump float d_16;
  d_16 = tmpvar_7;
  lowp vec4 faceColor_17;
  faceColor_17 = faceColor_4;
  lowp vec4 outlineColor_18;
  outlineColor_18 = outlineColor_3;
  mediump float outline_19;
  outline_19 = tmpvar_8;
  mediump float softness_20;
  softness_20 = tmpvar_9;
  mediump float tmpvar_21;
  tmpvar_21 = (1.0 - clamp ((
    ((d_16 - (outline_19 * 0.5)) + (softness_20 * 0.5))
   / 
    (1.0 + softness_20)
  ), 0.0, 1.0));
  faceColor_17.xyz = (faceColor_17.xyz * faceColor_17.w);
  outlineColor_18.xyz = (outlineColor_18.xyz * outlineColor_18.w);
  mediump vec4 tmpvar_22;
  tmpvar_22 = mix (faceColor_17, outlineColor_18, vec4((clamp (
    (d_16 + (outline_19 * 0.5))
  , 0.0, 1.0) * sqrt(
    min (1.0, outline_19)
  ))));
  faceColor_17 = tmpvar_22;
  faceColor_17 = (faceColor_17 * tmpvar_21);
  faceColor_4 = faceColor_17;
  highp vec3 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.x = (0.5 / _TextureWidth);
  tmpvar_23.y = (0.5 / _TextureHeight);
  highp vec4 h_24;
  highp vec2 P_25;
  P_25 = (xlv_TEXCOORD0 - tmpvar_23.xz);
  highp vec2 P_26;
  P_26 = (xlv_TEXCOORD0 + tmpvar_23.xz);
  highp vec2 P_27;
  P_27 = (xlv_TEXCOORD0 - tmpvar_23.zy);
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_23.zy);
  lowp vec4 tmpvar_29;
  tmpvar_29.x = texture2D (_MainTex, P_25).w;
  tmpvar_29.y = texture2D (_MainTex, P_26).w;
  tmpvar_29.z = texture2D (_MainTex, P_27).w;
  tmpvar_29.w = texture2D (_MainTex, P_28).w;
  h_24 = tmpvar_29;
  highp vec4 h_30;
  h_30 = h_24;
  highp float tmpvar_31;
  tmpvar_31 = (_ShaderFlags / 2.0);
  highp float tmpvar_32;
  tmpvar_32 = (fract(abs(tmpvar_31)) * 2.0);
  highp float tmpvar_33;
  if ((tmpvar_31 >= 0.0)) {
    tmpvar_33 = tmpvar_32;
  } else {
    tmpvar_33 = -(tmpvar_32);
  };
  h_30 = (h_24 + (xlv_TEXCOORD1.w + _BevelOffset));
  highp float tmpvar_34;
  tmpvar_34 = max (0.01, (_OutlineWidth + _BevelWidth));
  h_30 = (h_30 - 0.5);
  h_30 = (h_30 / tmpvar_34);
  highp vec4 tmpvar_35;
  tmpvar_35 = clamp ((h_30 + 0.5), 0.0, 1.0);
  h_30 = tmpvar_35;
  if (bool(float((tmpvar_33 >= 1.0)))) {
    h_30 = (1.0 - abs((
      (tmpvar_35 * 2.0)
     - 1.0)));
  };
  h_30 = (min (mix (h_30, 
    sin(((h_30 * 3.141592) / 2.0))
  , vec4(_BevelRoundness)), vec4((1.0 - _BevelClamp))) * ((_Bevel * tmpvar_34) * (_GradientScale * -2.0)));
  highp vec3 tmpvar_36;
  tmpvar_36.xy = vec2(1.0, 0.0);
  tmpvar_36.z = (h_30.y - h_30.x);
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(tmpvar_36);
  highp vec3 tmpvar_38;
  tmpvar_38.xy = vec2(0.0, -1.0);
  tmpvar_38.z = (h_30.w - h_30.z);
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(tmpvar_38);
  highp vec2 tmpvar_40;
  tmpvar_40.x = _FaceUVSpeedX;
  tmpvar_40.y = _FaceUVSpeedY;
  highp vec2 P_41;
  P_41 = (xlv_TEXCOORD5.xy + (tmpvar_40 * _Time.y));
  lowp vec3 tmpvar_42;
  tmpvar_42 = ((texture2D (_BumpMap, P_41).xyz * 2.0) - 1.0);
  bump_2 = tmpvar_42;
  bump_2 = (bump_2 * mix (_BumpFace, _BumpOutline, clamp (
    (tmpvar_7 + (tmpvar_8 * 0.5))
  , 0.0, 1.0)));
  highp vec3 tmpvar_43;
  tmpvar_43 = normalize(((
    (tmpvar_37.yzx * tmpvar_39.zxy)
   - 
    (tmpvar_37.zxy * tmpvar_39.yzx)
  ) - bump_2));
  highp vec3 tmpvar_44;
  tmpvar_44.z = -1.0;
  tmpvar_44.x = sin(_LightAngle);
  tmpvar_44.y = cos(_LightAngle);
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize(tmpvar_44);
  highp vec3 tmpvar_46;
  tmpvar_46 = ((_SpecularColor.xyz * pow (
    max (0.0, dot (tmpvar_43, tmpvar_45))
  , _Reflectivity)) * _SpecularPower);
  faceColor_4.xyz = (faceColor_4.xyz + (tmpvar_46 * faceColor_4.w));
  highp float tmpvar_47;
  tmpvar_47 = dot (tmpvar_43, tmpvar_45);
  faceColor_4.xyz = (faceColor_4.xyz * (1.0 - (tmpvar_47 * _Diffuse)));
  highp float tmpvar_48;
  tmpvar_48 = mix (_Ambient, 1.0, (tmpvar_43.z * tmpvar_43.z));
  faceColor_4.xyz = (faceColor_4.xyz * tmpvar_48);
  highp vec3 tmpvar_49;
  highp vec3 N_50;
  N_50 = -(tmpvar_43);
  tmpvar_49 = (xlv_TEXCOORD3 - (2.0 * (
    dot (N_50, xlv_TEXCOORD3)
   * N_50)));
  lowp vec4 tmpvar_51;
  tmpvar_51 = textureCube (_Cube, tmpvar_49);
  highp float tmpvar_52;
  tmpvar_52 = clamp ((tmpvar_7 + (tmpvar_8 * 0.5)), 0.0, 1.0);
  lowp vec3 tmpvar_53;
  tmpvar_53 = mix (_ReflectFaceColor.xyz, _ReflectOutlineColor.xyz, vec3(tmpvar_52));
  faceColor_4.xyz = (faceColor_4.xyz + ((tmpvar_51.xyz * tmpvar_53) * faceColor_4.w));
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_MainTex, xlv_TEXCOORD4.xy);
  highp float tmpvar_55;
  tmpvar_55 = clamp (((tmpvar_54.w * xlv_TEXCOORD4.z) - xlv_TEXCOORD4.w), 0.0, 1.0);
  faceColor_4 = (faceColor_4 + ((xlv_COLOR1 * tmpvar_55) * (1.0 - faceColor_4.w)));
  highp vec4 tmpvar_56;
  highp float glow_57;
  highp float tmpvar_58;
  tmpvar_58 = (tmpvar_7 - ((_GlowOffset * _ScaleRatioB) * (0.5 * xlv_TEXCOORD1.y)));
  highp float tmpvar_59;
  tmpvar_59 = ((mix (_GlowInner, 
    (_GlowOuter * _ScaleRatioB)
  , 
    float((tmpvar_58 >= 0.0))
  ) * 0.5) * xlv_TEXCOORD1.y);
  glow_57 = (1.0 - pow (clamp (
    abs((tmpvar_58 / (1.0 + tmpvar_59)))
  , 0.0, 1.0), _GlowPower));
  glow_57 = (glow_57 * sqrt(min (1.0, tmpvar_59)));
  highp float tmpvar_60;
  tmpvar_60 = clamp (((_GlowColor.w * glow_57) * 2.0), 0.0, 1.0);
  lowp vec4 tmpvar_61;
  tmpvar_61.xyz = _GlowColor.xyz;
  tmpvar_61.w = tmpvar_60;
  tmpvar_56 = tmpvar_61;
  faceColor_4.xyz = (faceColor_4.xyz + (tmpvar_56.xyz * tmpvar_56.w));
  mediump vec2 tmpvar_62;
  highp vec2 tmpvar_63;
  tmpvar_63 = clamp (((
    (_ClipRect.zw - _ClipRect.xy)
   - 
    abs(xlv_TEXCOORD2.xy)
  ) * xlv_TEXCOORD2.zw), 0.0, 1.0);
  tmpvar_62 = tmpvar_63;
  faceColor_4 = (faceColor_4 * (tmpvar_62.x * tmpvar_62.y));
  tmpvar_1 = (faceColor_4 * xlv_COLOR.w);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixVP;
uniform highp float _FaceDilate;
uniform highp float _OutlineSoftness;
uniform highp float _OutlineWidth;
uniform highp mat4 _EnvMatrix;
uniform lowp vec4 _UnderlayColor;
uniform highp float _UnderlayOffsetX;
uniform highp float _UnderlayOffsetY;
uniform highp float _UnderlayDilate;
uniform highp float _UnderlaySoftness;
uniform highp float _GlowOffset;
uniform highp float _GlowOuter;
uniform highp float _WeightNormal;
uniform highp float _WeightBold;
uniform highp float _ScaleRatioA;
uniform highp float _ScaleRatioB;
uniform highp float _ScaleRatioC;
uniform highp float _VertexOffsetX;
uniform highp float _VertexOffsetY;
uniform highp vec4 _ClipRect;
uniform highp float _MaskSoftnessX;
uniform highp float _MaskSoftnessY;
uniform highp float _TextureWidth;
uniform highp float _TextureHeight;
uniform highp float _GradientScale;
uniform highp float _ScaleX;
uniform highp float _ScaleY;
uniform highp float _PerspectiveFilter;
uniform highp vec4 _FaceTex_ST;
uniform highp vec4 _OutlineTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp float bScale_3;
  highp vec4 underlayColor_4;
  highp float weight_5;
  highp float scale_6;
  highp vec2 pixelSize_7;
  highp vec4 vert_8;
  highp float tmpvar_9;
  tmpvar_9 = float((0.0 >= _glesMultiTexCoord1.y));
  vert_8.zw = _glesVertex.zw;
  vert_8.x = (_glesVertex.x + _VertexOffsetX);
  vert_8.y = (_glesVertex.y + _VertexOffsetY);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = vert_8.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec2 tmpvar_12;
  tmpvar_12.x = _ScaleX;
  tmpvar_12.y = _ScaleY;
  highp mat2 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_projection[0].xy;
  tmpvar_13[1] = glstate_matrix_projection[1].xy;
  pixelSize_7 = (tmpvar_10.ww / (tmpvar_12 * abs(
    (tmpvar_13 * _ScreenParams.xy)
  )));
  scale_6 = (inversesqrt(dot (pixelSize_7, pixelSize_7)) * ((
    abs(_glesMultiTexCoord1.y)
   * _GradientScale) * 1.5));
  if ((glstate_matrix_projection[3].w == 0.0)) {
    highp mat3 tmpvar_14;
    tmpvar_14[0] = unity_WorldToObject[0].xyz;
    tmpvar_14[1] = unity_WorldToObject[1].xyz;
    tmpvar_14[2] = unity_WorldToObject[2].xyz;
    scale_6 = mix ((abs(scale_6) * (1.0 - _PerspectiveFilter)), scale_6, abs(dot (
      normalize((_glesNormal * tmpvar_14))
    , 
      normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_8).xyz))
    )));
  };
  weight_5 = (((
    (mix (_WeightNormal, _WeightBold, tmpvar_9) / 4.0)
   + _FaceDilate) * _ScaleRatioA) * 0.5);
  underlayColor_4 = _UnderlayColor;
  underlayColor_4.xyz = (underlayColor_4.xyz * underlayColor_4.w);
  bScale_3 = (scale_6 / (1.0 + (
    (_UnderlaySoftness * _ScaleRatioC)
   * scale_6)));
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((-(
    (_UnderlayOffsetX * _ScaleRatioC)
  ) * _GradientScale) / _TextureWidth);
  tmpvar_15.y = ((-(
    (_UnderlayOffsetY * _ScaleRatioC)
  ) * _GradientScale) / _TextureHeight);
  highp vec4 tmpvar_16;
  tmpvar_16 = clamp (_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10), vec4(2e+10, 2e+10, 2e+10, 2e+10));
  highp vec2 tmpvar_17;
  highp vec2 xlat_varoutput_18;
  xlat_varoutput_18.x = floor((_glesMultiTexCoord1.x / 4096.0));
  xlat_varoutput_18.y = (_glesMultiTexCoord1.x - (4096.0 * xlat_varoutput_18.x));
  tmpvar_17 = (xlat_varoutput_18 * 0.001953125);
  highp vec4 tmpvar_19;
  tmpvar_19.x = (((
    min (((1.0 - (_OutlineWidth * _ScaleRatioA)) - (_OutlineSoftness * _ScaleRatioA)), ((1.0 - (_GlowOffset * _ScaleRatioB)) - (_GlowOuter * _ScaleRatioB)))
   / 2.0) - (0.5 / scale_6)) - weight_5);
  tmpvar_19.y = scale_6;
  tmpvar_19.z = ((0.5 - weight_5) + (0.5 / scale_6));
  tmpvar_19.w = weight_5;
  highp vec2 tmpvar_20;
  tmpvar_20.x = _MaskSoftnessX;
  tmpvar_20.y = _MaskSoftnessY;
  highp vec4 tmpvar_21;
  tmpvar_21.xy = (((vert_8.xy * 2.0) - tmpvar_16.xy) - tmpvar_16.zw);
  tmpvar_21.zw = (0.25 / ((0.25 * tmpvar_20) + pixelSize_7));
  highp mat3 tmpvar_22;
  tmpvar_22[0] = _EnvMatrix[0].xyz;
  tmpvar_22[1] = _EnvMatrix[1].xyz;
  tmpvar_22[2] = _EnvMatrix[2].xyz;
  highp vec4 tmpvar_23;
  tmpvar_23.xy = (_glesMultiTexCoord0.xy + tmpvar_15);
  tmpvar_23.z = bScale_3;
  tmpvar_23.w = (((
    (0.5 - weight_5)
   * bScale_3) - 0.5) - ((_UnderlayDilate * _ScaleRatioC) * (0.5 * bScale_3)));
  highp vec4 tmpvar_24;
  tmpvar_24.xy = ((tmpvar_17 * _FaceTex_ST.xy) + _FaceTex_ST.zw);
  tmpvar_24.zw = ((tmpvar_17 * _OutlineTex_ST.xy) + _OutlineTex_ST.zw);
  lowp vec4 tmpvar_25;
  tmpvar_25 = underlayColor_4;
  gl_Position = tmpvar_10;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_19;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = (tmpvar_22 * (_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_8).xyz));
  xlv_TEXCOORD4 = tmpvar_23;
  xlv_COLOR1 = tmpvar_25;
  xlv_TEXCOORD5 = tmpvar_24;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _FaceTex;
uniform highp float _FaceUVSpeedX;
uniform highp float _FaceUVSpeedY;
uniform lowp vec4 _FaceColor;
uniform highp float _OutlineSoftness;
uniform sampler2D _OutlineTex;
uniform highp float _OutlineUVSpeedX;
uniform highp float _OutlineUVSpeedY;
uniform lowp vec4 _OutlineColor;
uniform highp float _OutlineWidth;
uniform highp float _Bevel;
uniform highp float _BevelOffset;
uniform highp float _BevelWidth;
uniform highp float _BevelClamp;
uniform highp float _BevelRoundness;
uniform sampler2D _BumpMap;
uniform highp float _BumpOutline;
uniform highp float _BumpFace;
uniform lowp samplerCube _Cube;
uniform lowp vec4 _ReflectFaceColor;
uniform lowp vec4 _ReflectOutlineColor;
uniform lowp vec4 _SpecularColor;
uniform highp float _LightAngle;
uniform highp float _SpecularPower;
uniform highp float _Reflectivity;
uniform highp float _Diffuse;
uniform highp float _Ambient;
uniform lowp vec4 _GlowColor;
uniform highp float _GlowOffset;
uniform highp float _GlowOuter;
uniform highp float _GlowInner;
uniform highp float _GlowPower;
uniform highp float _ShaderFlags;
uniform highp float _ScaleRatioA;
uniform highp float _ScaleRatioB;
uniform highp vec4 _ClipRect;
uniform sampler2D _MainTex;
uniform highp float _TextureWidth;
uniform highp float _TextureHeight;
uniform highp float _GradientScale;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 bump_2;
  mediump vec4 outlineColor_3;
  mediump vec4 faceColor_4;
  highp float c_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  c_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD1.z - c_5) * xlv_TEXCOORD1.y);
  highp float tmpvar_8;
  tmpvar_8 = ((_OutlineWidth * _ScaleRatioA) * xlv_TEXCOORD1.y);
  highp float tmpvar_9;
  tmpvar_9 = ((_OutlineSoftness * _ScaleRatioA) * xlv_TEXCOORD1.y);
  faceColor_4 = _FaceColor;
  outlineColor_3 = _OutlineColor;
  faceColor_4.xyz = (faceColor_4.xyz * xlv_COLOR.xyz);
  highp vec2 tmpvar_10;
  tmpvar_10.x = _FaceUVSpeedX;
  tmpvar_10.y = _FaceUVSpeedY;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD5.xy + (tmpvar_10 * _Time.y));
  tmpvar_11 = texture2D (_FaceTex, P_12);
  faceColor_4 = (faceColor_4 * tmpvar_11);
  highp vec2 tmpvar_13;
  tmpvar_13.x = _OutlineUVSpeedX;
  tmpvar_13.y = _OutlineUVSpeedY;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD5.zw + (tmpvar_13 * _Time.y));
  tmpvar_14 = texture2D (_OutlineTex, P_15);
  outlineColor_3 = (outlineColor_3 * tmpvar_14);
  mediump float d_16;
  d_16 = tmpvar_7;
  lowp vec4 faceColor_17;
  faceColor_17 = faceColor_4;
  lowp vec4 outlineColor_18;
  outlineColor_18 = outlineColor_3;
  mediump float outline_19;
  outline_19 = tmpvar_8;
  mediump float softness_20;
  softness_20 = tmpvar_9;
  mediump float tmpvar_21;
  tmpvar_21 = (1.0 - clamp ((
    ((d_16 - (outline_19 * 0.5)) + (softness_20 * 0.5))
   / 
    (1.0 + softness_20)
  ), 0.0, 1.0));
  faceColor_17.xyz = (faceColor_17.xyz * faceColor_17.w);
  outlineColor_18.xyz = (outlineColor_18.xyz * outlineColor_18.w);
  mediump vec4 tmpvar_22;
  tmpvar_22 = mix (faceColor_17, outlineColor_18, vec4((clamp (
    (d_16 + (outline_19 * 0.5))
  , 0.0, 1.0) * sqrt(
    min (1.0, outline_19)
  ))));
  faceColor_17 = tmpvar_22;
  faceColor_17 = (faceColor_17 * tmpvar_21);
  faceColor_4 = faceColor_17;
  highp vec3 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.x = (0.5 / _TextureWidth);
  tmpvar_23.y = (0.5 / _TextureHeight);
  highp vec4 h_24;
  highp vec2 P_25;
  P_25 = (xlv_TEXCOORD0 - tmpvar_23.xz);
  highp vec2 P_26;
  P_26 = (xlv_TEXCOORD0 + tmpvar_23.xz);
  highp vec2 P_27;
  P_27 = (xlv_TEXCOORD0 - tmpvar_23.zy);
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_23.zy);
  lowp vec4 tmpvar_29;
  tmpvar_29.x = texture2D (_MainTex, P_25).w;
  tmpvar_29.y = texture2D (_MainTex, P_26).w;
  tmpvar_29.z = texture2D (_MainTex, P_27).w;
  tmpvar_29.w = texture2D (_MainTex, P_28).w;
  h_24 = tmpvar_29;
  highp vec4 h_30;
  h_30 = h_24;
  highp float tmpvar_31;
  tmpvar_31 = (_ShaderFlags / 2.0);
  highp float tmpvar_32;
  tmpvar_32 = (fract(abs(tmpvar_31)) * 2.0);
  highp float tmpvar_33;
  if ((tmpvar_31 >= 0.0)) {
    tmpvar_33 = tmpvar_32;
  } else {
    tmpvar_33 = -(tmpvar_32);
  };
  h_30 = (h_24 + (xlv_TEXCOORD1.w + _BevelOffset));
  highp float tmpvar_34;
  tmpvar_34 = max (0.01, (_OutlineWidth + _BevelWidth));
  h_30 = (h_30 - 0.5);
  h_30 = (h_30 / tmpvar_34);
  highp vec4 tmpvar_35;
  tmpvar_35 = clamp ((h_30 + 0.5), 0.0, 1.0);
  h_30 = tmpvar_35;
  if (bool(float((tmpvar_33 >= 1.0)))) {
    h_30 = (1.0 - abs((
      (tmpvar_35 * 2.0)
     - 1.0)));
  };
  h_30 = (min (mix (h_30, 
    sin(((h_30 * 3.141592) / 2.0))
  , vec4(_BevelRoundness)), vec4((1.0 - _BevelClamp))) * ((_Bevel * tmpvar_34) * (_GradientScale * -2.0)));
  highp vec3 tmpvar_36;
  tmpvar_36.xy = vec2(1.0, 0.0);
  tmpvar_36.z = (h_30.y - h_30.x);
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(tmpvar_36);
  highp vec3 tmpvar_38;
  tmpvar_38.xy = vec2(0.0, -1.0);
  tmpvar_38.z = (h_30.w - h_30.z);
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(tmpvar_38);
  highp vec2 tmpvar_40;
  tmpvar_40.x = _FaceUVSpeedX;
  tmpvar_40.y = _FaceUVSpeedY;
  highp vec2 P_41;
  P_41 = (xlv_TEXCOORD5.xy + (tmpvar_40 * _Time.y));
  lowp vec3 tmpvar_42;
  tmpvar_42 = ((texture2D (_BumpMap, P_41).xyz * 2.0) - 1.0);
  bump_2 = tmpvar_42;
  bump_2 = (bump_2 * mix (_BumpFace, _BumpOutline, clamp (
    (tmpvar_7 + (tmpvar_8 * 0.5))
  , 0.0, 1.0)));
  highp vec3 tmpvar_43;
  tmpvar_43 = normalize(((
    (tmpvar_37.yzx * tmpvar_39.zxy)
   - 
    (tmpvar_37.zxy * tmpvar_39.yzx)
  ) - bump_2));
  highp vec3 tmpvar_44;
  tmpvar_44.z = -1.0;
  tmpvar_44.x = sin(_LightAngle);
  tmpvar_44.y = cos(_LightAngle);
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize(tmpvar_44);
  highp vec3 tmpvar_46;
  tmpvar_46 = ((_SpecularColor.xyz * pow (
    max (0.0, dot (tmpvar_43, tmpvar_45))
  , _Reflectivity)) * _SpecularPower);
  faceColor_4.xyz = (faceColor_4.xyz + (tmpvar_46 * faceColor_4.w));
  highp float tmpvar_47;
  tmpvar_47 = dot (tmpvar_43, tmpvar_45);
  faceColor_4.xyz = (faceColor_4.xyz * (1.0 - (tmpvar_47 * _Diffuse)));
  highp float tmpvar_48;
  tmpvar_48 = mix (_Ambient, 1.0, (tmpvar_43.z * tmpvar_43.z));
  faceColor_4.xyz = (faceColor_4.xyz * tmpvar_48);
  highp vec3 tmpvar_49;
  highp vec3 N_50;
  N_50 = -(tmpvar_43);
  tmpvar_49 = (xlv_TEXCOORD3 - (2.0 * (
    dot (N_50, xlv_TEXCOORD3)
   * N_50)));
  lowp vec4 tmpvar_51;
  tmpvar_51 = textureCube (_Cube, tmpvar_49);
  highp float tmpvar_52;
  tmpvar_52 = clamp ((tmpvar_7 + (tmpvar_8 * 0.5)), 0.0, 1.0);
  lowp vec3 tmpvar_53;
  tmpvar_53 = mix (_ReflectFaceColor.xyz, _ReflectOutlineColor.xyz, vec3(tmpvar_52));
  faceColor_4.xyz = (faceColor_4.xyz + ((tmpvar_51.xyz * tmpvar_53) * faceColor_4.w));
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_MainTex, xlv_TEXCOORD4.xy);
  highp float tmpvar_55;
  tmpvar_55 = clamp (((tmpvar_54.w * xlv_TEXCOORD4.z) - xlv_TEXCOORD4.w), 0.0, 1.0);
  faceColor_4 = (faceColor_4 + ((xlv_COLOR1 * tmpvar_55) * (1.0 - faceColor_4.w)));
  highp vec4 tmpvar_56;
  highp float glow_57;
  highp float tmpvar_58;
  tmpvar_58 = (tmpvar_7 - ((_GlowOffset * _ScaleRatioB) * (0.5 * xlv_TEXCOORD1.y)));
  highp float tmpvar_59;
  tmpvar_59 = ((mix (_GlowInner, 
    (_GlowOuter * _ScaleRatioB)
  , 
    float((tmpvar_58 >= 0.0))
  ) * 0.5) * xlv_TEXCOORD1.y);
  glow_57 = (1.0 - pow (clamp (
    abs((tmpvar_58 / (1.0 + tmpvar_59)))
  , 0.0, 1.0), _GlowPower));
  glow_57 = (glow_57 * sqrt(min (1.0, tmpvar_59)));
  highp float tmpvar_60;
  tmpvar_60 = clamp (((_GlowColor.w * glow_57) * 2.0), 0.0, 1.0);
  lowp vec4 tmpvar_61;
  tmpvar_61.xyz = _GlowColor.xyz;
  tmpvar_61.w = tmpvar_60;
  tmpvar_56 = tmpvar_61;
  faceColor_4.xyz = (faceColor_4.xyz + (tmpvar_56.xyz * tmpvar_56.w));
  mediump vec2 tmpvar_62;
  highp vec2 tmpvar_63;
  tmpvar_63 = clamp (((
    (_ClipRect.zw - _ClipRect.xy)
   - 
    abs(xlv_TEXCOORD2.xy)
  ) * xlv_TEXCOORD2.zw), 0.0, 1.0);
  tmpvar_62 = tmpvar_63;
  faceColor_4 = (faceColor_4 * (tmpvar_62.x * tmpvar_62.y));
  tmpvar_1 = (faceColor_4 * xlv_COLOR.w);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixVP;
uniform highp float _FaceDilate;
uniform highp float _OutlineSoftness;
uniform highp float _OutlineWidth;
uniform highp mat4 _EnvMatrix;
uniform lowp vec4 _UnderlayColor;
uniform highp float _UnderlayOffsetX;
uniform highp float _UnderlayOffsetY;
uniform highp float _UnderlayDilate;
uniform highp float _UnderlaySoftness;
uniform highp float _GlowOffset;
uniform highp float _GlowOuter;
uniform highp float _WeightNormal;
uniform highp float _WeightBold;
uniform highp float _ScaleRatioA;
uniform highp float _ScaleRatioB;
uniform highp float _ScaleRatioC;
uniform highp float _VertexOffsetX;
uniform highp float _VertexOffsetY;
uniform highp vec4 _ClipRect;
uniform highp float _MaskSoftnessX;
uniform highp float _MaskSoftnessY;
uniform highp float _TextureWidth;
uniform highp float _TextureHeight;
uniform highp float _GradientScale;
uniform highp float _ScaleX;
uniform highp float _ScaleY;
uniform highp float _PerspectiveFilter;
uniform highp vec4 _FaceTex_ST;
uniform highp vec4 _OutlineTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp float bScale_3;
  highp vec4 underlayColor_4;
  highp float weight_5;
  highp float scale_6;
  highp vec2 pixelSize_7;
  highp vec4 vert_8;
  highp float tmpvar_9;
  tmpvar_9 = float((0.0 >= _glesMultiTexCoord1.y));
  vert_8.zw = _glesVertex.zw;
  vert_8.x = (_glesVertex.x + _VertexOffsetX);
  vert_8.y = (_glesVertex.y + _VertexOffsetY);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = vert_8.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec2 tmpvar_12;
  tmpvar_12.x = _ScaleX;
  tmpvar_12.y = _ScaleY;
  highp mat2 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_projection[0].xy;
  tmpvar_13[1] = glstate_matrix_projection[1].xy;
  pixelSize_7 = (tmpvar_10.ww / (tmpvar_12 * abs(
    (tmpvar_13 * _ScreenParams.xy)
  )));
  scale_6 = (inversesqrt(dot (pixelSize_7, pixelSize_7)) * ((
    abs(_glesMultiTexCoord1.y)
   * _GradientScale) * 1.5));
  if ((glstate_matrix_projection[3].w == 0.0)) {
    highp mat3 tmpvar_14;
    tmpvar_14[0] = unity_WorldToObject[0].xyz;
    tmpvar_14[1] = unity_WorldToObject[1].xyz;
    tmpvar_14[2] = unity_WorldToObject[2].xyz;
    scale_6 = mix ((abs(scale_6) * (1.0 - _PerspectiveFilter)), scale_6, abs(dot (
      normalize((_glesNormal * tmpvar_14))
    , 
      normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_8).xyz))
    )));
  };
  weight_5 = (((
    (mix (_WeightNormal, _WeightBold, tmpvar_9) / 4.0)
   + _FaceDilate) * _ScaleRatioA) * 0.5);
  underlayColor_4 = _UnderlayColor;
  underlayColor_4.xyz = (underlayColor_4.xyz * underlayColor_4.w);
  bScale_3 = (scale_6 / (1.0 + (
    (_UnderlaySoftness * _ScaleRatioC)
   * scale_6)));
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((-(
    (_UnderlayOffsetX * _ScaleRatioC)
  ) * _GradientScale) / _TextureWidth);
  tmpvar_15.y = ((-(
    (_UnderlayOffsetY * _ScaleRatioC)
  ) * _GradientScale) / _TextureHeight);
  highp vec4 tmpvar_16;
  tmpvar_16 = clamp (_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10), vec4(2e+10, 2e+10, 2e+10, 2e+10));
  highp vec2 tmpvar_17;
  highp vec2 xlat_varoutput_18;
  xlat_varoutput_18.x = floor((_glesMultiTexCoord1.x / 4096.0));
  xlat_varoutput_18.y = (_glesMultiTexCoord1.x - (4096.0 * xlat_varoutput_18.x));
  tmpvar_17 = (xlat_varoutput_18 * 0.001953125);
  highp vec4 tmpvar_19;
  tmpvar_19.x = (((
    min (((1.0 - (_OutlineWidth * _ScaleRatioA)) - (_OutlineSoftness * _ScaleRatioA)), ((1.0 - (_GlowOffset * _ScaleRatioB)) - (_GlowOuter * _ScaleRatioB)))
   / 2.0) - (0.5 / scale_6)) - weight_5);
  tmpvar_19.y = scale_6;
  tmpvar_19.z = ((0.5 - weight_5) + (0.5 / scale_6));
  tmpvar_19.w = weight_5;
  highp vec2 tmpvar_20;
  tmpvar_20.x = _MaskSoftnessX;
  tmpvar_20.y = _MaskSoftnessY;
  highp vec4 tmpvar_21;
  tmpvar_21.xy = (((vert_8.xy * 2.0) - tmpvar_16.xy) - tmpvar_16.zw);
  tmpvar_21.zw = (0.25 / ((0.25 * tmpvar_20) + pixelSize_7));
  highp mat3 tmpvar_22;
  tmpvar_22[0] = _EnvMatrix[0].xyz;
  tmpvar_22[1] = _EnvMatrix[1].xyz;
  tmpvar_22[2] = _EnvMatrix[2].xyz;
  highp vec4 tmpvar_23;
  tmpvar_23.xy = (_glesMultiTexCoord0.xy + tmpvar_15);
  tmpvar_23.z = bScale_3;
  tmpvar_23.w = (((
    (0.5 - weight_5)
   * bScale_3) - 0.5) - ((_UnderlayDilate * _ScaleRatioC) * (0.5 * bScale_3)));
  highp vec4 tmpvar_24;
  tmpvar_24.xy = ((tmpvar_17 * _FaceTex_ST.xy) + _FaceTex_ST.zw);
  tmpvar_24.zw = ((tmpvar_17 * _OutlineTex_ST.xy) + _OutlineTex_ST.zw);
  lowp vec4 tmpvar_25;
  tmpvar_25 = underlayColor_4;
  gl_Position = tmpvar_10;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_19;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = (tmpvar_22 * (_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_8).xyz));
  xlv_TEXCOORD4 = tmpvar_23;
  xlv_COLOR1 = tmpvar_25;
  xlv_TEXCOORD5 = tmpvar_24;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _FaceTex;
uniform highp float _FaceUVSpeedX;
uniform highp float _FaceUVSpeedY;
uniform lowp vec4 _FaceColor;
uniform highp float _OutlineSoftness;
uniform sampler2D _OutlineTex;
uniform highp float _OutlineUVSpeedX;
uniform highp float _OutlineUVSpeedY;
uniform lowp vec4 _OutlineColor;
uniform highp float _OutlineWidth;
uniform highp float _Bevel;
uniform highp float _BevelOffset;
uniform highp float _BevelWidth;
uniform highp float _BevelClamp;
uniform highp float _BevelRoundness;
uniform sampler2D _BumpMap;
uniform highp float _BumpOutline;
uniform highp float _BumpFace;
uniform lowp samplerCube _Cube;
uniform lowp vec4 _ReflectFaceColor;
uniform lowp vec4 _ReflectOutlineColor;
uniform lowp vec4 _SpecularColor;
uniform highp float _LightAngle;
uniform highp float _SpecularPower;
uniform highp float _Reflectivity;
uniform highp float _Diffuse;
uniform highp float _Ambient;
uniform lowp vec4 _GlowColor;
uniform highp float _GlowOffset;
uniform highp float _GlowOuter;
uniform highp float _GlowInner;
uniform highp float _GlowPower;
uniform highp float _ShaderFlags;
uniform highp float _ScaleRatioA;
uniform highp float _ScaleRatioB;
uniform highp vec4 _ClipRect;
uniform sampler2D _MainTex;
uniform highp float _TextureWidth;
uniform highp float _TextureHeight;
uniform highp float _GradientScale;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 bump_2;
  mediump vec4 outlineColor_3;
  mediump vec4 faceColor_4;
  highp float c_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  c_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD1.z - c_5) * xlv_TEXCOORD1.y);
  highp float tmpvar_8;
  tmpvar_8 = ((_OutlineWidth * _ScaleRatioA) * xlv_TEXCOORD1.y);
  highp float tmpvar_9;
  tmpvar_9 = ((_OutlineSoftness * _ScaleRatioA) * xlv_TEXCOORD1.y);
  faceColor_4 = _FaceColor;
  outlineColor_3 = _OutlineColor;
  faceColor_4.xyz = (faceColor_4.xyz * xlv_COLOR.xyz);
  highp vec2 tmpvar_10;
  tmpvar_10.x = _FaceUVSpeedX;
  tmpvar_10.y = _FaceUVSpeedY;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD5.xy + (tmpvar_10 * _Time.y));
  tmpvar_11 = texture2D (_FaceTex, P_12);
  faceColor_4 = (faceColor_4 * tmpvar_11);
  highp vec2 tmpvar_13;
  tmpvar_13.x = _OutlineUVSpeedX;
  tmpvar_13.y = _OutlineUVSpeedY;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD5.zw + (tmpvar_13 * _Time.y));
  tmpvar_14 = texture2D (_OutlineTex, P_15);
  outlineColor_3 = (outlineColor_3 * tmpvar_14);
  mediump float d_16;
  d_16 = tmpvar_7;
  lowp vec4 faceColor_17;
  faceColor_17 = faceColor_4;
  lowp vec4 outlineColor_18;
  outlineColor_18 = outlineColor_3;
  mediump float outline_19;
  outline_19 = tmpvar_8;
  mediump float softness_20;
  softness_20 = tmpvar_9;
  mediump float tmpvar_21;
  tmpvar_21 = (1.0 - clamp ((
    ((d_16 - (outline_19 * 0.5)) + (softness_20 * 0.5))
   / 
    (1.0 + softness_20)
  ), 0.0, 1.0));
  faceColor_17.xyz = (faceColor_17.xyz * faceColor_17.w);
  outlineColor_18.xyz = (outlineColor_18.xyz * outlineColor_18.w);
  mediump vec4 tmpvar_22;
  tmpvar_22 = mix (faceColor_17, outlineColor_18, vec4((clamp (
    (d_16 + (outline_19 * 0.5))
  , 0.0, 1.0) * sqrt(
    min (1.0, outline_19)
  ))));
  faceColor_17 = tmpvar_22;
  faceColor_17 = (faceColor_17 * tmpvar_21);
  faceColor_4 = faceColor_17;
  highp vec3 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.x = (0.5 / _TextureWidth);
  tmpvar_23.y = (0.5 / _TextureHeight);
  highp vec4 h_24;
  highp vec2 P_25;
  P_25 = (xlv_TEXCOORD0 - tmpvar_23.xz);
  highp vec2 P_26;
  P_26 = (xlv_TEXCOORD0 + tmpvar_23.xz);
  highp vec2 P_27;
  P_27 = (xlv_TEXCOORD0 - tmpvar_23.zy);
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_23.zy);
  lowp vec4 tmpvar_29;
  tmpvar_29.x = texture2D (_MainTex, P_25).w;
  tmpvar_29.y = texture2D (_MainTex, P_26).w;
  tmpvar_29.z = texture2D (_MainTex, P_27).w;
  tmpvar_29.w = texture2D (_MainTex, P_28).w;
  h_24 = tmpvar_29;
  highp vec4 h_30;
  h_30 = h_24;
  highp float tmpvar_31;
  tmpvar_31 = (_ShaderFlags / 2.0);
  highp float tmpvar_32;
  tmpvar_32 = (fract(abs(tmpvar_31)) * 2.0);
  highp float tmpvar_33;
  if ((tmpvar_31 >= 0.0)) {
    tmpvar_33 = tmpvar_32;
  } else {
    tmpvar_33 = -(tmpvar_32);
  };
  h_30 = (h_24 + (xlv_TEXCOORD1.w + _BevelOffset));
  highp float tmpvar_34;
  tmpvar_34 = max (0.01, (_OutlineWidth + _BevelWidth));
  h_30 = (h_30 - 0.5);
  h_30 = (h_30 / tmpvar_34);
  highp vec4 tmpvar_35;
  tmpvar_35 = clamp ((h_30 + 0.5), 0.0, 1.0);
  h_30 = tmpvar_35;
  if (bool(float((tmpvar_33 >= 1.0)))) {
    h_30 = (1.0 - abs((
      (tmpvar_35 * 2.0)
     - 1.0)));
  };
  h_30 = (min (mix (h_30, 
    sin(((h_30 * 3.141592) / 2.0))
  , vec4(_BevelRoundness)), vec4((1.0 - _BevelClamp))) * ((_Bevel * tmpvar_34) * (_GradientScale * -2.0)));
  highp vec3 tmpvar_36;
  tmpvar_36.xy = vec2(1.0, 0.0);
  tmpvar_36.z = (h_30.y - h_30.x);
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(tmpvar_36);
  highp vec3 tmpvar_38;
  tmpvar_38.xy = vec2(0.0, -1.0);
  tmpvar_38.z = (h_30.w - h_30.z);
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(tmpvar_38);
  highp vec2 tmpvar_40;
  tmpvar_40.x = _FaceUVSpeedX;
  tmpvar_40.y = _FaceUVSpeedY;
  highp vec2 P_41;
  P_41 = (xlv_TEXCOORD5.xy + (tmpvar_40 * _Time.y));
  lowp vec3 tmpvar_42;
  tmpvar_42 = ((texture2D (_BumpMap, P_41).xyz * 2.0) - 1.0);
  bump_2 = tmpvar_42;
  bump_2 = (bump_2 * mix (_BumpFace, _BumpOutline, clamp (
    (tmpvar_7 + (tmpvar_8 * 0.5))
  , 0.0, 1.0)));
  highp vec3 tmpvar_43;
  tmpvar_43 = normalize(((
    (tmpvar_37.yzx * tmpvar_39.zxy)
   - 
    (tmpvar_37.zxy * tmpvar_39.yzx)
  ) - bump_2));
  highp vec3 tmpvar_44;
  tmpvar_44.z = -1.0;
  tmpvar_44.x = sin(_LightAngle);
  tmpvar_44.y = cos(_LightAngle);
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize(tmpvar_44);
  highp vec3 tmpvar_46;
  tmpvar_46 = ((_SpecularColor.xyz * pow (
    max (0.0, dot (tmpvar_43, tmpvar_45))
  , _Reflectivity)) * _SpecularPower);
  faceColor_4.xyz = (faceColor_4.xyz + (tmpvar_46 * faceColor_4.w));
  highp float tmpvar_47;
  tmpvar_47 = dot (tmpvar_43, tmpvar_45);
  faceColor_4.xyz = (faceColor_4.xyz * (1.0 - (tmpvar_47 * _Diffuse)));
  highp float tmpvar_48;
  tmpvar_48 = mix (_Ambient, 1.0, (tmpvar_43.z * tmpvar_43.z));
  faceColor_4.xyz = (faceColor_4.xyz * tmpvar_48);
  highp vec3 tmpvar_49;
  highp vec3 N_50;
  N_50 = -(tmpvar_43);
  tmpvar_49 = (xlv_TEXCOORD3 - (2.0 * (
    dot (N_50, xlv_TEXCOORD3)
   * N_50)));
  lowp vec4 tmpvar_51;
  tmpvar_51 = textureCube (_Cube, tmpvar_49);
  highp float tmpvar_52;
  tmpvar_52 = clamp ((tmpvar_7 + (tmpvar_8 * 0.5)), 0.0, 1.0);
  lowp vec3 tmpvar_53;
  tmpvar_53 = mix (_ReflectFaceColor.xyz, _ReflectOutlineColor.xyz, vec3(tmpvar_52));
  faceColor_4.xyz = (faceColor_4.xyz + ((tmpvar_51.xyz * tmpvar_53) * faceColor_4.w));
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_MainTex, xlv_TEXCOORD4.xy);
  highp float tmpvar_55;
  tmpvar_55 = clamp (((tmpvar_54.w * xlv_TEXCOORD4.z) - xlv_TEXCOORD4.w), 0.0, 1.0);
  faceColor_4 = (faceColor_4 + ((xlv_COLOR1 * tmpvar_55) * (1.0 - faceColor_4.w)));
  highp vec4 tmpvar_56;
  highp float glow_57;
  highp float tmpvar_58;
  tmpvar_58 = (tmpvar_7 - ((_GlowOffset * _ScaleRatioB) * (0.5 * xlv_TEXCOORD1.y)));
  highp float tmpvar_59;
  tmpvar_59 = ((mix (_GlowInner, 
    (_GlowOuter * _ScaleRatioB)
  , 
    float((tmpvar_58 >= 0.0))
  ) * 0.5) * xlv_TEXCOORD1.y);
  glow_57 = (1.0 - pow (clamp (
    abs((tmpvar_58 / (1.0 + tmpvar_59)))
  , 0.0, 1.0), _GlowPower));
  glow_57 = (glow_57 * sqrt(min (1.0, tmpvar_59)));
  highp float tmpvar_60;
  tmpvar_60 = clamp (((_GlowColor.w * glow_57) * 2.0), 0.0, 1.0);
  lowp vec4 tmpvar_61;
  tmpvar_61.xyz = _GlowColor.xyz;
  tmpvar_61.w = tmpvar_60;
  tmpvar_56 = tmpvar_61;
  faceColor_4.xyz = (faceColor_4.xyz + (tmpvar_56.xyz * tmpvar_56.w));
  mediump vec2 tmpvar_62;
  highp vec2 tmpvar_63;
  tmpvar_63 = clamp (((
    (_ClipRect.zw - _ClipRect.xy)
   - 
    abs(xlv_TEXCOORD2.xy)
  ) * xlv_TEXCOORD2.zw), 0.0, 1.0);
  tmpvar_62 = tmpvar_63;
  faceColor_4 = (faceColor_4 * (tmpvar_62.x * tmpvar_62.y));
  tmpvar_1 = (faceColor_4 * xlv_COLOR.w);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _FaceDilate;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineWidth;
uniform 	vec4 hlslcc_mtx4x4_EnvMatrix[4];
uniform 	mediump vec4 _UnderlayColor;
uniform 	float _UnderlayOffsetX;
uniform 	float _UnderlayOffsetY;
uniform 	float _UnderlayDilate;
uniform 	float _UnderlaySoftness;
uniform 	float _GlowOffset;
uniform 	float _GlowOuter;
uniform 	float _WeightNormal;
uniform 	float _WeightBold;
uniform 	float _ScaleRatioA;
uniform 	float _ScaleRatioB;
uniform 	float _ScaleRatioC;
uniform 	float _VertexOffsetX;
uniform 	float _VertexOffsetY;
uniform 	vec4 _ClipRect;
uniform 	float _MaskSoftnessX;
uniform 	float _MaskSoftnessY;
uniform 	float _TextureWidth;
uniform 	float _TextureHeight;
uniform 	float _GradientScale;
uniform 	float _ScaleX;
uniform 	float _ScaleY;
uniform 	float _PerspectiveFilter;
uniform 	vec4 _FaceTex_ST;
uniform 	vec4 _OutlineTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat4;
vec3 u_xlat6;
vec2 u_xlat8;
float u_xlat12;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat0.xy = vec2(in_POSITION0.x + float(_VertexOffsetX), in_POSITION0.y + float(_VertexOffsetY));
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat8.x = (-_OutlineWidth) * _ScaleRatioA + 1.0;
    u_xlat8.x = (-_OutlineSoftness) * _ScaleRatioA + u_xlat8.x;
    u_xlat12 = (-_GlowOffset) * _ScaleRatioB + 1.0;
    u_xlat12 = (-_GlowOuter) * _ScaleRatioB + u_xlat12;
    u_xlat8.x = min(u_xlat12, u_xlat8.x);
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat2.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat2.xy;
    u_xlat2.xy = vec2(abs(u_xlat2.x) * float(_ScaleX), abs(u_xlat2.y) * float(_ScaleY));
    u_xlat2.xy = u_xlat2.ww / u_xlat2.xy;
    u_xlat13 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat2.xy;
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat2.xy;
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.x = abs(in_TEXCOORD1.y) * _GradientScale;
    u_xlat13 = u_xlat13 * u_xlat2.x;
    u_xlat2.x = u_xlat13 * 1.5;
    u_xlat6.x = (-_PerspectiveFilter) + 1.0;
    u_xlat6.x = u_xlat6.x * abs(u_xlat2.x);
    u_xlat13 = u_xlat13 * 1.5 + (-u_xlat6.x);
    u_xlat12 = abs(u_xlat12) * u_xlat13 + u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0);
#else
    u_xlatb13 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
#endif
    u_xlat6.x = (u_xlatb13) ? u_xlat12 : u_xlat2.x;
    u_xlat12 = 0.5 / u_xlat6.x;
    u_xlat8.x = u_xlat8.x * 0.5 + (-u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.0>=in_TEXCOORD1.y);
#else
    u_xlatb13 = 0.0>=in_TEXCOORD1.y;
#endif
    u_xlat13 = u_xlatb13 ? 1.0 : float(0.0);
    u_xlat2.x = (-_WeightNormal) + _WeightBold;
    u_xlat13 = u_xlat13 * u_xlat2.x + _WeightNormal;
    u_xlat13 = u_xlat13 * 0.25 + _FaceDilate;
    u_xlat13 = u_xlat13 * _ScaleRatioA;
    vs_TEXCOORD1.x = (-u_xlat13) * 0.5 + u_xlat8.x;
    u_xlat6.z = u_xlat13 * 0.5;
    u_xlat8.x = (-u_xlat13) * 0.5 + 0.5;
    vs_TEXCOORD1.yw = u_xlat6.xz;
    vs_TEXCOORD1.z = u_xlat12 + u_xlat8.x;
    u_xlat3 = max(_ClipRect, vec4(-2e+010, -2e+010, -2e+010, -2e+010));
    u_xlat3 = min(u_xlat3, vec4(2e+010, 2e+010, 2e+010, 2e+010));
    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat3.xy);
    vs_TEXCOORD2.xy = vec2((-u_xlat3.z) + u_xlat0.x, (-u_xlat3.w) + u_xlat0.y);
    u_xlat0.xyw = u_xlat1.yyy * hlslcc_mtx4x4_EnvMatrix[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_EnvMatrix[0].xyz * u_xlat1.xxx + u_xlat0.xyw;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4_EnvMatrix[2].xyz * u_xlat1.zzz + u_xlat0.xyw;
    u_xlat1 = vec4(_UnderlaySoftness, _UnderlayDilate, _UnderlayOffsetX, _UnderlayOffsetY) * vec4(vec4(_ScaleRatioC, _ScaleRatioC, _ScaleRatioC, _ScaleRatioC));
    u_xlat0.x = u_xlat1.x * u_xlat6.x + 1.0;
    u_xlat0.x = u_xlat6.x / u_xlat0.x;
    u_xlat4 = u_xlat8.x * u_xlat0.x + -0.5;
    u_xlat8.x = u_xlat0.x * u_xlat1.y;
    u_xlat1.xy = vec2((-u_xlat1.z) * _GradientScale, (-u_xlat1.w) * _GradientScale);
    u_xlat1.xy = vec2(u_xlat1.x / float(_TextureWidth), u_xlat1.y / float(_TextureHeight));
    vs_TEXCOORD4.xy = u_xlat1.xy + in_TEXCOORD0.xy;
    vs_TEXCOORD4.z = u_xlat0.x;
    vs_TEXCOORD4.w = (-u_xlat8.x) * 0.5 + u_xlat4;
    u_xlat0.xyz = _UnderlayColor.www * _UnderlayColor.xyz;
    vs_COLOR1.xyz = u_xlat0.xyz;
    vs_COLOR1.w = _UnderlayColor.w;
    u_xlat0.x = in_TEXCOORD1.x * 0.000244140625;
    u_xlat8.x = floor(u_xlat0.x);
    u_xlat8.y = (-u_xlat8.x) * 4096.0 + in_TEXCOORD1.x;
    u_xlat0.xy = u_xlat8.xy * vec2(0.001953125, 0.001953125);
    vs_TEXCOORD5.xy = u_xlat0.xy * _FaceTex_ST.xy + _FaceTex_ST.zw;
    vs_TEXCOORD5.zw = u_xlat0.xy * _OutlineTex_ST.xy + _OutlineTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _FaceUVSpeedX;
uniform 	float _FaceUVSpeedY;
uniform 	mediump vec4 _FaceColor;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineUVSpeedX;
uniform 	float _OutlineUVSpeedY;
uniform 	mediump vec4 _OutlineColor;
uniform 	float _OutlineWidth;
uniform 	float _Bevel;
uniform 	float _BevelOffset;
uniform 	float _BevelWidth;
uniform 	float _BevelClamp;
uniform 	float _BevelRoundness;
uniform 	float _BumpOutline;
uniform 	float _BumpFace;
uniform 	mediump vec4 _ReflectFaceColor;
uniform 	mediump vec4 _ReflectOutlineColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	float _LightAngle;
uniform 	float _SpecularPower;
uniform 	float _Reflectivity;
uniform 	float _Diffuse;
uniform 	float _Ambient;
uniform 	mediump vec4 _GlowColor;
uniform 	float _GlowOffset;
uniform 	float _GlowOuter;
uniform 	float _GlowInner;
uniform 	float _GlowPower;
uniform 	float _ShaderFlags;
uniform 	float _ScaleRatioA;
uniform 	float _ScaleRatioB;
uniform 	vec4 _ClipRect;
uniform 	float _TextureWidth;
uniform 	float _TextureHeight;
uniform 	float _GradientScale;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FaceTex;
uniform lowp sampler2D _OutlineTex;
uniform lowp sampler2D _BumpMap;
uniform lowp samplerCube _Cube;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
vec4 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec4 u_xlat16_5;
lowp vec4 u_xlat10_5;
mediump vec4 u_xlat16_6;
float u_xlat7;
mediump vec4 u_xlat16_7;
float u_xlat8;
float u_xlat9;
bool u_xlatb9;
vec2 u_xlat10;
mediump float u_xlat16_12;
float u_xlat16;
bool u_xlatb17;
mediump float u_xlat16_20;
float u_xlat24;
mediump float u_xlat16_24;
lowp float u_xlat10_24;
float u_xlat26;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w + _BevelOffset;
    u_xlat1.xy = vec2(float(0.5) / float(_TextureWidth), float(0.5) / float(_TextureHeight));
    u_xlat1.z = 0.0;
    u_xlat2 = (-u_xlat1.xzzy) + vs_TEXCOORD0.xyxy;
    u_xlat1 = u_xlat1.xzzy + vs_TEXCOORD0.xyxy;
    u_xlat3.x = texture(_MainTex, u_xlat2.xy).w;
    u_xlat3.z = texture(_MainTex, u_xlat2.zw).w;
    u_xlat3.y = texture(_MainTex, u_xlat1.xy).w;
    u_xlat3.w = texture(_MainTex, u_xlat1.zw).w;
    u_xlat0 = u_xlat0.xxxx + u_xlat3;
    u_xlat0 = u_xlat0 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat1.x = _BevelWidth + _OutlineWidth;
    u_xlat1.x = max(u_xlat1.x, 0.00999999978);
    u_xlat0 = u_xlat0 / u_xlat1.xxxx;
    u_xlat1.x = u_xlat1.x * _Bevel;
    u_xlat1.x = u_xlat1.x * _GradientScale;
    u_xlat1.x = u_xlat1.x * -2.0;
    u_xlat0 = u_xlat0 + vec4(0.5, 0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat2 = u_xlat0 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = -abs(u_xlat2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat9 = _ShaderFlags * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb17 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat9 = fract(abs(u_xlat9));
    u_xlat9 = (u_xlatb17) ? u_xlat9 : (-u_xlat9);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=0.5);
#else
    u_xlatb9 = u_xlat9>=0.5;
#endif
    u_xlat0 = (bool(u_xlatb9)) ? u_xlat2 : u_xlat0;
    u_xlat2 = u_xlat0 * vec4(1.57079601, 1.57079601, 1.57079601, 1.57079601);
    u_xlat2 = sin(u_xlat2);
    u_xlat2 = (-u_xlat0) + u_xlat2;
    u_xlat0 = vec4(vec4(_BevelRoundness, _BevelRoundness, _BevelRoundness, _BevelRoundness)) * u_xlat2 + u_xlat0;
    u_xlat9 = (-_BevelClamp) + 1.0;
    u_xlat0 = min(u_xlat0, vec4(u_xlat9));
    u_xlat0.xz = u_xlat1.xx * u_xlat0.xz;
    u_xlat0.yz = u_xlat0.wy * u_xlat1.xx + (-u_xlat0.zx);
    u_xlat0.x = float(-1.0);
    u_xlat0.w = float(1.0);
    u_xlat1.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat24 = dot(u_xlat0.zw, u_xlat0.zw);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.x = u_xlat24 * u_xlat0.z;
    u_xlat2.yz = vec2(u_xlat24) * vec2(1.0, 0.0);
    u_xlat0.z = 0.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat2.zxy * u_xlat0.yzx + (-u_xlat1.xyz);
    u_xlat1.xy = vec2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy + vs_TEXCOORD5.xy;
    u_xlat10_2.xyz = texture(_BumpMap, u_xlat1.xy).xyz;
    u_xlat10_1 = texture(_FaceTex, u_xlat1.xy);
    u_xlat16_4.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat24 = (-_BumpFace) + _BumpOutline;
    u_xlat10_2.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat2.x = (-u_xlat10_2.x) + vs_TEXCOORD1.z;
    u_xlat2.z = _OutlineWidth * _ScaleRatioA;
    u_xlat10.xy = u_xlat2.xz * vs_TEXCOORD1.yy;
    u_xlat26 = u_xlat10.y * 0.5 + u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat26 * u_xlat24 + _BumpFace;
    u_xlat0.xyz = (-u_xlat16_4.xyz) * vec3(u_xlat24) + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(vs_TEXCOORD3.xyz, (-u_xlat0.xyz));
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat3.xyz = u_xlat0.xyz * vec3(u_xlat24) + vs_TEXCOORD3.xyz;
    u_xlat10_3.xyz = texture(_Cube, u_xlat3.xyz).xyz;
    u_xlat16_5.xyz = (-_ReflectFaceColor.xyz) + _ReflectOutlineColor.xyz;
    u_xlat5.xyz = vec3(u_xlat26) * u_xlat16_5.xyz + _ReflectFaceColor.xyz;
    u_xlat3.xyz = u_xlat10_3.xyz * u_xlat5.xyz;
    u_xlat16_4.x = min(u_xlat10.y, 1.0);
    u_xlat16_12 = u_xlat10.y * 0.5;
    u_xlat16_4.x = sqrt(u_xlat16_4.x);
    u_xlat16_20 = u_xlat2.x * vs_TEXCOORD1.y + u_xlat16_12;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat2.x * vs_TEXCOORD1.y + (-u_xlat16_12);
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_20;
    u_xlat16_6.xyz = vs_COLOR0.xyz * _FaceColor.xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_6.xyz;
    u_xlat16_24 = u_xlat10_1.w * _FaceColor.w;
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_1.xyz;
    u_xlat2.xz = vec2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy + vs_TEXCOORD5.zw;
    u_xlat10_5 = texture(_OutlineTex, u_xlat2.xz);
    u_xlat16_7 = u_xlat10_5 * _OutlineColor;
    u_xlat16_5.w = _OutlineColor.w * u_xlat10_5.w + (-u_xlat16_24);
    u_xlat16_5.xyz = u_xlat16_7.xyz * u_xlat16_7.www + (-u_xlat16_6.xyz);
    u_xlat16_5 = u_xlat16_4.xxxx * u_xlat16_5;
    u_xlat16_6.xyz = u_xlat16_1.xyz * vec3(u_xlat16_24) + u_xlat16_5.xyz;
    u_xlat16_6.w = _FaceColor.w * u_xlat10_1.w + u_xlat16_5.w;
    u_xlat24 = _OutlineSoftness * _ScaleRatioA;
    u_xlat1.x = u_xlat24 * vs_TEXCOORD1.y;
    u_xlat16_4.x = u_xlat24 * vs_TEXCOORD1.y + 1.0;
    u_xlat16_12 = u_xlat1.x * 0.5 + u_xlat16_12;
    u_xlat16_4.x = u_xlat16_12 / u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_1 = u_xlat16_4.xxxx * u_xlat16_6;
    u_xlat16_4.x = (-u_xlat16_6.w) * u_xlat16_4.x + 1.0;
    u_xlat2.xzw = u_xlat16_1.www * u_xlat3.xyz;
    u_xlat3.x = sin(_LightAngle);
    u_xlat7 = cos(_LightAngle);
    u_xlat3.y = u_xlat7;
    u_xlat3.z = -1.0;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat8 = u_xlat0.z * u_xlat0.z;
    u_xlat16 = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-u_xlat0.x) * _Diffuse + 1.0;
    u_xlat16 = log2(u_xlat16);
    u_xlat16 = u_xlat16 * _Reflectivity;
    u_xlat16 = exp2(u_xlat16);
    u_xlat3.xyz = vec3(u_xlat16) * _SpecularColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_SpecularPower, _SpecularPower, _SpecularPower));
    u_xlat3.xyz = u_xlat3.xyz * u_xlat16_1.www + u_xlat16_1.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat3.x = (-_Ambient) + 1.0;
    u_xlat8 = u_xlat8 * u_xlat3.x + _Ambient;
    u_xlat0.xyz = u_xlat0.xzw * vec3(u_xlat8) + u_xlat2.xzw;
    u_xlat10_24 = texture(_MainTex, vs_TEXCOORD4.xy).w;
    u_xlat24 = u_xlat10_24 * vs_TEXCOORD4.z + (-vs_TEXCOORD4.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat3 = vec4(u_xlat24) * vs_COLOR1;
    u_xlat0.xyz = u_xlat3.xyz * u_xlat16_4.xxx + u_xlat0.xyz;
    u_xlat1.w = u_xlat3.w * u_xlat16_4.x + u_xlat16_1.w;
    u_xlat24 = _GlowOffset * _ScaleRatioB;
    u_xlat24 = u_xlat24 * vs_TEXCOORD1.y;
    u_xlat24 = (-u_xlat24) * 0.5 + u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat24>=0.0);
#else
    u_xlatb2 = u_xlat24>=0.0;
#endif
    u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat10.x = _GlowOuter * _ScaleRatioB + (-_GlowInner);
    u_xlat2.x = u_xlat2.x * u_xlat10.x + _GlowInner;
    u_xlat2.x = u_xlat2.x * vs_TEXCOORD1.y;
    u_xlat10.x = u_xlat2.x * 0.5 + 1.0;
    u_xlat2.x = u_xlat2.x * 0.5;
    u_xlat2.x = min(u_xlat2.x, 1.0);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat24 = u_xlat24 / u_xlat10.x;
    u_xlat24 = min(abs(u_xlat24), 1.0);
    u_xlat24 = log2(u_xlat24);
    u_xlat24 = u_xlat24 * _GlowPower;
    u_xlat24 = exp2(u_xlat24);
    u_xlat24 = (-u_xlat24) + 1.0;
    u_xlat24 = u_xlat2.x * u_xlat24;
    u_xlat24 = dot(_GlowColor.ww, vec2(u_xlat24));
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat1.xyz = _GlowColor.xyz * vec3(u_xlat24) + u_xlat0.xyz;
    u_xlat0.xy = vec2((-_ClipRect.x) + _ClipRect.z, (-_ClipRect.y) + _ClipRect.w);
    u_xlat0.xy = u_xlat0.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat0.xy = vec2(u_xlat0.x * vs_TEXCOORD2.z, u_xlat0.y * vs_TEXCOORD2.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_0 = u_xlat1 * u_xlat16_4.xxxx;
    SV_Target0 = u_xlat16_0 * vs_COLOR0.wwww;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _FaceDilate;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineWidth;
uniform 	vec4 hlslcc_mtx4x4_EnvMatrix[4];
uniform 	mediump vec4 _UnderlayColor;
uniform 	float _UnderlayOffsetX;
uniform 	float _UnderlayOffsetY;
uniform 	float _UnderlayDilate;
uniform 	float _UnderlaySoftness;
uniform 	float _GlowOffset;
uniform 	float _GlowOuter;
uniform 	float _WeightNormal;
uniform 	float _WeightBold;
uniform 	float _ScaleRatioA;
uniform 	float _ScaleRatioB;
uniform 	float _ScaleRatioC;
uniform 	float _VertexOffsetX;
uniform 	float _VertexOffsetY;
uniform 	vec4 _ClipRect;
uniform 	float _MaskSoftnessX;
uniform 	float _MaskSoftnessY;
uniform 	float _TextureWidth;
uniform 	float _TextureHeight;
uniform 	float _GradientScale;
uniform 	float _ScaleX;
uniform 	float _ScaleY;
uniform 	float _PerspectiveFilter;
uniform 	vec4 _FaceTex_ST;
uniform 	vec4 _OutlineTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat4;
vec3 u_xlat6;
vec2 u_xlat8;
float u_xlat12;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat0.xy = vec2(in_POSITION0.x + float(_VertexOffsetX), in_POSITION0.y + float(_VertexOffsetY));
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat8.x = (-_OutlineWidth) * _ScaleRatioA + 1.0;
    u_xlat8.x = (-_OutlineSoftness) * _ScaleRatioA + u_xlat8.x;
    u_xlat12 = (-_GlowOffset) * _ScaleRatioB + 1.0;
    u_xlat12 = (-_GlowOuter) * _ScaleRatioB + u_xlat12;
    u_xlat8.x = min(u_xlat12, u_xlat8.x);
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat2.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat2.xy;
    u_xlat2.xy = vec2(abs(u_xlat2.x) * float(_ScaleX), abs(u_xlat2.y) * float(_ScaleY));
    u_xlat2.xy = u_xlat2.ww / u_xlat2.xy;
    u_xlat13 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat2.xy;
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat2.xy;
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.x = abs(in_TEXCOORD1.y) * _GradientScale;
    u_xlat13 = u_xlat13 * u_xlat2.x;
    u_xlat2.x = u_xlat13 * 1.5;
    u_xlat6.x = (-_PerspectiveFilter) + 1.0;
    u_xlat6.x = u_xlat6.x * abs(u_xlat2.x);
    u_xlat13 = u_xlat13 * 1.5 + (-u_xlat6.x);
    u_xlat12 = abs(u_xlat12) * u_xlat13 + u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0);
#else
    u_xlatb13 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
#endif
    u_xlat6.x = (u_xlatb13) ? u_xlat12 : u_xlat2.x;
    u_xlat12 = 0.5 / u_xlat6.x;
    u_xlat8.x = u_xlat8.x * 0.5 + (-u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.0>=in_TEXCOORD1.y);
#else
    u_xlatb13 = 0.0>=in_TEXCOORD1.y;
#endif
    u_xlat13 = u_xlatb13 ? 1.0 : float(0.0);
    u_xlat2.x = (-_WeightNormal) + _WeightBold;
    u_xlat13 = u_xlat13 * u_xlat2.x + _WeightNormal;
    u_xlat13 = u_xlat13 * 0.25 + _FaceDilate;
    u_xlat13 = u_xlat13 * _ScaleRatioA;
    vs_TEXCOORD1.x = (-u_xlat13) * 0.5 + u_xlat8.x;
    u_xlat6.z = u_xlat13 * 0.5;
    u_xlat8.x = (-u_xlat13) * 0.5 + 0.5;
    vs_TEXCOORD1.yw = u_xlat6.xz;
    vs_TEXCOORD1.z = u_xlat12 + u_xlat8.x;
    u_xlat3 = max(_ClipRect, vec4(-2e+010, -2e+010, -2e+010, -2e+010));
    u_xlat3 = min(u_xlat3, vec4(2e+010, 2e+010, 2e+010, 2e+010));
    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat3.xy);
    vs_TEXCOORD2.xy = vec2((-u_xlat3.z) + u_xlat0.x, (-u_xlat3.w) + u_xlat0.y);
    u_xlat0.xyw = u_xlat1.yyy * hlslcc_mtx4x4_EnvMatrix[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_EnvMatrix[0].xyz * u_xlat1.xxx + u_xlat0.xyw;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4_EnvMatrix[2].xyz * u_xlat1.zzz + u_xlat0.xyw;
    u_xlat1 = vec4(_UnderlaySoftness, _UnderlayDilate, _UnderlayOffsetX, _UnderlayOffsetY) * vec4(vec4(_ScaleRatioC, _ScaleRatioC, _ScaleRatioC, _ScaleRatioC));
    u_xlat0.x = u_xlat1.x * u_xlat6.x + 1.0;
    u_xlat0.x = u_xlat6.x / u_xlat0.x;
    u_xlat4 = u_xlat8.x * u_xlat0.x + -0.5;
    u_xlat8.x = u_xlat0.x * u_xlat1.y;
    u_xlat1.xy = vec2((-u_xlat1.z) * _GradientScale, (-u_xlat1.w) * _GradientScale);
    u_xlat1.xy = vec2(u_xlat1.x / float(_TextureWidth), u_xlat1.y / float(_TextureHeight));
    vs_TEXCOORD4.xy = u_xlat1.xy + in_TEXCOORD0.xy;
    vs_TEXCOORD4.z = u_xlat0.x;
    vs_TEXCOORD4.w = (-u_xlat8.x) * 0.5 + u_xlat4;
    u_xlat0.xyz = _UnderlayColor.www * _UnderlayColor.xyz;
    vs_COLOR1.xyz = u_xlat0.xyz;
    vs_COLOR1.w = _UnderlayColor.w;
    u_xlat0.x = in_TEXCOORD1.x * 0.000244140625;
    u_xlat8.x = floor(u_xlat0.x);
    u_xlat8.y = (-u_xlat8.x) * 4096.0 + in_TEXCOORD1.x;
    u_xlat0.xy = u_xlat8.xy * vec2(0.001953125, 0.001953125);
    vs_TEXCOORD5.xy = u_xlat0.xy * _FaceTex_ST.xy + _FaceTex_ST.zw;
    vs_TEXCOORD5.zw = u_xlat0.xy * _OutlineTex_ST.xy + _OutlineTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _FaceUVSpeedX;
uniform 	float _FaceUVSpeedY;
uniform 	mediump vec4 _FaceColor;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineUVSpeedX;
uniform 	float _OutlineUVSpeedY;
uniform 	mediump vec4 _OutlineColor;
uniform 	float _OutlineWidth;
uniform 	float _Bevel;
uniform 	float _BevelOffset;
uniform 	float _BevelWidth;
uniform 	float _BevelClamp;
uniform 	float _BevelRoundness;
uniform 	float _BumpOutline;
uniform 	float _BumpFace;
uniform 	mediump vec4 _ReflectFaceColor;
uniform 	mediump vec4 _ReflectOutlineColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	float _LightAngle;
uniform 	float _SpecularPower;
uniform 	float _Reflectivity;
uniform 	float _Diffuse;
uniform 	float _Ambient;
uniform 	mediump vec4 _GlowColor;
uniform 	float _GlowOffset;
uniform 	float _GlowOuter;
uniform 	float _GlowInner;
uniform 	float _GlowPower;
uniform 	float _ShaderFlags;
uniform 	float _ScaleRatioA;
uniform 	float _ScaleRatioB;
uniform 	vec4 _ClipRect;
uniform 	float _TextureWidth;
uniform 	float _TextureHeight;
uniform 	float _GradientScale;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FaceTex;
uniform lowp sampler2D _OutlineTex;
uniform lowp sampler2D _BumpMap;
uniform lowp samplerCube _Cube;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
vec4 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec4 u_xlat16_5;
lowp vec4 u_xlat10_5;
mediump vec4 u_xlat16_6;
float u_xlat7;
mediump vec4 u_xlat16_7;
float u_xlat8;
float u_xlat9;
bool u_xlatb9;
vec2 u_xlat10;
mediump float u_xlat16_12;
float u_xlat16;
bool u_xlatb17;
mediump float u_xlat16_20;
float u_xlat24;
mediump float u_xlat16_24;
lowp float u_xlat10_24;
float u_xlat26;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w + _BevelOffset;
    u_xlat1.xy = vec2(float(0.5) / float(_TextureWidth), float(0.5) / float(_TextureHeight));
    u_xlat1.z = 0.0;
    u_xlat2 = (-u_xlat1.xzzy) + vs_TEXCOORD0.xyxy;
    u_xlat1 = u_xlat1.xzzy + vs_TEXCOORD0.xyxy;
    u_xlat3.x = texture(_MainTex, u_xlat2.xy).w;
    u_xlat3.z = texture(_MainTex, u_xlat2.zw).w;
    u_xlat3.y = texture(_MainTex, u_xlat1.xy).w;
    u_xlat3.w = texture(_MainTex, u_xlat1.zw).w;
    u_xlat0 = u_xlat0.xxxx + u_xlat3;
    u_xlat0 = u_xlat0 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat1.x = _BevelWidth + _OutlineWidth;
    u_xlat1.x = max(u_xlat1.x, 0.00999999978);
    u_xlat0 = u_xlat0 / u_xlat1.xxxx;
    u_xlat1.x = u_xlat1.x * _Bevel;
    u_xlat1.x = u_xlat1.x * _GradientScale;
    u_xlat1.x = u_xlat1.x * -2.0;
    u_xlat0 = u_xlat0 + vec4(0.5, 0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat2 = u_xlat0 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = -abs(u_xlat2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat9 = _ShaderFlags * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb17 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat9 = fract(abs(u_xlat9));
    u_xlat9 = (u_xlatb17) ? u_xlat9 : (-u_xlat9);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=0.5);
#else
    u_xlatb9 = u_xlat9>=0.5;
#endif
    u_xlat0 = (bool(u_xlatb9)) ? u_xlat2 : u_xlat0;
    u_xlat2 = u_xlat0 * vec4(1.57079601, 1.57079601, 1.57079601, 1.57079601);
    u_xlat2 = sin(u_xlat2);
    u_xlat2 = (-u_xlat0) + u_xlat2;
    u_xlat0 = vec4(vec4(_BevelRoundness, _BevelRoundness, _BevelRoundness, _BevelRoundness)) * u_xlat2 + u_xlat0;
    u_xlat9 = (-_BevelClamp) + 1.0;
    u_xlat0 = min(u_xlat0, vec4(u_xlat9));
    u_xlat0.xz = u_xlat1.xx * u_xlat0.xz;
    u_xlat0.yz = u_xlat0.wy * u_xlat1.xx + (-u_xlat0.zx);
    u_xlat0.x = float(-1.0);
    u_xlat0.w = float(1.0);
    u_xlat1.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat24 = dot(u_xlat0.zw, u_xlat0.zw);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.x = u_xlat24 * u_xlat0.z;
    u_xlat2.yz = vec2(u_xlat24) * vec2(1.0, 0.0);
    u_xlat0.z = 0.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat2.zxy * u_xlat0.yzx + (-u_xlat1.xyz);
    u_xlat1.xy = vec2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy + vs_TEXCOORD5.xy;
    u_xlat10_2.xyz = texture(_BumpMap, u_xlat1.xy).xyz;
    u_xlat10_1 = texture(_FaceTex, u_xlat1.xy);
    u_xlat16_4.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat24 = (-_BumpFace) + _BumpOutline;
    u_xlat10_2.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat2.x = (-u_xlat10_2.x) + vs_TEXCOORD1.z;
    u_xlat2.z = _OutlineWidth * _ScaleRatioA;
    u_xlat10.xy = u_xlat2.xz * vs_TEXCOORD1.yy;
    u_xlat26 = u_xlat10.y * 0.5 + u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat26 * u_xlat24 + _BumpFace;
    u_xlat0.xyz = (-u_xlat16_4.xyz) * vec3(u_xlat24) + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(vs_TEXCOORD3.xyz, (-u_xlat0.xyz));
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat3.xyz = u_xlat0.xyz * vec3(u_xlat24) + vs_TEXCOORD3.xyz;
    u_xlat10_3.xyz = texture(_Cube, u_xlat3.xyz).xyz;
    u_xlat16_5.xyz = (-_ReflectFaceColor.xyz) + _ReflectOutlineColor.xyz;
    u_xlat5.xyz = vec3(u_xlat26) * u_xlat16_5.xyz + _ReflectFaceColor.xyz;
    u_xlat3.xyz = u_xlat10_3.xyz * u_xlat5.xyz;
    u_xlat16_4.x = min(u_xlat10.y, 1.0);
    u_xlat16_12 = u_xlat10.y * 0.5;
    u_xlat16_4.x = sqrt(u_xlat16_4.x);
    u_xlat16_20 = u_xlat2.x * vs_TEXCOORD1.y + u_xlat16_12;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat2.x * vs_TEXCOORD1.y + (-u_xlat16_12);
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_20;
    u_xlat16_6.xyz = vs_COLOR0.xyz * _FaceColor.xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_6.xyz;
    u_xlat16_24 = u_xlat10_1.w * _FaceColor.w;
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_1.xyz;
    u_xlat2.xz = vec2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy + vs_TEXCOORD5.zw;
    u_xlat10_5 = texture(_OutlineTex, u_xlat2.xz);
    u_xlat16_7 = u_xlat10_5 * _OutlineColor;
    u_xlat16_5.w = _OutlineColor.w * u_xlat10_5.w + (-u_xlat16_24);
    u_xlat16_5.xyz = u_xlat16_7.xyz * u_xlat16_7.www + (-u_xlat16_6.xyz);
    u_xlat16_5 = u_xlat16_4.xxxx * u_xlat16_5;
    u_xlat16_6.xyz = u_xlat16_1.xyz * vec3(u_xlat16_24) + u_xlat16_5.xyz;
    u_xlat16_6.w = _FaceColor.w * u_xlat10_1.w + u_xlat16_5.w;
    u_xlat24 = _OutlineSoftness * _ScaleRatioA;
    u_xlat1.x = u_xlat24 * vs_TEXCOORD1.y;
    u_xlat16_4.x = u_xlat24 * vs_TEXCOORD1.y + 1.0;
    u_xlat16_12 = u_xlat1.x * 0.5 + u_xlat16_12;
    u_xlat16_4.x = u_xlat16_12 / u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_1 = u_xlat16_4.xxxx * u_xlat16_6;
    u_xlat16_4.x = (-u_xlat16_6.w) * u_xlat16_4.x + 1.0;
    u_xlat2.xzw = u_xlat16_1.www * u_xlat3.xyz;
    u_xlat3.x = sin(_LightAngle);
    u_xlat7 = cos(_LightAngle);
    u_xlat3.y = u_xlat7;
    u_xlat3.z = -1.0;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat8 = u_xlat0.z * u_xlat0.z;
    u_xlat16 = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-u_xlat0.x) * _Diffuse + 1.0;
    u_xlat16 = log2(u_xlat16);
    u_xlat16 = u_xlat16 * _Reflectivity;
    u_xlat16 = exp2(u_xlat16);
    u_xlat3.xyz = vec3(u_xlat16) * _SpecularColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_SpecularPower, _SpecularPower, _SpecularPower));
    u_xlat3.xyz = u_xlat3.xyz * u_xlat16_1.www + u_xlat16_1.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat3.x = (-_Ambient) + 1.0;
    u_xlat8 = u_xlat8 * u_xlat3.x + _Ambient;
    u_xlat0.xyz = u_xlat0.xzw * vec3(u_xlat8) + u_xlat2.xzw;
    u_xlat10_24 = texture(_MainTex, vs_TEXCOORD4.xy).w;
    u_xlat24 = u_xlat10_24 * vs_TEXCOORD4.z + (-vs_TEXCOORD4.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat3 = vec4(u_xlat24) * vs_COLOR1;
    u_xlat0.xyz = u_xlat3.xyz * u_xlat16_4.xxx + u_xlat0.xyz;
    u_xlat1.w = u_xlat3.w * u_xlat16_4.x + u_xlat16_1.w;
    u_xlat24 = _GlowOffset * _ScaleRatioB;
    u_xlat24 = u_xlat24 * vs_TEXCOORD1.y;
    u_xlat24 = (-u_xlat24) * 0.5 + u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat24>=0.0);
#else
    u_xlatb2 = u_xlat24>=0.0;
#endif
    u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat10.x = _GlowOuter * _ScaleRatioB + (-_GlowInner);
    u_xlat2.x = u_xlat2.x * u_xlat10.x + _GlowInner;
    u_xlat2.x = u_xlat2.x * vs_TEXCOORD1.y;
    u_xlat10.x = u_xlat2.x * 0.5 + 1.0;
    u_xlat2.x = u_xlat2.x * 0.5;
    u_xlat2.x = min(u_xlat2.x, 1.0);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat24 = u_xlat24 / u_xlat10.x;
    u_xlat24 = min(abs(u_xlat24), 1.0);
    u_xlat24 = log2(u_xlat24);
    u_xlat24 = u_xlat24 * _GlowPower;
    u_xlat24 = exp2(u_xlat24);
    u_xlat24 = (-u_xlat24) + 1.0;
    u_xlat24 = u_xlat2.x * u_xlat24;
    u_xlat24 = dot(_GlowColor.ww, vec2(u_xlat24));
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat1.xyz = _GlowColor.xyz * vec3(u_xlat24) + u_xlat0.xyz;
    u_xlat0.xy = vec2((-_ClipRect.x) + _ClipRect.z, (-_ClipRect.y) + _ClipRect.w);
    u_xlat0.xy = u_xlat0.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat0.xy = vec2(u_xlat0.x * vs_TEXCOORD2.z, u_xlat0.y * vs_TEXCOORD2.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_0 = u_xlat1 * u_xlat16_4.xxxx;
    SV_Target0 = u_xlat16_0 * vs_COLOR0.wwww;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _FaceDilate;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineWidth;
uniform 	vec4 hlslcc_mtx4x4_EnvMatrix[4];
uniform 	mediump vec4 _UnderlayColor;
uniform 	float _UnderlayOffsetX;
uniform 	float _UnderlayOffsetY;
uniform 	float _UnderlayDilate;
uniform 	float _UnderlaySoftness;
uniform 	float _GlowOffset;
uniform 	float _GlowOuter;
uniform 	float _WeightNormal;
uniform 	float _WeightBold;
uniform 	float _ScaleRatioA;
uniform 	float _ScaleRatioB;
uniform 	float _ScaleRatioC;
uniform 	float _VertexOffsetX;
uniform 	float _VertexOffsetY;
uniform 	vec4 _ClipRect;
uniform 	float _MaskSoftnessX;
uniform 	float _MaskSoftnessY;
uniform 	float _TextureWidth;
uniform 	float _TextureHeight;
uniform 	float _GradientScale;
uniform 	float _ScaleX;
uniform 	float _ScaleY;
uniform 	float _PerspectiveFilter;
uniform 	vec4 _FaceTex_ST;
uniform 	vec4 _OutlineTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat4;
vec3 u_xlat6;
vec2 u_xlat8;
float u_xlat12;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat0.xy = vec2(in_POSITION0.x + float(_VertexOffsetX), in_POSITION0.y + float(_VertexOffsetY));
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat8.x = (-_OutlineWidth) * _ScaleRatioA + 1.0;
    u_xlat8.x = (-_OutlineSoftness) * _ScaleRatioA + u_xlat8.x;
    u_xlat12 = (-_GlowOffset) * _ScaleRatioB + 1.0;
    u_xlat12 = (-_GlowOuter) * _ScaleRatioB + u_xlat12;
    u_xlat8.x = min(u_xlat12, u_xlat8.x);
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat2.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat2.xy;
    u_xlat2.xy = vec2(abs(u_xlat2.x) * float(_ScaleX), abs(u_xlat2.y) * float(_ScaleY));
    u_xlat2.xy = u_xlat2.ww / u_xlat2.xy;
    u_xlat13 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat2.xy;
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat2.xy;
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.x = abs(in_TEXCOORD1.y) * _GradientScale;
    u_xlat13 = u_xlat13 * u_xlat2.x;
    u_xlat2.x = u_xlat13 * 1.5;
    u_xlat6.x = (-_PerspectiveFilter) + 1.0;
    u_xlat6.x = u_xlat6.x * abs(u_xlat2.x);
    u_xlat13 = u_xlat13 * 1.5 + (-u_xlat6.x);
    u_xlat12 = abs(u_xlat12) * u_xlat13 + u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0);
#else
    u_xlatb13 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
#endif
    u_xlat6.x = (u_xlatb13) ? u_xlat12 : u_xlat2.x;
    u_xlat12 = 0.5 / u_xlat6.x;
    u_xlat8.x = u_xlat8.x * 0.5 + (-u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.0>=in_TEXCOORD1.y);
#else
    u_xlatb13 = 0.0>=in_TEXCOORD1.y;
#endif
    u_xlat13 = u_xlatb13 ? 1.0 : float(0.0);
    u_xlat2.x = (-_WeightNormal) + _WeightBold;
    u_xlat13 = u_xlat13 * u_xlat2.x + _WeightNormal;
    u_xlat13 = u_xlat13 * 0.25 + _FaceDilate;
    u_xlat13 = u_xlat13 * _ScaleRatioA;
    vs_TEXCOORD1.x = (-u_xlat13) * 0.5 + u_xlat8.x;
    u_xlat6.z = u_xlat13 * 0.5;
    u_xlat8.x = (-u_xlat13) * 0.5 + 0.5;
    vs_TEXCOORD1.yw = u_xlat6.xz;
    vs_TEXCOORD1.z = u_xlat12 + u_xlat8.x;
    u_xlat3 = max(_ClipRect, vec4(-2e+010, -2e+010, -2e+010, -2e+010));
    u_xlat3 = min(u_xlat3, vec4(2e+010, 2e+010, 2e+010, 2e+010));
    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat3.xy);
    vs_TEXCOORD2.xy = vec2((-u_xlat3.z) + u_xlat0.x, (-u_xlat3.w) + u_xlat0.y);
    u_xlat0.xyw = u_xlat1.yyy * hlslcc_mtx4x4_EnvMatrix[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_EnvMatrix[0].xyz * u_xlat1.xxx + u_xlat0.xyw;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4_EnvMatrix[2].xyz * u_xlat1.zzz + u_xlat0.xyw;
    u_xlat1 = vec4(_UnderlaySoftness, _UnderlayDilate, _UnderlayOffsetX, _UnderlayOffsetY) * vec4(vec4(_ScaleRatioC, _ScaleRatioC, _ScaleRatioC, _ScaleRatioC));
    u_xlat0.x = u_xlat1.x * u_xlat6.x + 1.0;
    u_xlat0.x = u_xlat6.x / u_xlat0.x;
    u_xlat4 = u_xlat8.x * u_xlat0.x + -0.5;
    u_xlat8.x = u_xlat0.x * u_xlat1.y;
    u_xlat1.xy = vec2((-u_xlat1.z) * _GradientScale, (-u_xlat1.w) * _GradientScale);
    u_xlat1.xy = vec2(u_xlat1.x / float(_TextureWidth), u_xlat1.y / float(_TextureHeight));
    vs_TEXCOORD4.xy = u_xlat1.xy + in_TEXCOORD0.xy;
    vs_TEXCOORD4.z = u_xlat0.x;
    vs_TEXCOORD4.w = (-u_xlat8.x) * 0.5 + u_xlat4;
    u_xlat0.xyz = _UnderlayColor.www * _UnderlayColor.xyz;
    vs_COLOR1.xyz = u_xlat0.xyz;
    vs_COLOR1.w = _UnderlayColor.w;
    u_xlat0.x = in_TEXCOORD1.x * 0.000244140625;
    u_xlat8.x = floor(u_xlat0.x);
    u_xlat8.y = (-u_xlat8.x) * 4096.0 + in_TEXCOORD1.x;
    u_xlat0.xy = u_xlat8.xy * vec2(0.001953125, 0.001953125);
    vs_TEXCOORD5.xy = u_xlat0.xy * _FaceTex_ST.xy + _FaceTex_ST.zw;
    vs_TEXCOORD5.zw = u_xlat0.xy * _OutlineTex_ST.xy + _OutlineTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _FaceUVSpeedX;
uniform 	float _FaceUVSpeedY;
uniform 	mediump vec4 _FaceColor;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineUVSpeedX;
uniform 	float _OutlineUVSpeedY;
uniform 	mediump vec4 _OutlineColor;
uniform 	float _OutlineWidth;
uniform 	float _Bevel;
uniform 	float _BevelOffset;
uniform 	float _BevelWidth;
uniform 	float _BevelClamp;
uniform 	float _BevelRoundness;
uniform 	float _BumpOutline;
uniform 	float _BumpFace;
uniform 	mediump vec4 _ReflectFaceColor;
uniform 	mediump vec4 _ReflectOutlineColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	float _LightAngle;
uniform 	float _SpecularPower;
uniform 	float _Reflectivity;
uniform 	float _Diffuse;
uniform 	float _Ambient;
uniform 	mediump vec4 _GlowColor;
uniform 	float _GlowOffset;
uniform 	float _GlowOuter;
uniform 	float _GlowInner;
uniform 	float _GlowPower;
uniform 	float _ShaderFlags;
uniform 	float _ScaleRatioA;
uniform 	float _ScaleRatioB;
uniform 	vec4 _ClipRect;
uniform 	float _TextureWidth;
uniform 	float _TextureHeight;
uniform 	float _GradientScale;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FaceTex;
uniform lowp sampler2D _OutlineTex;
uniform lowp sampler2D _BumpMap;
uniform lowp samplerCube _Cube;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec3 u_xlat10_2;
bool u_xlatb2;
vec4 u_xlat3;
lowp vec3 u_xlat10_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec4 u_xlat16_5;
lowp vec4 u_xlat10_5;
mediump vec4 u_xlat16_6;
float u_xlat7;
mediump vec4 u_xlat16_7;
float u_xlat8;
float u_xlat9;
bool u_xlatb9;
vec2 u_xlat10;
mediump float u_xlat16_12;
float u_xlat16;
bool u_xlatb17;
mediump float u_xlat16_20;
float u_xlat24;
mediump float u_xlat16_24;
lowp float u_xlat10_24;
float u_xlat26;
void main()
{
    u_xlat0.x = vs_TEXCOORD1.w + _BevelOffset;
    u_xlat1.xy = vec2(float(0.5) / float(_TextureWidth), float(0.5) / float(_TextureHeight));
    u_xlat1.z = 0.0;
    u_xlat2 = (-u_xlat1.xzzy) + vs_TEXCOORD0.xyxy;
    u_xlat1 = u_xlat1.xzzy + vs_TEXCOORD0.xyxy;
    u_xlat3.x = texture(_MainTex, u_xlat2.xy).w;
    u_xlat3.z = texture(_MainTex, u_xlat2.zw).w;
    u_xlat3.y = texture(_MainTex, u_xlat1.xy).w;
    u_xlat3.w = texture(_MainTex, u_xlat1.zw).w;
    u_xlat0 = u_xlat0.xxxx + u_xlat3;
    u_xlat0 = u_xlat0 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat1.x = _BevelWidth + _OutlineWidth;
    u_xlat1.x = max(u_xlat1.x, 0.00999999978);
    u_xlat0 = u_xlat0 / u_xlat1.xxxx;
    u_xlat1.x = u_xlat1.x * _Bevel;
    u_xlat1.x = u_xlat1.x * _GradientScale;
    u_xlat1.x = u_xlat1.x * -2.0;
    u_xlat0 = u_xlat0 + vec4(0.5, 0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat0 = min(max(u_xlat0, 0.0), 1.0);
#else
    u_xlat0 = clamp(u_xlat0, 0.0, 1.0);
#endif
    u_xlat2 = u_xlat0 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = -abs(u_xlat2) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat9 = _ShaderFlags * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb17 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb17 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat9 = fract(abs(u_xlat9));
    u_xlat9 = (u_xlatb17) ? u_xlat9 : (-u_xlat9);
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=0.5);
#else
    u_xlatb9 = u_xlat9>=0.5;
#endif
    u_xlat0 = (bool(u_xlatb9)) ? u_xlat2 : u_xlat0;
    u_xlat2 = u_xlat0 * vec4(1.57079601, 1.57079601, 1.57079601, 1.57079601);
    u_xlat2 = sin(u_xlat2);
    u_xlat2 = (-u_xlat0) + u_xlat2;
    u_xlat0 = vec4(vec4(_BevelRoundness, _BevelRoundness, _BevelRoundness, _BevelRoundness)) * u_xlat2 + u_xlat0;
    u_xlat9 = (-_BevelClamp) + 1.0;
    u_xlat0 = min(u_xlat0, vec4(u_xlat9));
    u_xlat0.xz = u_xlat1.xx * u_xlat0.xz;
    u_xlat0.yz = u_xlat0.wy * u_xlat1.xx + (-u_xlat0.zx);
    u_xlat0.x = float(-1.0);
    u_xlat0.w = float(1.0);
    u_xlat1.x = dot(u_xlat0.xy, u_xlat0.xy);
    u_xlat1.x = inversesqrt(u_xlat1.x);
    u_xlat24 = dot(u_xlat0.zw, u_xlat0.zw);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat2.x = u_xlat24 * u_xlat0.z;
    u_xlat2.yz = vec2(u_xlat24) * vec2(1.0, 0.0);
    u_xlat0.z = 0.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz;
    u_xlat1.xyz = u_xlat0.xyz * u_xlat2.xyz;
    u_xlat0.xyz = u_xlat2.zxy * u_xlat0.yzx + (-u_xlat1.xyz);
    u_xlat1.xy = vec2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy + vs_TEXCOORD5.xy;
    u_xlat10_2.xyz = texture(_BumpMap, u_xlat1.xy).xyz;
    u_xlat10_1 = texture(_FaceTex, u_xlat1.xy);
    u_xlat16_4.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat24 = (-_BumpFace) + _BumpOutline;
    u_xlat10_2.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat2.x = (-u_xlat10_2.x) + vs_TEXCOORD1.z;
    u_xlat2.z = _OutlineWidth * _ScaleRatioA;
    u_xlat10.xy = u_xlat2.xz * vs_TEXCOORD1.yy;
    u_xlat26 = u_xlat10.y * 0.5 + u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat26 = min(max(u_xlat26, 0.0), 1.0);
#else
    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
#endif
    u_xlat24 = u_xlat26 * u_xlat24 + _BumpFace;
    u_xlat0.xyz = (-u_xlat16_4.xyz) * vec3(u_xlat24) + u_xlat0.xyz;
    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
    u_xlat24 = dot(vs_TEXCOORD3.xyz, (-u_xlat0.xyz));
    u_xlat24 = u_xlat24 + u_xlat24;
    u_xlat3.xyz = u_xlat0.xyz * vec3(u_xlat24) + vs_TEXCOORD3.xyz;
    u_xlat10_3.xyz = texture(_Cube, u_xlat3.xyz).xyz;
    u_xlat16_5.xyz = (-_ReflectFaceColor.xyz) + _ReflectOutlineColor.xyz;
    u_xlat5.xyz = vec3(u_xlat26) * u_xlat16_5.xyz + _ReflectFaceColor.xyz;
    u_xlat3.xyz = u_xlat10_3.xyz * u_xlat5.xyz;
    u_xlat16_4.x = min(u_xlat10.y, 1.0);
    u_xlat16_12 = u_xlat10.y * 0.5;
    u_xlat16_4.x = sqrt(u_xlat16_4.x);
    u_xlat16_20 = u_xlat2.x * vs_TEXCOORD1.y + u_xlat16_12;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_20 = min(max(u_xlat16_20, 0.0), 1.0);
#else
    u_xlat16_20 = clamp(u_xlat16_20, 0.0, 1.0);
#endif
    u_xlat16_12 = u_xlat2.x * vs_TEXCOORD1.y + (-u_xlat16_12);
    u_xlat16_4.x = u_xlat16_4.x * u_xlat16_20;
    u_xlat16_6.xyz = vs_COLOR0.xyz * _FaceColor.xyz;
    u_xlat16_1.xyz = u_xlat10_1.xyz * u_xlat16_6.xyz;
    u_xlat16_24 = u_xlat10_1.w * _FaceColor.w;
    u_xlat16_6.xyz = vec3(u_xlat16_24) * u_xlat16_1.xyz;
    u_xlat2.xz = vec2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy + vs_TEXCOORD5.zw;
    u_xlat10_5 = texture(_OutlineTex, u_xlat2.xz);
    u_xlat16_7 = u_xlat10_5 * _OutlineColor;
    u_xlat16_5.w = _OutlineColor.w * u_xlat10_5.w + (-u_xlat16_24);
    u_xlat16_5.xyz = u_xlat16_7.xyz * u_xlat16_7.www + (-u_xlat16_6.xyz);
    u_xlat16_5 = u_xlat16_4.xxxx * u_xlat16_5;
    u_xlat16_6.xyz = u_xlat16_1.xyz * vec3(u_xlat16_24) + u_xlat16_5.xyz;
    u_xlat16_6.w = _FaceColor.w * u_xlat10_1.w + u_xlat16_5.w;
    u_xlat24 = _OutlineSoftness * _ScaleRatioA;
    u_xlat1.x = u_xlat24 * vs_TEXCOORD1.y;
    u_xlat16_4.x = u_xlat24 * vs_TEXCOORD1.y + 1.0;
    u_xlat16_12 = u_xlat1.x * 0.5 + u_xlat16_12;
    u_xlat16_4.x = u_xlat16_12 / u_xlat16_4.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.x = min(max(u_xlat16_4.x, 0.0), 1.0);
#else
    u_xlat16_4.x = clamp(u_xlat16_4.x, 0.0, 1.0);
#endif
    u_xlat16_4.x = (-u_xlat16_4.x) + 1.0;
    u_xlat16_1 = u_xlat16_4.xxxx * u_xlat16_6;
    u_xlat16_4.x = (-u_xlat16_6.w) * u_xlat16_4.x + 1.0;
    u_xlat2.xzw = u_xlat16_1.www * u_xlat3.xyz;
    u_xlat3.x = sin(_LightAngle);
    u_xlat7 = cos(_LightAngle);
    u_xlat3.y = u_xlat7;
    u_xlat3.z = -1.0;
    u_xlat24 = dot(u_xlat3.xyz, u_xlat3.xyz);
    u_xlat24 = inversesqrt(u_xlat24);
    u_xlat3.xyz = vec3(u_xlat24) * u_xlat3.xyz;
    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
    u_xlat8 = u_xlat0.z * u_xlat0.z;
    u_xlat16 = max(u_xlat0.x, 0.0);
    u_xlat0.x = (-u_xlat0.x) * _Diffuse + 1.0;
    u_xlat16 = log2(u_xlat16);
    u_xlat16 = u_xlat16 * _Reflectivity;
    u_xlat16 = exp2(u_xlat16);
    u_xlat3.xyz = vec3(u_xlat16) * _SpecularColor.xyz;
    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_SpecularPower, _SpecularPower, _SpecularPower));
    u_xlat3.xyz = u_xlat3.xyz * u_xlat16_1.www + u_xlat16_1.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat3.xyz;
    u_xlat3.x = (-_Ambient) + 1.0;
    u_xlat8 = u_xlat8 * u_xlat3.x + _Ambient;
    u_xlat0.xyz = u_xlat0.xzw * vec3(u_xlat8) + u_xlat2.xzw;
    u_xlat10_24 = texture(_MainTex, vs_TEXCOORD4.xy).w;
    u_xlat24 = u_xlat10_24 * vs_TEXCOORD4.z + (-vs_TEXCOORD4.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat3 = vec4(u_xlat24) * vs_COLOR1;
    u_xlat0.xyz = u_xlat3.xyz * u_xlat16_4.xxx + u_xlat0.xyz;
    u_xlat1.w = u_xlat3.w * u_xlat16_4.x + u_xlat16_1.w;
    u_xlat24 = _GlowOffset * _ScaleRatioB;
    u_xlat24 = u_xlat24 * vs_TEXCOORD1.y;
    u_xlat24 = (-u_xlat24) * 0.5 + u_xlat10.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(u_xlat24>=0.0);
#else
    u_xlatb2 = u_xlat24>=0.0;
#endif
    u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
    u_xlat10.x = _GlowOuter * _ScaleRatioB + (-_GlowInner);
    u_xlat2.x = u_xlat2.x * u_xlat10.x + _GlowInner;
    u_xlat2.x = u_xlat2.x * vs_TEXCOORD1.y;
    u_xlat10.x = u_xlat2.x * 0.5 + 1.0;
    u_xlat2.x = u_xlat2.x * 0.5;
    u_xlat2.x = min(u_xlat2.x, 1.0);
    u_xlat2.x = sqrt(u_xlat2.x);
    u_xlat24 = u_xlat24 / u_xlat10.x;
    u_xlat24 = min(abs(u_xlat24), 1.0);
    u_xlat24 = log2(u_xlat24);
    u_xlat24 = u_xlat24 * _GlowPower;
    u_xlat24 = exp2(u_xlat24);
    u_xlat24 = (-u_xlat24) + 1.0;
    u_xlat24 = u_xlat2.x * u_xlat24;
    u_xlat24 = dot(_GlowColor.ww, vec2(u_xlat24));
#ifdef UNITY_ADRENO_ES3
    u_xlat24 = min(max(u_xlat24, 0.0), 1.0);
#else
    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
#endif
    u_xlat1.xyz = _GlowColor.xyz * vec3(u_xlat24) + u_xlat0.xyz;
    u_xlat0.xy = vec2((-_ClipRect.x) + _ClipRect.z, (-_ClipRect.y) + _ClipRect.w);
    u_xlat0.xy = u_xlat0.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat0.xy = vec2(u_xlat0.x * vs_TEXCOORD2.z, u_xlat0.y * vs_TEXCOORD2.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat0.xy = min(max(u_xlat0.xy, 0.0), 1.0);
#else
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
#endif
    u_xlat16_4.x = u_xlat0.y * u_xlat0.x;
    u_xlat16_0 = u_xlat1 * u_xlat16_4.xxxx;
    SV_Target0 = u_xlat16_0 * vs_COLOR0.wwww;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNITY_UI_ALPHACLIP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixVP;
uniform highp float _FaceDilate;
uniform highp float _OutlineSoftness;
uniform highp float _OutlineWidth;
uniform highp mat4 _EnvMatrix;
uniform highp float _WeightNormal;
uniform highp float _WeightBold;
uniform highp float _ScaleRatioA;
uniform highp float _VertexOffsetX;
uniform highp float _VertexOffsetY;
uniform highp vec4 _ClipRect;
uniform highp float _MaskSoftnessX;
uniform highp float _MaskSoftnessY;
uniform highp float _GradientScale;
uniform highp float _ScaleX;
uniform highp float _ScaleY;
uniform highp float _PerspectiveFilter;
uniform highp vec4 _FaceTex_ST;
uniform highp vec4 _OutlineTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp float weight_3;
  highp float scale_4;
  highp vec2 pixelSize_5;
  highp vec4 vert_6;
  highp float tmpvar_7;
  tmpvar_7 = float((0.0 >= _glesMultiTexCoord1.y));
  vert_6.zw = _glesVertex.zw;
  vert_6.x = (_glesVertex.x + _VertexOffsetX);
  vert_6.y = (_glesVertex.y + _VertexOffsetY);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = vert_6.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp vec2 tmpvar_10;
  tmpvar_10.x = _ScaleX;
  tmpvar_10.y = _ScaleY;
  highp mat2 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_projection[0].xy;
  tmpvar_11[1] = glstate_matrix_projection[1].xy;
  pixelSize_5 = (tmpvar_8.ww / (tmpvar_10 * abs(
    (tmpvar_11 * _ScreenParams.xy)
  )));
  scale_4 = (inversesqrt(dot (pixelSize_5, pixelSize_5)) * ((
    abs(_glesMultiTexCoord1.y)
   * _GradientScale) * 1.5));
  if ((glstate_matrix_projection[3].w == 0.0)) {
    highp mat3 tmpvar_12;
    tmpvar_12[0] = unity_WorldToObject[0].xyz;
    tmpvar_12[1] = unity_WorldToObject[1].xyz;
    tmpvar_12[2] = unity_WorldToObject[2].xyz;
    scale_4 = mix ((abs(scale_4) * (1.0 - _PerspectiveFilter)), scale_4, abs(dot (
      normalize((_glesNormal * tmpvar_12))
    , 
      normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_6).xyz))
    )));
  };
  weight_3 = (((
    (mix (_WeightNormal, _WeightBold, tmpvar_7) / 4.0)
   + _FaceDilate) * _ScaleRatioA) * 0.5);
  highp vec4 tmpvar_13;
  tmpvar_13 = clamp (_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10), vec4(2e+10, 2e+10, 2e+10, 2e+10));
  highp vec2 tmpvar_14;
  highp vec2 xlat_varoutput_15;
  xlat_varoutput_15.x = floor((_glesMultiTexCoord1.x / 4096.0));
  xlat_varoutput_15.y = (_glesMultiTexCoord1.x - (4096.0 * xlat_varoutput_15.x));
  tmpvar_14 = (xlat_varoutput_15 * 0.001953125);
  highp vec4 tmpvar_16;
  tmpvar_16.x = (((
    ((1.0 - (_OutlineWidth * _ScaleRatioA)) - (_OutlineSoftness * _ScaleRatioA))
   / 2.0) - (0.5 / scale_4)) - weight_3);
  tmpvar_16.y = scale_4;
  tmpvar_16.z = ((0.5 - weight_3) + (0.5 / scale_4));
  tmpvar_16.w = weight_3;
  highp vec2 tmpvar_17;
  tmpvar_17.x = _MaskSoftnessX;
  tmpvar_17.y = _MaskSoftnessY;
  highp vec4 tmpvar_18;
  tmpvar_18.xy = (((vert_6.xy * 2.0) - tmpvar_13.xy) - tmpvar_13.zw);
  tmpvar_18.zw = (0.25 / ((0.25 * tmpvar_17) + pixelSize_5));
  highp mat3 tmpvar_19;
  tmpvar_19[0] = _EnvMatrix[0].xyz;
  tmpvar_19[1] = _EnvMatrix[1].xyz;
  tmpvar_19[2] = _EnvMatrix[2].xyz;
  highp vec4 tmpvar_20;
  tmpvar_20.xy = ((tmpvar_14 * _FaceTex_ST.xy) + _FaceTex_ST.zw);
  tmpvar_20.zw = ((tmpvar_14 * _OutlineTex_ST.xy) + _OutlineTex_ST.zw);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = (tmpvar_19 * (_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_6).xyz));
  xlv_TEXCOORD5 = tmpvar_20;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _FaceTex;
uniform highp float _FaceUVSpeedX;
uniform highp float _FaceUVSpeedY;
uniform lowp vec4 _FaceColor;
uniform highp float _OutlineSoftness;
uniform sampler2D _OutlineTex;
uniform highp float _OutlineUVSpeedX;
uniform highp float _OutlineUVSpeedY;
uniform lowp vec4 _OutlineColor;
uniform highp float _OutlineWidth;
uniform highp float _ScaleRatioA;
uniform highp vec4 _ClipRect;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 outlineColor_2;
  mediump vec4 faceColor_3;
  highp float c_4;
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  c_4 = tmpvar_5;
  highp float x_6;
  x_6 = (c_4 - xlv_TEXCOORD1.x);
  if ((x_6 < 0.0)) {
    discard;
  };
  highp float tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD1.z - c_4) * xlv_TEXCOORD1.y);
  highp float tmpvar_8;
  tmpvar_8 = ((_OutlineWidth * _ScaleRatioA) * xlv_TEXCOORD1.y);
  highp float tmpvar_9;
  tmpvar_9 = ((_OutlineSoftness * _ScaleRatioA) * xlv_TEXCOORD1.y);
  faceColor_3 = _FaceColor;
  outlineColor_2 = _OutlineColor;
  faceColor_3.xyz = (faceColor_3.xyz * xlv_COLOR.xyz);
  highp vec2 tmpvar_10;
  tmpvar_10.x = _FaceUVSpeedX;
  tmpvar_10.y = _FaceUVSpeedY;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD5.xy + (tmpvar_10 * _Time.y));
  tmpvar_11 = texture2D (_FaceTex, P_12);
  faceColor_3 = (faceColor_3 * tmpvar_11);
  highp vec2 tmpvar_13;
  tmpvar_13.x = _OutlineUVSpeedX;
  tmpvar_13.y = _OutlineUVSpeedY;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD5.zw + (tmpvar_13 * _Time.y));
  tmpvar_14 = texture2D (_OutlineTex, P_15);
  outlineColor_2 = (outlineColor_2 * tmpvar_14);
  mediump float d_16;
  d_16 = tmpvar_7;
  lowp vec4 faceColor_17;
  faceColor_17 = faceColor_3;
  lowp vec4 outlineColor_18;
  outlineColor_18 = outlineColor_2;
  mediump float outline_19;
  outline_19 = tmpvar_8;
  mediump float softness_20;
  softness_20 = tmpvar_9;
  mediump float tmpvar_21;
  tmpvar_21 = (1.0 - clamp ((
    ((d_16 - (outline_19 * 0.5)) + (softness_20 * 0.5))
   / 
    (1.0 + softness_20)
  ), 0.0, 1.0));
  faceColor_17.xyz = (faceColor_17.xyz * faceColor_17.w);
  outlineColor_18.xyz = (outlineColor_18.xyz * outlineColor_18.w);
  mediump vec4 tmpvar_22;
  tmpvar_22 = mix (faceColor_17, outlineColor_18, vec4((clamp (
    (d_16 + (outline_19 * 0.5))
  , 0.0, 1.0) * sqrt(
    min (1.0, outline_19)
  ))));
  faceColor_17 = tmpvar_22;
  faceColor_17 = (faceColor_17 * tmpvar_21);
  faceColor_3 = faceColor_17;
  mediump vec2 tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = clamp (((
    (_ClipRect.zw - _ClipRect.xy)
   - 
    abs(xlv_TEXCOORD2.xy)
  ) * xlv_TEXCOORD2.zw), 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  faceColor_3 = (faceColor_3 * (tmpvar_23.x * tmpvar_23.y));
  mediump float x_25;
  x_25 = (faceColor_3.w - 0.001);
  if ((x_25 < 0.0)) {
    discard;
  };
  tmpvar_1 = (faceColor_3 * xlv_COLOR.w);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNITY_UI_ALPHACLIP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixVP;
uniform highp float _FaceDilate;
uniform highp float _OutlineSoftness;
uniform highp float _OutlineWidth;
uniform highp mat4 _EnvMatrix;
uniform highp float _WeightNormal;
uniform highp float _WeightBold;
uniform highp float _ScaleRatioA;
uniform highp float _VertexOffsetX;
uniform highp float _VertexOffsetY;
uniform highp vec4 _ClipRect;
uniform highp float _MaskSoftnessX;
uniform highp float _MaskSoftnessY;
uniform highp float _GradientScale;
uniform highp float _ScaleX;
uniform highp float _ScaleY;
uniform highp float _PerspectiveFilter;
uniform highp vec4 _FaceTex_ST;
uniform highp vec4 _OutlineTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp float weight_3;
  highp float scale_4;
  highp vec2 pixelSize_5;
  highp vec4 vert_6;
  highp float tmpvar_7;
  tmpvar_7 = float((0.0 >= _glesMultiTexCoord1.y));
  vert_6.zw = _glesVertex.zw;
  vert_6.x = (_glesVertex.x + _VertexOffsetX);
  vert_6.y = (_glesVertex.y + _VertexOffsetY);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = vert_6.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp vec2 tmpvar_10;
  tmpvar_10.x = _ScaleX;
  tmpvar_10.y = _ScaleY;
  highp mat2 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_projection[0].xy;
  tmpvar_11[1] = glstate_matrix_projection[1].xy;
  pixelSize_5 = (tmpvar_8.ww / (tmpvar_10 * abs(
    (tmpvar_11 * _ScreenParams.xy)
  )));
  scale_4 = (inversesqrt(dot (pixelSize_5, pixelSize_5)) * ((
    abs(_glesMultiTexCoord1.y)
   * _GradientScale) * 1.5));
  if ((glstate_matrix_projection[3].w == 0.0)) {
    highp mat3 tmpvar_12;
    tmpvar_12[0] = unity_WorldToObject[0].xyz;
    tmpvar_12[1] = unity_WorldToObject[1].xyz;
    tmpvar_12[2] = unity_WorldToObject[2].xyz;
    scale_4 = mix ((abs(scale_4) * (1.0 - _PerspectiveFilter)), scale_4, abs(dot (
      normalize((_glesNormal * tmpvar_12))
    , 
      normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_6).xyz))
    )));
  };
  weight_3 = (((
    (mix (_WeightNormal, _WeightBold, tmpvar_7) / 4.0)
   + _FaceDilate) * _ScaleRatioA) * 0.5);
  highp vec4 tmpvar_13;
  tmpvar_13 = clamp (_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10), vec4(2e+10, 2e+10, 2e+10, 2e+10));
  highp vec2 tmpvar_14;
  highp vec2 xlat_varoutput_15;
  xlat_varoutput_15.x = floor((_glesMultiTexCoord1.x / 4096.0));
  xlat_varoutput_15.y = (_glesMultiTexCoord1.x - (4096.0 * xlat_varoutput_15.x));
  tmpvar_14 = (xlat_varoutput_15 * 0.001953125);
  highp vec4 tmpvar_16;
  tmpvar_16.x = (((
    ((1.0 - (_OutlineWidth * _ScaleRatioA)) - (_OutlineSoftness * _ScaleRatioA))
   / 2.0) - (0.5 / scale_4)) - weight_3);
  tmpvar_16.y = scale_4;
  tmpvar_16.z = ((0.5 - weight_3) + (0.5 / scale_4));
  tmpvar_16.w = weight_3;
  highp vec2 tmpvar_17;
  tmpvar_17.x = _MaskSoftnessX;
  tmpvar_17.y = _MaskSoftnessY;
  highp vec4 tmpvar_18;
  tmpvar_18.xy = (((vert_6.xy * 2.0) - tmpvar_13.xy) - tmpvar_13.zw);
  tmpvar_18.zw = (0.25 / ((0.25 * tmpvar_17) + pixelSize_5));
  highp mat3 tmpvar_19;
  tmpvar_19[0] = _EnvMatrix[0].xyz;
  tmpvar_19[1] = _EnvMatrix[1].xyz;
  tmpvar_19[2] = _EnvMatrix[2].xyz;
  highp vec4 tmpvar_20;
  tmpvar_20.xy = ((tmpvar_14 * _FaceTex_ST.xy) + _FaceTex_ST.zw);
  tmpvar_20.zw = ((tmpvar_14 * _OutlineTex_ST.xy) + _OutlineTex_ST.zw);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = (tmpvar_19 * (_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_6).xyz));
  xlv_TEXCOORD5 = tmpvar_20;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _FaceTex;
uniform highp float _FaceUVSpeedX;
uniform highp float _FaceUVSpeedY;
uniform lowp vec4 _FaceColor;
uniform highp float _OutlineSoftness;
uniform sampler2D _OutlineTex;
uniform highp float _OutlineUVSpeedX;
uniform highp float _OutlineUVSpeedY;
uniform lowp vec4 _OutlineColor;
uniform highp float _OutlineWidth;
uniform highp float _ScaleRatioA;
uniform highp vec4 _ClipRect;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 outlineColor_2;
  mediump vec4 faceColor_3;
  highp float c_4;
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  c_4 = tmpvar_5;
  highp float x_6;
  x_6 = (c_4 - xlv_TEXCOORD1.x);
  if ((x_6 < 0.0)) {
    discard;
  };
  highp float tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD1.z - c_4) * xlv_TEXCOORD1.y);
  highp float tmpvar_8;
  tmpvar_8 = ((_OutlineWidth * _ScaleRatioA) * xlv_TEXCOORD1.y);
  highp float tmpvar_9;
  tmpvar_9 = ((_OutlineSoftness * _ScaleRatioA) * xlv_TEXCOORD1.y);
  faceColor_3 = _FaceColor;
  outlineColor_2 = _OutlineColor;
  faceColor_3.xyz = (faceColor_3.xyz * xlv_COLOR.xyz);
  highp vec2 tmpvar_10;
  tmpvar_10.x = _FaceUVSpeedX;
  tmpvar_10.y = _FaceUVSpeedY;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD5.xy + (tmpvar_10 * _Time.y));
  tmpvar_11 = texture2D (_FaceTex, P_12);
  faceColor_3 = (faceColor_3 * tmpvar_11);
  highp vec2 tmpvar_13;
  tmpvar_13.x = _OutlineUVSpeedX;
  tmpvar_13.y = _OutlineUVSpeedY;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD5.zw + (tmpvar_13 * _Time.y));
  tmpvar_14 = texture2D (_OutlineTex, P_15);
  outlineColor_2 = (outlineColor_2 * tmpvar_14);
  mediump float d_16;
  d_16 = tmpvar_7;
  lowp vec4 faceColor_17;
  faceColor_17 = faceColor_3;
  lowp vec4 outlineColor_18;
  outlineColor_18 = outlineColor_2;
  mediump float outline_19;
  outline_19 = tmpvar_8;
  mediump float softness_20;
  softness_20 = tmpvar_9;
  mediump float tmpvar_21;
  tmpvar_21 = (1.0 - clamp ((
    ((d_16 - (outline_19 * 0.5)) + (softness_20 * 0.5))
   / 
    (1.0 + softness_20)
  ), 0.0, 1.0));
  faceColor_17.xyz = (faceColor_17.xyz * faceColor_17.w);
  outlineColor_18.xyz = (outlineColor_18.xyz * outlineColor_18.w);
  mediump vec4 tmpvar_22;
  tmpvar_22 = mix (faceColor_17, outlineColor_18, vec4((clamp (
    (d_16 + (outline_19 * 0.5))
  , 0.0, 1.0) * sqrt(
    min (1.0, outline_19)
  ))));
  faceColor_17 = tmpvar_22;
  faceColor_17 = (faceColor_17 * tmpvar_21);
  faceColor_3 = faceColor_17;
  mediump vec2 tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = clamp (((
    (_ClipRect.zw - _ClipRect.xy)
   - 
    abs(xlv_TEXCOORD2.xy)
  ) * xlv_TEXCOORD2.zw), 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  faceColor_3 = (faceColor_3 * (tmpvar_23.x * tmpvar_23.y));
  mediump float x_25;
  x_25 = (faceColor_3.w - 0.001);
  if ((x_25 < 0.0)) {
    discard;
  };
  tmpvar_1 = (faceColor_3 * xlv_COLOR.w);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNITY_UI_ALPHACLIP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixVP;
uniform highp float _FaceDilate;
uniform highp float _OutlineSoftness;
uniform highp float _OutlineWidth;
uniform highp mat4 _EnvMatrix;
uniform highp float _WeightNormal;
uniform highp float _WeightBold;
uniform highp float _ScaleRatioA;
uniform highp float _VertexOffsetX;
uniform highp float _VertexOffsetY;
uniform highp vec4 _ClipRect;
uniform highp float _MaskSoftnessX;
uniform highp float _MaskSoftnessY;
uniform highp float _GradientScale;
uniform highp float _ScaleX;
uniform highp float _ScaleY;
uniform highp float _PerspectiveFilter;
uniform highp vec4 _FaceTex_ST;
uniform highp vec4 _OutlineTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp float weight_3;
  highp float scale_4;
  highp vec2 pixelSize_5;
  highp vec4 vert_6;
  highp float tmpvar_7;
  tmpvar_7 = float((0.0 >= _glesMultiTexCoord1.y));
  vert_6.zw = _glesVertex.zw;
  vert_6.x = (_glesVertex.x + _VertexOffsetX);
  vert_6.y = (_glesVertex.y + _VertexOffsetY);
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = vert_6.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp vec2 tmpvar_10;
  tmpvar_10.x = _ScaleX;
  tmpvar_10.y = _ScaleY;
  highp mat2 tmpvar_11;
  tmpvar_11[0] = glstate_matrix_projection[0].xy;
  tmpvar_11[1] = glstate_matrix_projection[1].xy;
  pixelSize_5 = (tmpvar_8.ww / (tmpvar_10 * abs(
    (tmpvar_11 * _ScreenParams.xy)
  )));
  scale_4 = (inversesqrt(dot (pixelSize_5, pixelSize_5)) * ((
    abs(_glesMultiTexCoord1.y)
   * _GradientScale) * 1.5));
  if ((glstate_matrix_projection[3].w == 0.0)) {
    highp mat3 tmpvar_12;
    tmpvar_12[0] = unity_WorldToObject[0].xyz;
    tmpvar_12[1] = unity_WorldToObject[1].xyz;
    tmpvar_12[2] = unity_WorldToObject[2].xyz;
    scale_4 = mix ((abs(scale_4) * (1.0 - _PerspectiveFilter)), scale_4, abs(dot (
      normalize((_glesNormal * tmpvar_12))
    , 
      normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_6).xyz))
    )));
  };
  weight_3 = (((
    (mix (_WeightNormal, _WeightBold, tmpvar_7) / 4.0)
   + _FaceDilate) * _ScaleRatioA) * 0.5);
  highp vec4 tmpvar_13;
  tmpvar_13 = clamp (_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10), vec4(2e+10, 2e+10, 2e+10, 2e+10));
  highp vec2 tmpvar_14;
  highp vec2 xlat_varoutput_15;
  xlat_varoutput_15.x = floor((_glesMultiTexCoord1.x / 4096.0));
  xlat_varoutput_15.y = (_glesMultiTexCoord1.x - (4096.0 * xlat_varoutput_15.x));
  tmpvar_14 = (xlat_varoutput_15 * 0.001953125);
  highp vec4 tmpvar_16;
  tmpvar_16.x = (((
    ((1.0 - (_OutlineWidth * _ScaleRatioA)) - (_OutlineSoftness * _ScaleRatioA))
   / 2.0) - (0.5 / scale_4)) - weight_3);
  tmpvar_16.y = scale_4;
  tmpvar_16.z = ((0.5 - weight_3) + (0.5 / scale_4));
  tmpvar_16.w = weight_3;
  highp vec2 tmpvar_17;
  tmpvar_17.x = _MaskSoftnessX;
  tmpvar_17.y = _MaskSoftnessY;
  highp vec4 tmpvar_18;
  tmpvar_18.xy = (((vert_6.xy * 2.0) - tmpvar_13.xy) - tmpvar_13.zw);
  tmpvar_18.zw = (0.25 / ((0.25 * tmpvar_17) + pixelSize_5));
  highp mat3 tmpvar_19;
  tmpvar_19[0] = _EnvMatrix[0].xyz;
  tmpvar_19[1] = _EnvMatrix[1].xyz;
  tmpvar_19[2] = _EnvMatrix[2].xyz;
  highp vec4 tmpvar_20;
  tmpvar_20.xy = ((tmpvar_14 * _FaceTex_ST.xy) + _FaceTex_ST.zw);
  tmpvar_20.zw = ((tmpvar_14 * _OutlineTex_ST.xy) + _OutlineTex_ST.zw);
  gl_Position = tmpvar_8;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_16;
  xlv_TEXCOORD2 = tmpvar_18;
  xlv_TEXCOORD3 = (tmpvar_19 * (_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_6).xyz));
  xlv_TEXCOORD5 = tmpvar_20;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _FaceTex;
uniform highp float _FaceUVSpeedX;
uniform highp float _FaceUVSpeedY;
uniform lowp vec4 _FaceColor;
uniform highp float _OutlineSoftness;
uniform sampler2D _OutlineTex;
uniform highp float _OutlineUVSpeedX;
uniform highp float _OutlineUVSpeedY;
uniform lowp vec4 _OutlineColor;
uniform highp float _OutlineWidth;
uniform highp float _ScaleRatioA;
uniform highp vec4 _ClipRect;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 outlineColor_2;
  mediump vec4 faceColor_3;
  highp float c_4;
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  c_4 = tmpvar_5;
  highp float x_6;
  x_6 = (c_4 - xlv_TEXCOORD1.x);
  if ((x_6 < 0.0)) {
    discard;
  };
  highp float tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD1.z - c_4) * xlv_TEXCOORD1.y);
  highp float tmpvar_8;
  tmpvar_8 = ((_OutlineWidth * _ScaleRatioA) * xlv_TEXCOORD1.y);
  highp float tmpvar_9;
  tmpvar_9 = ((_OutlineSoftness * _ScaleRatioA) * xlv_TEXCOORD1.y);
  faceColor_3 = _FaceColor;
  outlineColor_2 = _OutlineColor;
  faceColor_3.xyz = (faceColor_3.xyz * xlv_COLOR.xyz);
  highp vec2 tmpvar_10;
  tmpvar_10.x = _FaceUVSpeedX;
  tmpvar_10.y = _FaceUVSpeedY;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD5.xy + (tmpvar_10 * _Time.y));
  tmpvar_11 = texture2D (_FaceTex, P_12);
  faceColor_3 = (faceColor_3 * tmpvar_11);
  highp vec2 tmpvar_13;
  tmpvar_13.x = _OutlineUVSpeedX;
  tmpvar_13.y = _OutlineUVSpeedY;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD5.zw + (tmpvar_13 * _Time.y));
  tmpvar_14 = texture2D (_OutlineTex, P_15);
  outlineColor_2 = (outlineColor_2 * tmpvar_14);
  mediump float d_16;
  d_16 = tmpvar_7;
  lowp vec4 faceColor_17;
  faceColor_17 = faceColor_3;
  lowp vec4 outlineColor_18;
  outlineColor_18 = outlineColor_2;
  mediump float outline_19;
  outline_19 = tmpvar_8;
  mediump float softness_20;
  softness_20 = tmpvar_9;
  mediump float tmpvar_21;
  tmpvar_21 = (1.0 - clamp ((
    ((d_16 - (outline_19 * 0.5)) + (softness_20 * 0.5))
   / 
    (1.0 + softness_20)
  ), 0.0, 1.0));
  faceColor_17.xyz = (faceColor_17.xyz * faceColor_17.w);
  outlineColor_18.xyz = (outlineColor_18.xyz * outlineColor_18.w);
  mediump vec4 tmpvar_22;
  tmpvar_22 = mix (faceColor_17, outlineColor_18, vec4((clamp (
    (d_16 + (outline_19 * 0.5))
  , 0.0, 1.0) * sqrt(
    min (1.0, outline_19)
  ))));
  faceColor_17 = tmpvar_22;
  faceColor_17 = (faceColor_17 * tmpvar_21);
  faceColor_3 = faceColor_17;
  mediump vec2 tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24 = clamp (((
    (_ClipRect.zw - _ClipRect.xy)
   - 
    abs(xlv_TEXCOORD2.xy)
  ) * xlv_TEXCOORD2.zw), 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  faceColor_3 = (faceColor_3 * (tmpvar_23.x * tmpvar_23.y));
  mediump float x_25;
  x_25 = (faceColor_3.w - 0.001);
  if ((x_25 < 0.0)) {
    discard;
  };
  tmpvar_1 = (faceColor_3 * xlv_COLOR.w);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _FaceDilate;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineWidth;
uniform 	vec4 hlslcc_mtx4x4_EnvMatrix[4];
uniform 	float _WeightNormal;
uniform 	float _WeightBold;
uniform 	float _ScaleRatioA;
uniform 	float _VertexOffsetX;
uniform 	float _VertexOffsetY;
uniform 	vec4 _ClipRect;
uniform 	float _MaskSoftnessX;
uniform 	float _MaskSoftnessY;
uniform 	float _GradientScale;
uniform 	float _ScaleX;
uniform 	float _ScaleY;
uniform 	float _PerspectiveFilter;
uniform 	vec4 _FaceTex_ST;
uniform 	vec4 _OutlineTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat6;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0.xy = vec2(in_POSITION0.x + float(_VertexOffsetX), in_POSITION0.y + float(_VertexOffsetY));
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat2.xyz = u_xlat8.xxx * u_xlat2.xyz;
    u_xlat8.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat2.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat2.xy;
    u_xlat2.xy = vec2(abs(u_xlat2.x) * float(_ScaleX), abs(u_xlat2.y) * float(_ScaleY));
    u_xlat2.xy = u_xlat2.ww / u_xlat2.xy;
    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat2.xy;
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat2.xy;
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat13 = abs(in_TEXCOORD1.y) * _GradientScale;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * 1.5;
    u_xlat2.x = (-_PerspectiveFilter) + 1.0;
    u_xlat2.x = abs(u_xlat13) * u_xlat2.x;
    u_xlat12 = u_xlat12 * 1.5 + (-u_xlat2.x);
    u_xlat8.x = abs(u_xlat8.x) * u_xlat12 + u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0);
#else
    u_xlatb12 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
#endif
    u_xlat6.x = (u_xlatb12) ? u_xlat8.x : u_xlat13;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.0>=in_TEXCOORD1.y);
#else
    u_xlatb8 = 0.0>=in_TEXCOORD1.y;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat12 = (-_WeightNormal) + _WeightBold;
    u_xlat8.x = u_xlat8.x * u_xlat12 + _WeightNormal;
    u_xlat8.x = u_xlat8.x * 0.25 + _FaceDilate;
    u_xlat8.x = u_xlat8.x * _ScaleRatioA;
    u_xlat6.z = u_xlat8.x * 0.5;
    vs_TEXCOORD1.yw = u_xlat6.xz;
    u_xlat12 = 0.5 / u_xlat6.x;
    u_xlat13 = (-_OutlineWidth) * _ScaleRatioA + 1.0;
    u_xlat13 = (-_OutlineSoftness) * _ScaleRatioA + u_xlat13;
    u_xlat13 = u_xlat13 * 0.5 + (-u_xlat12);
    vs_TEXCOORD1.x = (-u_xlat8.x) * 0.5 + u_xlat13;
    u_xlat8.x = (-u_xlat8.x) * 0.5 + 0.5;
    vs_TEXCOORD1.z = u_xlat12 + u_xlat8.x;
    u_xlat2 = max(_ClipRect, vec4(-2e+010, -2e+010, -2e+010, -2e+010));
    u_xlat2 = min(u_xlat2, vec4(2e+010, 2e+010, 2e+010, 2e+010));
    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat2.xy);
    vs_TEXCOORD2.xy = vec2((-u_xlat2.z) + u_xlat0.x, (-u_xlat2.w) + u_xlat0.y);
    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4x4_EnvMatrix[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_EnvMatrix[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4_EnvMatrix[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x * 0.000244140625;
    u_xlat8.x = floor(u_xlat0.x);
    u_xlat8.y = (-u_xlat8.x) * 4096.0 + in_TEXCOORD1.x;
    u_xlat0.xy = u_xlat8.xy * vec2(0.001953125, 0.001953125);
    vs_TEXCOORD5.xy = u_xlat0.xy * _FaceTex_ST.xy + _FaceTex_ST.zw;
    vs_TEXCOORD5.zw = u_xlat0.xy * _OutlineTex_ST.xy + _OutlineTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _FaceUVSpeedX;
uniform 	float _FaceUVSpeedY;
uniform 	mediump vec4 _FaceColor;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineUVSpeedX;
uniform 	float _OutlineUVSpeedY;
uniform 	mediump vec4 _OutlineColor;
uniform 	float _OutlineWidth;
uniform 	float _ScaleRatioA;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FaceTex;
uniform lowp sampler2D _OutlineTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
lowp vec4 u_xlat10_4;
bool u_xlatb4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_6;
float u_xlat9;
mediump float u_xlat16_11;
void main()
{
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat5 = u_xlat10_0.x + (-vs_TEXCOORD1.x);
    u_xlat0.x = (-u_xlat10_0.x) + vs_TEXCOORD1.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5<0.0);
#else
    u_xlatb5 = u_xlat5<0.0;
#endif
    if((int(u_xlatb5) * int(0xffffffffu))!=0){discard;}
    u_xlat5 = _OutlineWidth * _ScaleRatioA;
    u_xlat5 = u_xlat5 * vs_TEXCOORD1.y;
    u_xlat16_1 = min(u_xlat5, 1.0);
    u_xlat16_6 = u_xlat5 * 0.5;
    u_xlat16_1 = sqrt(u_xlat16_1);
    u_xlat16_11 = u_xlat0.x * vs_TEXCOORD1.y + u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat0.x * vs_TEXCOORD1.y + (-u_xlat16_6);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_11;
    u_xlat0.xy = vec2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy + vs_TEXCOORD5.zw;
    u_xlat10_0 = texture(_OutlineTex, u_xlat0.xy);
    u_xlat16_2 = u_xlat10_0 * _OutlineColor;
    u_xlat16_3.xyz = vs_COLOR0.xyz * _FaceColor.xyz;
    u_xlat0.xy = vec2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy + vs_TEXCOORD5.xy;
    u_xlat10_4 = texture(_FaceTex, u_xlat0.xy);
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat10_4.xyz;
    u_xlat16_4 = u_xlat10_4.w * _FaceColor.w;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vec3(u_xlat16_4);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_2.www + (-u_xlat16_3.xyz);
    u_xlat16_2.w = _OutlineColor.w * u_xlat10_0.w + (-u_xlat16_4);
    u_xlat16_2 = vec4(u_xlat16_1) * u_xlat16_2;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_4) + u_xlat16_2.xyz;
    u_xlat16_0.w = _FaceColor.w * u_xlat10_4.w + u_xlat16_2.w;
    u_xlat4.x = _OutlineSoftness * _ScaleRatioA;
    u_xlat9 = u_xlat4.x * vs_TEXCOORD1.y;
    u_xlat16_1 = u_xlat4.x * vs_TEXCOORD1.y + 1.0;
    u_xlat16_6 = u_xlat9 * 0.5 + u_xlat16_6;
    u_xlat16_1 = u_xlat16_6 / u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_0 = u_xlat16_0 * vec4(u_xlat16_1);
    u_xlat4.xy = vec2((-_ClipRect.x) + _ClipRect.z, (-_ClipRect.y) + _ClipRect.w);
    u_xlat4.xy = u_xlat4.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat4.xy = vec2(u_xlat4.x * vs_TEXCOORD2.z, u_xlat4.y * vs_TEXCOORD2.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat4.y * u_xlat4.x;
    u_xlat16_6 = u_xlat16_0.w * u_xlat16_1 + -0.00100000005;
    u_xlat16_0 = u_xlat16_0 * vec4(u_xlat16_1);
    SV_Target0 = u_xlat16_0 * vs_COLOR0.wwww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat16_6<0.0);
#else
    u_xlatb4 = u_xlat16_6<0.0;
#endif
    if((int(u_xlatb4) * int(0xffffffffu))!=0){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _FaceDilate;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineWidth;
uniform 	vec4 hlslcc_mtx4x4_EnvMatrix[4];
uniform 	float _WeightNormal;
uniform 	float _WeightBold;
uniform 	float _ScaleRatioA;
uniform 	float _VertexOffsetX;
uniform 	float _VertexOffsetY;
uniform 	vec4 _ClipRect;
uniform 	float _MaskSoftnessX;
uniform 	float _MaskSoftnessY;
uniform 	float _GradientScale;
uniform 	float _ScaleX;
uniform 	float _ScaleY;
uniform 	float _PerspectiveFilter;
uniform 	vec4 _FaceTex_ST;
uniform 	vec4 _OutlineTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat6;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0.xy = vec2(in_POSITION0.x + float(_VertexOffsetX), in_POSITION0.y + float(_VertexOffsetY));
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat2.xyz = u_xlat8.xxx * u_xlat2.xyz;
    u_xlat8.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat2.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat2.xy;
    u_xlat2.xy = vec2(abs(u_xlat2.x) * float(_ScaleX), abs(u_xlat2.y) * float(_ScaleY));
    u_xlat2.xy = u_xlat2.ww / u_xlat2.xy;
    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat2.xy;
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat2.xy;
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat13 = abs(in_TEXCOORD1.y) * _GradientScale;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * 1.5;
    u_xlat2.x = (-_PerspectiveFilter) + 1.0;
    u_xlat2.x = abs(u_xlat13) * u_xlat2.x;
    u_xlat12 = u_xlat12 * 1.5 + (-u_xlat2.x);
    u_xlat8.x = abs(u_xlat8.x) * u_xlat12 + u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0);
#else
    u_xlatb12 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
#endif
    u_xlat6.x = (u_xlatb12) ? u_xlat8.x : u_xlat13;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.0>=in_TEXCOORD1.y);
#else
    u_xlatb8 = 0.0>=in_TEXCOORD1.y;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat12 = (-_WeightNormal) + _WeightBold;
    u_xlat8.x = u_xlat8.x * u_xlat12 + _WeightNormal;
    u_xlat8.x = u_xlat8.x * 0.25 + _FaceDilate;
    u_xlat8.x = u_xlat8.x * _ScaleRatioA;
    u_xlat6.z = u_xlat8.x * 0.5;
    vs_TEXCOORD1.yw = u_xlat6.xz;
    u_xlat12 = 0.5 / u_xlat6.x;
    u_xlat13 = (-_OutlineWidth) * _ScaleRatioA + 1.0;
    u_xlat13 = (-_OutlineSoftness) * _ScaleRatioA + u_xlat13;
    u_xlat13 = u_xlat13 * 0.5 + (-u_xlat12);
    vs_TEXCOORD1.x = (-u_xlat8.x) * 0.5 + u_xlat13;
    u_xlat8.x = (-u_xlat8.x) * 0.5 + 0.5;
    vs_TEXCOORD1.z = u_xlat12 + u_xlat8.x;
    u_xlat2 = max(_ClipRect, vec4(-2e+010, -2e+010, -2e+010, -2e+010));
    u_xlat2 = min(u_xlat2, vec4(2e+010, 2e+010, 2e+010, 2e+010));
    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat2.xy);
    vs_TEXCOORD2.xy = vec2((-u_xlat2.z) + u_xlat0.x, (-u_xlat2.w) + u_xlat0.y);
    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4x4_EnvMatrix[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_EnvMatrix[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4_EnvMatrix[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x * 0.000244140625;
    u_xlat8.x = floor(u_xlat0.x);
    u_xlat8.y = (-u_xlat8.x) * 4096.0 + in_TEXCOORD1.x;
    u_xlat0.xy = u_xlat8.xy * vec2(0.001953125, 0.001953125);
    vs_TEXCOORD5.xy = u_xlat0.xy * _FaceTex_ST.xy + _FaceTex_ST.zw;
    vs_TEXCOORD5.zw = u_xlat0.xy * _OutlineTex_ST.xy + _OutlineTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _FaceUVSpeedX;
uniform 	float _FaceUVSpeedY;
uniform 	mediump vec4 _FaceColor;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineUVSpeedX;
uniform 	float _OutlineUVSpeedY;
uniform 	mediump vec4 _OutlineColor;
uniform 	float _OutlineWidth;
uniform 	float _ScaleRatioA;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FaceTex;
uniform lowp sampler2D _OutlineTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
lowp vec4 u_xlat10_4;
bool u_xlatb4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_6;
float u_xlat9;
mediump float u_xlat16_11;
void main()
{
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat5 = u_xlat10_0.x + (-vs_TEXCOORD1.x);
    u_xlat0.x = (-u_xlat10_0.x) + vs_TEXCOORD1.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5<0.0);
#else
    u_xlatb5 = u_xlat5<0.0;
#endif
    if((int(u_xlatb5) * int(0xffffffffu))!=0){discard;}
    u_xlat5 = _OutlineWidth * _ScaleRatioA;
    u_xlat5 = u_xlat5 * vs_TEXCOORD1.y;
    u_xlat16_1 = min(u_xlat5, 1.0);
    u_xlat16_6 = u_xlat5 * 0.5;
    u_xlat16_1 = sqrt(u_xlat16_1);
    u_xlat16_11 = u_xlat0.x * vs_TEXCOORD1.y + u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat0.x * vs_TEXCOORD1.y + (-u_xlat16_6);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_11;
    u_xlat0.xy = vec2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy + vs_TEXCOORD5.zw;
    u_xlat10_0 = texture(_OutlineTex, u_xlat0.xy);
    u_xlat16_2 = u_xlat10_0 * _OutlineColor;
    u_xlat16_3.xyz = vs_COLOR0.xyz * _FaceColor.xyz;
    u_xlat0.xy = vec2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy + vs_TEXCOORD5.xy;
    u_xlat10_4 = texture(_FaceTex, u_xlat0.xy);
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat10_4.xyz;
    u_xlat16_4 = u_xlat10_4.w * _FaceColor.w;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vec3(u_xlat16_4);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_2.www + (-u_xlat16_3.xyz);
    u_xlat16_2.w = _OutlineColor.w * u_xlat10_0.w + (-u_xlat16_4);
    u_xlat16_2 = vec4(u_xlat16_1) * u_xlat16_2;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_4) + u_xlat16_2.xyz;
    u_xlat16_0.w = _FaceColor.w * u_xlat10_4.w + u_xlat16_2.w;
    u_xlat4.x = _OutlineSoftness * _ScaleRatioA;
    u_xlat9 = u_xlat4.x * vs_TEXCOORD1.y;
    u_xlat16_1 = u_xlat4.x * vs_TEXCOORD1.y + 1.0;
    u_xlat16_6 = u_xlat9 * 0.5 + u_xlat16_6;
    u_xlat16_1 = u_xlat16_6 / u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_0 = u_xlat16_0 * vec4(u_xlat16_1);
    u_xlat4.xy = vec2((-_ClipRect.x) + _ClipRect.z, (-_ClipRect.y) + _ClipRect.w);
    u_xlat4.xy = u_xlat4.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat4.xy = vec2(u_xlat4.x * vs_TEXCOORD2.z, u_xlat4.y * vs_TEXCOORD2.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat4.y * u_xlat4.x;
    u_xlat16_6 = u_xlat16_0.w * u_xlat16_1 + -0.00100000005;
    u_xlat16_0 = u_xlat16_0 * vec4(u_xlat16_1);
    SV_Target0 = u_xlat16_0 * vs_COLOR0.wwww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat16_6<0.0);
#else
    u_xlatb4 = u_xlat16_6<0.0;
#endif
    if((int(u_xlatb4) * int(0xffffffffu))!=0){discard;}
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNITY_UI_ALPHACLIP" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _FaceDilate;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineWidth;
uniform 	vec4 hlslcc_mtx4x4_EnvMatrix[4];
uniform 	float _WeightNormal;
uniform 	float _WeightBold;
uniform 	float _ScaleRatioA;
uniform 	float _VertexOffsetX;
uniform 	float _VertexOffsetY;
uniform 	vec4 _ClipRect;
uniform 	float _MaskSoftnessX;
uniform 	float _MaskSoftnessY;
uniform 	float _GradientScale;
uniform 	float _ScaleX;
uniform 	float _ScaleY;
uniform 	float _PerspectiveFilter;
uniform 	vec4 _FaceTex_ST;
uniform 	vec4 _OutlineTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD5;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
vec3 u_xlat6;
vec2 u_xlat8;
bool u_xlatb8;
float u_xlat12;
bool u_xlatb12;
float u_xlat13;
void main()
{
    u_xlat0.xy = vec2(in_POSITION0.x + float(_VertexOffsetX), in_POSITION0.y + float(_VertexOffsetY));
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat2.xyz = u_xlat8.xxx * u_xlat2.xyz;
    u_xlat8.x = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat8.x = inversesqrt(u_xlat8.x);
    u_xlat3.xyz = u_xlat8.xxx * u_xlat1.xyz;
    u_xlat8.x = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat2.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat2.xy;
    u_xlat2.xy = vec2(abs(u_xlat2.x) * float(_ScaleX), abs(u_xlat2.y) * float(_ScaleY));
    u_xlat2.xy = u_xlat2.ww / u_xlat2.xy;
    u_xlat12 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat2.xy;
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat2.xy;
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat13 = abs(in_TEXCOORD1.y) * _GradientScale;
    u_xlat12 = u_xlat12 * u_xlat13;
    u_xlat13 = u_xlat12 * 1.5;
    u_xlat2.x = (-_PerspectiveFilter) + 1.0;
    u_xlat2.x = abs(u_xlat13) * u_xlat2.x;
    u_xlat12 = u_xlat12 * 1.5 + (-u_xlat2.x);
    u_xlat8.x = abs(u_xlat8.x) * u_xlat12 + u_xlat2.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0);
#else
    u_xlatb12 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
#endif
    u_xlat6.x = (u_xlatb12) ? u_xlat8.x : u_xlat13;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(0.0>=in_TEXCOORD1.y);
#else
    u_xlatb8 = 0.0>=in_TEXCOORD1.y;
#endif
    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
    u_xlat12 = (-_WeightNormal) + _WeightBold;
    u_xlat8.x = u_xlat8.x * u_xlat12 + _WeightNormal;
    u_xlat8.x = u_xlat8.x * 0.25 + _FaceDilate;
    u_xlat8.x = u_xlat8.x * _ScaleRatioA;
    u_xlat6.z = u_xlat8.x * 0.5;
    vs_TEXCOORD1.yw = u_xlat6.xz;
    u_xlat12 = 0.5 / u_xlat6.x;
    u_xlat13 = (-_OutlineWidth) * _ScaleRatioA + 1.0;
    u_xlat13 = (-_OutlineSoftness) * _ScaleRatioA + u_xlat13;
    u_xlat13 = u_xlat13 * 0.5 + (-u_xlat12);
    vs_TEXCOORD1.x = (-u_xlat8.x) * 0.5 + u_xlat13;
    u_xlat8.x = (-u_xlat8.x) * 0.5 + 0.5;
    vs_TEXCOORD1.z = u_xlat12 + u_xlat8.x;
    u_xlat2 = max(_ClipRect, vec4(-2e+010, -2e+010, -2e+010, -2e+010));
    u_xlat2 = min(u_xlat2, vec4(2e+010, 2e+010, 2e+010, 2e+010));
    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat2.xy);
    vs_TEXCOORD2.xy = vec2((-u_xlat2.z) + u_xlat0.x, (-u_xlat2.w) + u_xlat0.y);
    u_xlat0.xyz = u_xlat1.yyy * hlslcc_mtx4x4_EnvMatrix[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4_EnvMatrix[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4_EnvMatrix[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
    u_xlat0.x = in_TEXCOORD1.x * 0.000244140625;
    u_xlat8.x = floor(u_xlat0.x);
    u_xlat8.y = (-u_xlat8.x) * 4096.0 + in_TEXCOORD1.x;
    u_xlat0.xy = u_xlat8.xy * vec2(0.001953125, 0.001953125);
    vs_TEXCOORD5.xy = u_xlat0.xy * _FaceTex_ST.xy + _FaceTex_ST.zw;
    vs_TEXCOORD5.zw = u_xlat0.xy * _OutlineTex_ST.xy + _OutlineTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _FaceUVSpeedX;
uniform 	float _FaceUVSpeedY;
uniform 	mediump vec4 _FaceColor;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineUVSpeedX;
uniform 	float _OutlineUVSpeedY;
uniform 	mediump vec4 _OutlineColor;
uniform 	float _OutlineWidth;
uniform 	float _ScaleRatioA;
uniform 	vec4 _ClipRect;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FaceTex;
uniform lowp sampler2D _OutlineTex;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec2 u_xlat0;
mediump vec4 u_xlat16_0;
lowp vec4 u_xlat10_0;
mediump float u_xlat16_1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
vec2 u_xlat4;
mediump float u_xlat16_4;
lowp vec4 u_xlat10_4;
bool u_xlatb4;
float u_xlat5;
bool u_xlatb5;
mediump float u_xlat16_6;
float u_xlat9;
mediump float u_xlat16_11;
void main()
{
    u_xlat10_0.x = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat5 = u_xlat10_0.x + (-vs_TEXCOORD1.x);
    u_xlat0.x = (-u_xlat10_0.x) + vs_TEXCOORD1.z;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat5<0.0);
#else
    u_xlatb5 = u_xlat5<0.0;
#endif
    if((int(u_xlatb5) * int(0xffffffffu))!=0){discard;}
    u_xlat5 = _OutlineWidth * _ScaleRatioA;
    u_xlat5 = u_xlat5 * vs_TEXCOORD1.y;
    u_xlat16_1 = min(u_xlat5, 1.0);
    u_xlat16_6 = u_xlat5 * 0.5;
    u_xlat16_1 = sqrt(u_xlat16_1);
    u_xlat16_11 = u_xlat0.x * vs_TEXCOORD1.y + u_xlat16_6;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_11 = min(max(u_xlat16_11, 0.0), 1.0);
#else
    u_xlat16_11 = clamp(u_xlat16_11, 0.0, 1.0);
#endif
    u_xlat16_6 = u_xlat0.x * vs_TEXCOORD1.y + (-u_xlat16_6);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_11;
    u_xlat0.xy = vec2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy + vs_TEXCOORD5.zw;
    u_xlat10_0 = texture(_OutlineTex, u_xlat0.xy);
    u_xlat16_2 = u_xlat10_0 * _OutlineColor;
    u_xlat16_3.xyz = vs_COLOR0.xyz * _FaceColor.xyz;
    u_xlat0.xy = vec2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy + vs_TEXCOORD5.xy;
    u_xlat10_4 = texture(_FaceTex, u_xlat0.xy);
    u_xlat16_0.xyz = u_xlat16_3.xyz * u_xlat10_4.xyz;
    u_xlat16_4 = u_xlat10_4.w * _FaceColor.w;
    u_xlat16_3.xyz = u_xlat16_0.xyz * vec3(u_xlat16_4);
    u_xlat16_2.xyz = u_xlat16_2.xyz * u_xlat16_2.www + (-u_xlat16_3.xyz);
    u_xlat16_2.w = _OutlineColor.w * u_xlat10_0.w + (-u_xlat16_4);
    u_xlat16_2 = vec4(u_xlat16_1) * u_xlat16_2;
    u_xlat16_0.xyz = u_xlat16_0.xyz * vec3(u_xlat16_4) + u_xlat16_2.xyz;
    u_xlat16_0.w = _FaceColor.w * u_xlat10_4.w + u_xlat16_2.w;
    u_xlat4.x = _OutlineSoftness * _ScaleRatioA;
    u_xlat9 = u_xlat4.x * vs_TEXCOORD1.y;
    u_xlat16_1 = u_xlat4.x * vs_TEXCOORD1.y + 1.0;
    u_xlat16_6 = u_xlat9 * 0.5 + u_xlat16_6;
    u_xlat16_1 = u_xlat16_6 / u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_0 = u_xlat16_0 * vec4(u_xlat16_1);
    u_xlat4.xy = vec2((-_ClipRect.x) + _ClipRect.z, (-_ClipRect.y) + _ClipRect.w);
    u_xlat4.xy = u_xlat4.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat4.xy = vec2(u_xlat4.x * vs_TEXCOORD2.z, u_xlat4.y * vs_TEXCOORD2.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat4.xy = min(max(u_xlat4.xy, 0.0), 1.0);
#else
    u_xlat4.xy = clamp(u_xlat4.xy, 0.0, 1.0);
#endif
    u_xlat16_1 = u_xlat4.y * u_xlat4.x;
    u_xlat16_6 = u_xlat16_0.w * u_xlat16_1 + -0.00100000005;
    u_xlat16_0 = u_xlat16_0 * vec4(u_xlat16_1);
    SV_Target0 = u_xlat16_0 * vs_COLOR0.wwww;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat16_6<0.0);
#else
    u_xlatb4 = u_xlat16_6<0.0;
#endif
    if((int(u_xlatb4) * int(0xffffffffu))!=0){discard;}
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNITY_UI_ALPHACLIP" "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixVP;
uniform highp float _FaceDilate;
uniform highp float _OutlineSoftness;
uniform highp float _OutlineWidth;
uniform highp mat4 _EnvMatrix;
uniform lowp vec4 _UnderlayColor;
uniform highp float _UnderlayOffsetX;
uniform highp float _UnderlayOffsetY;
uniform highp float _UnderlayDilate;
uniform highp float _UnderlaySoftness;
uniform highp float _GlowOffset;
uniform highp float _GlowOuter;
uniform highp float _WeightNormal;
uniform highp float _WeightBold;
uniform highp float _ScaleRatioA;
uniform highp float _ScaleRatioB;
uniform highp float _ScaleRatioC;
uniform highp float _VertexOffsetX;
uniform highp float _VertexOffsetY;
uniform highp vec4 _ClipRect;
uniform highp float _MaskSoftnessX;
uniform highp float _MaskSoftnessY;
uniform highp float _TextureWidth;
uniform highp float _TextureHeight;
uniform highp float _GradientScale;
uniform highp float _ScaleX;
uniform highp float _ScaleY;
uniform highp float _PerspectiveFilter;
uniform highp vec4 _FaceTex_ST;
uniform highp vec4 _OutlineTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp float bScale_3;
  highp vec4 underlayColor_4;
  highp float weight_5;
  highp float scale_6;
  highp vec2 pixelSize_7;
  highp vec4 vert_8;
  highp float tmpvar_9;
  tmpvar_9 = float((0.0 >= _glesMultiTexCoord1.y));
  vert_8.zw = _glesVertex.zw;
  vert_8.x = (_glesVertex.x + _VertexOffsetX);
  vert_8.y = (_glesVertex.y + _VertexOffsetY);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = vert_8.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec2 tmpvar_12;
  tmpvar_12.x = _ScaleX;
  tmpvar_12.y = _ScaleY;
  highp mat2 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_projection[0].xy;
  tmpvar_13[1] = glstate_matrix_projection[1].xy;
  pixelSize_7 = (tmpvar_10.ww / (tmpvar_12 * abs(
    (tmpvar_13 * _ScreenParams.xy)
  )));
  scale_6 = (inversesqrt(dot (pixelSize_7, pixelSize_7)) * ((
    abs(_glesMultiTexCoord1.y)
   * _GradientScale) * 1.5));
  if ((glstate_matrix_projection[3].w == 0.0)) {
    highp mat3 tmpvar_14;
    tmpvar_14[0] = unity_WorldToObject[0].xyz;
    tmpvar_14[1] = unity_WorldToObject[1].xyz;
    tmpvar_14[2] = unity_WorldToObject[2].xyz;
    scale_6 = mix ((abs(scale_6) * (1.0 - _PerspectiveFilter)), scale_6, abs(dot (
      normalize((_glesNormal * tmpvar_14))
    , 
      normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_8).xyz))
    )));
  };
  weight_5 = (((
    (mix (_WeightNormal, _WeightBold, tmpvar_9) / 4.0)
   + _FaceDilate) * _ScaleRatioA) * 0.5);
  underlayColor_4 = _UnderlayColor;
  underlayColor_4.xyz = (underlayColor_4.xyz * underlayColor_4.w);
  bScale_3 = (scale_6 / (1.0 + (
    (_UnderlaySoftness * _ScaleRatioC)
   * scale_6)));
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((-(
    (_UnderlayOffsetX * _ScaleRatioC)
  ) * _GradientScale) / _TextureWidth);
  tmpvar_15.y = ((-(
    (_UnderlayOffsetY * _ScaleRatioC)
  ) * _GradientScale) / _TextureHeight);
  highp vec4 tmpvar_16;
  tmpvar_16 = clamp (_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10), vec4(2e+10, 2e+10, 2e+10, 2e+10));
  highp vec2 tmpvar_17;
  highp vec2 xlat_varoutput_18;
  xlat_varoutput_18.x = floor((_glesMultiTexCoord1.x / 4096.0));
  xlat_varoutput_18.y = (_glesMultiTexCoord1.x - (4096.0 * xlat_varoutput_18.x));
  tmpvar_17 = (xlat_varoutput_18 * 0.001953125);
  highp vec4 tmpvar_19;
  tmpvar_19.x = (((
    min (((1.0 - (_OutlineWidth * _ScaleRatioA)) - (_OutlineSoftness * _ScaleRatioA)), ((1.0 - (_GlowOffset * _ScaleRatioB)) - (_GlowOuter * _ScaleRatioB)))
   / 2.0) - (0.5 / scale_6)) - weight_5);
  tmpvar_19.y = scale_6;
  tmpvar_19.z = ((0.5 - weight_5) + (0.5 / scale_6));
  tmpvar_19.w = weight_5;
  highp vec2 tmpvar_20;
  tmpvar_20.x = _MaskSoftnessX;
  tmpvar_20.y = _MaskSoftnessY;
  highp vec4 tmpvar_21;
  tmpvar_21.xy = (((vert_8.xy * 2.0) - tmpvar_16.xy) - tmpvar_16.zw);
  tmpvar_21.zw = (0.25 / ((0.25 * tmpvar_20) + pixelSize_7));
  highp mat3 tmpvar_22;
  tmpvar_22[0] = _EnvMatrix[0].xyz;
  tmpvar_22[1] = _EnvMatrix[1].xyz;
  tmpvar_22[2] = _EnvMatrix[2].xyz;
  highp vec4 tmpvar_23;
  tmpvar_23.xy = (_glesMultiTexCoord0.xy + tmpvar_15);
  tmpvar_23.z = bScale_3;
  tmpvar_23.w = (((
    (0.5 - weight_5)
   * bScale_3) - 0.5) - ((_UnderlayDilate * _ScaleRatioC) * (0.5 * bScale_3)));
  highp vec4 tmpvar_24;
  tmpvar_24.xy = ((tmpvar_17 * _FaceTex_ST.xy) + _FaceTex_ST.zw);
  tmpvar_24.zw = ((tmpvar_17 * _OutlineTex_ST.xy) + _OutlineTex_ST.zw);
  lowp vec4 tmpvar_25;
  tmpvar_25 = underlayColor_4;
  gl_Position = tmpvar_10;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_19;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = (tmpvar_22 * (_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_8).xyz));
  xlv_TEXCOORD4 = tmpvar_23;
  xlv_COLOR1 = tmpvar_25;
  xlv_TEXCOORD5 = tmpvar_24;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _FaceTex;
uniform highp float _FaceUVSpeedX;
uniform highp float _FaceUVSpeedY;
uniform lowp vec4 _FaceColor;
uniform highp float _OutlineSoftness;
uniform sampler2D _OutlineTex;
uniform highp float _OutlineUVSpeedX;
uniform highp float _OutlineUVSpeedY;
uniform lowp vec4 _OutlineColor;
uniform highp float _OutlineWidth;
uniform highp float _Bevel;
uniform highp float _BevelOffset;
uniform highp float _BevelWidth;
uniform highp float _BevelClamp;
uniform highp float _BevelRoundness;
uniform sampler2D _BumpMap;
uniform highp float _BumpOutline;
uniform highp float _BumpFace;
uniform lowp samplerCube _Cube;
uniform lowp vec4 _ReflectFaceColor;
uniform lowp vec4 _ReflectOutlineColor;
uniform lowp vec4 _SpecularColor;
uniform highp float _LightAngle;
uniform highp float _SpecularPower;
uniform highp float _Reflectivity;
uniform highp float _Diffuse;
uniform highp float _Ambient;
uniform lowp vec4 _GlowColor;
uniform highp float _GlowOffset;
uniform highp float _GlowOuter;
uniform highp float _GlowInner;
uniform highp float _GlowPower;
uniform highp float _ShaderFlags;
uniform highp float _ScaleRatioA;
uniform highp float _ScaleRatioB;
uniform highp vec4 _ClipRect;
uniform sampler2D _MainTex;
uniform highp float _TextureWidth;
uniform highp float _TextureHeight;
uniform highp float _GradientScale;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 bump_2;
  mediump vec4 outlineColor_3;
  mediump vec4 faceColor_4;
  highp float c_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  c_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD1.z - c_5) * xlv_TEXCOORD1.y);
  highp float tmpvar_8;
  tmpvar_8 = ((_OutlineWidth * _ScaleRatioA) * xlv_TEXCOORD1.y);
  highp float tmpvar_9;
  tmpvar_9 = ((_OutlineSoftness * _ScaleRatioA) * xlv_TEXCOORD1.y);
  faceColor_4 = _FaceColor;
  outlineColor_3 = _OutlineColor;
  faceColor_4.xyz = (faceColor_4.xyz * xlv_COLOR.xyz);
  highp vec2 tmpvar_10;
  tmpvar_10.x = _FaceUVSpeedX;
  tmpvar_10.y = _FaceUVSpeedY;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD5.xy + (tmpvar_10 * _Time.y));
  tmpvar_11 = texture2D (_FaceTex, P_12);
  faceColor_4 = (faceColor_4 * tmpvar_11);
  highp vec2 tmpvar_13;
  tmpvar_13.x = _OutlineUVSpeedX;
  tmpvar_13.y = _OutlineUVSpeedY;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD5.zw + (tmpvar_13 * _Time.y));
  tmpvar_14 = texture2D (_OutlineTex, P_15);
  outlineColor_3 = (outlineColor_3 * tmpvar_14);
  mediump float d_16;
  d_16 = tmpvar_7;
  lowp vec4 faceColor_17;
  faceColor_17 = faceColor_4;
  lowp vec4 outlineColor_18;
  outlineColor_18 = outlineColor_3;
  mediump float outline_19;
  outline_19 = tmpvar_8;
  mediump float softness_20;
  softness_20 = tmpvar_9;
  mediump float tmpvar_21;
  tmpvar_21 = (1.0 - clamp ((
    ((d_16 - (outline_19 * 0.5)) + (softness_20 * 0.5))
   / 
    (1.0 + softness_20)
  ), 0.0, 1.0));
  faceColor_17.xyz = (faceColor_17.xyz * faceColor_17.w);
  outlineColor_18.xyz = (outlineColor_18.xyz * outlineColor_18.w);
  mediump vec4 tmpvar_22;
  tmpvar_22 = mix (faceColor_17, outlineColor_18, vec4((clamp (
    (d_16 + (outline_19 * 0.5))
  , 0.0, 1.0) * sqrt(
    min (1.0, outline_19)
  ))));
  faceColor_17 = tmpvar_22;
  faceColor_17 = (faceColor_17 * tmpvar_21);
  faceColor_4 = faceColor_17;
  highp vec3 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.x = (0.5 / _TextureWidth);
  tmpvar_23.y = (0.5 / _TextureHeight);
  highp vec4 h_24;
  highp vec2 P_25;
  P_25 = (xlv_TEXCOORD0 - tmpvar_23.xz);
  highp vec2 P_26;
  P_26 = (xlv_TEXCOORD0 + tmpvar_23.xz);
  highp vec2 P_27;
  P_27 = (xlv_TEXCOORD0 - tmpvar_23.zy);
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_23.zy);
  lowp vec4 tmpvar_29;
  tmpvar_29.x = texture2D (_MainTex, P_25).w;
  tmpvar_29.y = texture2D (_MainTex, P_26).w;
  tmpvar_29.z = texture2D (_MainTex, P_27).w;
  tmpvar_29.w = texture2D (_MainTex, P_28).w;
  h_24 = tmpvar_29;
  highp vec4 h_30;
  h_30 = h_24;
  highp float tmpvar_31;
  tmpvar_31 = (_ShaderFlags / 2.0);
  highp float tmpvar_32;
  tmpvar_32 = (fract(abs(tmpvar_31)) * 2.0);
  highp float tmpvar_33;
  if ((tmpvar_31 >= 0.0)) {
    tmpvar_33 = tmpvar_32;
  } else {
    tmpvar_33 = -(tmpvar_32);
  };
  h_30 = (h_24 + (xlv_TEXCOORD1.w + _BevelOffset));
  highp float tmpvar_34;
  tmpvar_34 = max (0.01, (_OutlineWidth + _BevelWidth));
  h_30 = (h_30 - 0.5);
  h_30 = (h_30 / tmpvar_34);
  highp vec4 tmpvar_35;
  tmpvar_35 = clamp ((h_30 + 0.5), 0.0, 1.0);
  h_30 = tmpvar_35;
  if (bool(float((tmpvar_33 >= 1.0)))) {
    h_30 = (1.0 - abs((
      (tmpvar_35 * 2.0)
     - 1.0)));
  };
  h_30 = (min (mix (h_30, 
    sin(((h_30 * 3.141592) / 2.0))
  , vec4(_BevelRoundness)), vec4((1.0 - _BevelClamp))) * ((_Bevel * tmpvar_34) * (_GradientScale * -2.0)));
  highp vec3 tmpvar_36;
  tmpvar_36.xy = vec2(1.0, 0.0);
  tmpvar_36.z = (h_30.y - h_30.x);
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(tmpvar_36);
  highp vec3 tmpvar_38;
  tmpvar_38.xy = vec2(0.0, -1.0);
  tmpvar_38.z = (h_30.w - h_30.z);
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(tmpvar_38);
  highp vec2 tmpvar_40;
  tmpvar_40.x = _FaceUVSpeedX;
  tmpvar_40.y = _FaceUVSpeedY;
  highp vec2 P_41;
  P_41 = (xlv_TEXCOORD5.xy + (tmpvar_40 * _Time.y));
  lowp vec3 tmpvar_42;
  tmpvar_42 = ((texture2D (_BumpMap, P_41).xyz * 2.0) - 1.0);
  bump_2 = tmpvar_42;
  bump_2 = (bump_2 * mix (_BumpFace, _BumpOutline, clamp (
    (tmpvar_7 + (tmpvar_8 * 0.5))
  , 0.0, 1.0)));
  highp vec3 tmpvar_43;
  tmpvar_43 = normalize(((
    (tmpvar_37.yzx * tmpvar_39.zxy)
   - 
    (tmpvar_37.zxy * tmpvar_39.yzx)
  ) - bump_2));
  highp vec3 tmpvar_44;
  tmpvar_44.z = -1.0;
  tmpvar_44.x = sin(_LightAngle);
  tmpvar_44.y = cos(_LightAngle);
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize(tmpvar_44);
  highp vec3 tmpvar_46;
  tmpvar_46 = ((_SpecularColor.xyz * pow (
    max (0.0, dot (tmpvar_43, tmpvar_45))
  , _Reflectivity)) * _SpecularPower);
  faceColor_4.xyz = (faceColor_4.xyz + (tmpvar_46 * faceColor_4.w));
  highp float tmpvar_47;
  tmpvar_47 = dot (tmpvar_43, tmpvar_45);
  faceColor_4.xyz = (faceColor_4.xyz * (1.0 - (tmpvar_47 * _Diffuse)));
  highp float tmpvar_48;
  tmpvar_48 = mix (_Ambient, 1.0, (tmpvar_43.z * tmpvar_43.z));
  faceColor_4.xyz = (faceColor_4.xyz * tmpvar_48);
  highp vec3 tmpvar_49;
  highp vec3 N_50;
  N_50 = -(tmpvar_43);
  tmpvar_49 = (xlv_TEXCOORD3 - (2.0 * (
    dot (N_50, xlv_TEXCOORD3)
   * N_50)));
  lowp vec4 tmpvar_51;
  tmpvar_51 = textureCube (_Cube, tmpvar_49);
  highp float tmpvar_52;
  tmpvar_52 = clamp ((tmpvar_7 + (tmpvar_8 * 0.5)), 0.0, 1.0);
  lowp vec3 tmpvar_53;
  tmpvar_53 = mix (_ReflectFaceColor.xyz, _ReflectOutlineColor.xyz, vec3(tmpvar_52));
  faceColor_4.xyz = (faceColor_4.xyz + ((tmpvar_51.xyz * tmpvar_53) * faceColor_4.w));
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_MainTex, xlv_TEXCOORD4.xy);
  highp float tmpvar_55;
  tmpvar_55 = clamp (((tmpvar_54.w * xlv_TEXCOORD4.z) - xlv_TEXCOORD4.w), 0.0, 1.0);
  faceColor_4 = (faceColor_4 + ((xlv_COLOR1 * tmpvar_55) * (1.0 - faceColor_4.w)));
  highp vec4 tmpvar_56;
  highp float glow_57;
  highp float tmpvar_58;
  tmpvar_58 = (tmpvar_7 - ((_GlowOffset * _ScaleRatioB) * (0.5 * xlv_TEXCOORD1.y)));
  highp float tmpvar_59;
  tmpvar_59 = ((mix (_GlowInner, 
    (_GlowOuter * _ScaleRatioB)
  , 
    float((tmpvar_58 >= 0.0))
  ) * 0.5) * xlv_TEXCOORD1.y);
  glow_57 = (1.0 - pow (clamp (
    abs((tmpvar_58 / (1.0 + tmpvar_59)))
  , 0.0, 1.0), _GlowPower));
  glow_57 = (glow_57 * sqrt(min (1.0, tmpvar_59)));
  highp float tmpvar_60;
  tmpvar_60 = clamp (((_GlowColor.w * glow_57) * 2.0), 0.0, 1.0);
  lowp vec4 tmpvar_61;
  tmpvar_61.xyz = _GlowColor.xyz;
  tmpvar_61.w = tmpvar_60;
  tmpvar_56 = tmpvar_61;
  faceColor_4.xyz = (faceColor_4.xyz + (tmpvar_56.xyz * tmpvar_56.w));
  mediump vec2 tmpvar_62;
  highp vec2 tmpvar_63;
  tmpvar_63 = clamp (((
    (_ClipRect.zw - _ClipRect.xy)
   - 
    abs(xlv_TEXCOORD2.xy)
  ) * xlv_TEXCOORD2.zw), 0.0, 1.0);
  tmpvar_62 = tmpvar_63;
  faceColor_4 = (faceColor_4 * (tmpvar_62.x * tmpvar_62.y));
  mediump float x_64;
  x_64 = (faceColor_4.w - 0.001);
  if ((x_64 < 0.0)) {
    discard;
  };
  tmpvar_1 = (faceColor_4 * xlv_COLOR.w);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNITY_UI_ALPHACLIP" "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixVP;
uniform highp float _FaceDilate;
uniform highp float _OutlineSoftness;
uniform highp float _OutlineWidth;
uniform highp mat4 _EnvMatrix;
uniform lowp vec4 _UnderlayColor;
uniform highp float _UnderlayOffsetX;
uniform highp float _UnderlayOffsetY;
uniform highp float _UnderlayDilate;
uniform highp float _UnderlaySoftness;
uniform highp float _GlowOffset;
uniform highp float _GlowOuter;
uniform highp float _WeightNormal;
uniform highp float _WeightBold;
uniform highp float _ScaleRatioA;
uniform highp float _ScaleRatioB;
uniform highp float _ScaleRatioC;
uniform highp float _VertexOffsetX;
uniform highp float _VertexOffsetY;
uniform highp vec4 _ClipRect;
uniform highp float _MaskSoftnessX;
uniform highp float _MaskSoftnessY;
uniform highp float _TextureWidth;
uniform highp float _TextureHeight;
uniform highp float _GradientScale;
uniform highp float _ScaleX;
uniform highp float _ScaleY;
uniform highp float _PerspectiveFilter;
uniform highp vec4 _FaceTex_ST;
uniform highp vec4 _OutlineTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp float bScale_3;
  highp vec4 underlayColor_4;
  highp float weight_5;
  highp float scale_6;
  highp vec2 pixelSize_7;
  highp vec4 vert_8;
  highp float tmpvar_9;
  tmpvar_9 = float((0.0 >= _glesMultiTexCoord1.y));
  vert_8.zw = _glesVertex.zw;
  vert_8.x = (_glesVertex.x + _VertexOffsetX);
  vert_8.y = (_glesVertex.y + _VertexOffsetY);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = vert_8.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec2 tmpvar_12;
  tmpvar_12.x = _ScaleX;
  tmpvar_12.y = _ScaleY;
  highp mat2 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_projection[0].xy;
  tmpvar_13[1] = glstate_matrix_projection[1].xy;
  pixelSize_7 = (tmpvar_10.ww / (tmpvar_12 * abs(
    (tmpvar_13 * _ScreenParams.xy)
  )));
  scale_6 = (inversesqrt(dot (pixelSize_7, pixelSize_7)) * ((
    abs(_glesMultiTexCoord1.y)
   * _GradientScale) * 1.5));
  if ((glstate_matrix_projection[3].w == 0.0)) {
    highp mat3 tmpvar_14;
    tmpvar_14[0] = unity_WorldToObject[0].xyz;
    tmpvar_14[1] = unity_WorldToObject[1].xyz;
    tmpvar_14[2] = unity_WorldToObject[2].xyz;
    scale_6 = mix ((abs(scale_6) * (1.0 - _PerspectiveFilter)), scale_6, abs(dot (
      normalize((_glesNormal * tmpvar_14))
    , 
      normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_8).xyz))
    )));
  };
  weight_5 = (((
    (mix (_WeightNormal, _WeightBold, tmpvar_9) / 4.0)
   + _FaceDilate) * _ScaleRatioA) * 0.5);
  underlayColor_4 = _UnderlayColor;
  underlayColor_4.xyz = (underlayColor_4.xyz * underlayColor_4.w);
  bScale_3 = (scale_6 / (1.0 + (
    (_UnderlaySoftness * _ScaleRatioC)
   * scale_6)));
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((-(
    (_UnderlayOffsetX * _ScaleRatioC)
  ) * _GradientScale) / _TextureWidth);
  tmpvar_15.y = ((-(
    (_UnderlayOffsetY * _ScaleRatioC)
  ) * _GradientScale) / _TextureHeight);
  highp vec4 tmpvar_16;
  tmpvar_16 = clamp (_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10), vec4(2e+10, 2e+10, 2e+10, 2e+10));
  highp vec2 tmpvar_17;
  highp vec2 xlat_varoutput_18;
  xlat_varoutput_18.x = floor((_glesMultiTexCoord1.x / 4096.0));
  xlat_varoutput_18.y = (_glesMultiTexCoord1.x - (4096.0 * xlat_varoutput_18.x));
  tmpvar_17 = (xlat_varoutput_18 * 0.001953125);
  highp vec4 tmpvar_19;
  tmpvar_19.x = (((
    min (((1.0 - (_OutlineWidth * _ScaleRatioA)) - (_OutlineSoftness * _ScaleRatioA)), ((1.0 - (_GlowOffset * _ScaleRatioB)) - (_GlowOuter * _ScaleRatioB)))
   / 2.0) - (0.5 / scale_6)) - weight_5);
  tmpvar_19.y = scale_6;
  tmpvar_19.z = ((0.5 - weight_5) + (0.5 / scale_6));
  tmpvar_19.w = weight_5;
  highp vec2 tmpvar_20;
  tmpvar_20.x = _MaskSoftnessX;
  tmpvar_20.y = _MaskSoftnessY;
  highp vec4 tmpvar_21;
  tmpvar_21.xy = (((vert_8.xy * 2.0) - tmpvar_16.xy) - tmpvar_16.zw);
  tmpvar_21.zw = (0.25 / ((0.25 * tmpvar_20) + pixelSize_7));
  highp mat3 tmpvar_22;
  tmpvar_22[0] = _EnvMatrix[0].xyz;
  tmpvar_22[1] = _EnvMatrix[1].xyz;
  tmpvar_22[2] = _EnvMatrix[2].xyz;
  highp vec4 tmpvar_23;
  tmpvar_23.xy = (_glesMultiTexCoord0.xy + tmpvar_15);
  tmpvar_23.z = bScale_3;
  tmpvar_23.w = (((
    (0.5 - weight_5)
   * bScale_3) - 0.5) - ((_UnderlayDilate * _ScaleRatioC) * (0.5 * bScale_3)));
  highp vec4 tmpvar_24;
  tmpvar_24.xy = ((tmpvar_17 * _FaceTex_ST.xy) + _FaceTex_ST.zw);
  tmpvar_24.zw = ((tmpvar_17 * _OutlineTex_ST.xy) + _OutlineTex_ST.zw);
  lowp vec4 tmpvar_25;
  tmpvar_25 = underlayColor_4;
  gl_Position = tmpvar_10;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_19;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = (tmpvar_22 * (_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_8).xyz));
  xlv_TEXCOORD4 = tmpvar_23;
  xlv_COLOR1 = tmpvar_25;
  xlv_TEXCOORD5 = tmpvar_24;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _FaceTex;
uniform highp float _FaceUVSpeedX;
uniform highp float _FaceUVSpeedY;
uniform lowp vec4 _FaceColor;
uniform highp float _OutlineSoftness;
uniform sampler2D _OutlineTex;
uniform highp float _OutlineUVSpeedX;
uniform highp float _OutlineUVSpeedY;
uniform lowp vec4 _OutlineColor;
uniform highp float _OutlineWidth;
uniform highp float _Bevel;
uniform highp float _BevelOffset;
uniform highp float _BevelWidth;
uniform highp float _BevelClamp;
uniform highp float _BevelRoundness;
uniform sampler2D _BumpMap;
uniform highp float _BumpOutline;
uniform highp float _BumpFace;
uniform lowp samplerCube _Cube;
uniform lowp vec4 _ReflectFaceColor;
uniform lowp vec4 _ReflectOutlineColor;
uniform lowp vec4 _SpecularColor;
uniform highp float _LightAngle;
uniform highp float _SpecularPower;
uniform highp float _Reflectivity;
uniform highp float _Diffuse;
uniform highp float _Ambient;
uniform lowp vec4 _GlowColor;
uniform highp float _GlowOffset;
uniform highp float _GlowOuter;
uniform highp float _GlowInner;
uniform highp float _GlowPower;
uniform highp float _ShaderFlags;
uniform highp float _ScaleRatioA;
uniform highp float _ScaleRatioB;
uniform highp vec4 _ClipRect;
uniform sampler2D _MainTex;
uniform highp float _TextureWidth;
uniform highp float _TextureHeight;
uniform highp float _GradientScale;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 bump_2;
  mediump vec4 outlineColor_3;
  mediump vec4 faceColor_4;
  highp float c_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  c_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD1.z - c_5) * xlv_TEXCOORD1.y);
  highp float tmpvar_8;
  tmpvar_8 = ((_OutlineWidth * _ScaleRatioA) * xlv_TEXCOORD1.y);
  highp float tmpvar_9;
  tmpvar_9 = ((_OutlineSoftness * _ScaleRatioA) * xlv_TEXCOORD1.y);
  faceColor_4 = _FaceColor;
  outlineColor_3 = _OutlineColor;
  faceColor_4.xyz = (faceColor_4.xyz * xlv_COLOR.xyz);
  highp vec2 tmpvar_10;
  tmpvar_10.x = _FaceUVSpeedX;
  tmpvar_10.y = _FaceUVSpeedY;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD5.xy + (tmpvar_10 * _Time.y));
  tmpvar_11 = texture2D (_FaceTex, P_12);
  faceColor_4 = (faceColor_4 * tmpvar_11);
  highp vec2 tmpvar_13;
  tmpvar_13.x = _OutlineUVSpeedX;
  tmpvar_13.y = _OutlineUVSpeedY;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD5.zw + (tmpvar_13 * _Time.y));
  tmpvar_14 = texture2D (_OutlineTex, P_15);
  outlineColor_3 = (outlineColor_3 * tmpvar_14);
  mediump float d_16;
  d_16 = tmpvar_7;
  lowp vec4 faceColor_17;
  faceColor_17 = faceColor_4;
  lowp vec4 outlineColor_18;
  outlineColor_18 = outlineColor_3;
  mediump float outline_19;
  outline_19 = tmpvar_8;
  mediump float softness_20;
  softness_20 = tmpvar_9;
  mediump float tmpvar_21;
  tmpvar_21 = (1.0 - clamp ((
    ((d_16 - (outline_19 * 0.5)) + (softness_20 * 0.5))
   / 
    (1.0 + softness_20)
  ), 0.0, 1.0));
  faceColor_17.xyz = (faceColor_17.xyz * faceColor_17.w);
  outlineColor_18.xyz = (outlineColor_18.xyz * outlineColor_18.w);
  mediump vec4 tmpvar_22;
  tmpvar_22 = mix (faceColor_17, outlineColor_18, vec4((clamp (
    (d_16 + (outline_19 * 0.5))
  , 0.0, 1.0) * sqrt(
    min (1.0, outline_19)
  ))));
  faceColor_17 = tmpvar_22;
  faceColor_17 = (faceColor_17 * tmpvar_21);
  faceColor_4 = faceColor_17;
  highp vec3 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.x = (0.5 / _TextureWidth);
  tmpvar_23.y = (0.5 / _TextureHeight);
  highp vec4 h_24;
  highp vec2 P_25;
  P_25 = (xlv_TEXCOORD0 - tmpvar_23.xz);
  highp vec2 P_26;
  P_26 = (xlv_TEXCOORD0 + tmpvar_23.xz);
  highp vec2 P_27;
  P_27 = (xlv_TEXCOORD0 - tmpvar_23.zy);
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_23.zy);
  lowp vec4 tmpvar_29;
  tmpvar_29.x = texture2D (_MainTex, P_25).w;
  tmpvar_29.y = texture2D (_MainTex, P_26).w;
  tmpvar_29.z = texture2D (_MainTex, P_27).w;
  tmpvar_29.w = texture2D (_MainTex, P_28).w;
  h_24 = tmpvar_29;
  highp vec4 h_30;
  h_30 = h_24;
  highp float tmpvar_31;
  tmpvar_31 = (_ShaderFlags / 2.0);
  highp float tmpvar_32;
  tmpvar_32 = (fract(abs(tmpvar_31)) * 2.0);
  highp float tmpvar_33;
  if ((tmpvar_31 >= 0.0)) {
    tmpvar_33 = tmpvar_32;
  } else {
    tmpvar_33 = -(tmpvar_32);
  };
  h_30 = (h_24 + (xlv_TEXCOORD1.w + _BevelOffset));
  highp float tmpvar_34;
  tmpvar_34 = max (0.01, (_OutlineWidth + _BevelWidth));
  h_30 = (h_30 - 0.5);
  h_30 = (h_30 / tmpvar_34);
  highp vec4 tmpvar_35;
  tmpvar_35 = clamp ((h_30 + 0.5), 0.0, 1.0);
  h_30 = tmpvar_35;
  if (bool(float((tmpvar_33 >= 1.0)))) {
    h_30 = (1.0 - abs((
      (tmpvar_35 * 2.0)
     - 1.0)));
  };
  h_30 = (min (mix (h_30, 
    sin(((h_30 * 3.141592) / 2.0))
  , vec4(_BevelRoundness)), vec4((1.0 - _BevelClamp))) * ((_Bevel * tmpvar_34) * (_GradientScale * -2.0)));
  highp vec3 tmpvar_36;
  tmpvar_36.xy = vec2(1.0, 0.0);
  tmpvar_36.z = (h_30.y - h_30.x);
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(tmpvar_36);
  highp vec3 tmpvar_38;
  tmpvar_38.xy = vec2(0.0, -1.0);
  tmpvar_38.z = (h_30.w - h_30.z);
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(tmpvar_38);
  highp vec2 tmpvar_40;
  tmpvar_40.x = _FaceUVSpeedX;
  tmpvar_40.y = _FaceUVSpeedY;
  highp vec2 P_41;
  P_41 = (xlv_TEXCOORD5.xy + (tmpvar_40 * _Time.y));
  lowp vec3 tmpvar_42;
  tmpvar_42 = ((texture2D (_BumpMap, P_41).xyz * 2.0) - 1.0);
  bump_2 = tmpvar_42;
  bump_2 = (bump_2 * mix (_BumpFace, _BumpOutline, clamp (
    (tmpvar_7 + (tmpvar_8 * 0.5))
  , 0.0, 1.0)));
  highp vec3 tmpvar_43;
  tmpvar_43 = normalize(((
    (tmpvar_37.yzx * tmpvar_39.zxy)
   - 
    (tmpvar_37.zxy * tmpvar_39.yzx)
  ) - bump_2));
  highp vec3 tmpvar_44;
  tmpvar_44.z = -1.0;
  tmpvar_44.x = sin(_LightAngle);
  tmpvar_44.y = cos(_LightAngle);
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize(tmpvar_44);
  highp vec3 tmpvar_46;
  tmpvar_46 = ((_SpecularColor.xyz * pow (
    max (0.0, dot (tmpvar_43, tmpvar_45))
  , _Reflectivity)) * _SpecularPower);
  faceColor_4.xyz = (faceColor_4.xyz + (tmpvar_46 * faceColor_4.w));
  highp float tmpvar_47;
  tmpvar_47 = dot (tmpvar_43, tmpvar_45);
  faceColor_4.xyz = (faceColor_4.xyz * (1.0 - (tmpvar_47 * _Diffuse)));
  highp float tmpvar_48;
  tmpvar_48 = mix (_Ambient, 1.0, (tmpvar_43.z * tmpvar_43.z));
  faceColor_4.xyz = (faceColor_4.xyz * tmpvar_48);
  highp vec3 tmpvar_49;
  highp vec3 N_50;
  N_50 = -(tmpvar_43);
  tmpvar_49 = (xlv_TEXCOORD3 - (2.0 * (
    dot (N_50, xlv_TEXCOORD3)
   * N_50)));
  lowp vec4 tmpvar_51;
  tmpvar_51 = textureCube (_Cube, tmpvar_49);
  highp float tmpvar_52;
  tmpvar_52 = clamp ((tmpvar_7 + (tmpvar_8 * 0.5)), 0.0, 1.0);
  lowp vec3 tmpvar_53;
  tmpvar_53 = mix (_ReflectFaceColor.xyz, _ReflectOutlineColor.xyz, vec3(tmpvar_52));
  faceColor_4.xyz = (faceColor_4.xyz + ((tmpvar_51.xyz * tmpvar_53) * faceColor_4.w));
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_MainTex, xlv_TEXCOORD4.xy);
  highp float tmpvar_55;
  tmpvar_55 = clamp (((tmpvar_54.w * xlv_TEXCOORD4.z) - xlv_TEXCOORD4.w), 0.0, 1.0);
  faceColor_4 = (faceColor_4 + ((xlv_COLOR1 * tmpvar_55) * (1.0 - faceColor_4.w)));
  highp vec4 tmpvar_56;
  highp float glow_57;
  highp float tmpvar_58;
  tmpvar_58 = (tmpvar_7 - ((_GlowOffset * _ScaleRatioB) * (0.5 * xlv_TEXCOORD1.y)));
  highp float tmpvar_59;
  tmpvar_59 = ((mix (_GlowInner, 
    (_GlowOuter * _ScaleRatioB)
  , 
    float((tmpvar_58 >= 0.0))
  ) * 0.5) * xlv_TEXCOORD1.y);
  glow_57 = (1.0 - pow (clamp (
    abs((tmpvar_58 / (1.0 + tmpvar_59)))
  , 0.0, 1.0), _GlowPower));
  glow_57 = (glow_57 * sqrt(min (1.0, tmpvar_59)));
  highp float tmpvar_60;
  tmpvar_60 = clamp (((_GlowColor.w * glow_57) * 2.0), 0.0, 1.0);
  lowp vec4 tmpvar_61;
  tmpvar_61.xyz = _GlowColor.xyz;
  tmpvar_61.w = tmpvar_60;
  tmpvar_56 = tmpvar_61;
  faceColor_4.xyz = (faceColor_4.xyz + (tmpvar_56.xyz * tmpvar_56.w));
  mediump vec2 tmpvar_62;
  highp vec2 tmpvar_63;
  tmpvar_63 = clamp (((
    (_ClipRect.zw - _ClipRect.xy)
   - 
    abs(xlv_TEXCOORD2.xy)
  ) * xlv_TEXCOORD2.zw), 0.0, 1.0);
  tmpvar_62 = tmpvar_63;
  faceColor_4 = (faceColor_4 * (tmpvar_62.x * tmpvar_62.y));
  mediump float x_64;
  x_64 = (faceColor_4.w - 0.001);
  if ((x_64 < 0.0)) {
    discard;
  };
  tmpvar_1 = (faceColor_4 * xlv_COLOR.w);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNITY_UI_ALPHACLIP" "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixVP;
uniform highp float _FaceDilate;
uniform highp float _OutlineSoftness;
uniform highp float _OutlineWidth;
uniform highp mat4 _EnvMatrix;
uniform lowp vec4 _UnderlayColor;
uniform highp float _UnderlayOffsetX;
uniform highp float _UnderlayOffsetY;
uniform highp float _UnderlayDilate;
uniform highp float _UnderlaySoftness;
uniform highp float _GlowOffset;
uniform highp float _GlowOuter;
uniform highp float _WeightNormal;
uniform highp float _WeightBold;
uniform highp float _ScaleRatioA;
uniform highp float _ScaleRatioB;
uniform highp float _ScaleRatioC;
uniform highp float _VertexOffsetX;
uniform highp float _VertexOffsetY;
uniform highp vec4 _ClipRect;
uniform highp float _MaskSoftnessX;
uniform highp float _MaskSoftnessY;
uniform highp float _TextureWidth;
uniform highp float _TextureHeight;
uniform highp float _GradientScale;
uniform highp float _ScaleX;
uniform highp float _ScaleY;
uniform highp float _PerspectiveFilter;
uniform highp vec4 _FaceTex_ST;
uniform highp vec4 _OutlineTex_ST;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp float bScale_3;
  highp vec4 underlayColor_4;
  highp float weight_5;
  highp float scale_6;
  highp vec2 pixelSize_7;
  highp vec4 vert_8;
  highp float tmpvar_9;
  tmpvar_9 = float((0.0 >= _glesMultiTexCoord1.y));
  vert_8.zw = _glesVertex.zw;
  vert_8.x = (_glesVertex.x + _VertexOffsetX);
  vert_8.y = (_glesVertex.y + _VertexOffsetY);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = vert_8.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp vec2 tmpvar_12;
  tmpvar_12.x = _ScaleX;
  tmpvar_12.y = _ScaleY;
  highp mat2 tmpvar_13;
  tmpvar_13[0] = glstate_matrix_projection[0].xy;
  tmpvar_13[1] = glstate_matrix_projection[1].xy;
  pixelSize_7 = (tmpvar_10.ww / (tmpvar_12 * abs(
    (tmpvar_13 * _ScreenParams.xy)
  )));
  scale_6 = (inversesqrt(dot (pixelSize_7, pixelSize_7)) * ((
    abs(_glesMultiTexCoord1.y)
   * _GradientScale) * 1.5));
  if ((glstate_matrix_projection[3].w == 0.0)) {
    highp mat3 tmpvar_14;
    tmpvar_14[0] = unity_WorldToObject[0].xyz;
    tmpvar_14[1] = unity_WorldToObject[1].xyz;
    tmpvar_14[2] = unity_WorldToObject[2].xyz;
    scale_6 = mix ((abs(scale_6) * (1.0 - _PerspectiveFilter)), scale_6, abs(dot (
      normalize((_glesNormal * tmpvar_14))
    , 
      normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_8).xyz))
    )));
  };
  weight_5 = (((
    (mix (_WeightNormal, _WeightBold, tmpvar_9) / 4.0)
   + _FaceDilate) * _ScaleRatioA) * 0.5);
  underlayColor_4 = _UnderlayColor;
  underlayColor_4.xyz = (underlayColor_4.xyz * underlayColor_4.w);
  bScale_3 = (scale_6 / (1.0 + (
    (_UnderlaySoftness * _ScaleRatioC)
   * scale_6)));
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((-(
    (_UnderlayOffsetX * _ScaleRatioC)
  ) * _GradientScale) / _TextureWidth);
  tmpvar_15.y = ((-(
    (_UnderlayOffsetY * _ScaleRatioC)
  ) * _GradientScale) / _TextureHeight);
  highp vec4 tmpvar_16;
  tmpvar_16 = clamp (_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10), vec4(2e+10, 2e+10, 2e+10, 2e+10));
  highp vec2 tmpvar_17;
  highp vec2 xlat_varoutput_18;
  xlat_varoutput_18.x = floor((_glesMultiTexCoord1.x / 4096.0));
  xlat_varoutput_18.y = (_glesMultiTexCoord1.x - (4096.0 * xlat_varoutput_18.x));
  tmpvar_17 = (xlat_varoutput_18 * 0.001953125);
  highp vec4 tmpvar_19;
  tmpvar_19.x = (((
    min (((1.0 - (_OutlineWidth * _ScaleRatioA)) - (_OutlineSoftness * _ScaleRatioA)), ((1.0 - (_GlowOffset * _ScaleRatioB)) - (_GlowOuter * _ScaleRatioB)))
   / 2.0) - (0.5 / scale_6)) - weight_5);
  tmpvar_19.y = scale_6;
  tmpvar_19.z = ((0.5 - weight_5) + (0.5 / scale_6));
  tmpvar_19.w = weight_5;
  highp vec2 tmpvar_20;
  tmpvar_20.x = _MaskSoftnessX;
  tmpvar_20.y = _MaskSoftnessY;
  highp vec4 tmpvar_21;
  tmpvar_21.xy = (((vert_8.xy * 2.0) - tmpvar_16.xy) - tmpvar_16.zw);
  tmpvar_21.zw = (0.25 / ((0.25 * tmpvar_20) + pixelSize_7));
  highp mat3 tmpvar_22;
  tmpvar_22[0] = _EnvMatrix[0].xyz;
  tmpvar_22[1] = _EnvMatrix[1].xyz;
  tmpvar_22[2] = _EnvMatrix[2].xyz;
  highp vec4 tmpvar_23;
  tmpvar_23.xy = (_glesMultiTexCoord0.xy + tmpvar_15);
  tmpvar_23.z = bScale_3;
  tmpvar_23.w = (((
    (0.5 - weight_5)
   * bScale_3) - 0.5) - ((_UnderlayDilate * _ScaleRatioC) * (0.5 * bScale_3)));
  highp vec4 tmpvar_24;
  tmpvar_24.xy = ((tmpvar_17 * _FaceTex_ST.xy) + _FaceTex_ST.zw);
  tmpvar_24.zw = ((tmpvar_17 * _OutlineTex_ST.xy) + _OutlineTex_ST.zw);
  lowp vec4 tmpvar_25;
  tmpvar_25 = underlayColor_4;
  gl_Position = tmpvar_10;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_19;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = (tmpvar_22 * (_WorldSpaceCameraPos - (unity_ObjectToWorld * vert_8).xyz));
  xlv_TEXCOORD4 = tmpvar_23;
  xlv_COLOR1 = tmpvar_25;
  xlv_TEXCOORD5 = tmpvar_24;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _FaceTex;
uniform highp float _FaceUVSpeedX;
uniform highp float _FaceUVSpeedY;
uniform lowp vec4 _FaceColor;
uniform highp float _OutlineSoftness;
uniform sampler2D _OutlineTex;
uniform highp float _OutlineUVSpeedX;
uniform highp float _OutlineUVSpeedY;
uniform lowp vec4 _OutlineColor;
uniform highp float _OutlineWidth;
uniform highp float _Bevel;
uniform highp float _BevelOffset;
uniform highp float _BevelWidth;
uniform highp float _BevelClamp;
uniform highp float _BevelRoundness;
uniform sampler2D _BumpMap;
uniform highp float _BumpOutline;
uniform highp float _BumpFace;
uniform lowp samplerCube _Cube;
uniform lowp vec4 _ReflectFaceColor;
uniform lowp vec4 _ReflectOutlineColor;
uniform lowp vec4 _SpecularColor;
uniform highp float _LightAngle;
uniform highp float _SpecularPower;
uniform highp float _Reflectivity;
uniform highp float _Diffuse;
uniform highp float _Ambient;
uniform lowp vec4 _GlowColor;
uniform highp float _GlowOffset;
uniform highp float _GlowOuter;
uniform highp float _GlowInner;
uniform highp float _GlowPower;
uniform highp float _ShaderFlags;
uniform highp float _ScaleRatioA;
uniform highp float _ScaleRatioB;
uniform highp vec4 _ClipRect;
uniform sampler2D _MainTex;
uniform highp float _TextureWidth;
uniform highp float _TextureHeight;
uniform highp float _GradientScale;
varying lowp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying lowp vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 bump_2;
  mediump vec4 outlineColor_3;
  mediump vec4 faceColor_4;
  highp float c_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  c_5 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD1.z - c_5) * xlv_TEXCOORD1.y);
  highp float tmpvar_8;
  tmpvar_8 = ((_OutlineWidth * _ScaleRatioA) * xlv_TEXCOORD1.y);
  highp float tmpvar_9;
  tmpvar_9 = ((_OutlineSoftness * _ScaleRatioA) * xlv_TEXCOORD1.y);
  faceColor_4 = _FaceColor;
  outlineColor_3 = _OutlineColor;
  faceColor_4.xyz = (faceColor_4.xyz * xlv_COLOR.xyz);
  highp vec2 tmpvar_10;
  tmpvar_10.x = _FaceUVSpeedX;
  tmpvar_10.y = _FaceUVSpeedY;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (xlv_TEXCOORD5.xy + (tmpvar_10 * _Time.y));
  tmpvar_11 = texture2D (_FaceTex, P_12);
  faceColor_4 = (faceColor_4 * tmpvar_11);
  highp vec2 tmpvar_13;
  tmpvar_13.x = _OutlineUVSpeedX;
  tmpvar_13.y = _OutlineUVSpeedY;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD5.zw + (tmpvar_13 * _Time.y));
  tmpvar_14 = texture2D (_OutlineTex, P_15);
  outlineColor_3 = (outlineColor_3 * tmpvar_14);
  mediump float d_16;
  d_16 = tmpvar_7;
  lowp vec4 faceColor_17;
  faceColor_17 = faceColor_4;
  lowp vec4 outlineColor_18;
  outlineColor_18 = outlineColor_3;
  mediump float outline_19;
  outline_19 = tmpvar_8;
  mediump float softness_20;
  softness_20 = tmpvar_9;
  mediump float tmpvar_21;
  tmpvar_21 = (1.0 - clamp ((
    ((d_16 - (outline_19 * 0.5)) + (softness_20 * 0.5))
   / 
    (1.0 + softness_20)
  ), 0.0, 1.0));
  faceColor_17.xyz = (faceColor_17.xyz * faceColor_17.w);
  outlineColor_18.xyz = (outlineColor_18.xyz * outlineColor_18.w);
  mediump vec4 tmpvar_22;
  tmpvar_22 = mix (faceColor_17, outlineColor_18, vec4((clamp (
    (d_16 + (outline_19 * 0.5))
  , 0.0, 1.0) * sqrt(
    min (1.0, outline_19)
  ))));
  faceColor_17 = tmpvar_22;
  faceColor_17 = (faceColor_17 * tmpvar_21);
  faceColor_4 = faceColor_17;
  highp vec3 tmpvar_23;
  tmpvar_23.z = 0.0;
  tmpvar_23.x = (0.5 / _TextureWidth);
  tmpvar_23.y = (0.5 / _TextureHeight);
  highp vec4 h_24;
  highp vec2 P_25;
  P_25 = (xlv_TEXCOORD0 - tmpvar_23.xz);
  highp vec2 P_26;
  P_26 = (xlv_TEXCOORD0 + tmpvar_23.xz);
  highp vec2 P_27;
  P_27 = (xlv_TEXCOORD0 - tmpvar_23.zy);
  highp vec2 P_28;
  P_28 = (xlv_TEXCOORD0 + tmpvar_23.zy);
  lowp vec4 tmpvar_29;
  tmpvar_29.x = texture2D (_MainTex, P_25).w;
  tmpvar_29.y = texture2D (_MainTex, P_26).w;
  tmpvar_29.z = texture2D (_MainTex, P_27).w;
  tmpvar_29.w = texture2D (_MainTex, P_28).w;
  h_24 = tmpvar_29;
  highp vec4 h_30;
  h_30 = h_24;
  highp float tmpvar_31;
  tmpvar_31 = (_ShaderFlags / 2.0);
  highp float tmpvar_32;
  tmpvar_32 = (fract(abs(tmpvar_31)) * 2.0);
  highp float tmpvar_33;
  if ((tmpvar_31 >= 0.0)) {
    tmpvar_33 = tmpvar_32;
  } else {
    tmpvar_33 = -(tmpvar_32);
  };
  h_30 = (h_24 + (xlv_TEXCOORD1.w + _BevelOffset));
  highp float tmpvar_34;
  tmpvar_34 = max (0.01, (_OutlineWidth + _BevelWidth));
  h_30 = (h_30 - 0.5);
  h_30 = (h_30 / tmpvar_34);
  highp vec4 tmpvar_35;
  tmpvar_35 = clamp ((h_30 + 0.5), 0.0, 1.0);
  h_30 = tmpvar_35;
  if (bool(float((tmpvar_33 >= 1.0)))) {
    h_30 = (1.0 - abs((
      (tmpvar_35 * 2.0)
     - 1.0)));
  };
  h_30 = (min (mix (h_30, 
    sin(((h_30 * 3.141592) / 2.0))
  , vec4(_BevelRoundness)), vec4((1.0 - _BevelClamp))) * ((_Bevel * tmpvar_34) * (_GradientScale * -2.0)));
  highp vec3 tmpvar_36;
  tmpvar_36.xy = vec2(1.0, 0.0);
  tmpvar_36.z = (h_30.y - h_30.x);
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(tmpvar_36);
  highp vec3 tmpvar_38;
  tmpvar_38.xy = vec2(0.0, -1.0);
  tmpvar_38.z = (h_30.w - h_30.z);
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(tmpvar_38);
  highp vec2 tmpvar_40;
  tmpvar_40.x = _FaceUVSpeedX;
  tmpvar_40.y = _FaceUVSpeedY;
  highp vec2 P_41;
  P_41 = (xlv_TEXCOORD5.xy + (tmpvar_40 * _Time.y));
  lowp vec3 tmpvar_42;
  tmpvar_42 = ((texture2D (_BumpMap, P_41).xyz * 2.0) - 1.0);
  bump_2 = tmpvar_42;
  bump_2 = (bump_2 * mix (_BumpFace, _BumpOutline, clamp (
    (tmpvar_7 + (tmpvar_8 * 0.5))
  , 0.0, 1.0)));
  highp vec3 tmpvar_43;
  tmpvar_43 = normalize(((
    (tmpvar_37.yzx * tmpvar_39.zxy)
   - 
    (tmpvar_37.zxy * tmpvar_39.yzx)
  ) - bump_2));
  highp vec3 tmpvar_44;
  tmpvar_44.z = -1.0;
  tmpvar_44.x = sin(_LightAngle);
  tmpvar_44.y = cos(_LightAngle);
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize(tmpvar_44);
  highp vec3 tmpvar_46;
  tmpvar_46 = ((_SpecularColor.xyz * pow (
    max (0.0, dot (tmpvar_43, tmpvar_45))
  , _Reflectivity)) * _SpecularPower);
  faceColor_4.xyz = (faceColor_4.xyz + (tmpvar_46 * faceColor_4.w));
  highp float tmpvar_47;
  tmpvar_47 = dot (tmpvar_43, tmpvar_45);
  faceColor_4.xyz = (faceColor_4.xyz * (1.0 - (tmpvar_47 * _Diffuse)));
  highp float tmpvar_48;
  tmpvar_48 = mix (_Ambient, 1.0, (tmpvar_43.z * tmpvar_43.z));
  faceColor_4.xyz = (faceColor_4.xyz * tmpvar_48);
  highp vec3 tmpvar_49;
  highp vec3 N_50;
  N_50 = -(tmpvar_43);
  tmpvar_49 = (xlv_TEXCOORD3 - (2.0 * (
    dot (N_50, xlv_TEXCOORD3)
   * N_50)));
  lowp vec4 tmpvar_51;
  tmpvar_51 = textureCube (_Cube, tmpvar_49);
  highp float tmpvar_52;
  tmpvar_52 = clamp ((tmpvar_7 + (tmpvar_8 * 0.5)), 0.0, 1.0);
  lowp vec3 tmpvar_53;
  tmpvar_53 = mix (_ReflectFaceColor.xyz, _ReflectOutlineColor.xyz, vec3(tmpvar_52));
  faceColor_4.xyz = (faceColor_4.xyz + ((tmpvar_51.xyz * tmpvar_53) * faceColor_4.w));
  lowp vec4 tmpvar_54;
  tmpvar_54 = texture2D (_MainTex, xlv_TEXCOORD4.xy);
  highp float tmpvar_55;
  tmpvar_55 = clamp (((tmpvar_54.w * xlv_TEXCOORD4.z) - xlv_TEXCOORD4.w), 0.0, 1.0);
  faceColor_4 = (faceColor_4 + ((xlv_COLOR1 * tmpvar_55) * (1.0 - faceColor_4.w)));
  highp vec4 tmpvar_56;
  highp float glow_57;
  highp float tmpvar_58;
  tmpvar_58 = (tmpvar_7 - ((_GlowOffset * _ScaleRatioB) * (0.5 * xlv_TEXCOORD1.y)));
  highp float tmpvar_59;
  tmpvar_59 = ((mix (_GlowInner, 
    (_GlowOuter * _ScaleRatioB)
  , 
    float((tmpvar_58 >= 0.0))
  ) * 0.5) * xlv_TEXCOORD1.y);
  glow_57 = (1.0 - pow (clamp (
    abs((tmpvar_58 / (1.0 + tmpvar_59)))
  , 0.0, 1.0), _GlowPower));
  glow_57 = (glow_57 * sqrt(min (1.0, tmpvar_59)));
  highp float tmpvar_60;
  tmpvar_60 = clamp (((_GlowColor.w * glow_57) * 2.0), 0.0, 1.0);
  lowp vec4 tmpvar_61;
  tmpvar_61.xyz = _GlowColor.xyz;
  tmpvar_61.w = tmpvar_60;
  tmpvar_56 = tmpvar_61;
  faceColor_4.xyz = (faceColor_4.xyz + (tmpvar_56.xyz * tmpvar_56.w));
  mediump vec2 tmpvar_62;
  highp vec2 tmpvar_63;
  tmpvar_63 = clamp (((
    (_ClipRect.zw - _ClipRect.xy)
   - 
    abs(xlv_TEXCOORD2.xy)
  ) * xlv_TEXCOORD2.zw), 0.0, 1.0);
  tmpvar_62 = tmpvar_63;
  faceColor_4 = (faceColor_4 * (tmpvar_62.x * tmpvar_62.y));
  mediump float x_64;
  x_64 = (faceColor_4.w - 0.001);
  if ((x_64 < 0.0)) {
    discard;
  };
  tmpvar_1 = (faceColor_4 * xlv_COLOR.w);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNITY_UI_ALPHACLIP" "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _FaceDilate;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineWidth;
uniform 	vec4 hlslcc_mtx4x4_EnvMatrix[4];
uniform 	mediump vec4 _UnderlayColor;
uniform 	float _UnderlayOffsetX;
uniform 	float _UnderlayOffsetY;
uniform 	float _UnderlayDilate;
uniform 	float _UnderlaySoftness;
uniform 	float _GlowOffset;
uniform 	float _GlowOuter;
uniform 	float _WeightNormal;
uniform 	float _WeightBold;
uniform 	float _ScaleRatioA;
uniform 	float _ScaleRatioB;
uniform 	float _ScaleRatioC;
uniform 	float _VertexOffsetX;
uniform 	float _VertexOffsetY;
uniform 	vec4 _ClipRect;
uniform 	float _MaskSoftnessX;
uniform 	float _MaskSoftnessY;
uniform 	float _TextureWidth;
uniform 	float _TextureHeight;
uniform 	float _GradientScale;
uniform 	float _ScaleX;
uniform 	float _ScaleY;
uniform 	float _PerspectiveFilter;
uniform 	vec4 _FaceTex_ST;
uniform 	vec4 _OutlineTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat4;
vec3 u_xlat6;
vec2 u_xlat8;
float u_xlat12;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat0.xy = vec2(in_POSITION0.x + float(_VertexOffsetX), in_POSITION0.y + float(_VertexOffsetY));
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat8.x = (-_OutlineWidth) * _ScaleRatioA + 1.0;
    u_xlat8.x = (-_OutlineSoftness) * _ScaleRatioA + u_xlat8.x;
    u_xlat12 = (-_GlowOffset) * _ScaleRatioB + 1.0;
    u_xlat12 = (-_GlowOuter) * _ScaleRatioB + u_xlat12;
    u_xlat8.x = min(u_xlat12, u_xlat8.x);
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat2.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat2.xy;
    u_xlat2.xy = vec2(abs(u_xlat2.x) * float(_ScaleX), abs(u_xlat2.y) * float(_ScaleY));
    u_xlat2.xy = u_xlat2.ww / u_xlat2.xy;
    u_xlat13 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat2.xy;
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat2.xy;
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.x = abs(in_TEXCOORD1.y) * _GradientScale;
    u_xlat13 = u_xlat13 * u_xlat2.x;
    u_xlat2.x = u_xlat13 * 1.5;
    u_xlat6.x = (-_PerspectiveFilter) + 1.0;
    u_xlat6.x = u_xlat6.x * abs(u_xlat2.x);
    u_xlat13 = u_xlat13 * 1.5 + (-u_xlat6.x);
    u_xlat12 = abs(u_xlat12) * u_xlat13 + u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0);
#else
    u_xlatb13 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
#endif
    u_xlat6.x = (u_xlatb13) ? u_xlat12 : u_xlat2.x;
    u_xlat12 = 0.5 / u_xlat6.x;
    u_xlat8.x = u_xlat8.x * 0.5 + (-u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.0>=in_TEXCOORD1.y);
#else
    u_xlatb13 = 0.0>=in_TEXCOORD1.y;
#endif
    u_xlat13 = u_xlatb13 ? 1.0 : float(0.0);
    u_xlat2.x = (-_WeightNormal) + _WeightBold;
    u_xlat13 = u_xlat13 * u_xlat2.x + _WeightNormal;
    u_xlat13 = u_xlat13 * 0.25 + _FaceDilate;
    u_xlat13 = u_xlat13 * _ScaleRatioA;
    vs_TEXCOORD1.x = (-u_xlat13) * 0.5 + u_xlat8.x;
    u_xlat6.z = u_xlat13 * 0.5;
    u_xlat8.x = (-u_xlat13) * 0.5 + 0.5;
    vs_TEXCOORD1.yw = u_xlat6.xz;
    vs_TEXCOORD1.z = u_xlat12 + u_xlat8.x;
    u_xlat3 = max(_ClipRect, vec4(-2e+010, -2e+010, -2e+010, -2e+010));
    u_xlat3 = min(u_xlat3, vec4(2e+010, 2e+010, 2e+010, 2e+010));
    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat3.xy);
    vs_TEXCOORD2.xy = vec2((-u_xlat3.z) + u_xlat0.x, (-u_xlat3.w) + u_xlat0.y);
    u_xlat0.xyw = u_xlat1.yyy * hlslcc_mtx4x4_EnvMatrix[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_EnvMatrix[0].xyz * u_xlat1.xxx + u_xlat0.xyw;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4_EnvMatrix[2].xyz * u_xlat1.zzz + u_xlat0.xyw;
    u_xlat1 = vec4(_UnderlaySoftness, _UnderlayDilate, _UnderlayOffsetX, _UnderlayOffsetY) * vec4(vec4(_ScaleRatioC, _ScaleRatioC, _ScaleRatioC, _ScaleRatioC));
    u_xlat0.x = u_xlat1.x * u_xlat6.x + 1.0;
    u_xlat0.x = u_xlat6.x / u_xlat0.x;
    u_xlat4 = u_xlat8.x * u_xlat0.x + -0.5;
    u_xlat8.x = u_xlat0.x * u_xlat1.y;
    u_xlat1.xy = vec2((-u_xlat1.z) * _GradientScale, (-u_xlat1.w) * _GradientScale);
    u_xlat1.xy = vec2(u_xlat1.x / float(_TextureWidth), u_xlat1.y / float(_TextureHeight));
    vs_TEXCOORD4.xy = u_xlat1.xy + in_TEXCOORD0.xy;
    vs_TEXCOORD4.z = u_xlat0.x;
    vs_TEXCOORD4.w = (-u_xlat8.x) * 0.5 + u_xlat4;
    u_xlat0.xyz = _UnderlayColor.www * _UnderlayColor.xyz;
    vs_COLOR1.xyz = u_xlat0.xyz;
    vs_COLOR1.w = _UnderlayColor.w;
    u_xlat0.x = in_TEXCOORD1.x * 0.000244140625;
    u_xlat8.x = floor(u_xlat0.x);
    u_xlat8.y = (-u_xlat8.x) * 4096.0 + in_TEXCOORD1.x;
    u_xlat0.xy = u_xlat8.xy * vec2(0.001953125, 0.001953125);
    vs_TEXCOORD5.xy = u_xlat0.xy * _FaceTex_ST.xy + _FaceTex_ST.zw;
    vs_TEXCOORD5.zw = u_xlat0.xy * _OutlineTex_ST.xy + _OutlineTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _FaceUVSpeedX;
uniform 	float _FaceUVSpeedY;
uniform 	mediump vec4 _FaceColor;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineUVSpeedX;
uniform 	float _OutlineUVSpeedY;
uniform 	mediump vec4 _OutlineColor;
uniform 	float _OutlineWidth;
uniform 	float _Bevel;
uniform 	float _BevelOffset;
uniform 	float _BevelWidth;
uniform 	float _BevelClamp;
uniform 	float _BevelRoundness;
uniform 	float _BumpOutline;
uniform 	float _BumpFace;
uniform 	mediump vec4 _ReflectFaceColor;
uniform 	mediump vec4 _ReflectOutlineColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	float _LightAngle;
uniform 	float _SpecularPower;
uniform 	float _Reflectivity;
uniform 	float _Diffuse;
uniform 	float _Ambient;
uniform 	mediump vec4 _GlowColor;
uniform 	float _GlowOffset;
uniform 	float _GlowOuter;
uniform 	float _GlowInner;
uniform 	float _GlowPower;
uniform 	float _ShaderFlags;
uniform 	float _ScaleRatioA;
uniform 	float _ScaleRatioB;
uniform 	vec4 _ClipRect;
uniform 	float _TextureWidth;
uniform 	float _TextureHeight;
uniform 	float _GradientScale;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FaceTex;
uniform lowp sampler2D _OutlineTex;
uniform lowp sampler2D _BumpMap;
uniform lowp samplerCube _Cube;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec4 u_xlat16_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
lowp vec4 u_xlat10_5;
bool u_xlatb5;
mediump vec3 u_xlat16_6;
vec4 u_xlat7;
lowp vec3 u_xlat10_7;
vec4 u_xlat8;
mediump vec3 u_xlat16_8;
bool u_xlatb8;
vec3 u_xlat9;
lowp float u_xlat10_9;
mediump float u_xlat16_10;
float u_xlat14;
vec2 u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
bool u_xlatb18;
mediump float u_xlat16_19;
float u_xlat23;
float u_xlat27;
bool u_xlatb27;
float u_xlat32;
void main()
{
    u_xlat0.x = _OutlineWidth * _ScaleRatioA;
    u_xlat0.x = u_xlat0.x * vs_TEXCOORD1.y;
    u_xlat16_1 = min(u_xlat0.x, 1.0);
    u_xlat16_1 = sqrt(u_xlat16_1);
    u_xlat16_10 = u_xlat0.x * 0.5;
    u_xlat10_9 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat9.x = (-u_xlat10_9) + vs_TEXCOORD1.z;
    u_xlat16_19 = u_xlat9.x * vs_TEXCOORD1.y + u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat9.x * vs_TEXCOORD1.y + (-u_xlat16_10);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_19;
    u_xlat18.xy = vec2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy + vs_TEXCOORD5.zw;
    u_xlat10_2 = texture(_OutlineTex, u_xlat18.xy);
    u_xlat16_3 = u_xlat10_2 * _OutlineColor;
    u_xlat16_4.xyz = vs_COLOR0.xyz * _FaceColor.xyz;
    u_xlat18.xy = vec2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy + vs_TEXCOORD5.xy;
    u_xlat10_5 = texture(_FaceTex, u_xlat18.xy);
    u_xlat10_2.xyz = texture(_BumpMap, u_xlat18.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat10_5.xyz;
    u_xlat16_18 = u_xlat10_5.w * _FaceColor.w;
    u_xlat16_4.xyz = vec3(u_xlat16_18) * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_3.www + (-u_xlat16_4.xyz);
    u_xlat16_3.w = _OutlineColor.w * u_xlat10_2.w + (-u_xlat16_18);
    u_xlat16_3 = vec4(u_xlat16_1) * u_xlat16_3;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_18) + u_xlat16_3.xyz;
    u_xlat16_2.w = _FaceColor.w * u_xlat10_5.w + u_xlat16_3.w;
    u_xlat9.y = _OutlineSoftness * _ScaleRatioA;
    u_xlat9.xz = u_xlat9.xy * vs_TEXCOORD1.yy;
    u_xlat16_1 = u_xlat9.y * vs_TEXCOORD1.y + 1.0;
    u_xlat16_10 = u_xlat9.z * 0.5 + u_xlat16_10;
    u_xlat16_1 = u_xlat16_10 / u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_3 = vec4(u_xlat16_1) * u_xlat16_2;
    u_xlat16_1 = (-u_xlat16_2.w) * u_xlat16_1 + 1.0;
    u_xlat10_18 = texture(_MainTex, vs_TEXCOORD4.xy).w;
    u_xlat18.x = u_xlat10_18 * vs_TEXCOORD4.z + (-vs_TEXCOORD4.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat18.x = min(max(u_xlat18.x, 0.0), 1.0);
#else
    u_xlat18.x = clamp(u_xlat18.x, 0.0, 1.0);
#endif
    u_xlat2 = u_xlat18.xxxx * vs_COLOR1;
    u_xlat4.w = u_xlat2.w * u_xlat16_1 + u_xlat16_3.w;
    u_xlat18.xy = vec2((-_ClipRect.x) + _ClipRect.z, (-_ClipRect.y) + _ClipRect.w);
    u_xlat18.xy = u_xlat18.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat18.xy = vec2(u_xlat18.x * vs_TEXCOORD2.z, u_xlat18.y * vs_TEXCOORD2.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat18.xy = min(max(u_xlat18.xy, 0.0), 1.0);
#else
    u_xlat18.xy = clamp(u_xlat18.xy, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat18.y * u_xlat18.x;
    u_xlat16_19 = u_xlat4.w * u_xlat16_10 + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat16_19<0.0);
#else
    u_xlatb18 = u_xlat16_19<0.0;
#endif
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat18.x = vs_TEXCOORD1.w + _BevelOffset;
    u_xlat5.xy = vec2(float(0.5) / float(_TextureWidth), float(0.5) / float(_TextureHeight));
    u_xlat5.z = 0.0;
    u_xlat7 = (-u_xlat5.xzzy) + vs_TEXCOORD0.xyxy;
    u_xlat5 = u_xlat5.xzzy + vs_TEXCOORD0.xyxy;
    u_xlat8.x = texture(_MainTex, u_xlat7.xy).w;
    u_xlat8.z = texture(_MainTex, u_xlat7.zw).w;
    u_xlat8.y = texture(_MainTex, u_xlat5.xy).w;
    u_xlat8.w = texture(_MainTex, u_xlat5.zw).w;
    u_xlat5 = u_xlat18.xxxx + u_xlat8;
    u_xlat5 = u_xlat5 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat18.x = _BevelWidth + _OutlineWidth;
    u_xlat18.x = max(u_xlat18.x, 0.00999999978);
    u_xlat5 = u_xlat5 / u_xlat18.xxxx;
    u_xlat18.x = u_xlat18.x * _Bevel;
    u_xlat18.x = u_xlat18.x * _GradientScale;
    u_xlat18.x = u_xlat18.x * -2.0;
    u_xlat5 = u_xlat5 + vec4(0.5, 0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat7 = u_xlat5 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat7 = -abs(u_xlat7) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat27 = _ShaderFlags * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat27>=(-u_xlat27));
#else
    u_xlatb8 = u_xlat27>=(-u_xlat27);
#endif
    u_xlat27 = fract(abs(u_xlat27));
    u_xlat27 = (u_xlatb8) ? u_xlat27 : (-u_xlat27);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat27>=0.5);
#else
    u_xlatb27 = u_xlat27>=0.5;
#endif
    u_xlat5 = (bool(u_xlatb27)) ? u_xlat7 : u_xlat5;
    u_xlat7 = u_xlat5 * vec4(1.57079601, 1.57079601, 1.57079601, 1.57079601);
    u_xlat7 = sin(u_xlat7);
    u_xlat7 = (-u_xlat5) + u_xlat7;
    u_xlat5 = vec4(vec4(_BevelRoundness, _BevelRoundness, _BevelRoundness, _BevelRoundness)) * u_xlat7 + u_xlat5;
    u_xlat27 = (-_BevelClamp) + 1.0;
    u_xlat5 = min(vec4(u_xlat27), u_xlat5);
    u_xlat5.xz = u_xlat18.xx * u_xlat5.xz;
    u_xlat5.yz = u_xlat5.wy * u_xlat18.xx + (-u_xlat5.zx);
    u_xlat5.x = float(-1.0);
    u_xlat5.w = float(1.0);
    u_xlat18.x = dot(u_xlat5.xy, u_xlat5.xy);
    u_xlat18.x = inversesqrt(u_xlat18.x);
    u_xlat27 = dot(u_xlat5.zw, u_xlat5.zw);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat7.x = u_xlat27 * u_xlat5.z;
    u_xlat7.yz = vec2(u_xlat27) * vec2(1.0, 0.0);
    u_xlat5.z = 0.0;
    u_xlat5.xyz = u_xlat18.xxx * u_xlat5.xyz;
    u_xlat8.xyz = u_xlat5.xyz * u_xlat7.xyz;
    u_xlat5.xyz = u_xlat7.zxy * u_xlat5.yzx + (-u_xlat8.xyz);
    u_xlat0.x = u_xlat0.x * 0.5 + u_xlat9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat18.x = (-_BumpFace) + _BumpOutline;
    u_xlat18.x = u_xlat0.x * u_xlat18.x + _BumpFace;
    u_xlat5.xyz = (-u_xlat16_6.xyz) * u_xlat18.xxx + u_xlat5.xyz;
    u_xlat18.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18.x = inversesqrt(u_xlat18.x);
    u_xlat5.xyz = u_xlat18.xxx * u_xlat5.xyz;
    u_xlat18.x = dot(vs_TEXCOORD3.xyz, (-u_xlat5.xyz));
    u_xlat18.x = u_xlat18.x + u_xlat18.x;
    u_xlat7.xyz = u_xlat5.xyz * u_xlat18.xxx + vs_TEXCOORD3.xyz;
    u_xlat10_7.xyz = texture(_Cube, u_xlat7.xyz).xyz;
    u_xlat16_8.xyz = (-_ReflectFaceColor.xyz) + _ReflectOutlineColor.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_8.xyz + _ReflectFaceColor.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat10_7.xyz;
    u_xlat0.xzw = u_xlat16_3.www * u_xlat0.xzw;
    u_xlat7.x = sin(_LightAngle);
    u_xlat8.x = cos(_LightAngle);
    u_xlat7.y = u_xlat8.x;
    u_xlat7.z = -1.0;
    u_xlat32 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat32 = inversesqrt(u_xlat32);
    u_xlat7.xyz = vec3(u_xlat32) * u_xlat7.xyz;
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat14 = u_xlat5.z * u_xlat5.z;
    u_xlat23 = max(u_xlat5.x, 0.0);
    u_xlat5.x = (-u_xlat5.x) * _Diffuse + 1.0;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Reflectivity;
    u_xlat23 = exp2(u_xlat23);
    u_xlat7.xyz = vec3(u_xlat23) * _SpecularColor.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecularPower, _SpecularPower, _SpecularPower));
    u_xlat7.xyz = u_xlat7.xyz * u_xlat16_3.www + u_xlat16_3.xyz;
    u_xlat5.xzw = u_xlat5.xxx * u_xlat7.xyz;
    u_xlat7.x = (-_Ambient) + 1.0;
    u_xlat14 = u_xlat14 * u_xlat7.x + _Ambient;
    u_xlat0.xzw = u_xlat5.xzw * vec3(u_xlat14) + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat2.xyz * vec3(u_xlat16_1) + u_xlat0.xzw;
    u_xlat5.x = _GlowOffset * _ScaleRatioB;
    u_xlat5.x = u_xlat5.x * vs_TEXCOORD1.y;
    u_xlat9.x = (-u_xlat5.x) * 0.5 + u_xlat9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat9.x>=0.0);
#else
    u_xlatb5 = u_xlat9.x>=0.0;
#endif
    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat14 = _GlowOuter * _ScaleRatioB + (-_GlowInner);
    u_xlat5.x = u_xlat5.x * u_xlat14 + _GlowInner;
    u_xlat5.x = u_xlat5.x * vs_TEXCOORD1.y;
    u_xlat14 = u_xlat5.x * 0.5 + 1.0;
    u_xlat5.x = u_xlat5.x * 0.5;
    u_xlat5.x = min(u_xlat5.x, 1.0);
    u_xlat5.x = sqrt(u_xlat5.x);
    u_xlat9.x = u_xlat9.x / u_xlat14;
    u_xlat9.x = min(abs(u_xlat9.x), 1.0);
    u_xlat9.x = log2(u_xlat9.x);
    u_xlat9.x = u_xlat9.x * _GlowPower;
    u_xlat9.x = exp2(u_xlat9.x);
    u_xlat9.x = (-u_xlat9.x) + 1.0;
    u_xlat9.x = u_xlat5.x * u_xlat9.x;
    u_xlat9.x = dot(_GlowColor.ww, u_xlat9.xx);
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = _GlowColor.xyz * u_xlat9.xxx + u_xlat0.xzw;
    u_xlat16_0 = vec4(u_xlat16_10) * u_xlat4;
    SV_Target0 = u_xlat16_0 * vs_COLOR0.wwww;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNITY_UI_ALPHACLIP" "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _FaceDilate;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineWidth;
uniform 	vec4 hlslcc_mtx4x4_EnvMatrix[4];
uniform 	mediump vec4 _UnderlayColor;
uniform 	float _UnderlayOffsetX;
uniform 	float _UnderlayOffsetY;
uniform 	float _UnderlayDilate;
uniform 	float _UnderlaySoftness;
uniform 	float _GlowOffset;
uniform 	float _GlowOuter;
uniform 	float _WeightNormal;
uniform 	float _WeightBold;
uniform 	float _ScaleRatioA;
uniform 	float _ScaleRatioB;
uniform 	float _ScaleRatioC;
uniform 	float _VertexOffsetX;
uniform 	float _VertexOffsetY;
uniform 	vec4 _ClipRect;
uniform 	float _MaskSoftnessX;
uniform 	float _MaskSoftnessY;
uniform 	float _TextureWidth;
uniform 	float _TextureHeight;
uniform 	float _GradientScale;
uniform 	float _ScaleX;
uniform 	float _ScaleY;
uniform 	float _PerspectiveFilter;
uniform 	vec4 _FaceTex_ST;
uniform 	vec4 _OutlineTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat4;
vec3 u_xlat6;
vec2 u_xlat8;
float u_xlat12;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat0.xy = vec2(in_POSITION0.x + float(_VertexOffsetX), in_POSITION0.y + float(_VertexOffsetY));
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat8.x = (-_OutlineWidth) * _ScaleRatioA + 1.0;
    u_xlat8.x = (-_OutlineSoftness) * _ScaleRatioA + u_xlat8.x;
    u_xlat12 = (-_GlowOffset) * _ScaleRatioB + 1.0;
    u_xlat12 = (-_GlowOuter) * _ScaleRatioB + u_xlat12;
    u_xlat8.x = min(u_xlat12, u_xlat8.x);
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat2.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat2.xy;
    u_xlat2.xy = vec2(abs(u_xlat2.x) * float(_ScaleX), abs(u_xlat2.y) * float(_ScaleY));
    u_xlat2.xy = u_xlat2.ww / u_xlat2.xy;
    u_xlat13 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat2.xy;
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat2.xy;
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.x = abs(in_TEXCOORD1.y) * _GradientScale;
    u_xlat13 = u_xlat13 * u_xlat2.x;
    u_xlat2.x = u_xlat13 * 1.5;
    u_xlat6.x = (-_PerspectiveFilter) + 1.0;
    u_xlat6.x = u_xlat6.x * abs(u_xlat2.x);
    u_xlat13 = u_xlat13 * 1.5 + (-u_xlat6.x);
    u_xlat12 = abs(u_xlat12) * u_xlat13 + u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0);
#else
    u_xlatb13 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
#endif
    u_xlat6.x = (u_xlatb13) ? u_xlat12 : u_xlat2.x;
    u_xlat12 = 0.5 / u_xlat6.x;
    u_xlat8.x = u_xlat8.x * 0.5 + (-u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.0>=in_TEXCOORD1.y);
#else
    u_xlatb13 = 0.0>=in_TEXCOORD1.y;
#endif
    u_xlat13 = u_xlatb13 ? 1.0 : float(0.0);
    u_xlat2.x = (-_WeightNormal) + _WeightBold;
    u_xlat13 = u_xlat13 * u_xlat2.x + _WeightNormal;
    u_xlat13 = u_xlat13 * 0.25 + _FaceDilate;
    u_xlat13 = u_xlat13 * _ScaleRatioA;
    vs_TEXCOORD1.x = (-u_xlat13) * 0.5 + u_xlat8.x;
    u_xlat6.z = u_xlat13 * 0.5;
    u_xlat8.x = (-u_xlat13) * 0.5 + 0.5;
    vs_TEXCOORD1.yw = u_xlat6.xz;
    vs_TEXCOORD1.z = u_xlat12 + u_xlat8.x;
    u_xlat3 = max(_ClipRect, vec4(-2e+010, -2e+010, -2e+010, -2e+010));
    u_xlat3 = min(u_xlat3, vec4(2e+010, 2e+010, 2e+010, 2e+010));
    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat3.xy);
    vs_TEXCOORD2.xy = vec2((-u_xlat3.z) + u_xlat0.x, (-u_xlat3.w) + u_xlat0.y);
    u_xlat0.xyw = u_xlat1.yyy * hlslcc_mtx4x4_EnvMatrix[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_EnvMatrix[0].xyz * u_xlat1.xxx + u_xlat0.xyw;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4_EnvMatrix[2].xyz * u_xlat1.zzz + u_xlat0.xyw;
    u_xlat1 = vec4(_UnderlaySoftness, _UnderlayDilate, _UnderlayOffsetX, _UnderlayOffsetY) * vec4(vec4(_ScaleRatioC, _ScaleRatioC, _ScaleRatioC, _ScaleRatioC));
    u_xlat0.x = u_xlat1.x * u_xlat6.x + 1.0;
    u_xlat0.x = u_xlat6.x / u_xlat0.x;
    u_xlat4 = u_xlat8.x * u_xlat0.x + -0.5;
    u_xlat8.x = u_xlat0.x * u_xlat1.y;
    u_xlat1.xy = vec2((-u_xlat1.z) * _GradientScale, (-u_xlat1.w) * _GradientScale);
    u_xlat1.xy = vec2(u_xlat1.x / float(_TextureWidth), u_xlat1.y / float(_TextureHeight));
    vs_TEXCOORD4.xy = u_xlat1.xy + in_TEXCOORD0.xy;
    vs_TEXCOORD4.z = u_xlat0.x;
    vs_TEXCOORD4.w = (-u_xlat8.x) * 0.5 + u_xlat4;
    u_xlat0.xyz = _UnderlayColor.www * _UnderlayColor.xyz;
    vs_COLOR1.xyz = u_xlat0.xyz;
    vs_COLOR1.w = _UnderlayColor.w;
    u_xlat0.x = in_TEXCOORD1.x * 0.000244140625;
    u_xlat8.x = floor(u_xlat0.x);
    u_xlat8.y = (-u_xlat8.x) * 4096.0 + in_TEXCOORD1.x;
    u_xlat0.xy = u_xlat8.xy * vec2(0.001953125, 0.001953125);
    vs_TEXCOORD5.xy = u_xlat0.xy * _FaceTex_ST.xy + _FaceTex_ST.zw;
    vs_TEXCOORD5.zw = u_xlat0.xy * _OutlineTex_ST.xy + _OutlineTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _FaceUVSpeedX;
uniform 	float _FaceUVSpeedY;
uniform 	mediump vec4 _FaceColor;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineUVSpeedX;
uniform 	float _OutlineUVSpeedY;
uniform 	mediump vec4 _OutlineColor;
uniform 	float _OutlineWidth;
uniform 	float _Bevel;
uniform 	float _BevelOffset;
uniform 	float _BevelWidth;
uniform 	float _BevelClamp;
uniform 	float _BevelRoundness;
uniform 	float _BumpOutline;
uniform 	float _BumpFace;
uniform 	mediump vec4 _ReflectFaceColor;
uniform 	mediump vec4 _ReflectOutlineColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	float _LightAngle;
uniform 	float _SpecularPower;
uniform 	float _Reflectivity;
uniform 	float _Diffuse;
uniform 	float _Ambient;
uniform 	mediump vec4 _GlowColor;
uniform 	float _GlowOffset;
uniform 	float _GlowOuter;
uniform 	float _GlowInner;
uniform 	float _GlowPower;
uniform 	float _ShaderFlags;
uniform 	float _ScaleRatioA;
uniform 	float _ScaleRatioB;
uniform 	vec4 _ClipRect;
uniform 	float _TextureWidth;
uniform 	float _TextureHeight;
uniform 	float _GradientScale;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FaceTex;
uniform lowp sampler2D _OutlineTex;
uniform lowp sampler2D _BumpMap;
uniform lowp samplerCube _Cube;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec4 u_xlat16_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
lowp vec4 u_xlat10_5;
bool u_xlatb5;
mediump vec3 u_xlat16_6;
vec4 u_xlat7;
lowp vec3 u_xlat10_7;
vec4 u_xlat8;
mediump vec3 u_xlat16_8;
bool u_xlatb8;
vec3 u_xlat9;
lowp float u_xlat10_9;
mediump float u_xlat16_10;
float u_xlat14;
vec2 u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
bool u_xlatb18;
mediump float u_xlat16_19;
float u_xlat23;
float u_xlat27;
bool u_xlatb27;
float u_xlat32;
void main()
{
    u_xlat0.x = _OutlineWidth * _ScaleRatioA;
    u_xlat0.x = u_xlat0.x * vs_TEXCOORD1.y;
    u_xlat16_1 = min(u_xlat0.x, 1.0);
    u_xlat16_1 = sqrt(u_xlat16_1);
    u_xlat16_10 = u_xlat0.x * 0.5;
    u_xlat10_9 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat9.x = (-u_xlat10_9) + vs_TEXCOORD1.z;
    u_xlat16_19 = u_xlat9.x * vs_TEXCOORD1.y + u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat9.x * vs_TEXCOORD1.y + (-u_xlat16_10);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_19;
    u_xlat18.xy = vec2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy + vs_TEXCOORD5.zw;
    u_xlat10_2 = texture(_OutlineTex, u_xlat18.xy);
    u_xlat16_3 = u_xlat10_2 * _OutlineColor;
    u_xlat16_4.xyz = vs_COLOR0.xyz * _FaceColor.xyz;
    u_xlat18.xy = vec2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy + vs_TEXCOORD5.xy;
    u_xlat10_5 = texture(_FaceTex, u_xlat18.xy);
    u_xlat10_2.xyz = texture(_BumpMap, u_xlat18.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat10_5.xyz;
    u_xlat16_18 = u_xlat10_5.w * _FaceColor.w;
    u_xlat16_4.xyz = vec3(u_xlat16_18) * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_3.www + (-u_xlat16_4.xyz);
    u_xlat16_3.w = _OutlineColor.w * u_xlat10_2.w + (-u_xlat16_18);
    u_xlat16_3 = vec4(u_xlat16_1) * u_xlat16_3;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_18) + u_xlat16_3.xyz;
    u_xlat16_2.w = _FaceColor.w * u_xlat10_5.w + u_xlat16_3.w;
    u_xlat9.y = _OutlineSoftness * _ScaleRatioA;
    u_xlat9.xz = u_xlat9.xy * vs_TEXCOORD1.yy;
    u_xlat16_1 = u_xlat9.y * vs_TEXCOORD1.y + 1.0;
    u_xlat16_10 = u_xlat9.z * 0.5 + u_xlat16_10;
    u_xlat16_1 = u_xlat16_10 / u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_3 = vec4(u_xlat16_1) * u_xlat16_2;
    u_xlat16_1 = (-u_xlat16_2.w) * u_xlat16_1 + 1.0;
    u_xlat10_18 = texture(_MainTex, vs_TEXCOORD4.xy).w;
    u_xlat18.x = u_xlat10_18 * vs_TEXCOORD4.z + (-vs_TEXCOORD4.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat18.x = min(max(u_xlat18.x, 0.0), 1.0);
#else
    u_xlat18.x = clamp(u_xlat18.x, 0.0, 1.0);
#endif
    u_xlat2 = u_xlat18.xxxx * vs_COLOR1;
    u_xlat4.w = u_xlat2.w * u_xlat16_1 + u_xlat16_3.w;
    u_xlat18.xy = vec2((-_ClipRect.x) + _ClipRect.z, (-_ClipRect.y) + _ClipRect.w);
    u_xlat18.xy = u_xlat18.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat18.xy = vec2(u_xlat18.x * vs_TEXCOORD2.z, u_xlat18.y * vs_TEXCOORD2.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat18.xy = min(max(u_xlat18.xy, 0.0), 1.0);
#else
    u_xlat18.xy = clamp(u_xlat18.xy, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat18.y * u_xlat18.x;
    u_xlat16_19 = u_xlat4.w * u_xlat16_10 + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat16_19<0.0);
#else
    u_xlatb18 = u_xlat16_19<0.0;
#endif
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat18.x = vs_TEXCOORD1.w + _BevelOffset;
    u_xlat5.xy = vec2(float(0.5) / float(_TextureWidth), float(0.5) / float(_TextureHeight));
    u_xlat5.z = 0.0;
    u_xlat7 = (-u_xlat5.xzzy) + vs_TEXCOORD0.xyxy;
    u_xlat5 = u_xlat5.xzzy + vs_TEXCOORD0.xyxy;
    u_xlat8.x = texture(_MainTex, u_xlat7.xy).w;
    u_xlat8.z = texture(_MainTex, u_xlat7.zw).w;
    u_xlat8.y = texture(_MainTex, u_xlat5.xy).w;
    u_xlat8.w = texture(_MainTex, u_xlat5.zw).w;
    u_xlat5 = u_xlat18.xxxx + u_xlat8;
    u_xlat5 = u_xlat5 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat18.x = _BevelWidth + _OutlineWidth;
    u_xlat18.x = max(u_xlat18.x, 0.00999999978);
    u_xlat5 = u_xlat5 / u_xlat18.xxxx;
    u_xlat18.x = u_xlat18.x * _Bevel;
    u_xlat18.x = u_xlat18.x * _GradientScale;
    u_xlat18.x = u_xlat18.x * -2.0;
    u_xlat5 = u_xlat5 + vec4(0.5, 0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat7 = u_xlat5 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat7 = -abs(u_xlat7) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat27 = _ShaderFlags * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat27>=(-u_xlat27));
#else
    u_xlatb8 = u_xlat27>=(-u_xlat27);
#endif
    u_xlat27 = fract(abs(u_xlat27));
    u_xlat27 = (u_xlatb8) ? u_xlat27 : (-u_xlat27);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat27>=0.5);
#else
    u_xlatb27 = u_xlat27>=0.5;
#endif
    u_xlat5 = (bool(u_xlatb27)) ? u_xlat7 : u_xlat5;
    u_xlat7 = u_xlat5 * vec4(1.57079601, 1.57079601, 1.57079601, 1.57079601);
    u_xlat7 = sin(u_xlat7);
    u_xlat7 = (-u_xlat5) + u_xlat7;
    u_xlat5 = vec4(vec4(_BevelRoundness, _BevelRoundness, _BevelRoundness, _BevelRoundness)) * u_xlat7 + u_xlat5;
    u_xlat27 = (-_BevelClamp) + 1.0;
    u_xlat5 = min(vec4(u_xlat27), u_xlat5);
    u_xlat5.xz = u_xlat18.xx * u_xlat5.xz;
    u_xlat5.yz = u_xlat5.wy * u_xlat18.xx + (-u_xlat5.zx);
    u_xlat5.x = float(-1.0);
    u_xlat5.w = float(1.0);
    u_xlat18.x = dot(u_xlat5.xy, u_xlat5.xy);
    u_xlat18.x = inversesqrt(u_xlat18.x);
    u_xlat27 = dot(u_xlat5.zw, u_xlat5.zw);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat7.x = u_xlat27 * u_xlat5.z;
    u_xlat7.yz = vec2(u_xlat27) * vec2(1.0, 0.0);
    u_xlat5.z = 0.0;
    u_xlat5.xyz = u_xlat18.xxx * u_xlat5.xyz;
    u_xlat8.xyz = u_xlat5.xyz * u_xlat7.xyz;
    u_xlat5.xyz = u_xlat7.zxy * u_xlat5.yzx + (-u_xlat8.xyz);
    u_xlat0.x = u_xlat0.x * 0.5 + u_xlat9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat18.x = (-_BumpFace) + _BumpOutline;
    u_xlat18.x = u_xlat0.x * u_xlat18.x + _BumpFace;
    u_xlat5.xyz = (-u_xlat16_6.xyz) * u_xlat18.xxx + u_xlat5.xyz;
    u_xlat18.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18.x = inversesqrt(u_xlat18.x);
    u_xlat5.xyz = u_xlat18.xxx * u_xlat5.xyz;
    u_xlat18.x = dot(vs_TEXCOORD3.xyz, (-u_xlat5.xyz));
    u_xlat18.x = u_xlat18.x + u_xlat18.x;
    u_xlat7.xyz = u_xlat5.xyz * u_xlat18.xxx + vs_TEXCOORD3.xyz;
    u_xlat10_7.xyz = texture(_Cube, u_xlat7.xyz).xyz;
    u_xlat16_8.xyz = (-_ReflectFaceColor.xyz) + _ReflectOutlineColor.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_8.xyz + _ReflectFaceColor.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat10_7.xyz;
    u_xlat0.xzw = u_xlat16_3.www * u_xlat0.xzw;
    u_xlat7.x = sin(_LightAngle);
    u_xlat8.x = cos(_LightAngle);
    u_xlat7.y = u_xlat8.x;
    u_xlat7.z = -1.0;
    u_xlat32 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat32 = inversesqrt(u_xlat32);
    u_xlat7.xyz = vec3(u_xlat32) * u_xlat7.xyz;
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat14 = u_xlat5.z * u_xlat5.z;
    u_xlat23 = max(u_xlat5.x, 0.0);
    u_xlat5.x = (-u_xlat5.x) * _Diffuse + 1.0;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Reflectivity;
    u_xlat23 = exp2(u_xlat23);
    u_xlat7.xyz = vec3(u_xlat23) * _SpecularColor.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecularPower, _SpecularPower, _SpecularPower));
    u_xlat7.xyz = u_xlat7.xyz * u_xlat16_3.www + u_xlat16_3.xyz;
    u_xlat5.xzw = u_xlat5.xxx * u_xlat7.xyz;
    u_xlat7.x = (-_Ambient) + 1.0;
    u_xlat14 = u_xlat14 * u_xlat7.x + _Ambient;
    u_xlat0.xzw = u_xlat5.xzw * vec3(u_xlat14) + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat2.xyz * vec3(u_xlat16_1) + u_xlat0.xzw;
    u_xlat5.x = _GlowOffset * _ScaleRatioB;
    u_xlat5.x = u_xlat5.x * vs_TEXCOORD1.y;
    u_xlat9.x = (-u_xlat5.x) * 0.5 + u_xlat9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat9.x>=0.0);
#else
    u_xlatb5 = u_xlat9.x>=0.0;
#endif
    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat14 = _GlowOuter * _ScaleRatioB + (-_GlowInner);
    u_xlat5.x = u_xlat5.x * u_xlat14 + _GlowInner;
    u_xlat5.x = u_xlat5.x * vs_TEXCOORD1.y;
    u_xlat14 = u_xlat5.x * 0.5 + 1.0;
    u_xlat5.x = u_xlat5.x * 0.5;
    u_xlat5.x = min(u_xlat5.x, 1.0);
    u_xlat5.x = sqrt(u_xlat5.x);
    u_xlat9.x = u_xlat9.x / u_xlat14;
    u_xlat9.x = min(abs(u_xlat9.x), 1.0);
    u_xlat9.x = log2(u_xlat9.x);
    u_xlat9.x = u_xlat9.x * _GlowPower;
    u_xlat9.x = exp2(u_xlat9.x);
    u_xlat9.x = (-u_xlat9.x) + 1.0;
    u_xlat9.x = u_xlat5.x * u_xlat9.x;
    u_xlat9.x = dot(_GlowColor.ww, u_xlat9.xx);
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = _GlowColor.xyz * u_xlat9.xxx + u_xlat0.xzw;
    u_xlat16_0 = vec4(u_xlat16_10) * u_xlat4;
    SV_Target0 = u_xlat16_0 * vs_COLOR0.wwww;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNITY_UI_ALPHACLIP" "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
"#ifdef VERTEX
#version 300 es

uniform 	vec3 _WorldSpaceCameraPos;
uniform 	vec4 _ScreenParams;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4glstate_matrix_projection[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	float _FaceDilate;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineWidth;
uniform 	vec4 hlslcc_mtx4x4_EnvMatrix[4];
uniform 	mediump vec4 _UnderlayColor;
uniform 	float _UnderlayOffsetX;
uniform 	float _UnderlayOffsetY;
uniform 	float _UnderlayDilate;
uniform 	float _UnderlaySoftness;
uniform 	float _GlowOffset;
uniform 	float _GlowOuter;
uniform 	float _WeightNormal;
uniform 	float _WeightBold;
uniform 	float _ScaleRatioA;
uniform 	float _ScaleRatioB;
uniform 	float _ScaleRatioC;
uniform 	float _VertexOffsetX;
uniform 	float _VertexOffsetY;
uniform 	vec4 _ClipRect;
uniform 	float _MaskSoftnessX;
uniform 	float _MaskSoftnessY;
uniform 	float _TextureWidth;
uniform 	float _TextureHeight;
uniform 	float _GradientScale;
uniform 	float _ScaleX;
uniform 	float _ScaleY;
uniform 	float _PerspectiveFilter;
uniform 	vec4 _FaceTex_ST;
uniform 	vec4 _OutlineTex_ST;
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
in mediump vec4 in_COLOR0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
out mediump vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec3 vs_TEXCOORD3;
out highp vec4 vs_TEXCOORD4;
out mediump vec4 vs_COLOR1;
out highp vec4 vs_TEXCOORD5;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
vec4 u_xlat3;
float u_xlat4;
vec3 u_xlat6;
vec2 u_xlat8;
float u_xlat12;
float u_xlat13;
bool u_xlatb13;
void main()
{
    u_xlat0.xy = vec2(in_POSITION0.x + float(_VertexOffsetX), in_POSITION0.y + float(_VertexOffsetY));
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat2 = u_xlat1 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
    u_xlat3 = u_xlat2.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
    u_xlat3 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
    gl_Position = u_xlat2;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    u_xlat8.x = (-_OutlineWidth) * _ScaleRatioA + 1.0;
    u_xlat8.x = (-_OutlineSoftness) * _ScaleRatioA + u_xlat8.x;
    u_xlat12 = (-_GlowOffset) * _ScaleRatioB + 1.0;
    u_xlat12 = (-_GlowOuter) * _ScaleRatioB + u_xlat12;
    u_xlat8.x = min(u_xlat12, u_xlat8.x);
    u_xlat2.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat2.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat2.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat12 = inversesqrt(u_xlat12);
    u_xlat3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
    u_xlat12 = dot(u_xlat2.xyz, u_xlat3.xyz);
    u_xlat2.xy = _ScreenParams.yy * hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat2.xy = hlslcc_mtx4x4glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat2.xy;
    u_xlat2.xy = vec2(abs(u_xlat2.x) * float(_ScaleX), abs(u_xlat2.y) * float(_ScaleY));
    u_xlat2.xy = u_xlat2.ww / u_xlat2.xy;
    u_xlat13 = dot(u_xlat2.xy, u_xlat2.xy);
    u_xlat2.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat2.xy;
    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat2.xy;
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat2.x = abs(in_TEXCOORD1.y) * _GradientScale;
    u_xlat13 = u_xlat13 * u_xlat2.x;
    u_xlat2.x = u_xlat13 * 1.5;
    u_xlat6.x = (-_PerspectiveFilter) + 1.0;
    u_xlat6.x = u_xlat6.x * abs(u_xlat2.x);
    u_xlat13 = u_xlat13 * 1.5 + (-u_xlat6.x);
    u_xlat12 = abs(u_xlat12) * u_xlat13 + u_xlat6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0);
#else
    u_xlatb13 = hlslcc_mtx4x4glstate_matrix_projection[3].w==0.0;
#endif
    u_xlat6.x = (u_xlatb13) ? u_xlat12 : u_xlat2.x;
    u_xlat12 = 0.5 / u_xlat6.x;
    u_xlat8.x = u_xlat8.x * 0.5 + (-u_xlat12);
#ifdef UNITY_ADRENO_ES3
    u_xlatb13 = !!(0.0>=in_TEXCOORD1.y);
#else
    u_xlatb13 = 0.0>=in_TEXCOORD1.y;
#endif
    u_xlat13 = u_xlatb13 ? 1.0 : float(0.0);
    u_xlat2.x = (-_WeightNormal) + _WeightBold;
    u_xlat13 = u_xlat13 * u_xlat2.x + _WeightNormal;
    u_xlat13 = u_xlat13 * 0.25 + _FaceDilate;
    u_xlat13 = u_xlat13 * _ScaleRatioA;
    vs_TEXCOORD1.x = (-u_xlat13) * 0.5 + u_xlat8.x;
    u_xlat6.z = u_xlat13 * 0.5;
    u_xlat8.x = (-u_xlat13) * 0.5 + 0.5;
    vs_TEXCOORD1.yw = u_xlat6.xz;
    vs_TEXCOORD1.z = u_xlat12 + u_xlat8.x;
    u_xlat3 = max(_ClipRect, vec4(-2e+010, -2e+010, -2e+010, -2e+010));
    u_xlat3 = min(u_xlat3, vec4(2e+010, 2e+010, 2e+010, 2e+010));
    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat3.xy);
    vs_TEXCOORD2.xy = vec2((-u_xlat3.z) + u_xlat0.x, (-u_xlat3.w) + u_xlat0.y);
    u_xlat0.xyw = u_xlat1.yyy * hlslcc_mtx4x4_EnvMatrix[1].xyz;
    u_xlat0.xyw = hlslcc_mtx4x4_EnvMatrix[0].xyz * u_xlat1.xxx + u_xlat0.xyw;
    vs_TEXCOORD3.xyz = hlslcc_mtx4x4_EnvMatrix[2].xyz * u_xlat1.zzz + u_xlat0.xyw;
    u_xlat1 = vec4(_UnderlaySoftness, _UnderlayDilate, _UnderlayOffsetX, _UnderlayOffsetY) * vec4(vec4(_ScaleRatioC, _ScaleRatioC, _ScaleRatioC, _ScaleRatioC));
    u_xlat0.x = u_xlat1.x * u_xlat6.x + 1.0;
    u_xlat0.x = u_xlat6.x / u_xlat0.x;
    u_xlat4 = u_xlat8.x * u_xlat0.x + -0.5;
    u_xlat8.x = u_xlat0.x * u_xlat1.y;
    u_xlat1.xy = vec2((-u_xlat1.z) * _GradientScale, (-u_xlat1.w) * _GradientScale);
    u_xlat1.xy = vec2(u_xlat1.x / float(_TextureWidth), u_xlat1.y / float(_TextureHeight));
    vs_TEXCOORD4.xy = u_xlat1.xy + in_TEXCOORD0.xy;
    vs_TEXCOORD4.z = u_xlat0.x;
    vs_TEXCOORD4.w = (-u_xlat8.x) * 0.5 + u_xlat4;
    u_xlat0.xyz = _UnderlayColor.www * _UnderlayColor.xyz;
    vs_COLOR1.xyz = u_xlat0.xyz;
    vs_COLOR1.w = _UnderlayColor.w;
    u_xlat0.x = in_TEXCOORD1.x * 0.000244140625;
    u_xlat8.x = floor(u_xlat0.x);
    u_xlat8.y = (-u_xlat8.x) * 4096.0 + in_TEXCOORD1.x;
    u_xlat0.xy = u_xlat8.xy * vec2(0.001953125, 0.001953125);
    vs_TEXCOORD5.xy = u_xlat0.xy * _FaceTex_ST.xy + _FaceTex_ST.zw;
    vs_TEXCOORD5.zw = u_xlat0.xy * _OutlineTex_ST.xy + _OutlineTex_ST.zw;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
uniform 	vec4 _Time;
uniform 	float _FaceUVSpeedX;
uniform 	float _FaceUVSpeedY;
uniform 	mediump vec4 _FaceColor;
uniform 	float _OutlineSoftness;
uniform 	float _OutlineUVSpeedX;
uniform 	float _OutlineUVSpeedY;
uniform 	mediump vec4 _OutlineColor;
uniform 	float _OutlineWidth;
uniform 	float _Bevel;
uniform 	float _BevelOffset;
uniform 	float _BevelWidth;
uniform 	float _BevelClamp;
uniform 	float _BevelRoundness;
uniform 	float _BumpOutline;
uniform 	float _BumpFace;
uniform 	mediump vec4 _ReflectFaceColor;
uniform 	mediump vec4 _ReflectOutlineColor;
uniform 	mediump vec4 _SpecularColor;
uniform 	float _LightAngle;
uniform 	float _SpecularPower;
uniform 	float _Reflectivity;
uniform 	float _Diffuse;
uniform 	float _Ambient;
uniform 	mediump vec4 _GlowColor;
uniform 	float _GlowOffset;
uniform 	float _GlowOuter;
uniform 	float _GlowInner;
uniform 	float _GlowPower;
uniform 	float _ShaderFlags;
uniform 	float _ScaleRatioA;
uniform 	float _ScaleRatioB;
uniform 	vec4 _ClipRect;
uniform 	float _TextureWidth;
uniform 	float _TextureHeight;
uniform 	float _GradientScale;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _FaceTex;
uniform lowp sampler2D _OutlineTex;
uniform lowp sampler2D _BumpMap;
uniform lowp samplerCube _Cube;
in mediump vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD1;
in highp vec4 vs_TEXCOORD2;
in highp vec3 vs_TEXCOORD3;
in highp vec4 vs_TEXCOORD4;
in mediump vec4 vs_COLOR1;
in highp vec4 vs_TEXCOORD5;
layout(location = 0) out mediump vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
mediump float u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
lowp vec4 u_xlat10_2;
mediump vec4 u_xlat16_3;
vec4 u_xlat4;
mediump vec3 u_xlat16_4;
vec4 u_xlat5;
lowp vec4 u_xlat10_5;
bool u_xlatb5;
mediump vec3 u_xlat16_6;
vec4 u_xlat7;
lowp vec3 u_xlat10_7;
vec4 u_xlat8;
mediump vec3 u_xlat16_8;
bool u_xlatb8;
vec3 u_xlat9;
lowp float u_xlat10_9;
mediump float u_xlat16_10;
float u_xlat14;
vec2 u_xlat18;
mediump float u_xlat16_18;
lowp float u_xlat10_18;
bool u_xlatb18;
mediump float u_xlat16_19;
float u_xlat23;
float u_xlat27;
bool u_xlatb27;
float u_xlat32;
void main()
{
    u_xlat0.x = _OutlineWidth * _ScaleRatioA;
    u_xlat0.x = u_xlat0.x * vs_TEXCOORD1.y;
    u_xlat16_1 = min(u_xlat0.x, 1.0);
    u_xlat16_1 = sqrt(u_xlat16_1);
    u_xlat16_10 = u_xlat0.x * 0.5;
    u_xlat10_9 = texture(_MainTex, vs_TEXCOORD0.xy).w;
    u_xlat9.x = (-u_xlat10_9) + vs_TEXCOORD1.z;
    u_xlat16_19 = u_xlat9.x * vs_TEXCOORD1.y + u_xlat16_10;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_19 = min(max(u_xlat16_19, 0.0), 1.0);
#else
    u_xlat16_19 = clamp(u_xlat16_19, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat9.x * vs_TEXCOORD1.y + (-u_xlat16_10);
    u_xlat16_1 = u_xlat16_1 * u_xlat16_19;
    u_xlat18.xy = vec2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy + vs_TEXCOORD5.zw;
    u_xlat10_2 = texture(_OutlineTex, u_xlat18.xy);
    u_xlat16_3 = u_xlat10_2 * _OutlineColor;
    u_xlat16_4.xyz = vs_COLOR0.xyz * _FaceColor.xyz;
    u_xlat18.xy = vec2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy + vs_TEXCOORD5.xy;
    u_xlat10_5 = texture(_FaceTex, u_xlat18.xy);
    u_xlat10_2.xyz = texture(_BumpMap, u_xlat18.xy).xyz;
    u_xlat16_6.xyz = u_xlat10_2.xyz * vec3(2.0, 2.0, 2.0) + vec3(-1.0, -1.0, -1.0);
    u_xlat16_2.xyz = u_xlat16_4.xyz * u_xlat10_5.xyz;
    u_xlat16_18 = u_xlat10_5.w * _FaceColor.w;
    u_xlat16_4.xyz = vec3(u_xlat16_18) * u_xlat16_2.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz * u_xlat16_3.www + (-u_xlat16_4.xyz);
    u_xlat16_3.w = _OutlineColor.w * u_xlat10_2.w + (-u_xlat16_18);
    u_xlat16_3 = vec4(u_xlat16_1) * u_xlat16_3;
    u_xlat16_2.xyz = u_xlat16_2.xyz * vec3(u_xlat16_18) + u_xlat16_3.xyz;
    u_xlat16_2.w = _FaceColor.w * u_xlat10_5.w + u_xlat16_3.w;
    u_xlat9.y = _OutlineSoftness * _ScaleRatioA;
    u_xlat9.xz = u_xlat9.xy * vs_TEXCOORD1.yy;
    u_xlat16_1 = u_xlat9.y * vs_TEXCOORD1.y + 1.0;
    u_xlat16_10 = u_xlat9.z * 0.5 + u_xlat16_10;
    u_xlat16_1 = u_xlat16_10 / u_xlat16_1;
#ifdef UNITY_ADRENO_ES3
    u_xlat16_1 = min(max(u_xlat16_1, 0.0), 1.0);
#else
    u_xlat16_1 = clamp(u_xlat16_1, 0.0, 1.0);
#endif
    u_xlat16_1 = (-u_xlat16_1) + 1.0;
    u_xlat16_3 = vec4(u_xlat16_1) * u_xlat16_2;
    u_xlat16_1 = (-u_xlat16_2.w) * u_xlat16_1 + 1.0;
    u_xlat10_18 = texture(_MainTex, vs_TEXCOORD4.xy).w;
    u_xlat18.x = u_xlat10_18 * vs_TEXCOORD4.z + (-vs_TEXCOORD4.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat18.x = min(max(u_xlat18.x, 0.0), 1.0);
#else
    u_xlat18.x = clamp(u_xlat18.x, 0.0, 1.0);
#endif
    u_xlat2 = u_xlat18.xxxx * vs_COLOR1;
    u_xlat4.w = u_xlat2.w * u_xlat16_1 + u_xlat16_3.w;
    u_xlat18.xy = vec2((-_ClipRect.x) + _ClipRect.z, (-_ClipRect.y) + _ClipRect.w);
    u_xlat18.xy = u_xlat18.xy + -abs(vs_TEXCOORD2.xy);
    u_xlat18.xy = vec2(u_xlat18.x * vs_TEXCOORD2.z, u_xlat18.y * vs_TEXCOORD2.w);
#ifdef UNITY_ADRENO_ES3
    u_xlat18.xy = min(max(u_xlat18.xy, 0.0), 1.0);
#else
    u_xlat18.xy = clamp(u_xlat18.xy, 0.0, 1.0);
#endif
    u_xlat16_10 = u_xlat18.y * u_xlat18.x;
    u_xlat16_19 = u_xlat4.w * u_xlat16_10 + -0.00100000005;
#ifdef UNITY_ADRENO_ES3
    u_xlatb18 = !!(u_xlat16_19<0.0);
#else
    u_xlatb18 = u_xlat16_19<0.0;
#endif
    if((int(u_xlatb18) * int(0xffffffffu))!=0){discard;}
    u_xlat18.x = vs_TEXCOORD1.w + _BevelOffset;
    u_xlat5.xy = vec2(float(0.5) / float(_TextureWidth), float(0.5) / float(_TextureHeight));
    u_xlat5.z = 0.0;
    u_xlat7 = (-u_xlat5.xzzy) + vs_TEXCOORD0.xyxy;
    u_xlat5 = u_xlat5.xzzy + vs_TEXCOORD0.xyxy;
    u_xlat8.x = texture(_MainTex, u_xlat7.xy).w;
    u_xlat8.z = texture(_MainTex, u_xlat7.zw).w;
    u_xlat8.y = texture(_MainTex, u_xlat5.xy).w;
    u_xlat8.w = texture(_MainTex, u_xlat5.zw).w;
    u_xlat5 = u_xlat18.xxxx + u_xlat8;
    u_xlat5 = u_xlat5 + vec4(-0.5, -0.5, -0.5, -0.5);
    u_xlat18.x = _BevelWidth + _OutlineWidth;
    u_xlat18.x = max(u_xlat18.x, 0.00999999978);
    u_xlat5 = u_xlat5 / u_xlat18.xxxx;
    u_xlat18.x = u_xlat18.x * _Bevel;
    u_xlat18.x = u_xlat18.x * _GradientScale;
    u_xlat18.x = u_xlat18.x * -2.0;
    u_xlat5 = u_xlat5 + vec4(0.5, 0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat5 = min(max(u_xlat5, 0.0), 1.0);
#else
    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
#endif
    u_xlat7 = u_xlat5 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat7 = -abs(u_xlat7) + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat27 = _ShaderFlags * 0.5;
#ifdef UNITY_ADRENO_ES3
    u_xlatb8 = !!(u_xlat27>=(-u_xlat27));
#else
    u_xlatb8 = u_xlat27>=(-u_xlat27);
#endif
    u_xlat27 = fract(abs(u_xlat27));
    u_xlat27 = (u_xlatb8) ? u_xlat27 : (-u_xlat27);
#ifdef UNITY_ADRENO_ES3
    u_xlatb27 = !!(u_xlat27>=0.5);
#else
    u_xlatb27 = u_xlat27>=0.5;
#endif
    u_xlat5 = (bool(u_xlatb27)) ? u_xlat7 : u_xlat5;
    u_xlat7 = u_xlat5 * vec4(1.57079601, 1.57079601, 1.57079601, 1.57079601);
    u_xlat7 = sin(u_xlat7);
    u_xlat7 = (-u_xlat5) + u_xlat7;
    u_xlat5 = vec4(vec4(_BevelRoundness, _BevelRoundness, _BevelRoundness, _BevelRoundness)) * u_xlat7 + u_xlat5;
    u_xlat27 = (-_BevelClamp) + 1.0;
    u_xlat5 = min(vec4(u_xlat27), u_xlat5);
    u_xlat5.xz = u_xlat18.xx * u_xlat5.xz;
    u_xlat5.yz = u_xlat5.wy * u_xlat18.xx + (-u_xlat5.zx);
    u_xlat5.x = float(-1.0);
    u_xlat5.w = float(1.0);
    u_xlat18.x = dot(u_xlat5.xy, u_xlat5.xy);
    u_xlat18.x = inversesqrt(u_xlat18.x);
    u_xlat27 = dot(u_xlat5.zw, u_xlat5.zw);
    u_xlat27 = inversesqrt(u_xlat27);
    u_xlat7.x = u_xlat27 * u_xlat5.z;
    u_xlat7.yz = vec2(u_xlat27) * vec2(1.0, 0.0);
    u_xlat5.z = 0.0;
    u_xlat5.xyz = u_xlat18.xxx * u_xlat5.xyz;
    u_xlat8.xyz = u_xlat5.xyz * u_xlat7.xyz;
    u_xlat5.xyz = u_xlat7.zxy * u_xlat5.yzx + (-u_xlat8.xyz);
    u_xlat0.x = u_xlat0.x * 0.5 + u_xlat9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat18.x = (-_BumpFace) + _BumpOutline;
    u_xlat18.x = u_xlat0.x * u_xlat18.x + _BumpFace;
    u_xlat5.xyz = (-u_xlat16_6.xyz) * u_xlat18.xxx + u_xlat5.xyz;
    u_xlat18.x = dot(u_xlat5.xyz, u_xlat5.xyz);
    u_xlat18.x = inversesqrt(u_xlat18.x);
    u_xlat5.xyz = u_xlat18.xxx * u_xlat5.xyz;
    u_xlat18.x = dot(vs_TEXCOORD3.xyz, (-u_xlat5.xyz));
    u_xlat18.x = u_xlat18.x + u_xlat18.x;
    u_xlat7.xyz = u_xlat5.xyz * u_xlat18.xxx + vs_TEXCOORD3.xyz;
    u_xlat10_7.xyz = texture(_Cube, u_xlat7.xyz).xyz;
    u_xlat16_8.xyz = (-_ReflectFaceColor.xyz) + _ReflectOutlineColor.xyz;
    u_xlat0.xzw = u_xlat0.xxx * u_xlat16_8.xyz + _ReflectFaceColor.xyz;
    u_xlat0.xzw = u_xlat0.xzw * u_xlat10_7.xyz;
    u_xlat0.xzw = u_xlat16_3.www * u_xlat0.xzw;
    u_xlat7.x = sin(_LightAngle);
    u_xlat8.x = cos(_LightAngle);
    u_xlat7.y = u_xlat8.x;
    u_xlat7.z = -1.0;
    u_xlat32 = dot(u_xlat7.xyz, u_xlat7.xyz);
    u_xlat32 = inversesqrt(u_xlat32);
    u_xlat7.xyz = vec3(u_xlat32) * u_xlat7.xyz;
    u_xlat5.x = dot(u_xlat5.xyz, u_xlat7.xyz);
    u_xlat14 = u_xlat5.z * u_xlat5.z;
    u_xlat23 = max(u_xlat5.x, 0.0);
    u_xlat5.x = (-u_xlat5.x) * _Diffuse + 1.0;
    u_xlat23 = log2(u_xlat23);
    u_xlat23 = u_xlat23 * _Reflectivity;
    u_xlat23 = exp2(u_xlat23);
    u_xlat7.xyz = vec3(u_xlat23) * _SpecularColor.xyz;
    u_xlat7.xyz = u_xlat7.xyz * vec3(vec3(_SpecularPower, _SpecularPower, _SpecularPower));
    u_xlat7.xyz = u_xlat7.xyz * u_xlat16_3.www + u_xlat16_3.xyz;
    u_xlat5.xzw = u_xlat5.xxx * u_xlat7.xyz;
    u_xlat7.x = (-_Ambient) + 1.0;
    u_xlat14 = u_xlat14 * u_xlat7.x + _Ambient;
    u_xlat0.xzw = u_xlat5.xzw * vec3(u_xlat14) + u_xlat0.xzw;
    u_xlat0.xzw = u_xlat2.xyz * vec3(u_xlat16_1) + u_xlat0.xzw;
    u_xlat5.x = _GlowOffset * _ScaleRatioB;
    u_xlat5.x = u_xlat5.x * vs_TEXCOORD1.y;
    u_xlat9.x = (-u_xlat5.x) * 0.5 + u_xlat9.x;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(u_xlat9.x>=0.0);
#else
    u_xlatb5 = u_xlat9.x>=0.0;
#endif
    u_xlat5.x = u_xlatb5 ? 1.0 : float(0.0);
    u_xlat14 = _GlowOuter * _ScaleRatioB + (-_GlowInner);
    u_xlat5.x = u_xlat5.x * u_xlat14 + _GlowInner;
    u_xlat5.x = u_xlat5.x * vs_TEXCOORD1.y;
    u_xlat14 = u_xlat5.x * 0.5 + 1.0;
    u_xlat5.x = u_xlat5.x * 0.5;
    u_xlat5.x = min(u_xlat5.x, 1.0);
    u_xlat5.x = sqrt(u_xlat5.x);
    u_xlat9.x = u_xlat9.x / u_xlat14;
    u_xlat9.x = min(abs(u_xlat9.x), 1.0);
    u_xlat9.x = log2(u_xlat9.x);
    u_xlat9.x = u_xlat9.x * _GlowPower;
    u_xlat9.x = exp2(u_xlat9.x);
    u_xlat9.x = (-u_xlat9.x) + 1.0;
    u_xlat9.x = u_xlat5.x * u_xlat9.x;
    u_xlat9.x = dot(_GlowColor.ww, u_xlat9.xx);
#ifdef UNITY_ADRENO_ES3
    u_xlat9.x = min(max(u_xlat9.x, 0.0), 1.0);
#else
    u_xlat9.x = clamp(u_xlat9.x, 0.0, 1.0);
#endif
    u_xlat4.xyz = _GlowColor.xyz * u_xlat9.xxx + u_xlat0.xzw;
    u_xlat16_0 = vec4(u_xlat16_10) * u_xlat4;
    SV_Target0 = u_xlat16_0 * vs_COLOR0.wwww;
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
Keywords { "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNITY_UI_ALPHACLIP" "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_CLIP_RECT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_CLIP_RECT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_CLIP_RECT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "UNITY_UI_CLIP_RECT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNITY_UI_CLIP_RECT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNITY_UI_CLIP_RECT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNITY_UI_ALPHACLIP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNITY_UI_ALPHACLIP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNITY_UI_ALPHACLIP" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNITY_UI_ALPHACLIP" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNITY_UI_ALPHACLIP" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNITY_UI_ALPHACLIP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNITY_UI_ALPHACLIP" "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNITY_UI_ALPHACLIP" "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNITY_UI_ALPHACLIP" "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNITY_UI_ALPHACLIP" "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNITY_UI_ALPHACLIP" "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "UNITY_UI_CLIP_RECT" "UNITY_UI_ALPHACLIP" "UNDERLAY_ON" "BEVEL_ON" "GLOW_ON" }
""
}
}
}
}
Fallback "TextMeshPro/Mobile/Distance Field"
CustomEditor "TMPro.EditorUtilities.TMP_SDFShaderGUI"
}