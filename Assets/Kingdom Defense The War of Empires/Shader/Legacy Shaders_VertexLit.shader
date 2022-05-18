//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Legacy Shaders/VertexLit" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_SpecColor ("Spec Color", Color) = (1,1,1,1)
_Emission ("Emissive Color", Color) = (0,0,0,0)
_Shininess ("Shininess", Range(0.01, 1)) = 0.7
_MainTex ("Base (RGB)", 2D) = "white" { }
}
SubShader {
 LOD 100
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "LIGHTMODE" = "Vertex" "RenderType" = "Opaque" }
  Fog {
   Mode Off
  }
  GpuProgramID 176578
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  mediump vec4 color_12;
  color_12 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_5;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = tmpvar_2.xyz;
  tmpvar_14[1] = tmpvar_3.xyz;
  tmpvar_14[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesNormal));
  eyeNormal_11 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_MatrixV * unity_ObjectToWorld) * tmpvar_13).xyz);
  viewDir_10 = -(tmpvar_16);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    highp vec3 tmpvar_17;
    tmpvar_17 = unity_LightPosition[il_6].xyz;
    mediump vec3 dirToLight_18;
    dirToLight_18 = tmpvar_17;
    mediump vec3 specColor_19;
    specColor_19 = specColor_8;
    mediump float tmpvar_20;
    tmpvar_20 = max (dot (eyeNormal_11, dirToLight_18), 0.0);
    mediump vec3 tmpvar_21;
    tmpvar_21 = ((tmpvar_20 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_20 > 0.0)) {
      specColor_19 = (specColor_8 + ((0.5 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_18 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_19;
    lcolor_9 = (lcolor_9 + min ((tmpvar_21 * 0.5), vec3(1.0, 1.0, 1.0)));
  };
  color_12.xyz = lcolor_9;
  color_12.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23 = clamp (color_12, 0.0, 1.0);
  tmpvar_22 = tmpvar_23;
  lowp vec3 tmpvar_24;
  mediump vec3 tmpvar_25;
  tmpvar_25 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_22;
  xlv_COLOR1 = tmpvar_24;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_26));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  col_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = 1.0;
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  mediump vec4 color_12;
  color_12 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_5;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = tmpvar_2.xyz;
  tmpvar_14[1] = tmpvar_3.xyz;
  tmpvar_14[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesNormal));
  eyeNormal_11 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_MatrixV * unity_ObjectToWorld) * tmpvar_13).xyz);
  viewDir_10 = -(tmpvar_16);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    highp vec3 tmpvar_17;
    tmpvar_17 = unity_LightPosition[il_6].xyz;
    mediump vec3 dirToLight_18;
    dirToLight_18 = tmpvar_17;
    mediump vec3 specColor_19;
    specColor_19 = specColor_8;
    mediump float tmpvar_20;
    tmpvar_20 = max (dot (eyeNormal_11, dirToLight_18), 0.0);
    mediump vec3 tmpvar_21;
    tmpvar_21 = ((tmpvar_20 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_20 > 0.0)) {
      specColor_19 = (specColor_8 + ((0.5 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_18 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_19;
    lcolor_9 = (lcolor_9 + min ((tmpvar_21 * 0.5), vec3(1.0, 1.0, 1.0)));
  };
  color_12.xyz = lcolor_9;
  color_12.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23 = clamp (color_12, 0.0, 1.0);
  tmpvar_22 = tmpvar_23;
  lowp vec3 tmpvar_24;
  mediump vec3 tmpvar_25;
  tmpvar_25 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_22;
  xlv_COLOR1 = tmpvar_24;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_26));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  col_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = 1.0;
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  mediump vec4 color_12;
  color_12 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_5;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = tmpvar_2.xyz;
  tmpvar_14[1] = tmpvar_3.xyz;
  tmpvar_14[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesNormal));
  eyeNormal_11 = tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(((unity_MatrixV * unity_ObjectToWorld) * tmpvar_13).xyz);
  viewDir_10 = -(tmpvar_16);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    highp vec3 tmpvar_17;
    tmpvar_17 = unity_LightPosition[il_6].xyz;
    mediump vec3 dirToLight_18;
    dirToLight_18 = tmpvar_17;
    mediump vec3 specColor_19;
    specColor_19 = specColor_8;
    mediump float tmpvar_20;
    tmpvar_20 = max (dot (eyeNormal_11, dirToLight_18), 0.0);
    mediump vec3 tmpvar_21;
    tmpvar_21 = ((tmpvar_20 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_20 > 0.0)) {
      specColor_19 = (specColor_8 + ((0.5 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_18 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_19;
    lcolor_9 = (lcolor_9 + min ((tmpvar_21 * 0.5), vec3(1.0, 1.0, 1.0)));
  };
  color_12.xyz = lcolor_9;
  color_12.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_22;
  mediump vec4 tmpvar_23;
  tmpvar_23 = clamp (color_12, 0.0, 1.0);
  tmpvar_22 = tmpvar_23;
  lowp vec3 tmpvar_24;
  mediump vec3 tmpvar_25;
  tmpvar_25 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_22;
  xlv_COLOR1 = tmpvar_24;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_26));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  col_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = 1.0;
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec4 _Emission;
uniform 	mediump float _Shininess;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_COLOR1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
float u_xlat36;
int u_xlati37;
mediump float u_xlat16_43;
mediump float u_xlat16_44;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
    u_xlat36 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat1.xyz = vec3(u_xlat36) * u_xlat1.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat16_7.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + _Emission.xyz;
    u_xlat16_43 = _Shininess * 128.0;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    u_xlat16_9.x = float(0.0);
    u_xlat16_9.y = float(0.0);
    u_xlat16_9.z = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<unity_VertexLightParams.x ; u_xlati_loop_1++)
    {
        u_xlat16_44 = dot(u_xlat1.xyz, unity_LightPosition[u_xlati_loop_1].xyz);
        u_xlat16_44 = max(u_xlat16_44, 0.0);
        u_xlat16_10.xyz = vec3(u_xlat16_44) * _Color.xyz;
        u_xlat16_10.xyz = u_xlat16_10.xyz * unity_LightColor[u_xlati_loop_1].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(0.0<u_xlat16_44);
#else
        u_xlatb2 = 0.0<u_xlat16_44;
#endif
        if(u_xlatb2){
            u_xlat16_11.xyz = (-u_xlat0.xyz) * vec3(u_xlat36) + unity_LightPosition[u_xlati_loop_1].xyz;
            u_xlat16_44 = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
            u_xlat16_44 = inversesqrt(u_xlat16_44);
            u_xlat16_11.xyz = vec3(u_xlat16_44) * u_xlat16_11.xyz;
            u_xlat16_44 = dot(u_xlat1.xyz, u_xlat16_11.xyz);
            u_xlat16_44 = max(u_xlat16_44, 0.0);
            u_xlat16_44 = log2(u_xlat16_44);
            u_xlat16_44 = u_xlat16_43 * u_xlat16_44;
            u_xlat16_44 = exp2(u_xlat16_44);
            u_xlat16_44 = min(u_xlat16_44, 1.0);
            u_xlat16_44 = u_xlat16_44 * 0.5;
            u_xlat16_9.xyz = vec3(u_xlat16_44) * unity_LightColor[u_xlati_loop_1].xyz + u_xlat16_9.xyz;
        //ENDIF
        }
        u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.5, 0.5, 0.5);
        u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_10.xyz;
    }
    vs_COLOR1.xyz = u_xlat16_9.xyz * _SpecColor.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR1.xyz = min(max(vs_COLOR1.xyz, 0.0), 1.0);
#else
    vs_COLOR1.xyz = clamp(vs_COLOR1.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.xyz = u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_COLOR1;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vs_COLOR1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec4 _Emission;
uniform 	mediump float _Shininess;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_COLOR1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
float u_xlat36;
int u_xlati37;
mediump float u_xlat16_43;
mediump float u_xlat16_44;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
    u_xlat36 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat1.xyz = vec3(u_xlat36) * u_xlat1.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat16_7.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + _Emission.xyz;
    u_xlat16_43 = _Shininess * 128.0;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    u_xlat16_9.x = float(0.0);
    u_xlat16_9.y = float(0.0);
    u_xlat16_9.z = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<unity_VertexLightParams.x ; u_xlati_loop_1++)
    {
        u_xlat16_44 = dot(u_xlat1.xyz, unity_LightPosition[u_xlati_loop_1].xyz);
        u_xlat16_44 = max(u_xlat16_44, 0.0);
        u_xlat16_10.xyz = vec3(u_xlat16_44) * _Color.xyz;
        u_xlat16_10.xyz = u_xlat16_10.xyz * unity_LightColor[u_xlati_loop_1].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(0.0<u_xlat16_44);
#else
        u_xlatb2 = 0.0<u_xlat16_44;
#endif
        if(u_xlatb2){
            u_xlat16_11.xyz = (-u_xlat0.xyz) * vec3(u_xlat36) + unity_LightPosition[u_xlati_loop_1].xyz;
            u_xlat16_44 = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
            u_xlat16_44 = inversesqrt(u_xlat16_44);
            u_xlat16_11.xyz = vec3(u_xlat16_44) * u_xlat16_11.xyz;
            u_xlat16_44 = dot(u_xlat1.xyz, u_xlat16_11.xyz);
            u_xlat16_44 = max(u_xlat16_44, 0.0);
            u_xlat16_44 = log2(u_xlat16_44);
            u_xlat16_44 = u_xlat16_43 * u_xlat16_44;
            u_xlat16_44 = exp2(u_xlat16_44);
            u_xlat16_44 = min(u_xlat16_44, 1.0);
            u_xlat16_44 = u_xlat16_44 * 0.5;
            u_xlat16_9.xyz = vec3(u_xlat16_44) * unity_LightColor[u_xlati_loop_1].xyz + u_xlat16_9.xyz;
        //ENDIF
        }
        u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.5, 0.5, 0.5);
        u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_10.xyz;
    }
    vs_COLOR1.xyz = u_xlat16_9.xyz * _SpecColor.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR1.xyz = min(max(vs_COLOR1.xyz, 0.0), 1.0);
#else
    vs_COLOR1.xyz = clamp(vs_COLOR1.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.xyz = u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_COLOR1;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vs_COLOR1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec4 _Emission;
uniform 	mediump float _Shininess;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_COLOR1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
bool u_xlatb2;
vec3 u_xlat3;
vec3 u_xlat4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump vec3 u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
mediump vec3 u_xlat16_11;
float u_xlat36;
int u_xlati37;
mediump float u_xlat16_43;
mediump float u_xlat16_44;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
    u_xlat36 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat1.xyz = vec3(u_xlat36) * u_xlat1.xyz;
    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat36 = inversesqrt(u_xlat36);
    u_xlat16_7.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + _Emission.xyz;
    u_xlat16_43 = _Shininess * 128.0;
    u_xlat16_8.xyz = u_xlat16_7.xyz;
    u_xlat16_9.x = float(0.0);
    u_xlat16_9.y = float(0.0);
    u_xlat16_9.z = float(0.0);
    for(int u_xlati_loop_1 = 0 ; u_xlati_loop_1<unity_VertexLightParams.x ; u_xlati_loop_1++)
    {
        u_xlat16_44 = dot(u_xlat1.xyz, unity_LightPosition[u_xlati_loop_1].xyz);
        u_xlat16_44 = max(u_xlat16_44, 0.0);
        u_xlat16_10.xyz = vec3(u_xlat16_44) * _Color.xyz;
        u_xlat16_10.xyz = u_xlat16_10.xyz * unity_LightColor[u_xlati_loop_1].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb2 = !!(0.0<u_xlat16_44);
#else
        u_xlatb2 = 0.0<u_xlat16_44;
#endif
        if(u_xlatb2){
            u_xlat16_11.xyz = (-u_xlat0.xyz) * vec3(u_xlat36) + unity_LightPosition[u_xlati_loop_1].xyz;
            u_xlat16_44 = dot(u_xlat16_11.xyz, u_xlat16_11.xyz);
            u_xlat16_44 = inversesqrt(u_xlat16_44);
            u_xlat16_11.xyz = vec3(u_xlat16_44) * u_xlat16_11.xyz;
            u_xlat16_44 = dot(u_xlat1.xyz, u_xlat16_11.xyz);
            u_xlat16_44 = max(u_xlat16_44, 0.0);
            u_xlat16_44 = log2(u_xlat16_44);
            u_xlat16_44 = u_xlat16_43 * u_xlat16_44;
            u_xlat16_44 = exp2(u_xlat16_44);
            u_xlat16_44 = min(u_xlat16_44, 1.0);
            u_xlat16_44 = u_xlat16_44 * 0.5;
            u_xlat16_9.xyz = vec3(u_xlat16_44) * unity_LightColor[u_xlati_loop_1].xyz + u_xlat16_9.xyz;
        //ENDIF
        }
        u_xlat16_10.xyz = u_xlat16_10.xyz * vec3(0.5, 0.5, 0.5);
        u_xlat16_10.xyz = min(u_xlat16_10.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_8.xyz = u_xlat16_8.xyz + u_xlat16_10.xyz;
    }
    vs_COLOR1.xyz = u_xlat16_9.xyz * _SpecColor.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR1.xyz = min(max(vs_COLOR1.xyz, 0.0), 1.0);
#else
    vs_COLOR1.xyz = clamp(vs_COLOR1.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.xyz = u_xlat16_8.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_COLOR1;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vs_COLOR1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float att_19;
    highp vec3 dirToLight_20;
    dirToLight_20 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_21;
    tmpvar_21 = dot (dirToLight_20, dirToLight_20);
    att_19 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_21))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_21 > unity_LightAtten[il_6].w))) {
      att_19 = 0.0;
    };
    dirToLight_20 = (dirToLight_20 * inversesqrt(max (tmpvar_21, 1e-06)));
    att_19 = (att_19 * 0.5);
    mediump vec3 dirToLight_22;
    dirToLight_22 = dirToLight_20;
    mediump vec3 specColor_23;
    specColor_23 = specColor_8;
    mediump float tmpvar_24;
    tmpvar_24 = max (dot (eyeNormal_11, dirToLight_22), 0.0);
    mediump vec3 tmpvar_25;
    tmpvar_25 = ((tmpvar_24 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_24 > 0.0)) {
      specColor_23 = (specColor_8 + ((att_19 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_22 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_23;
    lcolor_9 = (lcolor_9 + min ((tmpvar_25 * att_19), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27 = clamp (color_13, 0.0, 1.0);
  tmpvar_26 = tmpvar_27;
  lowp vec3 tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_26;
  xlv_COLOR1 = tmpvar_28;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_30));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  col_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = 1.0;
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float att_19;
    highp vec3 dirToLight_20;
    dirToLight_20 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_21;
    tmpvar_21 = dot (dirToLight_20, dirToLight_20);
    att_19 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_21))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_21 > unity_LightAtten[il_6].w))) {
      att_19 = 0.0;
    };
    dirToLight_20 = (dirToLight_20 * inversesqrt(max (tmpvar_21, 1e-06)));
    att_19 = (att_19 * 0.5);
    mediump vec3 dirToLight_22;
    dirToLight_22 = dirToLight_20;
    mediump vec3 specColor_23;
    specColor_23 = specColor_8;
    mediump float tmpvar_24;
    tmpvar_24 = max (dot (eyeNormal_11, dirToLight_22), 0.0);
    mediump vec3 tmpvar_25;
    tmpvar_25 = ((tmpvar_24 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_24 > 0.0)) {
      specColor_23 = (specColor_8 + ((att_19 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_22 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_23;
    lcolor_9 = (lcolor_9 + min ((tmpvar_25 * att_19), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27 = clamp (color_13, 0.0, 1.0);
  tmpvar_26 = tmpvar_27;
  lowp vec3 tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_26;
  xlv_COLOR1 = tmpvar_28;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_30));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  col_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = 1.0;
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float att_19;
    highp vec3 dirToLight_20;
    dirToLight_20 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_21;
    tmpvar_21 = dot (dirToLight_20, dirToLight_20);
    att_19 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_21))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_21 > unity_LightAtten[il_6].w))) {
      att_19 = 0.0;
    };
    dirToLight_20 = (dirToLight_20 * inversesqrt(max (tmpvar_21, 1e-06)));
    att_19 = (att_19 * 0.5);
    mediump vec3 dirToLight_22;
    dirToLight_22 = dirToLight_20;
    mediump vec3 specColor_23;
    specColor_23 = specColor_8;
    mediump float tmpvar_24;
    tmpvar_24 = max (dot (eyeNormal_11, dirToLight_22), 0.0);
    mediump vec3 tmpvar_25;
    tmpvar_25 = ((tmpvar_24 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_24 > 0.0)) {
      specColor_23 = (specColor_8 + ((att_19 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_22 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_23;
    lcolor_9 = (lcolor_9 + min ((tmpvar_25 * att_19), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27 = clamp (color_13, 0.0, 1.0);
  tmpvar_26 = tmpvar_27;
  lowp vec3 tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30.w = 1.0;
  tmpvar_30.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_26;
  xlv_COLOR1 = tmpvar_28;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_30));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  col_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = 1.0;
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "POINT" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec4 _Emission;
uniform 	mediump float _Shininess;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_COLOR1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
bool u_xlatb5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
bool u_xlatb9;
float u_xlat10;
vec3 u_xlat11;
vec3 u_xlat12;
bool u_xlatb12;
float u_xlat13;
mediump vec3 u_xlat16_14;
vec3 u_xlat15;
vec3 u_xlat16;
bool u_xlatb16;
float u_xlat17;
mediump vec3 u_xlat16_18;
vec3 u_xlat19;
vec3 u_xlat21;
mediump vec3 u_xlat16_22;
int u_xlati24;
bool u_xlatb24;
mediump vec3 u_xlat16_25;
mediump vec3 u_xlat16_26;
vec3 u_xlat28;
vec3 u_xlat29;
bool u_xlatb29;
vec3 u_xlat31;
vec3 u_xlat32;
bool u_xlatb32;
vec3 u_xlat35;
vec3 u_xlat36;
bool u_xlatb36;
mediump float u_xlat16_41;
bool u_xlatb43;
mediump float u_xlat16_44;
mediump float u_xlat16_45;
float u_xlat48;
bool u_xlatb48;
float u_xlat51;
bool u_xlatb51;
float u_xlat55;
bool u_xlatb55;
float u_xlat58;
float u_xlat61;
float u_xlat62;
mediump float u_xlat16_63;
mediump float u_xlat16_64;
bool u_xlatb65;
float u_xlat67;
bool u_xlatb68;
float u_xlat70;
bool u_xlatb72;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(unity_LightPosition[1].w!=0.0);
#else
    u_xlatb0 = unity_LightPosition[1].w!=0.0;
#endif
    u_xlat19.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat19.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat19.xyz;
    u_xlat19.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat19.xyz;
    u_xlat19.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat19.xyz;
    u_xlat19.xyz = u_xlat19.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat19.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat19.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat19.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat19.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat19.xyz = u_xlat19.xyz + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat19.xyz) * unity_LightPosition[1].www + unity_LightPosition[1].xyz;
    u_xlat58 = dot(u_xlat1.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(unity_LightAtten[1].w<u_xlat58);
#else
    u_xlatb2 = unity_LightAtten[1].w<u_xlat58;
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb2;
    u_xlat2.x = unity_LightAtten[1].z * u_xlat58 + 1.0;
    u_xlat58 = max(u_xlat58, 9.99999997e-007);
    u_xlat58 = inversesqrt(u_xlat58);
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat2.x = u_xlat2.x * 0.5;
    u_xlat16_3.x = (u_xlatb0) ? 0.0 : u_xlat2.x;
    u_xlat2.xyz = vec3(u_xlat58) * u_xlat1.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat4.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat4.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat5.xyz;
    u_xlat4.z = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat16_22.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat16_22.x = max(u_xlat16_22.x, 0.0);
    u_xlat16_6.xyz = u_xlat16_22.xxx * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<u_xlat16_22.x);
#else
    u_xlatb0 = 0.0<u_xlat16_22.x;
#endif
    u_xlat16_22.xyz = u_xlat16_6.xyz * unity_LightColor[1].xyz;
    u_xlat16_22.xyz = u_xlat16_3.xxx * u_xlat16_22.xyz;
    u_xlat16_22.xyz = min(u_xlat16_22.xyz, vec3(1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(unity_LightPosition[0].w!=0.0);
#else
    u_xlatb2 = unity_LightPosition[0].w!=0.0;
#endif
    u_xlat21.xyz = (-u_xlat19.xyz) * unity_LightPosition[0].www + unity_LightPosition[0].xyz;
    u_xlat61 = dot(u_xlat21.xyz, u_xlat21.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(unity_LightAtten[0].w<u_xlat61);
#else
    u_xlatb5 = unity_LightAtten[0].w<u_xlat61;
#endif
    u_xlatb2 = u_xlatb2 && u_xlatb5;
    u_xlat5.x = unity_LightAtten[0].z * u_xlat61 + 1.0;
    u_xlat61 = max(u_xlat61, 9.99999997e-007);
    u_xlat61 = inversesqrt(u_xlat61);
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.5;
    u_xlat16_6.x = (u_xlatb2) ? 0.0 : u_xlat5.x;
    u_xlat5.xyz = u_xlat21.xyz * vec3(u_xlat61);
    u_xlat16_25.x = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat16_25.x = max(u_xlat16_25.x, 0.0);
    u_xlat16_7.xyz = u_xlat16_25.xxx * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<u_xlat16_25.x);
#else
    u_xlatb2 = 0.0<u_xlat16_25.x;
#endif
    u_xlat16_25.xyz = u_xlat16_7.xyz * unity_LightColor[0].xyz;
    u_xlat16_25.xyz = u_xlat16_6.xxx * u_xlat16_25.xyz;
    u_xlat16_25.xyz = min(u_xlat16_25.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_7.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + _Emission.xyz;
    u_xlat16_25.xyz = u_xlat16_25.xyz + u_xlat16_7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0<unity_VertexLightParams.x);
#else
    u_xlatb5 = 0<unity_VertexLightParams.x;
#endif
    u_xlat16_25.xyz = (bool(u_xlatb5)) ? u_xlat16_25.xyz : u_xlat16_7.xyz;
    u_xlat16_22.xyz = u_xlat16_22.xyz + u_xlat16_25.xyz;
    u_xlati24 = u_xlatb5 ? 1 : int(0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb43 = !!(u_xlati24<unity_VertexLightParams.x);
#else
    u_xlatb43 = u_xlati24<unity_VertexLightParams.x;
#endif
    u_xlati24 = (u_xlatb43) ? 2 : u_xlati24;
    u_xlat16_22.xyz = (bool(u_xlatb43)) ? u_xlat16_22.xyz : u_xlat16_25.xyz;
    u_xlat8.xyz = (-u_xlat19.xyz) * unity_LightPosition[2].www + unity_LightPosition[2].xyz;
    u_xlat62 = dot(u_xlat8.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb65 = !!(unity_LightAtten[2].w<u_xlat62);
#else
    u_xlatb65 = unity_LightAtten[2].w<u_xlat62;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightPosition[2].w!=0.0);
#else
    u_xlatb9 = unity_LightPosition[2].w!=0.0;
#endif
    u_xlatb65 = u_xlatb65 && u_xlatb9;
    u_xlat9.x = unity_LightAtten[2].z * u_xlat62 + 1.0;
    u_xlat62 = max(u_xlat62, 9.99999997e-007);
    u_xlat62 = inversesqrt(u_xlat62);
    u_xlat9.x = float(1.0) / u_xlat9.x;
    u_xlat9.x = u_xlat9.x * 0.5;
    u_xlat16_25.x = (u_xlatb65) ? 0.0 : u_xlat9.x;
    u_xlat9.xyz = vec3(u_xlat62) * u_xlat8.xyz;
    u_xlat16_44 = dot(u_xlat4.xyz, u_xlat9.xyz);
    u_xlat16_44 = max(u_xlat16_44, 0.0);
    u_xlat16_7.xyz = vec3(u_xlat16_44) * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb65 = !!(0.0<u_xlat16_44);
#else
    u_xlatb65 = 0.0<u_xlat16_44;
#endif
    u_xlat16_7.xyz = u_xlat16_7.xyz * unity_LightColor[2].xyz;
    u_xlat16_7.xyz = u_xlat16_25.xxx * u_xlat16_7.xyz;
    u_xlat16_7.xyz = min(u_xlat16_7.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_7.xyz = u_xlat16_22.xyz + u_xlat16_7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlati24<unity_VertexLightParams.x);
#else
    u_xlatb9 = u_xlati24<unity_VertexLightParams.x;
#endif
    u_xlatb9 = u_xlatb43 && u_xlatb9;
    u_xlat16_22.xyz = (bool(u_xlatb9)) ? u_xlat16_7.xyz : u_xlat16_22.xyz;
    u_xlat28.xyz = (-u_xlat19.xyz) * unity_LightPosition[3].www + unity_LightPosition[3].xyz;
    u_xlat10 = dot(u_xlat28.xyz, u_xlat28.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb29 = !!(unity_LightAtten[3].w<u_xlat10);
#else
    u_xlatb29 = unity_LightAtten[3].w<u_xlat10;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb48 = !!(unity_LightPosition[3].w!=0.0);
#else
    u_xlatb48 = unity_LightPosition[3].w!=0.0;
#endif
    u_xlatb29 = u_xlatb29 && u_xlatb48;
    u_xlat48 = unity_LightAtten[3].z * u_xlat10 + 1.0;
    u_xlat10 = max(u_xlat10, 9.99999997e-007);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat48 = float(1.0) / u_xlat48;
    u_xlat48 = u_xlat48 * 0.5;
    u_xlat16_44 = (u_xlatb29) ? 0.0 : u_xlat48;
    u_xlat29.xyz = u_xlat28.xyz * vec3(u_xlat10);
    u_xlat16_63 = dot(u_xlat4.xyz, u_xlat29.xyz);
    u_xlat16_63 = max(u_xlat16_63, 0.0);
    u_xlat16_7.xyz = vec3(u_xlat16_63) * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb29 = !!(0.0<u_xlat16_63);
#else
    u_xlatb29 = 0.0<u_xlat16_63;
#endif
    u_xlat16_7.xyz = u_xlat16_7.xyz * unity_LightColor[3].xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_44) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = min(u_xlat16_7.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_7.xyz = u_xlat16_22.xyz + u_xlat16_7.xyz;
    u_xlati24 = (u_xlatb9) ? 3 : u_xlati24;
#ifdef UNITY_ADRENO_ES3
    u_xlatb48 = !!(u_xlati24<unity_VertexLightParams.x);
#else
    u_xlatb48 = u_xlati24<unity_VertexLightParams.x;
#endif
    u_xlatb48 = u_xlatb9 && u_xlatb48;
    u_xlat16_22.xyz = (bool(u_xlatb48)) ? u_xlat16_7.xyz : u_xlat16_22.xyz;
    u_xlat11.xyz = (-u_xlat19.xyz) * unity_LightPosition[4].www + unity_LightPosition[4].xyz;
    u_xlat67 = dot(u_xlat11.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb68 = !!(unity_LightAtten[4].w<u_xlat67);
#else
    u_xlatb68 = unity_LightAtten[4].w<u_xlat67;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(unity_LightPosition[4].w!=0.0);
#else
    u_xlatb12 = unity_LightPosition[4].w!=0.0;
#endif
    u_xlatb68 = u_xlatb68 && u_xlatb12;
    u_xlat12.x = unity_LightAtten[4].z * u_xlat67 + 1.0;
    u_xlat67 = max(u_xlat67, 9.99999997e-007);
    u_xlat67 = inversesqrt(u_xlat67);
    u_xlat12.x = float(1.0) / u_xlat12.x;
    u_xlat12.x = u_xlat12.x * 0.5;
    u_xlat16_63 = (u_xlatb68) ? 0.0 : u_xlat12.x;
    u_xlat12.xyz = vec3(u_xlat67) * u_xlat11.xyz;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat12.xyz);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlat16_26.xyz = u_xlat16_7.xxx * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb68 = !!(0.0<u_xlat16_7.x);
#else
    u_xlatb68 = 0.0<u_xlat16_7.x;
#endif
    u_xlat16_7.xyz = u_xlat16_26.xyz * unity_LightColor[4].xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_63) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = min(u_xlat16_7.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_7.xyz = u_xlat16_22.xyz + u_xlat16_7.xyz;
    u_xlati24 = (u_xlatb48) ? 4 : u_xlati24;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlati24<unity_VertexLightParams.x);
#else
    u_xlatb12 = u_xlati24<unity_VertexLightParams.x;
#endif
    u_xlatb12 = u_xlatb48 && u_xlatb12;
    u_xlat16_22.xyz = (bool(u_xlatb12)) ? u_xlat16_7.xyz : u_xlat16_22.xyz;
    u_xlat31.xyz = (-u_xlat19.xyz) * unity_LightPosition[5].www + unity_LightPosition[5].xyz;
    u_xlat13 = dot(u_xlat31.xyz, u_xlat31.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb32 = !!(unity_LightAtten[5].w<u_xlat13);
#else
    u_xlatb32 = unity_LightAtten[5].w<u_xlat13;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb51 = !!(unity_LightPosition[5].w!=0.0);
#else
    u_xlatb51 = unity_LightPosition[5].w!=0.0;
#endif
    u_xlatb32 = u_xlatb32 && u_xlatb51;
    u_xlat51 = unity_LightAtten[5].z * u_xlat13 + 1.0;
    u_xlat13 = max(u_xlat13, 9.99999997e-007);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat51 = float(1.0) / u_xlat51;
    u_xlat51 = u_xlat51 * 0.5;
    u_xlat16_7.x = (u_xlatb32) ? 0.0 : u_xlat51;
    u_xlat32.xyz = u_xlat31.xyz * vec3(u_xlat13);
    u_xlat16_26.x = dot(u_xlat4.xyz, u_xlat32.xyz);
    u_xlat16_26.x = max(u_xlat16_26.x, 0.0);
    u_xlat16_14.xyz = u_xlat16_26.xxx * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb32 = !!(0.0<u_xlat16_26.x);
#else
    u_xlatb32 = 0.0<u_xlat16_26.x;
#endif
    u_xlat16_26.xyz = u_xlat16_14.xyz * unity_LightColor[5].xyz;
    u_xlat16_26.xyz = u_xlat16_7.xxx * u_xlat16_26.xyz;
    u_xlat16_26.xyz = min(u_xlat16_26.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_26.xyz = u_xlat16_22.xyz + u_xlat16_26.xyz;
    u_xlati24 = (u_xlatb12) ? 5 : u_xlati24;
#ifdef UNITY_ADRENO_ES3
    u_xlatb51 = !!(u_xlati24<unity_VertexLightParams.x);
#else
    u_xlatb51 = u_xlati24<unity_VertexLightParams.x;
#endif
    u_xlatb51 = u_xlatb12 && u_xlatb51;
    u_xlat16_22.xyz = (bool(u_xlatb51)) ? u_xlat16_26.xyz : u_xlat16_22.xyz;
    u_xlat15.xyz = (-u_xlat19.xyz) * unity_LightPosition[6].www + unity_LightPosition[6].xyz;
    u_xlat70 = dot(u_xlat15.xyz, u_xlat15.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb72 = !!(unity_LightAtten[6].w<u_xlat70);
#else
    u_xlatb72 = unity_LightAtten[6].w<u_xlat70;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(unity_LightPosition[6].w!=0.0);
#else
    u_xlatb16 = unity_LightPosition[6].w!=0.0;
#endif
    u_xlatb72 = u_xlatb72 && u_xlatb16;
    u_xlat16.x = unity_LightAtten[6].z * u_xlat70 + 1.0;
    u_xlat70 = max(u_xlat70, 9.99999997e-007);
    u_xlat70 = inversesqrt(u_xlat70);
    u_xlat16.x = float(1.0) / u_xlat16.x;
    u_xlat16.x = u_xlat16.x * 0.5;
    u_xlat16_26.x = (u_xlatb72) ? 0.0 : u_xlat16.x;
    u_xlat16.xyz = vec3(u_xlat70) * u_xlat15.xyz;
    u_xlat16_45 = dot(u_xlat4.xyz, u_xlat16.xyz);
    u_xlat16_45 = max(u_xlat16_45, 0.0);
    u_xlat16_14.xyz = vec3(u_xlat16_45) * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb72 = !!(0.0<u_xlat16_45);
#else
    u_xlatb72 = 0.0<u_xlat16_45;
#endif
    u_xlat16_14.xyz = u_xlat16_14.xyz * unity_LightColor[6].xyz;
    u_xlat16_14.xyz = u_xlat16_26.xxx * u_xlat16_14.xyz;
    u_xlat16_14.xyz = min(u_xlat16_14.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_14.xyz = u_xlat16_22.xyz + u_xlat16_14.xyz;
    u_xlati24 = (u_xlatb51) ? 6 : u_xlati24;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlati24<unity_VertexLightParams.x);
#else
    u_xlatb16 = u_xlati24<unity_VertexLightParams.x;
#endif
    u_xlatb16 = u_xlatb51 && u_xlatb16;
    u_xlat16_22.xyz = (bool(u_xlatb16)) ? u_xlat16_14.xyz : u_xlat16_22.xyz;
    u_xlat35.xyz = (-u_xlat19.xyz) * unity_LightPosition[7].www + unity_LightPosition[7].xyz;
    u_xlat17 = dot(u_xlat35.xyz, u_xlat35.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(unity_LightAtten[7].w<u_xlat17);
#else
    u_xlatb36 = unity_LightAtten[7].w<u_xlat17;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb55 = !!(unity_LightPosition[7].w!=0.0);
#else
    u_xlatb55 = unity_LightPosition[7].w!=0.0;
#endif
    u_xlatb36 = u_xlatb36 && u_xlatb55;
    u_xlat55 = unity_LightAtten[7].z * u_xlat17 + 1.0;
    u_xlat17 = max(u_xlat17, 9.99999997e-007);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat55 = float(1.0) / u_xlat55;
    u_xlat55 = u_xlat55 * 0.5;
    u_xlat16_45 = (u_xlatb36) ? 0.0 : u_xlat55;
    u_xlat36.xyz = u_xlat35.xyz * vec3(u_xlat17);
    u_xlat16_64 = dot(u_xlat4.xyz, u_xlat36.xyz);
    u_xlat16_64 = max(u_xlat16_64, 0.0);
    u_xlat16_14.xyz = vec3(u_xlat16_64) * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(0.0<u_xlat16_64);
#else
    u_xlatb36 = 0.0<u_xlat16_64;
#endif
    u_xlat16_14.xyz = u_xlat16_14.xyz * unity_LightColor[7].xyz;
    u_xlat16_14.xyz = vec3(u_xlat16_45) * u_xlat16_14.xyz;
    u_xlat16_14.xyz = min(u_xlat16_14.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_14.xyz = u_xlat16_22.xyz + u_xlat16_14.xyz;
    u_xlati24 = (u_xlatb16) ? 7 : u_xlati24;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlati24<unity_VertexLightParams.x);
#else
    u_xlatb24 = u_xlati24<unity_VertexLightParams.x;
#endif
    u_xlatb24 = u_xlatb24 && u_xlatb16;
    vs_COLOR0.xyz = (bool(u_xlatb24)) ? u_xlat16_14.xyz : u_xlat16_22.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
    u_xlat55 = dot(u_xlat19.xyz, u_xlat19.xyz);
    u_xlat55 = inversesqrt(u_xlat55);
    u_xlat19.xyz = u_xlat19.xyz * vec3(u_xlat55);
    u_xlat16_22.xyz = u_xlat21.xyz * vec3(u_xlat61) + (-u_xlat19.xyz);
    u_xlat16_64 = dot(u_xlat16_22.xyz, u_xlat16_22.xyz);
    u_xlat16_64 = inversesqrt(u_xlat16_64);
    u_xlat16_22.xyz = u_xlat16_22.xyz * vec3(u_xlat16_64);
    u_xlat16_22.x = dot(u_xlat4.xyz, u_xlat16_22.xyz);
    u_xlat16_22.x = max(u_xlat16_22.x, 0.0);
    u_xlat16_22.x = log2(u_xlat16_22.x);
    u_xlat16_41 = _Shininess * 128.0;
    u_xlat16_22.x = u_xlat16_22.x * u_xlat16_41;
    u_xlat16_22.x = exp2(u_xlat16_22.x);
    u_xlat16_22.x = min(u_xlat16_22.x, 1.0);
    u_xlat16_22.x = u_xlat16_22.x * u_xlat16_6.x;
    u_xlat16_14.xyz = u_xlat16_22.xxx * unity_LightColor[0].xyz;
    u_xlat16_14.xyz = (bool(u_xlatb2)) ? u_xlat16_14.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_14.xyz = (bool(u_xlatb5)) ? u_xlat16_14.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_18.xyz = u_xlat1.xyz * vec3(u_xlat58) + (-u_xlat19.xyz);
    u_xlat16_22.x = dot(u_xlat16_18.xyz, u_xlat16_18.xyz);
    u_xlat16_22.x = inversesqrt(u_xlat16_22.x);
    u_xlat16_18.xyz = u_xlat16_22.xxx * u_xlat16_18.xyz;
    u_xlat16_22.x = dot(u_xlat4.xyz, u_xlat16_18.xyz);
    u_xlat16_22.x = max(u_xlat16_22.x, 0.0);
    u_xlat16_22.x = log2(u_xlat16_22.x);
    u_xlat16_22.x = u_xlat16_22.x * u_xlat16_41;
    u_xlat16_22.x = exp2(u_xlat16_22.x);
    u_xlat16_22.x = min(u_xlat16_22.x, 1.0);
    u_xlat16_3.x = u_xlat16_22.x * u_xlat16_3.x;
    u_xlat16_3.xyw = u_xlat16_3.xxx * unity_LightColor[1].xyz + u_xlat16_14.xyz;
    u_xlat16_3.xyw = (bool(u_xlatb0)) ? u_xlat16_3.xyw : u_xlat16_14.xyz;
    u_xlat16_3.xyw = (bool(u_xlatb43)) ? u_xlat16_3.xyw : u_xlat16_14.xyz;
    u_xlat16_14.xyz = u_xlat8.xyz * vec3(u_xlat62) + (-u_xlat19.xyz);
    u_xlat16_6.x = dot(u_xlat16_14.xyz, u_xlat16_14.xyz);
    u_xlat16_6.x = inversesqrt(u_xlat16_6.x);
    u_xlat16_14.xyz = u_xlat16_6.xxx * u_xlat16_14.xyz;
    u_xlat16_6.x = dot(u_xlat4.xyz, u_xlat16_14.xyz);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlat16_6.x = log2(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_41 * u_xlat16_6.x;
    u_xlat16_6.x = exp2(u_xlat16_6.x);
    u_xlat16_6.x = min(u_xlat16_6.x, 1.0);
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_25.x;
    u_xlat16_14.xyz = u_xlat16_6.xxx * unity_LightColor[2].xyz + u_xlat16_3.xyw;
    u_xlat16_14.xyz = (bool(u_xlatb65)) ? u_xlat16_14.xyz : u_xlat16_3.xyw;
    u_xlat16_3.xyw = (bool(u_xlatb9)) ? u_xlat16_14.xyz : u_xlat16_3.xyw;
    u_xlat16_14.xyz = u_xlat28.xyz * vec3(u_xlat10) + (-u_xlat19.xyz);
    u_xlat16_6.x = dot(u_xlat16_14.xyz, u_xlat16_14.xyz);
    u_xlat16_6.x = inversesqrt(u_xlat16_6.x);
    u_xlat16_14.xyz = u_xlat16_6.xxx * u_xlat16_14.xyz;
    u_xlat16_6.x = dot(u_xlat4.xyz, u_xlat16_14.xyz);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlat16_6.x = log2(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_41 * u_xlat16_6.x;
    u_xlat16_6.x = exp2(u_xlat16_6.x);
    u_xlat16_6.x = min(u_xlat16_6.x, 1.0);
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_44;
    u_xlat16_6.xyz = u_xlat16_6.xxx * unity_LightColor[3].xyz + u_xlat16_3.xyw;
    u_xlat16_6.xyz = (bool(u_xlatb29)) ? u_xlat16_6.xyz : u_xlat16_3.xyw;
    u_xlat16_3.xyw = (bool(u_xlatb48)) ? u_xlat16_6.xyz : u_xlat16_3.xyw;
    u_xlat16_6.xyz = u_xlat11.xyz * vec3(u_xlat67) + (-u_xlat19.xyz);
    u_xlat16_64 = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
    u_xlat16_64 = inversesqrt(u_xlat16_64);
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(u_xlat16_64);
    u_xlat16_6.x = dot(u_xlat4.xyz, u_xlat16_6.xyz);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlat16_6.x = log2(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_41 * u_xlat16_6.x;
    u_xlat16_6.x = exp2(u_xlat16_6.x);
    u_xlat16_6.x = min(u_xlat16_6.x, 1.0);
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_63;
    u_xlat16_6.xyz = u_xlat16_6.xxx * unity_LightColor[4].xyz + u_xlat16_3.xyw;
    u_xlat16_6.xyz = (bool(u_xlatb68)) ? u_xlat16_6.xyz : u_xlat16_3.xyw;
    u_xlat16_3.xyw = (bool(u_xlatb12)) ? u_xlat16_6.xyz : u_xlat16_3.xyw;
    u_xlat16_6.xyz = u_xlat31.xyz * vec3(u_xlat13) + (-u_xlat19.xyz);
    u_xlat16_63 = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
    u_xlat16_63 = inversesqrt(u_xlat16_63);
    u_xlat16_6.xyz = vec3(u_xlat16_63) * u_xlat16_6.xyz;
    u_xlat16_6.x = dot(u_xlat4.xyz, u_xlat16_6.xyz);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlat16_6.x = log2(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_41 * u_xlat16_6.x;
    u_xlat16_6.x = exp2(u_xlat16_6.x);
    u_xlat16_6.x = min(u_xlat16_6.x, 1.0);
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_7.x;
    u_xlat16_6.xyz = u_xlat16_6.xxx * unity_LightColor[5].xyz + u_xlat16_3.xyw;
    u_xlat16_6.xyz = (bool(u_xlatb32)) ? u_xlat16_6.xyz : u_xlat16_3.xyw;
    u_xlat16_3.xyw = (bool(u_xlatb51)) ? u_xlat16_6.xyz : u_xlat16_3.xyw;
    u_xlat16_6.xyz = u_xlat15.xyz * vec3(u_xlat70) + (-u_xlat19.xyz);
    u_xlat16_14.xyz = u_xlat35.xyz * vec3(u_xlat17) + (-u_xlat19.xyz);
    u_xlat16_63 = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
    u_xlat16_63 = inversesqrt(u_xlat16_63);
    u_xlat16_6.xyz = vec3(u_xlat16_63) * u_xlat16_6.xyz;
    u_xlat16_6.x = dot(u_xlat4.xyz, u_xlat16_6.xyz);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlat16_6.x = log2(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_41 * u_xlat16_6.x;
    u_xlat16_6.x = exp2(u_xlat16_6.x);
    u_xlat16_6.x = min(u_xlat16_6.x, 1.0);
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_26.x;
    u_xlat16_6.xyz = u_xlat16_6.xxx * unity_LightColor[6].xyz + u_xlat16_3.xyw;
    u_xlat16_6.xyz = (bool(u_xlatb72)) ? u_xlat16_6.xyz : u_xlat16_3.xyw;
    u_xlat16_3.xyw = (bool(u_xlatb16)) ? u_xlat16_6.xyz : u_xlat16_3.xyw;
    u_xlat16_6.x = dot(u_xlat16_14.xyz, u_xlat16_14.xyz);
    u_xlat16_6.x = inversesqrt(u_xlat16_6.x);
    u_xlat16_6.xyz = u_xlat16_6.xxx * u_xlat16_14.xyz;
    u_xlat16_6.x = dot(u_xlat4.xyz, u_xlat16_6.xyz);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlat16_6.x = log2(u_xlat16_6.x);
    u_xlat16_41 = u_xlat16_41 * u_xlat16_6.x;
    u_xlat16_41 = exp2(u_xlat16_41);
    u_xlat16_41 = min(u_xlat16_41, 1.0);
    u_xlat16_41 = u_xlat16_41 * u_xlat16_45;
    u_xlat16_6.xyz = vec3(u_xlat16_41) * unity_LightColor[7].xyz + u_xlat16_3.xyw;
    u_xlat16_6.xyz = (bool(u_xlatb36)) ? u_xlat16_6.xyz : u_xlat16_3.xyw;
    u_xlat16_3.xyz = (bool(u_xlatb24)) ? u_xlat16_6.xyz : u_xlat16_3.xyw;
    vs_COLOR1.xyz = u_xlat16_3.xyz * _SpecColor.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR1.xyz = min(max(vs_COLOR1.xyz, 0.0), 1.0);
#else
    vs_COLOR1.xyz = clamp(vs_COLOR1.xyz, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_COLOR1;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vs_COLOR1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec4 _Emission;
uniform 	mediump float _Shininess;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_COLOR1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
bool u_xlatb5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
bool u_xlatb9;
float u_xlat10;
vec3 u_xlat11;
vec3 u_xlat12;
bool u_xlatb12;
float u_xlat13;
mediump vec3 u_xlat16_14;
vec3 u_xlat15;
vec3 u_xlat16;
bool u_xlatb16;
float u_xlat17;
mediump vec3 u_xlat16_18;
vec3 u_xlat19;
vec3 u_xlat21;
mediump vec3 u_xlat16_22;
int u_xlati24;
bool u_xlatb24;
mediump vec3 u_xlat16_25;
mediump vec3 u_xlat16_26;
vec3 u_xlat28;
vec3 u_xlat29;
bool u_xlatb29;
vec3 u_xlat31;
vec3 u_xlat32;
bool u_xlatb32;
vec3 u_xlat35;
vec3 u_xlat36;
bool u_xlatb36;
mediump float u_xlat16_41;
bool u_xlatb43;
mediump float u_xlat16_44;
mediump float u_xlat16_45;
float u_xlat48;
bool u_xlatb48;
float u_xlat51;
bool u_xlatb51;
float u_xlat55;
bool u_xlatb55;
float u_xlat58;
float u_xlat61;
float u_xlat62;
mediump float u_xlat16_63;
mediump float u_xlat16_64;
bool u_xlatb65;
float u_xlat67;
bool u_xlatb68;
float u_xlat70;
bool u_xlatb72;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(unity_LightPosition[1].w!=0.0);
#else
    u_xlatb0 = unity_LightPosition[1].w!=0.0;
#endif
    u_xlat19.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat19.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat19.xyz;
    u_xlat19.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat19.xyz;
    u_xlat19.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat19.xyz;
    u_xlat19.xyz = u_xlat19.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat19.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat19.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat19.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat19.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat19.xyz = u_xlat19.xyz + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat19.xyz) * unity_LightPosition[1].www + unity_LightPosition[1].xyz;
    u_xlat58 = dot(u_xlat1.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(unity_LightAtten[1].w<u_xlat58);
#else
    u_xlatb2 = unity_LightAtten[1].w<u_xlat58;
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb2;
    u_xlat2.x = unity_LightAtten[1].z * u_xlat58 + 1.0;
    u_xlat58 = max(u_xlat58, 9.99999997e-007);
    u_xlat58 = inversesqrt(u_xlat58);
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat2.x = u_xlat2.x * 0.5;
    u_xlat16_3.x = (u_xlatb0) ? 0.0 : u_xlat2.x;
    u_xlat2.xyz = vec3(u_xlat58) * u_xlat1.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat4.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat4.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat5.xyz;
    u_xlat4.z = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat16_22.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat16_22.x = max(u_xlat16_22.x, 0.0);
    u_xlat16_6.xyz = u_xlat16_22.xxx * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<u_xlat16_22.x);
#else
    u_xlatb0 = 0.0<u_xlat16_22.x;
#endif
    u_xlat16_22.xyz = u_xlat16_6.xyz * unity_LightColor[1].xyz;
    u_xlat16_22.xyz = u_xlat16_3.xxx * u_xlat16_22.xyz;
    u_xlat16_22.xyz = min(u_xlat16_22.xyz, vec3(1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(unity_LightPosition[0].w!=0.0);
#else
    u_xlatb2 = unity_LightPosition[0].w!=0.0;
#endif
    u_xlat21.xyz = (-u_xlat19.xyz) * unity_LightPosition[0].www + unity_LightPosition[0].xyz;
    u_xlat61 = dot(u_xlat21.xyz, u_xlat21.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(unity_LightAtten[0].w<u_xlat61);
#else
    u_xlatb5 = unity_LightAtten[0].w<u_xlat61;
#endif
    u_xlatb2 = u_xlatb2 && u_xlatb5;
    u_xlat5.x = unity_LightAtten[0].z * u_xlat61 + 1.0;
    u_xlat61 = max(u_xlat61, 9.99999997e-007);
    u_xlat61 = inversesqrt(u_xlat61);
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.5;
    u_xlat16_6.x = (u_xlatb2) ? 0.0 : u_xlat5.x;
    u_xlat5.xyz = u_xlat21.xyz * vec3(u_xlat61);
    u_xlat16_25.x = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat16_25.x = max(u_xlat16_25.x, 0.0);
    u_xlat16_7.xyz = u_xlat16_25.xxx * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<u_xlat16_25.x);
#else
    u_xlatb2 = 0.0<u_xlat16_25.x;
#endif
    u_xlat16_25.xyz = u_xlat16_7.xyz * unity_LightColor[0].xyz;
    u_xlat16_25.xyz = u_xlat16_6.xxx * u_xlat16_25.xyz;
    u_xlat16_25.xyz = min(u_xlat16_25.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_7.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + _Emission.xyz;
    u_xlat16_25.xyz = u_xlat16_25.xyz + u_xlat16_7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0<unity_VertexLightParams.x);
#else
    u_xlatb5 = 0<unity_VertexLightParams.x;
#endif
    u_xlat16_25.xyz = (bool(u_xlatb5)) ? u_xlat16_25.xyz : u_xlat16_7.xyz;
    u_xlat16_22.xyz = u_xlat16_22.xyz + u_xlat16_25.xyz;
    u_xlati24 = u_xlatb5 ? 1 : int(0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb43 = !!(u_xlati24<unity_VertexLightParams.x);
#else
    u_xlatb43 = u_xlati24<unity_VertexLightParams.x;
#endif
    u_xlati24 = (u_xlatb43) ? 2 : u_xlati24;
    u_xlat16_22.xyz = (bool(u_xlatb43)) ? u_xlat16_22.xyz : u_xlat16_25.xyz;
    u_xlat8.xyz = (-u_xlat19.xyz) * unity_LightPosition[2].www + unity_LightPosition[2].xyz;
    u_xlat62 = dot(u_xlat8.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb65 = !!(unity_LightAtten[2].w<u_xlat62);
#else
    u_xlatb65 = unity_LightAtten[2].w<u_xlat62;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightPosition[2].w!=0.0);
#else
    u_xlatb9 = unity_LightPosition[2].w!=0.0;
#endif
    u_xlatb65 = u_xlatb65 && u_xlatb9;
    u_xlat9.x = unity_LightAtten[2].z * u_xlat62 + 1.0;
    u_xlat62 = max(u_xlat62, 9.99999997e-007);
    u_xlat62 = inversesqrt(u_xlat62);
    u_xlat9.x = float(1.0) / u_xlat9.x;
    u_xlat9.x = u_xlat9.x * 0.5;
    u_xlat16_25.x = (u_xlatb65) ? 0.0 : u_xlat9.x;
    u_xlat9.xyz = vec3(u_xlat62) * u_xlat8.xyz;
    u_xlat16_44 = dot(u_xlat4.xyz, u_xlat9.xyz);
    u_xlat16_44 = max(u_xlat16_44, 0.0);
    u_xlat16_7.xyz = vec3(u_xlat16_44) * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb65 = !!(0.0<u_xlat16_44);
#else
    u_xlatb65 = 0.0<u_xlat16_44;
#endif
    u_xlat16_7.xyz = u_xlat16_7.xyz * unity_LightColor[2].xyz;
    u_xlat16_7.xyz = u_xlat16_25.xxx * u_xlat16_7.xyz;
    u_xlat16_7.xyz = min(u_xlat16_7.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_7.xyz = u_xlat16_22.xyz + u_xlat16_7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlati24<unity_VertexLightParams.x);
#else
    u_xlatb9 = u_xlati24<unity_VertexLightParams.x;
#endif
    u_xlatb9 = u_xlatb43 && u_xlatb9;
    u_xlat16_22.xyz = (bool(u_xlatb9)) ? u_xlat16_7.xyz : u_xlat16_22.xyz;
    u_xlat28.xyz = (-u_xlat19.xyz) * unity_LightPosition[3].www + unity_LightPosition[3].xyz;
    u_xlat10 = dot(u_xlat28.xyz, u_xlat28.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb29 = !!(unity_LightAtten[3].w<u_xlat10);
#else
    u_xlatb29 = unity_LightAtten[3].w<u_xlat10;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb48 = !!(unity_LightPosition[3].w!=0.0);
#else
    u_xlatb48 = unity_LightPosition[3].w!=0.0;
#endif
    u_xlatb29 = u_xlatb29 && u_xlatb48;
    u_xlat48 = unity_LightAtten[3].z * u_xlat10 + 1.0;
    u_xlat10 = max(u_xlat10, 9.99999997e-007);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat48 = float(1.0) / u_xlat48;
    u_xlat48 = u_xlat48 * 0.5;
    u_xlat16_44 = (u_xlatb29) ? 0.0 : u_xlat48;
    u_xlat29.xyz = u_xlat28.xyz * vec3(u_xlat10);
    u_xlat16_63 = dot(u_xlat4.xyz, u_xlat29.xyz);
    u_xlat16_63 = max(u_xlat16_63, 0.0);
    u_xlat16_7.xyz = vec3(u_xlat16_63) * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb29 = !!(0.0<u_xlat16_63);
#else
    u_xlatb29 = 0.0<u_xlat16_63;
#endif
    u_xlat16_7.xyz = u_xlat16_7.xyz * unity_LightColor[3].xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_44) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = min(u_xlat16_7.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_7.xyz = u_xlat16_22.xyz + u_xlat16_7.xyz;
    u_xlati24 = (u_xlatb9) ? 3 : u_xlati24;
#ifdef UNITY_ADRENO_ES3
    u_xlatb48 = !!(u_xlati24<unity_VertexLightParams.x);
#else
    u_xlatb48 = u_xlati24<unity_VertexLightParams.x;
#endif
    u_xlatb48 = u_xlatb9 && u_xlatb48;
    u_xlat16_22.xyz = (bool(u_xlatb48)) ? u_xlat16_7.xyz : u_xlat16_22.xyz;
    u_xlat11.xyz = (-u_xlat19.xyz) * unity_LightPosition[4].www + unity_LightPosition[4].xyz;
    u_xlat67 = dot(u_xlat11.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb68 = !!(unity_LightAtten[4].w<u_xlat67);
#else
    u_xlatb68 = unity_LightAtten[4].w<u_xlat67;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(unity_LightPosition[4].w!=0.0);
#else
    u_xlatb12 = unity_LightPosition[4].w!=0.0;
#endif
    u_xlatb68 = u_xlatb68 && u_xlatb12;
    u_xlat12.x = unity_LightAtten[4].z * u_xlat67 + 1.0;
    u_xlat67 = max(u_xlat67, 9.99999997e-007);
    u_xlat67 = inversesqrt(u_xlat67);
    u_xlat12.x = float(1.0) / u_xlat12.x;
    u_xlat12.x = u_xlat12.x * 0.5;
    u_xlat16_63 = (u_xlatb68) ? 0.0 : u_xlat12.x;
    u_xlat12.xyz = vec3(u_xlat67) * u_xlat11.xyz;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat12.xyz);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlat16_26.xyz = u_xlat16_7.xxx * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb68 = !!(0.0<u_xlat16_7.x);
#else
    u_xlatb68 = 0.0<u_xlat16_7.x;
#endif
    u_xlat16_7.xyz = u_xlat16_26.xyz * unity_LightColor[4].xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_63) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = min(u_xlat16_7.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_7.xyz = u_xlat16_22.xyz + u_xlat16_7.xyz;
    u_xlati24 = (u_xlatb48) ? 4 : u_xlati24;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlati24<unity_VertexLightParams.x);
#else
    u_xlatb12 = u_xlati24<unity_VertexLightParams.x;
#endif
    u_xlatb12 = u_xlatb48 && u_xlatb12;
    u_xlat16_22.xyz = (bool(u_xlatb12)) ? u_xlat16_7.xyz : u_xlat16_22.xyz;
    u_xlat31.xyz = (-u_xlat19.xyz) * unity_LightPosition[5].www + unity_LightPosition[5].xyz;
    u_xlat13 = dot(u_xlat31.xyz, u_xlat31.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb32 = !!(unity_LightAtten[5].w<u_xlat13);
#else
    u_xlatb32 = unity_LightAtten[5].w<u_xlat13;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb51 = !!(unity_LightPosition[5].w!=0.0);
#else
    u_xlatb51 = unity_LightPosition[5].w!=0.0;
#endif
    u_xlatb32 = u_xlatb32 && u_xlatb51;
    u_xlat51 = unity_LightAtten[5].z * u_xlat13 + 1.0;
    u_xlat13 = max(u_xlat13, 9.99999997e-007);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat51 = float(1.0) / u_xlat51;
    u_xlat51 = u_xlat51 * 0.5;
    u_xlat16_7.x = (u_xlatb32) ? 0.0 : u_xlat51;
    u_xlat32.xyz = u_xlat31.xyz * vec3(u_xlat13);
    u_xlat16_26.x = dot(u_xlat4.xyz, u_xlat32.xyz);
    u_xlat16_26.x = max(u_xlat16_26.x, 0.0);
    u_xlat16_14.xyz = u_xlat16_26.xxx * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb32 = !!(0.0<u_xlat16_26.x);
#else
    u_xlatb32 = 0.0<u_xlat16_26.x;
#endif
    u_xlat16_26.xyz = u_xlat16_14.xyz * unity_LightColor[5].xyz;
    u_xlat16_26.xyz = u_xlat16_7.xxx * u_xlat16_26.xyz;
    u_xlat16_26.xyz = min(u_xlat16_26.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_26.xyz = u_xlat16_22.xyz + u_xlat16_26.xyz;
    u_xlati24 = (u_xlatb12) ? 5 : u_xlati24;
#ifdef UNITY_ADRENO_ES3
    u_xlatb51 = !!(u_xlati24<unity_VertexLightParams.x);
#else
    u_xlatb51 = u_xlati24<unity_VertexLightParams.x;
#endif
    u_xlatb51 = u_xlatb12 && u_xlatb51;
    u_xlat16_22.xyz = (bool(u_xlatb51)) ? u_xlat16_26.xyz : u_xlat16_22.xyz;
    u_xlat15.xyz = (-u_xlat19.xyz) * unity_LightPosition[6].www + unity_LightPosition[6].xyz;
    u_xlat70 = dot(u_xlat15.xyz, u_xlat15.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb72 = !!(unity_LightAtten[6].w<u_xlat70);
#else
    u_xlatb72 = unity_LightAtten[6].w<u_xlat70;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(unity_LightPosition[6].w!=0.0);
#else
    u_xlatb16 = unity_LightPosition[6].w!=0.0;
#endif
    u_xlatb72 = u_xlatb72 && u_xlatb16;
    u_xlat16.x = unity_LightAtten[6].z * u_xlat70 + 1.0;
    u_xlat70 = max(u_xlat70, 9.99999997e-007);
    u_xlat70 = inversesqrt(u_xlat70);
    u_xlat16.x = float(1.0) / u_xlat16.x;
    u_xlat16.x = u_xlat16.x * 0.5;
    u_xlat16_26.x = (u_xlatb72) ? 0.0 : u_xlat16.x;
    u_xlat16.xyz = vec3(u_xlat70) * u_xlat15.xyz;
    u_xlat16_45 = dot(u_xlat4.xyz, u_xlat16.xyz);
    u_xlat16_45 = max(u_xlat16_45, 0.0);
    u_xlat16_14.xyz = vec3(u_xlat16_45) * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb72 = !!(0.0<u_xlat16_45);
#else
    u_xlatb72 = 0.0<u_xlat16_45;
#endif
    u_xlat16_14.xyz = u_xlat16_14.xyz * unity_LightColor[6].xyz;
    u_xlat16_14.xyz = u_xlat16_26.xxx * u_xlat16_14.xyz;
    u_xlat16_14.xyz = min(u_xlat16_14.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_14.xyz = u_xlat16_22.xyz + u_xlat16_14.xyz;
    u_xlati24 = (u_xlatb51) ? 6 : u_xlati24;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlati24<unity_VertexLightParams.x);
#else
    u_xlatb16 = u_xlati24<unity_VertexLightParams.x;
#endif
    u_xlatb16 = u_xlatb51 && u_xlatb16;
    u_xlat16_22.xyz = (bool(u_xlatb16)) ? u_xlat16_14.xyz : u_xlat16_22.xyz;
    u_xlat35.xyz = (-u_xlat19.xyz) * unity_LightPosition[7].www + unity_LightPosition[7].xyz;
    u_xlat17 = dot(u_xlat35.xyz, u_xlat35.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(unity_LightAtten[7].w<u_xlat17);
#else
    u_xlatb36 = unity_LightAtten[7].w<u_xlat17;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb55 = !!(unity_LightPosition[7].w!=0.0);
#else
    u_xlatb55 = unity_LightPosition[7].w!=0.0;
#endif
    u_xlatb36 = u_xlatb36 && u_xlatb55;
    u_xlat55 = unity_LightAtten[7].z * u_xlat17 + 1.0;
    u_xlat17 = max(u_xlat17, 9.99999997e-007);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat55 = float(1.0) / u_xlat55;
    u_xlat55 = u_xlat55 * 0.5;
    u_xlat16_45 = (u_xlatb36) ? 0.0 : u_xlat55;
    u_xlat36.xyz = u_xlat35.xyz * vec3(u_xlat17);
    u_xlat16_64 = dot(u_xlat4.xyz, u_xlat36.xyz);
    u_xlat16_64 = max(u_xlat16_64, 0.0);
    u_xlat16_14.xyz = vec3(u_xlat16_64) * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(0.0<u_xlat16_64);
#else
    u_xlatb36 = 0.0<u_xlat16_64;
#endif
    u_xlat16_14.xyz = u_xlat16_14.xyz * unity_LightColor[7].xyz;
    u_xlat16_14.xyz = vec3(u_xlat16_45) * u_xlat16_14.xyz;
    u_xlat16_14.xyz = min(u_xlat16_14.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_14.xyz = u_xlat16_22.xyz + u_xlat16_14.xyz;
    u_xlati24 = (u_xlatb16) ? 7 : u_xlati24;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlati24<unity_VertexLightParams.x);
#else
    u_xlatb24 = u_xlati24<unity_VertexLightParams.x;
#endif
    u_xlatb24 = u_xlatb24 && u_xlatb16;
    vs_COLOR0.xyz = (bool(u_xlatb24)) ? u_xlat16_14.xyz : u_xlat16_22.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
    u_xlat55 = dot(u_xlat19.xyz, u_xlat19.xyz);
    u_xlat55 = inversesqrt(u_xlat55);
    u_xlat19.xyz = u_xlat19.xyz * vec3(u_xlat55);
    u_xlat16_22.xyz = u_xlat21.xyz * vec3(u_xlat61) + (-u_xlat19.xyz);
    u_xlat16_64 = dot(u_xlat16_22.xyz, u_xlat16_22.xyz);
    u_xlat16_64 = inversesqrt(u_xlat16_64);
    u_xlat16_22.xyz = u_xlat16_22.xyz * vec3(u_xlat16_64);
    u_xlat16_22.x = dot(u_xlat4.xyz, u_xlat16_22.xyz);
    u_xlat16_22.x = max(u_xlat16_22.x, 0.0);
    u_xlat16_22.x = log2(u_xlat16_22.x);
    u_xlat16_41 = _Shininess * 128.0;
    u_xlat16_22.x = u_xlat16_22.x * u_xlat16_41;
    u_xlat16_22.x = exp2(u_xlat16_22.x);
    u_xlat16_22.x = min(u_xlat16_22.x, 1.0);
    u_xlat16_22.x = u_xlat16_22.x * u_xlat16_6.x;
    u_xlat16_14.xyz = u_xlat16_22.xxx * unity_LightColor[0].xyz;
    u_xlat16_14.xyz = (bool(u_xlatb2)) ? u_xlat16_14.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_14.xyz = (bool(u_xlatb5)) ? u_xlat16_14.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_18.xyz = u_xlat1.xyz * vec3(u_xlat58) + (-u_xlat19.xyz);
    u_xlat16_22.x = dot(u_xlat16_18.xyz, u_xlat16_18.xyz);
    u_xlat16_22.x = inversesqrt(u_xlat16_22.x);
    u_xlat16_18.xyz = u_xlat16_22.xxx * u_xlat16_18.xyz;
    u_xlat16_22.x = dot(u_xlat4.xyz, u_xlat16_18.xyz);
    u_xlat16_22.x = max(u_xlat16_22.x, 0.0);
    u_xlat16_22.x = log2(u_xlat16_22.x);
    u_xlat16_22.x = u_xlat16_22.x * u_xlat16_41;
    u_xlat16_22.x = exp2(u_xlat16_22.x);
    u_xlat16_22.x = min(u_xlat16_22.x, 1.0);
    u_xlat16_3.x = u_xlat16_22.x * u_xlat16_3.x;
    u_xlat16_3.xyw = u_xlat16_3.xxx * unity_LightColor[1].xyz + u_xlat16_14.xyz;
    u_xlat16_3.xyw = (bool(u_xlatb0)) ? u_xlat16_3.xyw : u_xlat16_14.xyz;
    u_xlat16_3.xyw = (bool(u_xlatb43)) ? u_xlat16_3.xyw : u_xlat16_14.xyz;
    u_xlat16_14.xyz = u_xlat8.xyz * vec3(u_xlat62) + (-u_xlat19.xyz);
    u_xlat16_6.x = dot(u_xlat16_14.xyz, u_xlat16_14.xyz);
    u_xlat16_6.x = inversesqrt(u_xlat16_6.x);
    u_xlat16_14.xyz = u_xlat16_6.xxx * u_xlat16_14.xyz;
    u_xlat16_6.x = dot(u_xlat4.xyz, u_xlat16_14.xyz);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlat16_6.x = log2(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_41 * u_xlat16_6.x;
    u_xlat16_6.x = exp2(u_xlat16_6.x);
    u_xlat16_6.x = min(u_xlat16_6.x, 1.0);
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_25.x;
    u_xlat16_14.xyz = u_xlat16_6.xxx * unity_LightColor[2].xyz + u_xlat16_3.xyw;
    u_xlat16_14.xyz = (bool(u_xlatb65)) ? u_xlat16_14.xyz : u_xlat16_3.xyw;
    u_xlat16_3.xyw = (bool(u_xlatb9)) ? u_xlat16_14.xyz : u_xlat16_3.xyw;
    u_xlat16_14.xyz = u_xlat28.xyz * vec3(u_xlat10) + (-u_xlat19.xyz);
    u_xlat16_6.x = dot(u_xlat16_14.xyz, u_xlat16_14.xyz);
    u_xlat16_6.x = inversesqrt(u_xlat16_6.x);
    u_xlat16_14.xyz = u_xlat16_6.xxx * u_xlat16_14.xyz;
    u_xlat16_6.x = dot(u_xlat4.xyz, u_xlat16_14.xyz);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlat16_6.x = log2(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_41 * u_xlat16_6.x;
    u_xlat16_6.x = exp2(u_xlat16_6.x);
    u_xlat16_6.x = min(u_xlat16_6.x, 1.0);
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_44;
    u_xlat16_6.xyz = u_xlat16_6.xxx * unity_LightColor[3].xyz + u_xlat16_3.xyw;
    u_xlat16_6.xyz = (bool(u_xlatb29)) ? u_xlat16_6.xyz : u_xlat16_3.xyw;
    u_xlat16_3.xyw = (bool(u_xlatb48)) ? u_xlat16_6.xyz : u_xlat16_3.xyw;
    u_xlat16_6.xyz = u_xlat11.xyz * vec3(u_xlat67) + (-u_xlat19.xyz);
    u_xlat16_64 = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
    u_xlat16_64 = inversesqrt(u_xlat16_64);
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(u_xlat16_64);
    u_xlat16_6.x = dot(u_xlat4.xyz, u_xlat16_6.xyz);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlat16_6.x = log2(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_41 * u_xlat16_6.x;
    u_xlat16_6.x = exp2(u_xlat16_6.x);
    u_xlat16_6.x = min(u_xlat16_6.x, 1.0);
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_63;
    u_xlat16_6.xyz = u_xlat16_6.xxx * unity_LightColor[4].xyz + u_xlat16_3.xyw;
    u_xlat16_6.xyz = (bool(u_xlatb68)) ? u_xlat16_6.xyz : u_xlat16_3.xyw;
    u_xlat16_3.xyw = (bool(u_xlatb12)) ? u_xlat16_6.xyz : u_xlat16_3.xyw;
    u_xlat16_6.xyz = u_xlat31.xyz * vec3(u_xlat13) + (-u_xlat19.xyz);
    u_xlat16_63 = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
    u_xlat16_63 = inversesqrt(u_xlat16_63);
    u_xlat16_6.xyz = vec3(u_xlat16_63) * u_xlat16_6.xyz;
    u_xlat16_6.x = dot(u_xlat4.xyz, u_xlat16_6.xyz);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlat16_6.x = log2(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_41 * u_xlat16_6.x;
    u_xlat16_6.x = exp2(u_xlat16_6.x);
    u_xlat16_6.x = min(u_xlat16_6.x, 1.0);
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_7.x;
    u_xlat16_6.xyz = u_xlat16_6.xxx * unity_LightColor[5].xyz + u_xlat16_3.xyw;
    u_xlat16_6.xyz = (bool(u_xlatb32)) ? u_xlat16_6.xyz : u_xlat16_3.xyw;
    u_xlat16_3.xyw = (bool(u_xlatb51)) ? u_xlat16_6.xyz : u_xlat16_3.xyw;
    u_xlat16_6.xyz = u_xlat15.xyz * vec3(u_xlat70) + (-u_xlat19.xyz);
    u_xlat16_14.xyz = u_xlat35.xyz * vec3(u_xlat17) + (-u_xlat19.xyz);
    u_xlat16_63 = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
    u_xlat16_63 = inversesqrt(u_xlat16_63);
    u_xlat16_6.xyz = vec3(u_xlat16_63) * u_xlat16_6.xyz;
    u_xlat16_6.x = dot(u_xlat4.xyz, u_xlat16_6.xyz);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlat16_6.x = log2(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_41 * u_xlat16_6.x;
    u_xlat16_6.x = exp2(u_xlat16_6.x);
    u_xlat16_6.x = min(u_xlat16_6.x, 1.0);
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_26.x;
    u_xlat16_6.xyz = u_xlat16_6.xxx * unity_LightColor[6].xyz + u_xlat16_3.xyw;
    u_xlat16_6.xyz = (bool(u_xlatb72)) ? u_xlat16_6.xyz : u_xlat16_3.xyw;
    u_xlat16_3.xyw = (bool(u_xlatb16)) ? u_xlat16_6.xyz : u_xlat16_3.xyw;
    u_xlat16_6.x = dot(u_xlat16_14.xyz, u_xlat16_14.xyz);
    u_xlat16_6.x = inversesqrt(u_xlat16_6.x);
    u_xlat16_6.xyz = u_xlat16_6.xxx * u_xlat16_14.xyz;
    u_xlat16_6.x = dot(u_xlat4.xyz, u_xlat16_6.xyz);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlat16_6.x = log2(u_xlat16_6.x);
    u_xlat16_41 = u_xlat16_41 * u_xlat16_6.x;
    u_xlat16_41 = exp2(u_xlat16_41);
    u_xlat16_41 = min(u_xlat16_41, 1.0);
    u_xlat16_41 = u_xlat16_41 * u_xlat16_45;
    u_xlat16_6.xyz = vec3(u_xlat16_41) * unity_LightColor[7].xyz + u_xlat16_3.xyw;
    u_xlat16_6.xyz = (bool(u_xlatb36)) ? u_xlat16_6.xyz : u_xlat16_3.xyw;
    u_xlat16_3.xyz = (bool(u_xlatb24)) ? u_xlat16_6.xyz : u_xlat16_3.xyw;
    vs_COLOR1.xyz = u_xlat16_3.xyz * _SpecColor.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR1.xyz = min(max(vs_COLOR1.xyz, 0.0), 1.0);
#else
    vs_COLOR1.xyz = clamp(vs_COLOR1.xyz, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_COLOR1;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vs_COLOR1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec4 _Emission;
uniform 	mediump float _Shininess;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_COLOR1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
bool u_xlatb0;
vec4 u_xlat1;
vec3 u_xlat2;
bool u_xlatb2;
mediump vec4 u_xlat16_3;
vec3 u_xlat4;
vec3 u_xlat5;
bool u_xlatb5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
vec3 u_xlat8;
vec3 u_xlat9;
bool u_xlatb9;
float u_xlat10;
vec3 u_xlat11;
vec3 u_xlat12;
bool u_xlatb12;
float u_xlat13;
mediump vec3 u_xlat16_14;
vec3 u_xlat15;
vec3 u_xlat16;
bool u_xlatb16;
float u_xlat17;
mediump vec3 u_xlat16_18;
vec3 u_xlat19;
vec3 u_xlat21;
mediump vec3 u_xlat16_22;
int u_xlati24;
bool u_xlatb24;
mediump vec3 u_xlat16_25;
mediump vec3 u_xlat16_26;
vec3 u_xlat28;
vec3 u_xlat29;
bool u_xlatb29;
vec3 u_xlat31;
vec3 u_xlat32;
bool u_xlatb32;
vec3 u_xlat35;
vec3 u_xlat36;
bool u_xlatb36;
mediump float u_xlat16_41;
bool u_xlatb43;
mediump float u_xlat16_44;
mediump float u_xlat16_45;
float u_xlat48;
bool u_xlatb48;
float u_xlat51;
bool u_xlatb51;
float u_xlat55;
bool u_xlatb55;
float u_xlat58;
float u_xlat61;
float u_xlat62;
mediump float u_xlat16_63;
mediump float u_xlat16_64;
bool u_xlatb65;
float u_xlat67;
bool u_xlatb68;
float u_xlat70;
bool u_xlatb72;
void main()
{
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(unity_LightPosition[1].w!=0.0);
#else
    u_xlatb0 = unity_LightPosition[1].w!=0.0;
#endif
    u_xlat19.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat19.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat19.xyz;
    u_xlat19.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat19.xyz;
    u_xlat19.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat19.xyz;
    u_xlat19.xyz = u_xlat19.xyz * in_POSITION0.yyy;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat1.xyz;
    u_xlat19.xyz = u_xlat1.xyz * in_POSITION0.xxx + u_xlat19.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat1.xyz;
    u_xlat19.xyz = u_xlat1.xyz * in_POSITION0.zzz + u_xlat19.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat1.xyz;
    u_xlat19.xyz = u_xlat19.xyz + u_xlat1.xyz;
    u_xlat1.xyz = (-u_xlat19.xyz) * unity_LightPosition[1].www + unity_LightPosition[1].xyz;
    u_xlat58 = dot(u_xlat1.xyz, u_xlat1.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(unity_LightAtten[1].w<u_xlat58);
#else
    u_xlatb2 = unity_LightAtten[1].w<u_xlat58;
#endif
    u_xlatb0 = u_xlatb0 && u_xlatb2;
    u_xlat2.x = unity_LightAtten[1].z * u_xlat58 + 1.0;
    u_xlat58 = max(u_xlat58, 9.99999997e-007);
    u_xlat58 = inversesqrt(u_xlat58);
    u_xlat2.x = float(1.0) / u_xlat2.x;
    u_xlat2.x = u_xlat2.x * 0.5;
    u_xlat16_3.x = (u_xlatb0) ? 0.0 : u_xlat2.x;
    u_xlat2.xyz = vec3(u_xlat58) * u_xlat1.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat4.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat4.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat5.xyz;
    u_xlat4.z = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat0.x = dot(u_xlat4.xyz, u_xlat4.xyz);
    u_xlat0.x = inversesqrt(u_xlat0.x);
    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
    u_xlat16_22.x = dot(u_xlat4.xyz, u_xlat2.xyz);
    u_xlat16_22.x = max(u_xlat16_22.x, 0.0);
    u_xlat16_6.xyz = u_xlat16_22.xxx * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(0.0<u_xlat16_22.x);
#else
    u_xlatb0 = 0.0<u_xlat16_22.x;
#endif
    u_xlat16_22.xyz = u_xlat16_6.xyz * unity_LightColor[1].xyz;
    u_xlat16_22.xyz = u_xlat16_3.xxx * u_xlat16_22.xyz;
    u_xlat16_22.xyz = min(u_xlat16_22.xyz, vec3(1.0, 1.0, 1.0));
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(unity_LightPosition[0].w!=0.0);
#else
    u_xlatb2 = unity_LightPosition[0].w!=0.0;
#endif
    u_xlat21.xyz = (-u_xlat19.xyz) * unity_LightPosition[0].www + unity_LightPosition[0].xyz;
    u_xlat61 = dot(u_xlat21.xyz, u_xlat21.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(unity_LightAtten[0].w<u_xlat61);
#else
    u_xlatb5 = unity_LightAtten[0].w<u_xlat61;
#endif
    u_xlatb2 = u_xlatb2 && u_xlatb5;
    u_xlat5.x = unity_LightAtten[0].z * u_xlat61 + 1.0;
    u_xlat61 = max(u_xlat61, 9.99999997e-007);
    u_xlat61 = inversesqrt(u_xlat61);
    u_xlat5.x = float(1.0) / u_xlat5.x;
    u_xlat5.x = u_xlat5.x * 0.5;
    u_xlat16_6.x = (u_xlatb2) ? 0.0 : u_xlat5.x;
    u_xlat5.xyz = u_xlat21.xyz * vec3(u_xlat61);
    u_xlat16_25.x = dot(u_xlat4.xyz, u_xlat5.xyz);
    u_xlat16_25.x = max(u_xlat16_25.x, 0.0);
    u_xlat16_7.xyz = u_xlat16_25.xxx * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb2 = !!(0.0<u_xlat16_25.x);
#else
    u_xlatb2 = 0.0<u_xlat16_25.x;
#endif
    u_xlat16_25.xyz = u_xlat16_7.xyz * unity_LightColor[0].xyz;
    u_xlat16_25.xyz = u_xlat16_6.xxx * u_xlat16_25.xyz;
    u_xlat16_25.xyz = min(u_xlat16_25.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_7.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + _Emission.xyz;
    u_xlat16_25.xyz = u_xlat16_25.xyz + u_xlat16_7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb5 = !!(0<unity_VertexLightParams.x);
#else
    u_xlatb5 = 0<unity_VertexLightParams.x;
#endif
    u_xlat16_25.xyz = (bool(u_xlatb5)) ? u_xlat16_25.xyz : u_xlat16_7.xyz;
    u_xlat16_22.xyz = u_xlat16_22.xyz + u_xlat16_25.xyz;
    u_xlati24 = u_xlatb5 ? 1 : int(0);
#ifdef UNITY_ADRENO_ES3
    u_xlatb43 = !!(u_xlati24<unity_VertexLightParams.x);
#else
    u_xlatb43 = u_xlati24<unity_VertexLightParams.x;
#endif
    u_xlati24 = (u_xlatb43) ? 2 : u_xlati24;
    u_xlat16_22.xyz = (bool(u_xlatb43)) ? u_xlat16_22.xyz : u_xlat16_25.xyz;
    u_xlat8.xyz = (-u_xlat19.xyz) * unity_LightPosition[2].www + unity_LightPosition[2].xyz;
    u_xlat62 = dot(u_xlat8.xyz, u_xlat8.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb65 = !!(unity_LightAtten[2].w<u_xlat62);
#else
    u_xlatb65 = unity_LightAtten[2].w<u_xlat62;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightPosition[2].w!=0.0);
#else
    u_xlatb9 = unity_LightPosition[2].w!=0.0;
#endif
    u_xlatb65 = u_xlatb65 && u_xlatb9;
    u_xlat9.x = unity_LightAtten[2].z * u_xlat62 + 1.0;
    u_xlat62 = max(u_xlat62, 9.99999997e-007);
    u_xlat62 = inversesqrt(u_xlat62);
    u_xlat9.x = float(1.0) / u_xlat9.x;
    u_xlat9.x = u_xlat9.x * 0.5;
    u_xlat16_25.x = (u_xlatb65) ? 0.0 : u_xlat9.x;
    u_xlat9.xyz = vec3(u_xlat62) * u_xlat8.xyz;
    u_xlat16_44 = dot(u_xlat4.xyz, u_xlat9.xyz);
    u_xlat16_44 = max(u_xlat16_44, 0.0);
    u_xlat16_7.xyz = vec3(u_xlat16_44) * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb65 = !!(0.0<u_xlat16_44);
#else
    u_xlatb65 = 0.0<u_xlat16_44;
#endif
    u_xlat16_7.xyz = u_xlat16_7.xyz * unity_LightColor[2].xyz;
    u_xlat16_7.xyz = u_xlat16_25.xxx * u_xlat16_7.xyz;
    u_xlat16_7.xyz = min(u_xlat16_7.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_7.xyz = u_xlat16_22.xyz + u_xlat16_7.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlati24<unity_VertexLightParams.x);
#else
    u_xlatb9 = u_xlati24<unity_VertexLightParams.x;
#endif
    u_xlatb9 = u_xlatb43 && u_xlatb9;
    u_xlat16_22.xyz = (bool(u_xlatb9)) ? u_xlat16_7.xyz : u_xlat16_22.xyz;
    u_xlat28.xyz = (-u_xlat19.xyz) * unity_LightPosition[3].www + unity_LightPosition[3].xyz;
    u_xlat10 = dot(u_xlat28.xyz, u_xlat28.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb29 = !!(unity_LightAtten[3].w<u_xlat10);
#else
    u_xlatb29 = unity_LightAtten[3].w<u_xlat10;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb48 = !!(unity_LightPosition[3].w!=0.0);
#else
    u_xlatb48 = unity_LightPosition[3].w!=0.0;
#endif
    u_xlatb29 = u_xlatb29 && u_xlatb48;
    u_xlat48 = unity_LightAtten[3].z * u_xlat10 + 1.0;
    u_xlat10 = max(u_xlat10, 9.99999997e-007);
    u_xlat10 = inversesqrt(u_xlat10);
    u_xlat48 = float(1.0) / u_xlat48;
    u_xlat48 = u_xlat48 * 0.5;
    u_xlat16_44 = (u_xlatb29) ? 0.0 : u_xlat48;
    u_xlat29.xyz = u_xlat28.xyz * vec3(u_xlat10);
    u_xlat16_63 = dot(u_xlat4.xyz, u_xlat29.xyz);
    u_xlat16_63 = max(u_xlat16_63, 0.0);
    u_xlat16_7.xyz = vec3(u_xlat16_63) * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb29 = !!(0.0<u_xlat16_63);
#else
    u_xlatb29 = 0.0<u_xlat16_63;
#endif
    u_xlat16_7.xyz = u_xlat16_7.xyz * unity_LightColor[3].xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_44) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = min(u_xlat16_7.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_7.xyz = u_xlat16_22.xyz + u_xlat16_7.xyz;
    u_xlati24 = (u_xlatb9) ? 3 : u_xlati24;
#ifdef UNITY_ADRENO_ES3
    u_xlatb48 = !!(u_xlati24<unity_VertexLightParams.x);
#else
    u_xlatb48 = u_xlati24<unity_VertexLightParams.x;
#endif
    u_xlatb48 = u_xlatb9 && u_xlatb48;
    u_xlat16_22.xyz = (bool(u_xlatb48)) ? u_xlat16_7.xyz : u_xlat16_22.xyz;
    u_xlat11.xyz = (-u_xlat19.xyz) * unity_LightPosition[4].www + unity_LightPosition[4].xyz;
    u_xlat67 = dot(u_xlat11.xyz, u_xlat11.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb68 = !!(unity_LightAtten[4].w<u_xlat67);
#else
    u_xlatb68 = unity_LightAtten[4].w<u_xlat67;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(unity_LightPosition[4].w!=0.0);
#else
    u_xlatb12 = unity_LightPosition[4].w!=0.0;
#endif
    u_xlatb68 = u_xlatb68 && u_xlatb12;
    u_xlat12.x = unity_LightAtten[4].z * u_xlat67 + 1.0;
    u_xlat67 = max(u_xlat67, 9.99999997e-007);
    u_xlat67 = inversesqrt(u_xlat67);
    u_xlat12.x = float(1.0) / u_xlat12.x;
    u_xlat12.x = u_xlat12.x * 0.5;
    u_xlat16_63 = (u_xlatb68) ? 0.0 : u_xlat12.x;
    u_xlat12.xyz = vec3(u_xlat67) * u_xlat11.xyz;
    u_xlat16_7.x = dot(u_xlat4.xyz, u_xlat12.xyz);
    u_xlat16_7.x = max(u_xlat16_7.x, 0.0);
    u_xlat16_26.xyz = u_xlat16_7.xxx * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb68 = !!(0.0<u_xlat16_7.x);
#else
    u_xlatb68 = 0.0<u_xlat16_7.x;
#endif
    u_xlat16_7.xyz = u_xlat16_26.xyz * unity_LightColor[4].xyz;
    u_xlat16_7.xyz = vec3(u_xlat16_63) * u_xlat16_7.xyz;
    u_xlat16_7.xyz = min(u_xlat16_7.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_7.xyz = u_xlat16_22.xyz + u_xlat16_7.xyz;
    u_xlati24 = (u_xlatb48) ? 4 : u_xlati24;
#ifdef UNITY_ADRENO_ES3
    u_xlatb12 = !!(u_xlati24<unity_VertexLightParams.x);
#else
    u_xlatb12 = u_xlati24<unity_VertexLightParams.x;
#endif
    u_xlatb12 = u_xlatb48 && u_xlatb12;
    u_xlat16_22.xyz = (bool(u_xlatb12)) ? u_xlat16_7.xyz : u_xlat16_22.xyz;
    u_xlat31.xyz = (-u_xlat19.xyz) * unity_LightPosition[5].www + unity_LightPosition[5].xyz;
    u_xlat13 = dot(u_xlat31.xyz, u_xlat31.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb32 = !!(unity_LightAtten[5].w<u_xlat13);
#else
    u_xlatb32 = unity_LightAtten[5].w<u_xlat13;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb51 = !!(unity_LightPosition[5].w!=0.0);
#else
    u_xlatb51 = unity_LightPosition[5].w!=0.0;
#endif
    u_xlatb32 = u_xlatb32 && u_xlatb51;
    u_xlat51 = unity_LightAtten[5].z * u_xlat13 + 1.0;
    u_xlat13 = max(u_xlat13, 9.99999997e-007);
    u_xlat13 = inversesqrt(u_xlat13);
    u_xlat51 = float(1.0) / u_xlat51;
    u_xlat51 = u_xlat51 * 0.5;
    u_xlat16_7.x = (u_xlatb32) ? 0.0 : u_xlat51;
    u_xlat32.xyz = u_xlat31.xyz * vec3(u_xlat13);
    u_xlat16_26.x = dot(u_xlat4.xyz, u_xlat32.xyz);
    u_xlat16_26.x = max(u_xlat16_26.x, 0.0);
    u_xlat16_14.xyz = u_xlat16_26.xxx * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb32 = !!(0.0<u_xlat16_26.x);
#else
    u_xlatb32 = 0.0<u_xlat16_26.x;
#endif
    u_xlat16_26.xyz = u_xlat16_14.xyz * unity_LightColor[5].xyz;
    u_xlat16_26.xyz = u_xlat16_7.xxx * u_xlat16_26.xyz;
    u_xlat16_26.xyz = min(u_xlat16_26.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_26.xyz = u_xlat16_22.xyz + u_xlat16_26.xyz;
    u_xlati24 = (u_xlatb12) ? 5 : u_xlati24;
#ifdef UNITY_ADRENO_ES3
    u_xlatb51 = !!(u_xlati24<unity_VertexLightParams.x);
#else
    u_xlatb51 = u_xlati24<unity_VertexLightParams.x;
#endif
    u_xlatb51 = u_xlatb12 && u_xlatb51;
    u_xlat16_22.xyz = (bool(u_xlatb51)) ? u_xlat16_26.xyz : u_xlat16_22.xyz;
    u_xlat15.xyz = (-u_xlat19.xyz) * unity_LightPosition[6].www + unity_LightPosition[6].xyz;
    u_xlat70 = dot(u_xlat15.xyz, u_xlat15.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb72 = !!(unity_LightAtten[6].w<u_xlat70);
#else
    u_xlatb72 = unity_LightAtten[6].w<u_xlat70;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(unity_LightPosition[6].w!=0.0);
#else
    u_xlatb16 = unity_LightPosition[6].w!=0.0;
#endif
    u_xlatb72 = u_xlatb72 && u_xlatb16;
    u_xlat16.x = unity_LightAtten[6].z * u_xlat70 + 1.0;
    u_xlat70 = max(u_xlat70, 9.99999997e-007);
    u_xlat70 = inversesqrt(u_xlat70);
    u_xlat16.x = float(1.0) / u_xlat16.x;
    u_xlat16.x = u_xlat16.x * 0.5;
    u_xlat16_26.x = (u_xlatb72) ? 0.0 : u_xlat16.x;
    u_xlat16.xyz = vec3(u_xlat70) * u_xlat15.xyz;
    u_xlat16_45 = dot(u_xlat4.xyz, u_xlat16.xyz);
    u_xlat16_45 = max(u_xlat16_45, 0.0);
    u_xlat16_14.xyz = vec3(u_xlat16_45) * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb72 = !!(0.0<u_xlat16_45);
#else
    u_xlatb72 = 0.0<u_xlat16_45;
#endif
    u_xlat16_14.xyz = u_xlat16_14.xyz * unity_LightColor[6].xyz;
    u_xlat16_14.xyz = u_xlat16_26.xxx * u_xlat16_14.xyz;
    u_xlat16_14.xyz = min(u_xlat16_14.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_14.xyz = u_xlat16_22.xyz + u_xlat16_14.xyz;
    u_xlati24 = (u_xlatb51) ? 6 : u_xlati24;
#ifdef UNITY_ADRENO_ES3
    u_xlatb16 = !!(u_xlati24<unity_VertexLightParams.x);
#else
    u_xlatb16 = u_xlati24<unity_VertexLightParams.x;
#endif
    u_xlatb16 = u_xlatb51 && u_xlatb16;
    u_xlat16_22.xyz = (bool(u_xlatb16)) ? u_xlat16_14.xyz : u_xlat16_22.xyz;
    u_xlat35.xyz = (-u_xlat19.xyz) * unity_LightPosition[7].www + unity_LightPosition[7].xyz;
    u_xlat17 = dot(u_xlat35.xyz, u_xlat35.xyz);
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(unity_LightAtten[7].w<u_xlat17);
#else
    u_xlatb36 = unity_LightAtten[7].w<u_xlat17;
#endif
#ifdef UNITY_ADRENO_ES3
    u_xlatb55 = !!(unity_LightPosition[7].w!=0.0);
#else
    u_xlatb55 = unity_LightPosition[7].w!=0.0;
#endif
    u_xlatb36 = u_xlatb36 && u_xlatb55;
    u_xlat55 = unity_LightAtten[7].z * u_xlat17 + 1.0;
    u_xlat17 = max(u_xlat17, 9.99999997e-007);
    u_xlat17 = inversesqrt(u_xlat17);
    u_xlat55 = float(1.0) / u_xlat55;
    u_xlat55 = u_xlat55 * 0.5;
    u_xlat16_45 = (u_xlatb36) ? 0.0 : u_xlat55;
    u_xlat36.xyz = u_xlat35.xyz * vec3(u_xlat17);
    u_xlat16_64 = dot(u_xlat4.xyz, u_xlat36.xyz);
    u_xlat16_64 = max(u_xlat16_64, 0.0);
    u_xlat16_14.xyz = vec3(u_xlat16_64) * _Color.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb36 = !!(0.0<u_xlat16_64);
#else
    u_xlatb36 = 0.0<u_xlat16_64;
#endif
    u_xlat16_14.xyz = u_xlat16_14.xyz * unity_LightColor[7].xyz;
    u_xlat16_14.xyz = vec3(u_xlat16_45) * u_xlat16_14.xyz;
    u_xlat16_14.xyz = min(u_xlat16_14.xyz, vec3(1.0, 1.0, 1.0));
    u_xlat16_14.xyz = u_xlat16_22.xyz + u_xlat16_14.xyz;
    u_xlati24 = (u_xlatb16) ? 7 : u_xlati24;
#ifdef UNITY_ADRENO_ES3
    u_xlatb24 = !!(u_xlati24<unity_VertexLightParams.x);
#else
    u_xlatb24 = u_xlati24<unity_VertexLightParams.x;
#endif
    u_xlatb24 = u_xlatb24 && u_xlatb16;
    vs_COLOR0.xyz = (bool(u_xlatb24)) ? u_xlat16_14.xyz : u_xlat16_22.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
    u_xlat55 = dot(u_xlat19.xyz, u_xlat19.xyz);
    u_xlat55 = inversesqrt(u_xlat55);
    u_xlat19.xyz = u_xlat19.xyz * vec3(u_xlat55);
    u_xlat16_22.xyz = u_xlat21.xyz * vec3(u_xlat61) + (-u_xlat19.xyz);
    u_xlat16_64 = dot(u_xlat16_22.xyz, u_xlat16_22.xyz);
    u_xlat16_64 = inversesqrt(u_xlat16_64);
    u_xlat16_22.xyz = u_xlat16_22.xyz * vec3(u_xlat16_64);
    u_xlat16_22.x = dot(u_xlat4.xyz, u_xlat16_22.xyz);
    u_xlat16_22.x = max(u_xlat16_22.x, 0.0);
    u_xlat16_22.x = log2(u_xlat16_22.x);
    u_xlat16_41 = _Shininess * 128.0;
    u_xlat16_22.x = u_xlat16_22.x * u_xlat16_41;
    u_xlat16_22.x = exp2(u_xlat16_22.x);
    u_xlat16_22.x = min(u_xlat16_22.x, 1.0);
    u_xlat16_22.x = u_xlat16_22.x * u_xlat16_6.x;
    u_xlat16_14.xyz = u_xlat16_22.xxx * unity_LightColor[0].xyz;
    u_xlat16_14.xyz = (bool(u_xlatb2)) ? u_xlat16_14.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_14.xyz = (bool(u_xlatb5)) ? u_xlat16_14.xyz : vec3(0.0, 0.0, 0.0);
    u_xlat16_18.xyz = u_xlat1.xyz * vec3(u_xlat58) + (-u_xlat19.xyz);
    u_xlat16_22.x = dot(u_xlat16_18.xyz, u_xlat16_18.xyz);
    u_xlat16_22.x = inversesqrt(u_xlat16_22.x);
    u_xlat16_18.xyz = u_xlat16_22.xxx * u_xlat16_18.xyz;
    u_xlat16_22.x = dot(u_xlat4.xyz, u_xlat16_18.xyz);
    u_xlat16_22.x = max(u_xlat16_22.x, 0.0);
    u_xlat16_22.x = log2(u_xlat16_22.x);
    u_xlat16_22.x = u_xlat16_22.x * u_xlat16_41;
    u_xlat16_22.x = exp2(u_xlat16_22.x);
    u_xlat16_22.x = min(u_xlat16_22.x, 1.0);
    u_xlat16_3.x = u_xlat16_22.x * u_xlat16_3.x;
    u_xlat16_3.xyw = u_xlat16_3.xxx * unity_LightColor[1].xyz + u_xlat16_14.xyz;
    u_xlat16_3.xyw = (bool(u_xlatb0)) ? u_xlat16_3.xyw : u_xlat16_14.xyz;
    u_xlat16_3.xyw = (bool(u_xlatb43)) ? u_xlat16_3.xyw : u_xlat16_14.xyz;
    u_xlat16_14.xyz = u_xlat8.xyz * vec3(u_xlat62) + (-u_xlat19.xyz);
    u_xlat16_6.x = dot(u_xlat16_14.xyz, u_xlat16_14.xyz);
    u_xlat16_6.x = inversesqrt(u_xlat16_6.x);
    u_xlat16_14.xyz = u_xlat16_6.xxx * u_xlat16_14.xyz;
    u_xlat16_6.x = dot(u_xlat4.xyz, u_xlat16_14.xyz);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlat16_6.x = log2(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_41 * u_xlat16_6.x;
    u_xlat16_6.x = exp2(u_xlat16_6.x);
    u_xlat16_6.x = min(u_xlat16_6.x, 1.0);
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_25.x;
    u_xlat16_14.xyz = u_xlat16_6.xxx * unity_LightColor[2].xyz + u_xlat16_3.xyw;
    u_xlat16_14.xyz = (bool(u_xlatb65)) ? u_xlat16_14.xyz : u_xlat16_3.xyw;
    u_xlat16_3.xyw = (bool(u_xlatb9)) ? u_xlat16_14.xyz : u_xlat16_3.xyw;
    u_xlat16_14.xyz = u_xlat28.xyz * vec3(u_xlat10) + (-u_xlat19.xyz);
    u_xlat16_6.x = dot(u_xlat16_14.xyz, u_xlat16_14.xyz);
    u_xlat16_6.x = inversesqrt(u_xlat16_6.x);
    u_xlat16_14.xyz = u_xlat16_6.xxx * u_xlat16_14.xyz;
    u_xlat16_6.x = dot(u_xlat4.xyz, u_xlat16_14.xyz);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlat16_6.x = log2(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_41 * u_xlat16_6.x;
    u_xlat16_6.x = exp2(u_xlat16_6.x);
    u_xlat16_6.x = min(u_xlat16_6.x, 1.0);
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_44;
    u_xlat16_6.xyz = u_xlat16_6.xxx * unity_LightColor[3].xyz + u_xlat16_3.xyw;
    u_xlat16_6.xyz = (bool(u_xlatb29)) ? u_xlat16_6.xyz : u_xlat16_3.xyw;
    u_xlat16_3.xyw = (bool(u_xlatb48)) ? u_xlat16_6.xyz : u_xlat16_3.xyw;
    u_xlat16_6.xyz = u_xlat11.xyz * vec3(u_xlat67) + (-u_xlat19.xyz);
    u_xlat16_64 = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
    u_xlat16_64 = inversesqrt(u_xlat16_64);
    u_xlat16_6.xyz = u_xlat16_6.xyz * vec3(u_xlat16_64);
    u_xlat16_6.x = dot(u_xlat4.xyz, u_xlat16_6.xyz);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlat16_6.x = log2(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_41 * u_xlat16_6.x;
    u_xlat16_6.x = exp2(u_xlat16_6.x);
    u_xlat16_6.x = min(u_xlat16_6.x, 1.0);
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_63;
    u_xlat16_6.xyz = u_xlat16_6.xxx * unity_LightColor[4].xyz + u_xlat16_3.xyw;
    u_xlat16_6.xyz = (bool(u_xlatb68)) ? u_xlat16_6.xyz : u_xlat16_3.xyw;
    u_xlat16_3.xyw = (bool(u_xlatb12)) ? u_xlat16_6.xyz : u_xlat16_3.xyw;
    u_xlat16_6.xyz = u_xlat31.xyz * vec3(u_xlat13) + (-u_xlat19.xyz);
    u_xlat16_63 = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
    u_xlat16_63 = inversesqrt(u_xlat16_63);
    u_xlat16_6.xyz = vec3(u_xlat16_63) * u_xlat16_6.xyz;
    u_xlat16_6.x = dot(u_xlat4.xyz, u_xlat16_6.xyz);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlat16_6.x = log2(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_41 * u_xlat16_6.x;
    u_xlat16_6.x = exp2(u_xlat16_6.x);
    u_xlat16_6.x = min(u_xlat16_6.x, 1.0);
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_7.x;
    u_xlat16_6.xyz = u_xlat16_6.xxx * unity_LightColor[5].xyz + u_xlat16_3.xyw;
    u_xlat16_6.xyz = (bool(u_xlatb32)) ? u_xlat16_6.xyz : u_xlat16_3.xyw;
    u_xlat16_3.xyw = (bool(u_xlatb51)) ? u_xlat16_6.xyz : u_xlat16_3.xyw;
    u_xlat16_6.xyz = u_xlat15.xyz * vec3(u_xlat70) + (-u_xlat19.xyz);
    u_xlat16_14.xyz = u_xlat35.xyz * vec3(u_xlat17) + (-u_xlat19.xyz);
    u_xlat16_63 = dot(u_xlat16_6.xyz, u_xlat16_6.xyz);
    u_xlat16_63 = inversesqrt(u_xlat16_63);
    u_xlat16_6.xyz = vec3(u_xlat16_63) * u_xlat16_6.xyz;
    u_xlat16_6.x = dot(u_xlat4.xyz, u_xlat16_6.xyz);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlat16_6.x = log2(u_xlat16_6.x);
    u_xlat16_6.x = u_xlat16_41 * u_xlat16_6.x;
    u_xlat16_6.x = exp2(u_xlat16_6.x);
    u_xlat16_6.x = min(u_xlat16_6.x, 1.0);
    u_xlat16_6.x = u_xlat16_6.x * u_xlat16_26.x;
    u_xlat16_6.xyz = u_xlat16_6.xxx * unity_LightColor[6].xyz + u_xlat16_3.xyw;
    u_xlat16_6.xyz = (bool(u_xlatb72)) ? u_xlat16_6.xyz : u_xlat16_3.xyw;
    u_xlat16_3.xyw = (bool(u_xlatb16)) ? u_xlat16_6.xyz : u_xlat16_3.xyw;
    u_xlat16_6.x = dot(u_xlat16_14.xyz, u_xlat16_14.xyz);
    u_xlat16_6.x = inversesqrt(u_xlat16_6.x);
    u_xlat16_6.xyz = u_xlat16_6.xxx * u_xlat16_14.xyz;
    u_xlat16_6.x = dot(u_xlat4.xyz, u_xlat16_6.xyz);
    u_xlat16_6.x = max(u_xlat16_6.x, 0.0);
    u_xlat16_6.x = log2(u_xlat16_6.x);
    u_xlat16_41 = u_xlat16_41 * u_xlat16_6.x;
    u_xlat16_41 = exp2(u_xlat16_41);
    u_xlat16_41 = min(u_xlat16_41, 1.0);
    u_xlat16_41 = u_xlat16_41 * u_xlat16_45;
    u_xlat16_6.xyz = vec3(u_xlat16_41) * unity_LightColor[7].xyz + u_xlat16_3.xyw;
    u_xlat16_6.xyz = (bool(u_xlatb36)) ? u_xlat16_6.xyz : u_xlat16_3.xyw;
    u_xlat16_3.xyz = (bool(u_xlatb24)) ? u_xlat16_6.xyz : u_xlat16_3.xyw;
    vs_COLOR1.xyz = u_xlat16_3.xyz * _SpecColor.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR1.xyz = min(max(vs_COLOR1.xyz, 0.0), 1.0);
#else
    vs_COLOR1.xyz = clamp(vs_COLOR1.xyz, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_COLOR1;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vs_COLOR1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float rho_19;
    mediump float att_20;
    highp vec3 dirToLight_21;
    dirToLight_21 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_22;
    tmpvar_22 = dot (dirToLight_21, dirToLight_21);
    att_20 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_22))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_22 > unity_LightAtten[il_6].w))) {
      att_20 = 0.0;
    };
    dirToLight_21 = (dirToLight_21 * inversesqrt(max (tmpvar_22, 1e-06)));
    highp float tmpvar_23;
    tmpvar_23 = max (dot (dirToLight_21, unity_SpotDirection[il_6].xyz), 0.0);
    rho_19 = tmpvar_23;
    att_20 = (att_20 * clamp ((
      (rho_19 - unity_LightAtten[il_6].x)
     * unity_LightAtten[il_6].y), 0.0, 1.0));
    att_20 = (att_20 * 0.5);
    mediump vec3 dirToLight_24;
    dirToLight_24 = dirToLight_21;
    mediump vec3 specColor_25;
    specColor_25 = specColor_8;
    mediump float tmpvar_26;
    tmpvar_26 = max (dot (eyeNormal_11, dirToLight_24), 0.0);
    mediump vec3 tmpvar_27;
    tmpvar_27 = ((tmpvar_26 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_26 > 0.0)) {
      specColor_25 = (specColor_8 + ((att_20 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_24 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_25;
    lcolor_9 = (lcolor_9 + min ((tmpvar_27 * att_20), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_28;
  mediump vec4 tmpvar_29;
  tmpvar_29 = clamp (color_13, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  lowp vec3 tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_28;
  xlv_COLOR1 = tmpvar_30;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_32));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  col_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = 1.0;
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float rho_19;
    mediump float att_20;
    highp vec3 dirToLight_21;
    dirToLight_21 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_22;
    tmpvar_22 = dot (dirToLight_21, dirToLight_21);
    att_20 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_22))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_22 > unity_LightAtten[il_6].w))) {
      att_20 = 0.0;
    };
    dirToLight_21 = (dirToLight_21 * inversesqrt(max (tmpvar_22, 1e-06)));
    highp float tmpvar_23;
    tmpvar_23 = max (dot (dirToLight_21, unity_SpotDirection[il_6].xyz), 0.0);
    rho_19 = tmpvar_23;
    att_20 = (att_20 * clamp ((
      (rho_19 - unity_LightAtten[il_6].x)
     * unity_LightAtten[il_6].y), 0.0, 1.0));
    att_20 = (att_20 * 0.5);
    mediump vec3 dirToLight_24;
    dirToLight_24 = dirToLight_21;
    mediump vec3 specColor_25;
    specColor_25 = specColor_8;
    mediump float tmpvar_26;
    tmpvar_26 = max (dot (eyeNormal_11, dirToLight_24), 0.0);
    mediump vec3 tmpvar_27;
    tmpvar_27 = ((tmpvar_26 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_26 > 0.0)) {
      specColor_25 = (specColor_8 + ((att_20 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_24 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_25;
    lcolor_9 = (lcolor_9 + min ((tmpvar_27 * att_20), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_28;
  mediump vec4 tmpvar_29;
  tmpvar_29 = clamp (color_13, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  lowp vec3 tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_28;
  xlv_COLOR1 = tmpvar_30;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_32));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  col_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = 1.0;
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform mediump vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform mediump vec4 unity_LightAtten[8];
uniform highp vec4 unity_SpotDirection[8];
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _SpecColor;
uniform mediump vec4 _Emission;
uniform mediump float _Shininess;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec3 tmpvar_5;
  tmpvar_5 = _glesVertex.xyz;
  mediump float shininess_7;
  mediump vec3 specColor_8;
  mediump vec3 lcolor_9;
  mediump vec3 viewDir_10;
  mediump vec3 eyeNormal_11;
  highp vec3 eyePos_12;
  mediump vec4 color_13;
  color_13 = vec4(0.0, 0.0, 0.0, 1.1);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_5;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_14).xyz;
  eyePos_12 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = tmpvar_2.xyz;
  tmpvar_16[1] = tmpvar_3.xyz;
  tmpvar_16[2] = tmpvar_4.xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesNormal));
  eyeNormal_11 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  viewDir_10 = -(tmpvar_18);
  lcolor_9 = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  specColor_8 = vec3(0.0, 0.0, 0.0);
  shininess_7 = (_Shininess * 128.0);
  for (highp int il_6 = 0; il_6 < 8; il_6++) {
    mediump float rho_19;
    mediump float att_20;
    highp vec3 dirToLight_21;
    dirToLight_21 = (unity_LightPosition[il_6].xyz - (eyePos_12 * unity_LightPosition[il_6].w));
    highp float tmpvar_22;
    tmpvar_22 = dot (dirToLight_21, dirToLight_21);
    att_20 = (1.0/((1.0 + (unity_LightAtten[il_6].z * tmpvar_22))));
    if (((unity_LightPosition[il_6].w != 0.0) && (tmpvar_22 > unity_LightAtten[il_6].w))) {
      att_20 = 0.0;
    };
    dirToLight_21 = (dirToLight_21 * inversesqrt(max (tmpvar_22, 1e-06)));
    highp float tmpvar_23;
    tmpvar_23 = max (dot (dirToLight_21, unity_SpotDirection[il_6].xyz), 0.0);
    rho_19 = tmpvar_23;
    att_20 = (att_20 * clamp ((
      (rho_19 - unity_LightAtten[il_6].x)
     * unity_LightAtten[il_6].y), 0.0, 1.0));
    att_20 = (att_20 * 0.5);
    mediump vec3 dirToLight_24;
    dirToLight_24 = dirToLight_21;
    mediump vec3 specColor_25;
    specColor_25 = specColor_8;
    mediump float tmpvar_26;
    tmpvar_26 = max (dot (eyeNormal_11, dirToLight_24), 0.0);
    mediump vec3 tmpvar_27;
    tmpvar_27 = ((tmpvar_26 * _Color.xyz) * unity_LightColor[il_6].xyz);
    if ((tmpvar_26 > 0.0)) {
      specColor_25 = (specColor_8 + ((att_20 * 
        clamp (pow (max (dot (eyeNormal_11, 
          normalize((dirToLight_24 + viewDir_10))
        ), 0.0), shininess_7), 0.0, 1.0)
      ) * unity_LightColor[il_6].xyz));
    };
    specColor_8 = specColor_25;
    lcolor_9 = (lcolor_9 + min ((tmpvar_27 * att_20), vec3(1.0, 1.0, 1.0)));
  };
  color_13.xyz = lcolor_9;
  color_13.w = _Color.w;
  specColor_8 = (specColor_8 * _SpecColor.xyz);
  lowp vec4 tmpvar_28;
  mediump vec4 tmpvar_29;
  tmpvar_29 = clamp (color_13, 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  lowp vec3 tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31 = clamp (specColor_8, 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  highp vec4 tmpvar_32;
  tmpvar_32.w = 1.0;
  tmpvar_32.xyz = tmpvar_5;
  xlv_COLOR0 = tmpvar_28;
  xlv_COLOR1 = tmpvar_30;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_32));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_COLOR1;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  col_1.xyz = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = 1.0;
  col_1.xyz = (col_1.xyz + xlv_COLOR1);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPOT" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec4 _Emission;
uniform 	mediump float _Shininess;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_COLOR1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
bool u_xlatb15;
mediump vec3 u_xlat16_19;
mediump vec3 u_xlat16_20;
float u_xlat33;
int u_xlati33;
bool u_xlatb33;
float u_xlat34;
bool u_xlatb34;
float u_xlat35;
bool u_xlatb35;
float u_xlat36;
bool u_xlatb36;
mediump float u_xlat16_40;
mediump float u_xlat16_42;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
    u_xlat33 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat1.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat2.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_7.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + _Emission.xyz;
    u_xlat16_40 = _Shininess * 128.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(0<unity_VertexLightParams.x);
#else
    u_xlatb33 = 0<unity_VertexLightParams.x;
#endif
    if(u_xlatb33){
        u_xlat3.xyz = (-u_xlat0.xyz) * unity_LightPosition[0].www + unity_LightPosition[0].xyz;
        u_xlat33 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat34 = unity_LightAtten[0].z * u_xlat33 + 1.0;
        u_xlat34 = float(1.0) / u_xlat34;
#ifdef UNITY_ADRENO_ES3
        u_xlatb35 = !!(unity_LightPosition[0].w!=0.0);
#else
        u_xlatb35 = unity_LightPosition[0].w!=0.0;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb36 = !!(unity_LightAtten[0].w<u_xlat33);
#else
        u_xlatb36 = unity_LightAtten[0].w<u_xlat33;
#endif
        u_xlatb35 = u_xlatb35 && u_xlatb36;
        u_xlat16_8 = (u_xlatb35) ? 0.0 : u_xlat34;
        u_xlat33 = max(u_xlat33, 9.99999997e-007);
        u_xlat33 = inversesqrt(u_xlat33);
        u_xlat4.xyz = vec3(u_xlat33) * u_xlat3.xyz;
        u_xlat34 = dot(u_xlat4.xyz, unity_SpotDirection[0].xyz);
        u_xlat34 = max(u_xlat34, 0.0);
        u_xlat16_19.x = u_xlat34 + (-unity_LightAtten[0].x);
        u_xlat16_19.x = u_xlat16_19.x * unity_LightAtten[0].y;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_19.x = min(max(u_xlat16_19.x, 0.0), 1.0);
#else
        u_xlat16_19.x = clamp(u_xlat16_19.x, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_19.x * u_xlat16_8;
        u_xlat16_8 = u_xlat16_8 * 0.5;
        u_xlat16_19.x = dot(u_xlat1.xyz, u_xlat4.xyz);
        u_xlat16_19.x = max(u_xlat16_19.x, 0.0);
        u_xlat16_9.xyz = u_xlat16_19.xxx * _Color.xyz;
        u_xlat16_9.xyz = u_xlat16_9.xyz * unity_LightColor[0].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb34 = !!(0.0<u_xlat16_19.x);
#else
        u_xlatb34 = 0.0<u_xlat16_19.x;
#endif
        u_xlat16_19.xyz = u_xlat3.xyz * vec3(u_xlat33) + (-u_xlat2.xyz);
        u_xlat16_42 = dot(u_xlat16_19.xyz, u_xlat16_19.xyz);
        u_xlat16_42 = inversesqrt(u_xlat16_42);
        u_xlat16_19.xyz = u_xlat16_19.xyz * vec3(u_xlat16_42);
        u_xlat16_19.x = dot(u_xlat1.xyz, u_xlat16_19.xyz);
        u_xlat16_19.x = max(u_xlat16_19.x, 0.0);
        u_xlat16_19.x = log2(u_xlat16_19.x);
        u_xlat16_19.x = u_xlat16_40 * u_xlat16_19.x;
        u_xlat16_19.x = exp2(u_xlat16_19.x);
        u_xlat16_19.x = min(u_xlat16_19.x, 1.0);
        u_xlat16_19.x = u_xlat16_19.x * u_xlat16_8;
        u_xlat16_19.xyz = u_xlat16_19.xxx * unity_LightColor[0].xyz;
        u_xlat16_19.xyz = (bool(u_xlatb34)) ? u_xlat16_19.xyz : vec3(0.0, 0.0, 0.0);
        u_xlat16_9.xyz = vec3(u_xlat16_8) * u_xlat16_9.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_9.xyz;
        u_xlati33 = 1;
    } else {
        u_xlat16_19.x = float(0.0);
        u_xlat16_19.y = float(0.0);
        u_xlat16_19.z = float(0.0);
        u_xlati33 = 0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(u_xlati33<unity_VertexLightParams.x);
#else
    u_xlatb34 = u_xlati33<unity_VertexLightParams.x;
#endif
    if(u_xlatb34){
        u_xlat3.xyz = (-u_xlat0.xyz) * unity_LightPosition[1].www + unity_LightPosition[1].xyz;
        u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat36 = unity_LightAtten[1].z * u_xlat35 + 1.0;
        u_xlat36 = float(1.0) / u_xlat36;
#ifdef UNITY_ADRENO_ES3
        u_xlatb4 = !!(unity_LightPosition[1].w!=0.0);
#else
        u_xlatb4 = unity_LightPosition[1].w!=0.0;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb15 = !!(unity_LightAtten[1].w<u_xlat35);
#else
        u_xlatb15 = unity_LightAtten[1].w<u_xlat35;
#endif
        u_xlatb4 = u_xlatb15 && u_xlatb4;
        u_xlat16_8 = (u_xlatb4) ? 0.0 : u_xlat36;
        u_xlat35 = max(u_xlat35, 9.99999997e-007);
        u_xlat35 = inversesqrt(u_xlat35);
        u_xlat4.xyz = vec3(u_xlat35) * u_xlat3.xyz;
        u_xlat36 = dot(u_xlat4.xyz, unity_SpotDirection[1].xyz);
        u_xlat36 = max(u_xlat36, 0.0);
        u_xlat16_9.x = u_xlat36 + (-unity_LightAtten[1].x);
        u_xlat16_9.x = u_xlat16_9.x * unity_LightAtten[1].y;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
#else
        u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_8 = u_xlat16_8 * 0.5;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat4.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_20.xyz = u_xlat16_9.xxx * _Color.xyz;
        u_xlat16_20.xyz = u_xlat16_20.xyz * unity_LightColor[1].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb36 = !!(0.0<u_xlat16_9.x);
#else
        u_xlatb36 = 0.0<u_xlat16_9.x;
#endif
        u_xlat16_10.xyz = u_xlat3.xyz * vec3(u_xlat35) + (-u_xlat2.xyz);
        u_xlat16_9.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = inversesqrt(u_xlat16_9.x);
        u_xlat16_10.xyz = u_xlat16_9.xxx * u_xlat16_10.xyz;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_9.x = log2(u_xlat16_9.x);
        u_xlat16_9.x = u_xlat16_40 * u_xlat16_9.x;
        u_xlat16_9.x = exp2(u_xlat16_9.x);
        u_xlat16_9.x = min(u_xlat16_9.x, 1.0);
        u_xlat16_9.x = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_10.xyz = u_xlat16_9.xxx * unity_LightColor[1].xyz + u_xlat16_19.xyz;
        u_xlat16_19.xyz = (bool(u_xlatb36)) ? u_xlat16_10.xyz : u_xlat16_19.xyz;
        u_xlat16_9.xyz = vec3(u_xlat16_8) * u_xlat16_20.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_9.xyz;
        u_xlati33 = 2;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb35 = !!(u_xlati33<unity_VertexLightParams.x);
#else
    u_xlatb35 = u_xlati33<unity_VertexLightParams.x;
#endif
    u_xlatb34 = u_xlatb34 && u_xlatb35;
    if(u_xlatb34){
        u_xlat3.xyz = (-u_xlat0.xyz) * unity_LightPosition[2].www + unity_LightPosition[2].xyz;
        u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat36 = unity_LightAtten[2].z * u_xlat35 + 1.0;
        u_xlat36 = float(1.0) / u_xlat36;
#ifdef UNITY_ADRENO_ES3
        u_xlatb4 = !!(unity_LightPosition[2].w!=0.0);
#else
        u_xlatb4 = unity_LightPosition[2].w!=0.0;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb15 = !!(unity_LightAtten[2].w<u_xlat35);
#else
        u_xlatb15 = unity_LightAtten[2].w<u_xlat35;
#endif
        u_xlatb4 = u_xlatb15 && u_xlatb4;
        u_xlat16_8 = (u_xlatb4) ? 0.0 : u_xlat36;
        u_xlat35 = max(u_xlat35, 9.99999997e-007);
        u_xlat35 = inversesqrt(u_xlat35);
        u_xlat4.xyz = vec3(u_xlat35) * u_xlat3.xyz;
        u_xlat36 = dot(u_xlat4.xyz, unity_SpotDirection[2].xyz);
        u_xlat36 = max(u_xlat36, 0.0);
        u_xlat16_9.x = u_xlat36 + (-unity_LightAtten[2].x);
        u_xlat16_9.x = u_xlat16_9.x * unity_LightAtten[2].y;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
#else
        u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_8 = u_xlat16_8 * 0.5;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat4.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_20.xyz = u_xlat16_9.xxx * _Color.xyz;
        u_xlat16_20.xyz = u_xlat16_20.xyz * unity_LightColor[2].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb36 = !!(0.0<u_xlat16_9.x);
#else
        u_xlatb36 = 0.0<u_xlat16_9.x;
#endif
        u_xlat16_10.xyz = u_xlat3.xyz * vec3(u_xlat35) + (-u_xlat2.xyz);
        u_xlat16_9.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = inversesqrt(u_xlat16_9.x);
        u_xlat16_10.xyz = u_xlat16_9.xxx * u_xlat16_10.xyz;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_9.x = log2(u_xlat16_9.x);
        u_xlat16_9.x = u_xlat16_40 * u_xlat16_9.x;
        u_xlat16_9.x = exp2(u_xlat16_9.x);
        u_xlat16_9.x = min(u_xlat16_9.x, 1.0);
        u_xlat16_9.x = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_10.xyz = u_xlat16_9.xxx * unity_LightColor[2].xyz + u_xlat16_19.xyz;
        u_xlat16_19.xyz = (bool(u_xlatb36)) ? u_xlat16_10.xyz : u_xlat16_19.xyz;
        u_xlat16_9.xyz = vec3(u_xlat16_8) * u_xlat16_20.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_9.xyz;
        u_xlati33 = 3;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb35 = !!(u_xlati33<unity_VertexLightParams.x);
#else
    u_xlatb35 = u_xlati33<unity_VertexLightParams.x;
#endif
    u_xlatb34 = u_xlatb34 && u_xlatb35;
    if(u_xlatb34){
        u_xlat3.xyz = (-u_xlat0.xyz) * unity_LightPosition[3].www + unity_LightPosition[3].xyz;
        u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat36 = unity_LightAtten[3].z * u_xlat35 + 1.0;
        u_xlat36 = float(1.0) / u_xlat36;
#ifdef UNITY_ADRENO_ES3
        u_xlatb4 = !!(unity_LightPosition[3].w!=0.0);
#else
        u_xlatb4 = unity_LightPosition[3].w!=0.0;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb15 = !!(unity_LightAtten[3].w<u_xlat35);
#else
        u_xlatb15 = unity_LightAtten[3].w<u_xlat35;
#endif
        u_xlatb4 = u_xlatb15 && u_xlatb4;
        u_xlat16_8 = (u_xlatb4) ? 0.0 : u_xlat36;
        u_xlat35 = max(u_xlat35, 9.99999997e-007);
        u_xlat35 = inversesqrt(u_xlat35);
        u_xlat4.xyz = vec3(u_xlat35) * u_xlat3.xyz;
        u_xlat36 = dot(u_xlat4.xyz, unity_SpotDirection[3].xyz);
        u_xlat36 = max(u_xlat36, 0.0);
        u_xlat16_9.x = u_xlat36 + (-unity_LightAtten[3].x);
        u_xlat16_9.x = u_xlat16_9.x * unity_LightAtten[3].y;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
#else
        u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_8 = u_xlat16_8 * 0.5;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat4.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_20.xyz = u_xlat16_9.xxx * _Color.xyz;
        u_xlat16_20.xyz = u_xlat16_20.xyz * unity_LightColor[3].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb36 = !!(0.0<u_xlat16_9.x);
#else
        u_xlatb36 = 0.0<u_xlat16_9.x;
#endif
        u_xlat16_10.xyz = u_xlat3.xyz * vec3(u_xlat35) + (-u_xlat2.xyz);
        u_xlat16_9.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = inversesqrt(u_xlat16_9.x);
        u_xlat16_10.xyz = u_xlat16_9.xxx * u_xlat16_10.xyz;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_9.x = log2(u_xlat16_9.x);
        u_xlat16_9.x = u_xlat16_40 * u_xlat16_9.x;
        u_xlat16_9.x = exp2(u_xlat16_9.x);
        u_xlat16_9.x = min(u_xlat16_9.x, 1.0);
        u_xlat16_9.x = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_10.xyz = u_xlat16_9.xxx * unity_LightColor[3].xyz + u_xlat16_19.xyz;
        u_xlat16_19.xyz = (bool(u_xlatb36)) ? u_xlat16_10.xyz : u_xlat16_19.xyz;
        u_xlat16_9.xyz = vec3(u_xlat16_8) * u_xlat16_20.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_9.xyz;
        u_xlati33 = 4;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb35 = !!(u_xlati33<unity_VertexLightParams.x);
#else
    u_xlatb35 = u_xlati33<unity_VertexLightParams.x;
#endif
    u_xlatb34 = u_xlatb34 && u_xlatb35;
    if(u_xlatb34){
        u_xlat3.xyz = (-u_xlat0.xyz) * unity_LightPosition[4].www + unity_LightPosition[4].xyz;
        u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat36 = unity_LightAtten[4].z * u_xlat35 + 1.0;
        u_xlat36 = float(1.0) / u_xlat36;
#ifdef UNITY_ADRENO_ES3
        u_xlatb4 = !!(unity_LightPosition[4].w!=0.0);
#else
        u_xlatb4 = unity_LightPosition[4].w!=0.0;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb15 = !!(unity_LightAtten[4].w<u_xlat35);
#else
        u_xlatb15 = unity_LightAtten[4].w<u_xlat35;
#endif
        u_xlatb4 = u_xlatb15 && u_xlatb4;
        u_xlat16_8 = (u_xlatb4) ? 0.0 : u_xlat36;
        u_xlat35 = max(u_xlat35, 9.99999997e-007);
        u_xlat35 = inversesqrt(u_xlat35);
        u_xlat4.xyz = vec3(u_xlat35) * u_xlat3.xyz;
        u_xlat36 = dot(u_xlat4.xyz, unity_SpotDirection[4].xyz);
        u_xlat36 = max(u_xlat36, 0.0);
        u_xlat16_9.x = u_xlat36 + (-unity_LightAtten[4].x);
        u_xlat16_9.x = u_xlat16_9.x * unity_LightAtten[4].y;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
#else
        u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_8 = u_xlat16_8 * 0.5;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat4.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_20.xyz = u_xlat16_9.xxx * _Color.xyz;
        u_xlat16_20.xyz = u_xlat16_20.xyz * unity_LightColor[4].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb36 = !!(0.0<u_xlat16_9.x);
#else
        u_xlatb36 = 0.0<u_xlat16_9.x;
#endif
        u_xlat16_10.xyz = u_xlat3.xyz * vec3(u_xlat35) + (-u_xlat2.xyz);
        u_xlat16_9.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = inversesqrt(u_xlat16_9.x);
        u_xlat16_10.xyz = u_xlat16_9.xxx * u_xlat16_10.xyz;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_9.x = log2(u_xlat16_9.x);
        u_xlat16_9.x = u_xlat16_40 * u_xlat16_9.x;
        u_xlat16_9.x = exp2(u_xlat16_9.x);
        u_xlat16_9.x = min(u_xlat16_9.x, 1.0);
        u_xlat16_9.x = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_10.xyz = u_xlat16_9.xxx * unity_LightColor[4].xyz + u_xlat16_19.xyz;
        u_xlat16_19.xyz = (bool(u_xlatb36)) ? u_xlat16_10.xyz : u_xlat16_19.xyz;
        u_xlat16_9.xyz = vec3(u_xlat16_8) * u_xlat16_20.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_9.xyz;
        u_xlati33 = 5;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb35 = !!(u_xlati33<unity_VertexLightParams.x);
#else
    u_xlatb35 = u_xlati33<unity_VertexLightParams.x;
#endif
    u_xlatb34 = u_xlatb34 && u_xlatb35;
    if(u_xlatb34){
        u_xlat3.xyz = (-u_xlat0.xyz) * unity_LightPosition[5].www + unity_LightPosition[5].xyz;
        u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat36 = unity_LightAtten[5].z * u_xlat35 + 1.0;
        u_xlat36 = float(1.0) / u_xlat36;
#ifdef UNITY_ADRENO_ES3
        u_xlatb4 = !!(unity_LightPosition[5].w!=0.0);
#else
        u_xlatb4 = unity_LightPosition[5].w!=0.0;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb15 = !!(unity_LightAtten[5].w<u_xlat35);
#else
        u_xlatb15 = unity_LightAtten[5].w<u_xlat35;
#endif
        u_xlatb4 = u_xlatb15 && u_xlatb4;
        u_xlat16_8 = (u_xlatb4) ? 0.0 : u_xlat36;
        u_xlat35 = max(u_xlat35, 9.99999997e-007);
        u_xlat35 = inversesqrt(u_xlat35);
        u_xlat4.xyz = vec3(u_xlat35) * u_xlat3.xyz;
        u_xlat36 = dot(u_xlat4.xyz, unity_SpotDirection[5].xyz);
        u_xlat36 = max(u_xlat36, 0.0);
        u_xlat16_9.x = u_xlat36 + (-unity_LightAtten[5].x);
        u_xlat16_9.x = u_xlat16_9.x * unity_LightAtten[5].y;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
#else
        u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_8 = u_xlat16_8 * 0.5;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat4.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_20.xyz = u_xlat16_9.xxx * _Color.xyz;
        u_xlat16_20.xyz = u_xlat16_20.xyz * unity_LightColor[5].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb36 = !!(0.0<u_xlat16_9.x);
#else
        u_xlatb36 = 0.0<u_xlat16_9.x;
#endif
        u_xlat16_10.xyz = u_xlat3.xyz * vec3(u_xlat35) + (-u_xlat2.xyz);
        u_xlat16_9.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = inversesqrt(u_xlat16_9.x);
        u_xlat16_10.xyz = u_xlat16_9.xxx * u_xlat16_10.xyz;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_9.x = log2(u_xlat16_9.x);
        u_xlat16_9.x = u_xlat16_40 * u_xlat16_9.x;
        u_xlat16_9.x = exp2(u_xlat16_9.x);
        u_xlat16_9.x = min(u_xlat16_9.x, 1.0);
        u_xlat16_9.x = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_10.xyz = u_xlat16_9.xxx * unity_LightColor[5].xyz + u_xlat16_19.xyz;
        u_xlat16_19.xyz = (bool(u_xlatb36)) ? u_xlat16_10.xyz : u_xlat16_19.xyz;
        u_xlat16_9.xyz = vec3(u_xlat16_8) * u_xlat16_20.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_9.xyz;
        u_xlati33 = 6;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb35 = !!(u_xlati33<unity_VertexLightParams.x);
#else
    u_xlatb35 = u_xlati33<unity_VertexLightParams.x;
#endif
    u_xlatb34 = u_xlatb34 && u_xlatb35;
    if(u_xlatb34){
        u_xlat3.xyz = (-u_xlat0.xyz) * unity_LightPosition[6].www + unity_LightPosition[6].xyz;
        u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat36 = unity_LightAtten[6].z * u_xlat35 + 1.0;
        u_xlat36 = float(1.0) / u_xlat36;
#ifdef UNITY_ADRENO_ES3
        u_xlatb4 = !!(unity_LightPosition[6].w!=0.0);
#else
        u_xlatb4 = unity_LightPosition[6].w!=0.0;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb15 = !!(unity_LightAtten[6].w<u_xlat35);
#else
        u_xlatb15 = unity_LightAtten[6].w<u_xlat35;
#endif
        u_xlatb4 = u_xlatb15 && u_xlatb4;
        u_xlat16_8 = (u_xlatb4) ? 0.0 : u_xlat36;
        u_xlat35 = max(u_xlat35, 9.99999997e-007);
        u_xlat35 = inversesqrt(u_xlat35);
        u_xlat4.xyz = vec3(u_xlat35) * u_xlat3.xyz;
        u_xlat36 = dot(u_xlat4.xyz, unity_SpotDirection[6].xyz);
        u_xlat36 = max(u_xlat36, 0.0);
        u_xlat16_9.x = u_xlat36 + (-unity_LightAtten[6].x);
        u_xlat16_9.x = u_xlat16_9.x * unity_LightAtten[6].y;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
#else
        u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_8 = u_xlat16_8 * 0.5;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat4.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_20.xyz = u_xlat16_9.xxx * _Color.xyz;
        u_xlat16_20.xyz = u_xlat16_20.xyz * unity_LightColor[6].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb36 = !!(0.0<u_xlat16_9.x);
#else
        u_xlatb36 = 0.0<u_xlat16_9.x;
#endif
        u_xlat16_10.xyz = u_xlat3.xyz * vec3(u_xlat35) + (-u_xlat2.xyz);
        u_xlat16_9.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = inversesqrt(u_xlat16_9.x);
        u_xlat16_10.xyz = u_xlat16_9.xxx * u_xlat16_10.xyz;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_9.x = log2(u_xlat16_9.x);
        u_xlat16_9.x = u_xlat16_40 * u_xlat16_9.x;
        u_xlat16_9.x = exp2(u_xlat16_9.x);
        u_xlat16_9.x = min(u_xlat16_9.x, 1.0);
        u_xlat16_9.x = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_10.xyz = u_xlat16_9.xxx * unity_LightColor[6].xyz + u_xlat16_19.xyz;
        u_xlat16_19.xyz = (bool(u_xlatb36)) ? u_xlat16_10.xyz : u_xlat16_19.xyz;
        u_xlat16_9.xyz = vec3(u_xlat16_8) * u_xlat16_20.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_9.xyz;
        u_xlati33 = 7;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlati33<unity_VertexLightParams.x);
#else
    u_xlatb33 = u_xlati33<unity_VertexLightParams.x;
#endif
    u_xlatb33 = u_xlatb33 && u_xlatb34;
    if(u_xlatb33){
        u_xlat0.xyz = (-u_xlat0.xyz) * unity_LightPosition[7].www + unity_LightPosition[7].xyz;
        u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat34 = unity_LightAtten[7].z * u_xlat33 + 1.0;
        u_xlat34 = float(1.0) / u_xlat34;
#ifdef UNITY_ADRENO_ES3
        u_xlatb35 = !!(unity_LightPosition[7].w!=0.0);
#else
        u_xlatb35 = unity_LightPosition[7].w!=0.0;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb3 = !!(unity_LightAtten[7].w<u_xlat33);
#else
        u_xlatb3 = unity_LightAtten[7].w<u_xlat33;
#endif
        u_xlatb35 = u_xlatb35 && u_xlatb3;
        u_xlat16_8 = (u_xlatb35) ? 0.0 : u_xlat34;
        u_xlat33 = max(u_xlat33, 9.99999997e-007);
        u_xlat33 = inversesqrt(u_xlat33);
        u_xlat3.xyz = vec3(u_xlat33) * u_xlat0.xyz;
        u_xlat34 = dot(u_xlat3.xyz, unity_SpotDirection[7].xyz);
        u_xlat34 = max(u_xlat34, 0.0);
        u_xlat16_9.x = u_xlat34 + (-unity_LightAtten[7].x);
        u_xlat16_9.x = u_xlat16_9.x * unity_LightAtten[7].y;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
#else
        u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_8 = u_xlat16_8 * 0.5;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat3.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_20.xyz = u_xlat16_9.xxx * _Color.xyz;
        u_xlat16_20.xyz = u_xlat16_20.xyz * unity_LightColor[7].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb34 = !!(0.0<u_xlat16_9.x);
#else
        u_xlatb34 = 0.0<u_xlat16_9.x;
#endif
        u_xlat16_10.xyz = u_xlat0.xyz * vec3(u_xlat33) + (-u_xlat2.xyz);
        u_xlat16_9.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = inversesqrt(u_xlat16_9.x);
        u_xlat16_10.xyz = u_xlat16_9.xxx * u_xlat16_10.xyz;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_9.x = log2(u_xlat16_9.x);
        u_xlat16_40 = u_xlat16_40 * u_xlat16_9.x;
        u_xlat16_40 = exp2(u_xlat16_40);
        u_xlat16_40 = min(u_xlat16_40, 1.0);
        u_xlat16_40 = u_xlat16_40 * u_xlat16_8;
        u_xlat16_10.xyz = vec3(u_xlat16_40) * unity_LightColor[7].xyz + u_xlat16_19.xyz;
        u_xlat16_19.xyz = (bool(u_xlatb34)) ? u_xlat16_10.xyz : u_xlat16_19.xyz;
        u_xlat16_9.xyz = vec3(u_xlat16_8) * u_xlat16_20.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_9.xyz;
    //ENDIF
    }
    vs_COLOR1.xyz = u_xlat16_19.xyz * _SpecColor.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR1.xyz = min(max(vs_COLOR1.xyz, 0.0), 1.0);
#else
    vs_COLOR1.xyz = clamp(vs_COLOR1.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.xyz = u_xlat16_7.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_COLOR1;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vs_COLOR1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPOT" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec4 _Emission;
uniform 	mediump float _Shininess;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_COLOR1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
bool u_xlatb15;
mediump vec3 u_xlat16_19;
mediump vec3 u_xlat16_20;
float u_xlat33;
int u_xlati33;
bool u_xlatb33;
float u_xlat34;
bool u_xlatb34;
float u_xlat35;
bool u_xlatb35;
float u_xlat36;
bool u_xlatb36;
mediump float u_xlat16_40;
mediump float u_xlat16_42;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
    u_xlat33 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat1.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat2.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_7.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + _Emission.xyz;
    u_xlat16_40 = _Shininess * 128.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(0<unity_VertexLightParams.x);
#else
    u_xlatb33 = 0<unity_VertexLightParams.x;
#endif
    if(u_xlatb33){
        u_xlat3.xyz = (-u_xlat0.xyz) * unity_LightPosition[0].www + unity_LightPosition[0].xyz;
        u_xlat33 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat34 = unity_LightAtten[0].z * u_xlat33 + 1.0;
        u_xlat34 = float(1.0) / u_xlat34;
#ifdef UNITY_ADRENO_ES3
        u_xlatb35 = !!(unity_LightPosition[0].w!=0.0);
#else
        u_xlatb35 = unity_LightPosition[0].w!=0.0;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb36 = !!(unity_LightAtten[0].w<u_xlat33);
#else
        u_xlatb36 = unity_LightAtten[0].w<u_xlat33;
#endif
        u_xlatb35 = u_xlatb35 && u_xlatb36;
        u_xlat16_8 = (u_xlatb35) ? 0.0 : u_xlat34;
        u_xlat33 = max(u_xlat33, 9.99999997e-007);
        u_xlat33 = inversesqrt(u_xlat33);
        u_xlat4.xyz = vec3(u_xlat33) * u_xlat3.xyz;
        u_xlat34 = dot(u_xlat4.xyz, unity_SpotDirection[0].xyz);
        u_xlat34 = max(u_xlat34, 0.0);
        u_xlat16_19.x = u_xlat34 + (-unity_LightAtten[0].x);
        u_xlat16_19.x = u_xlat16_19.x * unity_LightAtten[0].y;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_19.x = min(max(u_xlat16_19.x, 0.0), 1.0);
#else
        u_xlat16_19.x = clamp(u_xlat16_19.x, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_19.x * u_xlat16_8;
        u_xlat16_8 = u_xlat16_8 * 0.5;
        u_xlat16_19.x = dot(u_xlat1.xyz, u_xlat4.xyz);
        u_xlat16_19.x = max(u_xlat16_19.x, 0.0);
        u_xlat16_9.xyz = u_xlat16_19.xxx * _Color.xyz;
        u_xlat16_9.xyz = u_xlat16_9.xyz * unity_LightColor[0].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb34 = !!(0.0<u_xlat16_19.x);
#else
        u_xlatb34 = 0.0<u_xlat16_19.x;
#endif
        u_xlat16_19.xyz = u_xlat3.xyz * vec3(u_xlat33) + (-u_xlat2.xyz);
        u_xlat16_42 = dot(u_xlat16_19.xyz, u_xlat16_19.xyz);
        u_xlat16_42 = inversesqrt(u_xlat16_42);
        u_xlat16_19.xyz = u_xlat16_19.xyz * vec3(u_xlat16_42);
        u_xlat16_19.x = dot(u_xlat1.xyz, u_xlat16_19.xyz);
        u_xlat16_19.x = max(u_xlat16_19.x, 0.0);
        u_xlat16_19.x = log2(u_xlat16_19.x);
        u_xlat16_19.x = u_xlat16_40 * u_xlat16_19.x;
        u_xlat16_19.x = exp2(u_xlat16_19.x);
        u_xlat16_19.x = min(u_xlat16_19.x, 1.0);
        u_xlat16_19.x = u_xlat16_19.x * u_xlat16_8;
        u_xlat16_19.xyz = u_xlat16_19.xxx * unity_LightColor[0].xyz;
        u_xlat16_19.xyz = (bool(u_xlatb34)) ? u_xlat16_19.xyz : vec3(0.0, 0.0, 0.0);
        u_xlat16_9.xyz = vec3(u_xlat16_8) * u_xlat16_9.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_9.xyz;
        u_xlati33 = 1;
    } else {
        u_xlat16_19.x = float(0.0);
        u_xlat16_19.y = float(0.0);
        u_xlat16_19.z = float(0.0);
        u_xlati33 = 0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(u_xlati33<unity_VertexLightParams.x);
#else
    u_xlatb34 = u_xlati33<unity_VertexLightParams.x;
#endif
    if(u_xlatb34){
        u_xlat3.xyz = (-u_xlat0.xyz) * unity_LightPosition[1].www + unity_LightPosition[1].xyz;
        u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat36 = unity_LightAtten[1].z * u_xlat35 + 1.0;
        u_xlat36 = float(1.0) / u_xlat36;
#ifdef UNITY_ADRENO_ES3
        u_xlatb4 = !!(unity_LightPosition[1].w!=0.0);
#else
        u_xlatb4 = unity_LightPosition[1].w!=0.0;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb15 = !!(unity_LightAtten[1].w<u_xlat35);
#else
        u_xlatb15 = unity_LightAtten[1].w<u_xlat35;
#endif
        u_xlatb4 = u_xlatb15 && u_xlatb4;
        u_xlat16_8 = (u_xlatb4) ? 0.0 : u_xlat36;
        u_xlat35 = max(u_xlat35, 9.99999997e-007);
        u_xlat35 = inversesqrt(u_xlat35);
        u_xlat4.xyz = vec3(u_xlat35) * u_xlat3.xyz;
        u_xlat36 = dot(u_xlat4.xyz, unity_SpotDirection[1].xyz);
        u_xlat36 = max(u_xlat36, 0.0);
        u_xlat16_9.x = u_xlat36 + (-unity_LightAtten[1].x);
        u_xlat16_9.x = u_xlat16_9.x * unity_LightAtten[1].y;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
#else
        u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_8 = u_xlat16_8 * 0.5;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat4.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_20.xyz = u_xlat16_9.xxx * _Color.xyz;
        u_xlat16_20.xyz = u_xlat16_20.xyz * unity_LightColor[1].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb36 = !!(0.0<u_xlat16_9.x);
#else
        u_xlatb36 = 0.0<u_xlat16_9.x;
#endif
        u_xlat16_10.xyz = u_xlat3.xyz * vec3(u_xlat35) + (-u_xlat2.xyz);
        u_xlat16_9.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = inversesqrt(u_xlat16_9.x);
        u_xlat16_10.xyz = u_xlat16_9.xxx * u_xlat16_10.xyz;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_9.x = log2(u_xlat16_9.x);
        u_xlat16_9.x = u_xlat16_40 * u_xlat16_9.x;
        u_xlat16_9.x = exp2(u_xlat16_9.x);
        u_xlat16_9.x = min(u_xlat16_9.x, 1.0);
        u_xlat16_9.x = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_10.xyz = u_xlat16_9.xxx * unity_LightColor[1].xyz + u_xlat16_19.xyz;
        u_xlat16_19.xyz = (bool(u_xlatb36)) ? u_xlat16_10.xyz : u_xlat16_19.xyz;
        u_xlat16_9.xyz = vec3(u_xlat16_8) * u_xlat16_20.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_9.xyz;
        u_xlati33 = 2;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb35 = !!(u_xlati33<unity_VertexLightParams.x);
#else
    u_xlatb35 = u_xlati33<unity_VertexLightParams.x;
#endif
    u_xlatb34 = u_xlatb34 && u_xlatb35;
    if(u_xlatb34){
        u_xlat3.xyz = (-u_xlat0.xyz) * unity_LightPosition[2].www + unity_LightPosition[2].xyz;
        u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat36 = unity_LightAtten[2].z * u_xlat35 + 1.0;
        u_xlat36 = float(1.0) / u_xlat36;
#ifdef UNITY_ADRENO_ES3
        u_xlatb4 = !!(unity_LightPosition[2].w!=0.0);
#else
        u_xlatb4 = unity_LightPosition[2].w!=0.0;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb15 = !!(unity_LightAtten[2].w<u_xlat35);
#else
        u_xlatb15 = unity_LightAtten[2].w<u_xlat35;
#endif
        u_xlatb4 = u_xlatb15 && u_xlatb4;
        u_xlat16_8 = (u_xlatb4) ? 0.0 : u_xlat36;
        u_xlat35 = max(u_xlat35, 9.99999997e-007);
        u_xlat35 = inversesqrt(u_xlat35);
        u_xlat4.xyz = vec3(u_xlat35) * u_xlat3.xyz;
        u_xlat36 = dot(u_xlat4.xyz, unity_SpotDirection[2].xyz);
        u_xlat36 = max(u_xlat36, 0.0);
        u_xlat16_9.x = u_xlat36 + (-unity_LightAtten[2].x);
        u_xlat16_9.x = u_xlat16_9.x * unity_LightAtten[2].y;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
#else
        u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_8 = u_xlat16_8 * 0.5;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat4.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_20.xyz = u_xlat16_9.xxx * _Color.xyz;
        u_xlat16_20.xyz = u_xlat16_20.xyz * unity_LightColor[2].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb36 = !!(0.0<u_xlat16_9.x);
#else
        u_xlatb36 = 0.0<u_xlat16_9.x;
#endif
        u_xlat16_10.xyz = u_xlat3.xyz * vec3(u_xlat35) + (-u_xlat2.xyz);
        u_xlat16_9.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = inversesqrt(u_xlat16_9.x);
        u_xlat16_10.xyz = u_xlat16_9.xxx * u_xlat16_10.xyz;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_9.x = log2(u_xlat16_9.x);
        u_xlat16_9.x = u_xlat16_40 * u_xlat16_9.x;
        u_xlat16_9.x = exp2(u_xlat16_9.x);
        u_xlat16_9.x = min(u_xlat16_9.x, 1.0);
        u_xlat16_9.x = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_10.xyz = u_xlat16_9.xxx * unity_LightColor[2].xyz + u_xlat16_19.xyz;
        u_xlat16_19.xyz = (bool(u_xlatb36)) ? u_xlat16_10.xyz : u_xlat16_19.xyz;
        u_xlat16_9.xyz = vec3(u_xlat16_8) * u_xlat16_20.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_9.xyz;
        u_xlati33 = 3;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb35 = !!(u_xlati33<unity_VertexLightParams.x);
#else
    u_xlatb35 = u_xlati33<unity_VertexLightParams.x;
#endif
    u_xlatb34 = u_xlatb34 && u_xlatb35;
    if(u_xlatb34){
        u_xlat3.xyz = (-u_xlat0.xyz) * unity_LightPosition[3].www + unity_LightPosition[3].xyz;
        u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat36 = unity_LightAtten[3].z * u_xlat35 + 1.0;
        u_xlat36 = float(1.0) / u_xlat36;
#ifdef UNITY_ADRENO_ES3
        u_xlatb4 = !!(unity_LightPosition[3].w!=0.0);
#else
        u_xlatb4 = unity_LightPosition[3].w!=0.0;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb15 = !!(unity_LightAtten[3].w<u_xlat35);
#else
        u_xlatb15 = unity_LightAtten[3].w<u_xlat35;
#endif
        u_xlatb4 = u_xlatb15 && u_xlatb4;
        u_xlat16_8 = (u_xlatb4) ? 0.0 : u_xlat36;
        u_xlat35 = max(u_xlat35, 9.99999997e-007);
        u_xlat35 = inversesqrt(u_xlat35);
        u_xlat4.xyz = vec3(u_xlat35) * u_xlat3.xyz;
        u_xlat36 = dot(u_xlat4.xyz, unity_SpotDirection[3].xyz);
        u_xlat36 = max(u_xlat36, 0.0);
        u_xlat16_9.x = u_xlat36 + (-unity_LightAtten[3].x);
        u_xlat16_9.x = u_xlat16_9.x * unity_LightAtten[3].y;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
#else
        u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_8 = u_xlat16_8 * 0.5;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat4.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_20.xyz = u_xlat16_9.xxx * _Color.xyz;
        u_xlat16_20.xyz = u_xlat16_20.xyz * unity_LightColor[3].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb36 = !!(0.0<u_xlat16_9.x);
#else
        u_xlatb36 = 0.0<u_xlat16_9.x;
#endif
        u_xlat16_10.xyz = u_xlat3.xyz * vec3(u_xlat35) + (-u_xlat2.xyz);
        u_xlat16_9.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = inversesqrt(u_xlat16_9.x);
        u_xlat16_10.xyz = u_xlat16_9.xxx * u_xlat16_10.xyz;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_9.x = log2(u_xlat16_9.x);
        u_xlat16_9.x = u_xlat16_40 * u_xlat16_9.x;
        u_xlat16_9.x = exp2(u_xlat16_9.x);
        u_xlat16_9.x = min(u_xlat16_9.x, 1.0);
        u_xlat16_9.x = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_10.xyz = u_xlat16_9.xxx * unity_LightColor[3].xyz + u_xlat16_19.xyz;
        u_xlat16_19.xyz = (bool(u_xlatb36)) ? u_xlat16_10.xyz : u_xlat16_19.xyz;
        u_xlat16_9.xyz = vec3(u_xlat16_8) * u_xlat16_20.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_9.xyz;
        u_xlati33 = 4;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb35 = !!(u_xlati33<unity_VertexLightParams.x);
#else
    u_xlatb35 = u_xlati33<unity_VertexLightParams.x;
#endif
    u_xlatb34 = u_xlatb34 && u_xlatb35;
    if(u_xlatb34){
        u_xlat3.xyz = (-u_xlat0.xyz) * unity_LightPosition[4].www + unity_LightPosition[4].xyz;
        u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat36 = unity_LightAtten[4].z * u_xlat35 + 1.0;
        u_xlat36 = float(1.0) / u_xlat36;
#ifdef UNITY_ADRENO_ES3
        u_xlatb4 = !!(unity_LightPosition[4].w!=0.0);
#else
        u_xlatb4 = unity_LightPosition[4].w!=0.0;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb15 = !!(unity_LightAtten[4].w<u_xlat35);
#else
        u_xlatb15 = unity_LightAtten[4].w<u_xlat35;
#endif
        u_xlatb4 = u_xlatb15 && u_xlatb4;
        u_xlat16_8 = (u_xlatb4) ? 0.0 : u_xlat36;
        u_xlat35 = max(u_xlat35, 9.99999997e-007);
        u_xlat35 = inversesqrt(u_xlat35);
        u_xlat4.xyz = vec3(u_xlat35) * u_xlat3.xyz;
        u_xlat36 = dot(u_xlat4.xyz, unity_SpotDirection[4].xyz);
        u_xlat36 = max(u_xlat36, 0.0);
        u_xlat16_9.x = u_xlat36 + (-unity_LightAtten[4].x);
        u_xlat16_9.x = u_xlat16_9.x * unity_LightAtten[4].y;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
#else
        u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_8 = u_xlat16_8 * 0.5;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat4.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_20.xyz = u_xlat16_9.xxx * _Color.xyz;
        u_xlat16_20.xyz = u_xlat16_20.xyz * unity_LightColor[4].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb36 = !!(0.0<u_xlat16_9.x);
#else
        u_xlatb36 = 0.0<u_xlat16_9.x;
#endif
        u_xlat16_10.xyz = u_xlat3.xyz * vec3(u_xlat35) + (-u_xlat2.xyz);
        u_xlat16_9.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = inversesqrt(u_xlat16_9.x);
        u_xlat16_10.xyz = u_xlat16_9.xxx * u_xlat16_10.xyz;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_9.x = log2(u_xlat16_9.x);
        u_xlat16_9.x = u_xlat16_40 * u_xlat16_9.x;
        u_xlat16_9.x = exp2(u_xlat16_9.x);
        u_xlat16_9.x = min(u_xlat16_9.x, 1.0);
        u_xlat16_9.x = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_10.xyz = u_xlat16_9.xxx * unity_LightColor[4].xyz + u_xlat16_19.xyz;
        u_xlat16_19.xyz = (bool(u_xlatb36)) ? u_xlat16_10.xyz : u_xlat16_19.xyz;
        u_xlat16_9.xyz = vec3(u_xlat16_8) * u_xlat16_20.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_9.xyz;
        u_xlati33 = 5;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb35 = !!(u_xlati33<unity_VertexLightParams.x);
#else
    u_xlatb35 = u_xlati33<unity_VertexLightParams.x;
#endif
    u_xlatb34 = u_xlatb34 && u_xlatb35;
    if(u_xlatb34){
        u_xlat3.xyz = (-u_xlat0.xyz) * unity_LightPosition[5].www + unity_LightPosition[5].xyz;
        u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat36 = unity_LightAtten[5].z * u_xlat35 + 1.0;
        u_xlat36 = float(1.0) / u_xlat36;
#ifdef UNITY_ADRENO_ES3
        u_xlatb4 = !!(unity_LightPosition[5].w!=0.0);
#else
        u_xlatb4 = unity_LightPosition[5].w!=0.0;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb15 = !!(unity_LightAtten[5].w<u_xlat35);
#else
        u_xlatb15 = unity_LightAtten[5].w<u_xlat35;
#endif
        u_xlatb4 = u_xlatb15 && u_xlatb4;
        u_xlat16_8 = (u_xlatb4) ? 0.0 : u_xlat36;
        u_xlat35 = max(u_xlat35, 9.99999997e-007);
        u_xlat35 = inversesqrt(u_xlat35);
        u_xlat4.xyz = vec3(u_xlat35) * u_xlat3.xyz;
        u_xlat36 = dot(u_xlat4.xyz, unity_SpotDirection[5].xyz);
        u_xlat36 = max(u_xlat36, 0.0);
        u_xlat16_9.x = u_xlat36 + (-unity_LightAtten[5].x);
        u_xlat16_9.x = u_xlat16_9.x * unity_LightAtten[5].y;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
#else
        u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_8 = u_xlat16_8 * 0.5;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat4.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_20.xyz = u_xlat16_9.xxx * _Color.xyz;
        u_xlat16_20.xyz = u_xlat16_20.xyz * unity_LightColor[5].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb36 = !!(0.0<u_xlat16_9.x);
#else
        u_xlatb36 = 0.0<u_xlat16_9.x;
#endif
        u_xlat16_10.xyz = u_xlat3.xyz * vec3(u_xlat35) + (-u_xlat2.xyz);
        u_xlat16_9.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = inversesqrt(u_xlat16_9.x);
        u_xlat16_10.xyz = u_xlat16_9.xxx * u_xlat16_10.xyz;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_9.x = log2(u_xlat16_9.x);
        u_xlat16_9.x = u_xlat16_40 * u_xlat16_9.x;
        u_xlat16_9.x = exp2(u_xlat16_9.x);
        u_xlat16_9.x = min(u_xlat16_9.x, 1.0);
        u_xlat16_9.x = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_10.xyz = u_xlat16_9.xxx * unity_LightColor[5].xyz + u_xlat16_19.xyz;
        u_xlat16_19.xyz = (bool(u_xlatb36)) ? u_xlat16_10.xyz : u_xlat16_19.xyz;
        u_xlat16_9.xyz = vec3(u_xlat16_8) * u_xlat16_20.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_9.xyz;
        u_xlati33 = 6;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb35 = !!(u_xlati33<unity_VertexLightParams.x);
#else
    u_xlatb35 = u_xlati33<unity_VertexLightParams.x;
#endif
    u_xlatb34 = u_xlatb34 && u_xlatb35;
    if(u_xlatb34){
        u_xlat3.xyz = (-u_xlat0.xyz) * unity_LightPosition[6].www + unity_LightPosition[6].xyz;
        u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat36 = unity_LightAtten[6].z * u_xlat35 + 1.0;
        u_xlat36 = float(1.0) / u_xlat36;
#ifdef UNITY_ADRENO_ES3
        u_xlatb4 = !!(unity_LightPosition[6].w!=0.0);
#else
        u_xlatb4 = unity_LightPosition[6].w!=0.0;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb15 = !!(unity_LightAtten[6].w<u_xlat35);
#else
        u_xlatb15 = unity_LightAtten[6].w<u_xlat35;
#endif
        u_xlatb4 = u_xlatb15 && u_xlatb4;
        u_xlat16_8 = (u_xlatb4) ? 0.0 : u_xlat36;
        u_xlat35 = max(u_xlat35, 9.99999997e-007);
        u_xlat35 = inversesqrt(u_xlat35);
        u_xlat4.xyz = vec3(u_xlat35) * u_xlat3.xyz;
        u_xlat36 = dot(u_xlat4.xyz, unity_SpotDirection[6].xyz);
        u_xlat36 = max(u_xlat36, 0.0);
        u_xlat16_9.x = u_xlat36 + (-unity_LightAtten[6].x);
        u_xlat16_9.x = u_xlat16_9.x * unity_LightAtten[6].y;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
#else
        u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_8 = u_xlat16_8 * 0.5;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat4.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_20.xyz = u_xlat16_9.xxx * _Color.xyz;
        u_xlat16_20.xyz = u_xlat16_20.xyz * unity_LightColor[6].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb36 = !!(0.0<u_xlat16_9.x);
#else
        u_xlatb36 = 0.0<u_xlat16_9.x;
#endif
        u_xlat16_10.xyz = u_xlat3.xyz * vec3(u_xlat35) + (-u_xlat2.xyz);
        u_xlat16_9.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = inversesqrt(u_xlat16_9.x);
        u_xlat16_10.xyz = u_xlat16_9.xxx * u_xlat16_10.xyz;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_9.x = log2(u_xlat16_9.x);
        u_xlat16_9.x = u_xlat16_40 * u_xlat16_9.x;
        u_xlat16_9.x = exp2(u_xlat16_9.x);
        u_xlat16_9.x = min(u_xlat16_9.x, 1.0);
        u_xlat16_9.x = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_10.xyz = u_xlat16_9.xxx * unity_LightColor[6].xyz + u_xlat16_19.xyz;
        u_xlat16_19.xyz = (bool(u_xlatb36)) ? u_xlat16_10.xyz : u_xlat16_19.xyz;
        u_xlat16_9.xyz = vec3(u_xlat16_8) * u_xlat16_20.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_9.xyz;
        u_xlati33 = 7;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlati33<unity_VertexLightParams.x);
#else
    u_xlatb33 = u_xlati33<unity_VertexLightParams.x;
#endif
    u_xlatb33 = u_xlatb33 && u_xlatb34;
    if(u_xlatb33){
        u_xlat0.xyz = (-u_xlat0.xyz) * unity_LightPosition[7].www + unity_LightPosition[7].xyz;
        u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat34 = unity_LightAtten[7].z * u_xlat33 + 1.0;
        u_xlat34 = float(1.0) / u_xlat34;
#ifdef UNITY_ADRENO_ES3
        u_xlatb35 = !!(unity_LightPosition[7].w!=0.0);
#else
        u_xlatb35 = unity_LightPosition[7].w!=0.0;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb3 = !!(unity_LightAtten[7].w<u_xlat33);
#else
        u_xlatb3 = unity_LightAtten[7].w<u_xlat33;
#endif
        u_xlatb35 = u_xlatb35 && u_xlatb3;
        u_xlat16_8 = (u_xlatb35) ? 0.0 : u_xlat34;
        u_xlat33 = max(u_xlat33, 9.99999997e-007);
        u_xlat33 = inversesqrt(u_xlat33);
        u_xlat3.xyz = vec3(u_xlat33) * u_xlat0.xyz;
        u_xlat34 = dot(u_xlat3.xyz, unity_SpotDirection[7].xyz);
        u_xlat34 = max(u_xlat34, 0.0);
        u_xlat16_9.x = u_xlat34 + (-unity_LightAtten[7].x);
        u_xlat16_9.x = u_xlat16_9.x * unity_LightAtten[7].y;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
#else
        u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_8 = u_xlat16_8 * 0.5;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat3.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_20.xyz = u_xlat16_9.xxx * _Color.xyz;
        u_xlat16_20.xyz = u_xlat16_20.xyz * unity_LightColor[7].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb34 = !!(0.0<u_xlat16_9.x);
#else
        u_xlatb34 = 0.0<u_xlat16_9.x;
#endif
        u_xlat16_10.xyz = u_xlat0.xyz * vec3(u_xlat33) + (-u_xlat2.xyz);
        u_xlat16_9.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = inversesqrt(u_xlat16_9.x);
        u_xlat16_10.xyz = u_xlat16_9.xxx * u_xlat16_10.xyz;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_9.x = log2(u_xlat16_9.x);
        u_xlat16_40 = u_xlat16_40 * u_xlat16_9.x;
        u_xlat16_40 = exp2(u_xlat16_40);
        u_xlat16_40 = min(u_xlat16_40, 1.0);
        u_xlat16_40 = u_xlat16_40 * u_xlat16_8;
        u_xlat16_10.xyz = vec3(u_xlat16_40) * unity_LightColor[7].xyz + u_xlat16_19.xyz;
        u_xlat16_19.xyz = (bool(u_xlatb34)) ? u_xlat16_10.xyz : u_xlat16_19.xyz;
        u_xlat16_9.xyz = vec3(u_xlat16_8) * u_xlat16_20.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_9.xyz;
    //ENDIF
    }
    vs_COLOR1.xyz = u_xlat16_19.xyz * _SpecColor.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR1.xyz = min(max(vs_COLOR1.xyz, 0.0), 1.0);
#else
    vs_COLOR1.xyz = clamp(vs_COLOR1.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.xyz = u_xlat16_7.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_COLOR1;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vs_COLOR1.xyz;
    SV_Target0.w = 1.0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPOT" }
"#ifdef VERTEX
#version 300 es

uniform 	mediump vec4 unity_LightColor[8];
uniform 	vec4 unity_LightPosition[8];
uniform 	mediump vec4 unity_LightAtten[8];
uniform 	vec4 unity_SpotDirection[8];
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	mediump vec4 glstate_lightmodel_ambient;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixInvV[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	mediump vec4 _Color;
uniform 	mediump vec4 _SpecColor;
uniform 	mediump vec4 _Emission;
uniform 	mediump float _Shininess;
uniform 	ivec4 unity_VertexLightParams;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_NORMAL0;
in highp vec3 in_TEXCOORD0;
out mediump vec4 vs_COLOR0;
out mediump vec3 vs_COLOR1;
out highp vec2 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
bool u_xlatb3;
vec3 u_xlat4;
bool u_xlatb4;
vec3 u_xlat5;
vec3 u_xlat6;
mediump vec3 u_xlat16_7;
mediump float u_xlat16_8;
mediump vec3 u_xlat16_9;
mediump vec3 u_xlat16_10;
bool u_xlatb15;
mediump vec3 u_xlat16_19;
mediump vec3 u_xlat16_20;
float u_xlat33;
int u_xlati33;
bool u_xlatb33;
float u_xlat34;
bool u_xlatb34;
float u_xlat35;
bool u_xlatb35;
float u_xlat36;
bool u_xlatb36;
mediump float u_xlat16_40;
mediump float u_xlat16_42;
void main()
{
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[0].www + u_xlat0.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_ObjectToWorld[1].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
    u_xlat1.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[1].www + u_xlat1.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
    u_xlat2.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[2].www + u_xlat2.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].yyy * hlslcc_mtx4x4unity_MatrixV[1].xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[0].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].xxx + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[2].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].zzz + u_xlat3.xyz;
    u_xlat3.xyz = hlslcc_mtx4x4unity_MatrixV[3].xyz * hlslcc_mtx4x4unity_ObjectToWorld[3].www + u_xlat3.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].yyy;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].xxx + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].zzz + u_xlat4.xyz;
    u_xlat4.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[0].www + u_xlat4.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].yyy;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].xxx + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].zzz + u_xlat5.xyz;
    u_xlat5.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[1].www + u_xlat5.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[1].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].yyy;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[0].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].xxx + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[2].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].zzz + u_xlat6.xyz;
    u_xlat6.xyz = hlslcc_mtx4x4unity_WorldToObject[3].xyz * hlslcc_mtx4x4unity_MatrixInvV[2].www + u_xlat6.xyz;
    u_xlat1.xyz = u_xlat1.xyz * in_POSITION0.yyy;
    u_xlat0.xyz = u_xlat0.xyz * in_POSITION0.xxx + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat2.xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
    u_xlat1.x = dot(u_xlat4.xyz, in_NORMAL0.xyz);
    u_xlat1.y = dot(u_xlat5.xyz, in_NORMAL0.xyz);
    u_xlat1.z = dot(u_xlat6.xyz, in_NORMAL0.xyz);
    u_xlat33 = dot(u_xlat1.xyz, u_xlat1.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat1.xyz = vec3(u_xlat33) * u_xlat1.xyz;
    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat33 = inversesqrt(u_xlat33);
    u_xlat2.xyz = vec3(u_xlat33) * u_xlat0.xyz;
    u_xlat16_7.xyz = _Color.xyz * glstate_lightmodel_ambient.xyz + _Emission.xyz;
    u_xlat16_40 = _Shininess * 128.0;
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(0<unity_VertexLightParams.x);
#else
    u_xlatb33 = 0<unity_VertexLightParams.x;
#endif
    if(u_xlatb33){
        u_xlat3.xyz = (-u_xlat0.xyz) * unity_LightPosition[0].www + unity_LightPosition[0].xyz;
        u_xlat33 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat34 = unity_LightAtten[0].z * u_xlat33 + 1.0;
        u_xlat34 = float(1.0) / u_xlat34;
#ifdef UNITY_ADRENO_ES3
        u_xlatb35 = !!(unity_LightPosition[0].w!=0.0);
#else
        u_xlatb35 = unity_LightPosition[0].w!=0.0;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb36 = !!(unity_LightAtten[0].w<u_xlat33);
#else
        u_xlatb36 = unity_LightAtten[0].w<u_xlat33;
#endif
        u_xlatb35 = u_xlatb35 && u_xlatb36;
        u_xlat16_8 = (u_xlatb35) ? 0.0 : u_xlat34;
        u_xlat33 = max(u_xlat33, 9.99999997e-007);
        u_xlat33 = inversesqrt(u_xlat33);
        u_xlat4.xyz = vec3(u_xlat33) * u_xlat3.xyz;
        u_xlat34 = dot(u_xlat4.xyz, unity_SpotDirection[0].xyz);
        u_xlat34 = max(u_xlat34, 0.0);
        u_xlat16_19.x = u_xlat34 + (-unity_LightAtten[0].x);
        u_xlat16_19.x = u_xlat16_19.x * unity_LightAtten[0].y;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_19.x = min(max(u_xlat16_19.x, 0.0), 1.0);
#else
        u_xlat16_19.x = clamp(u_xlat16_19.x, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_19.x * u_xlat16_8;
        u_xlat16_8 = u_xlat16_8 * 0.5;
        u_xlat16_19.x = dot(u_xlat1.xyz, u_xlat4.xyz);
        u_xlat16_19.x = max(u_xlat16_19.x, 0.0);
        u_xlat16_9.xyz = u_xlat16_19.xxx * _Color.xyz;
        u_xlat16_9.xyz = u_xlat16_9.xyz * unity_LightColor[0].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb34 = !!(0.0<u_xlat16_19.x);
#else
        u_xlatb34 = 0.0<u_xlat16_19.x;
#endif
        u_xlat16_19.xyz = u_xlat3.xyz * vec3(u_xlat33) + (-u_xlat2.xyz);
        u_xlat16_42 = dot(u_xlat16_19.xyz, u_xlat16_19.xyz);
        u_xlat16_42 = inversesqrt(u_xlat16_42);
        u_xlat16_19.xyz = u_xlat16_19.xyz * vec3(u_xlat16_42);
        u_xlat16_19.x = dot(u_xlat1.xyz, u_xlat16_19.xyz);
        u_xlat16_19.x = max(u_xlat16_19.x, 0.0);
        u_xlat16_19.x = log2(u_xlat16_19.x);
        u_xlat16_19.x = u_xlat16_40 * u_xlat16_19.x;
        u_xlat16_19.x = exp2(u_xlat16_19.x);
        u_xlat16_19.x = min(u_xlat16_19.x, 1.0);
        u_xlat16_19.x = u_xlat16_19.x * u_xlat16_8;
        u_xlat16_19.xyz = u_xlat16_19.xxx * unity_LightColor[0].xyz;
        u_xlat16_19.xyz = (bool(u_xlatb34)) ? u_xlat16_19.xyz : vec3(0.0, 0.0, 0.0);
        u_xlat16_9.xyz = vec3(u_xlat16_8) * u_xlat16_9.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_9.xyz;
        u_xlati33 = 1;
    } else {
        u_xlat16_19.x = float(0.0);
        u_xlat16_19.y = float(0.0);
        u_xlat16_19.z = float(0.0);
        u_xlati33 = 0;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb34 = !!(u_xlati33<unity_VertexLightParams.x);
#else
    u_xlatb34 = u_xlati33<unity_VertexLightParams.x;
#endif
    if(u_xlatb34){
        u_xlat3.xyz = (-u_xlat0.xyz) * unity_LightPosition[1].www + unity_LightPosition[1].xyz;
        u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat36 = unity_LightAtten[1].z * u_xlat35 + 1.0;
        u_xlat36 = float(1.0) / u_xlat36;
#ifdef UNITY_ADRENO_ES3
        u_xlatb4 = !!(unity_LightPosition[1].w!=0.0);
#else
        u_xlatb4 = unity_LightPosition[1].w!=0.0;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb15 = !!(unity_LightAtten[1].w<u_xlat35);
#else
        u_xlatb15 = unity_LightAtten[1].w<u_xlat35;
#endif
        u_xlatb4 = u_xlatb15 && u_xlatb4;
        u_xlat16_8 = (u_xlatb4) ? 0.0 : u_xlat36;
        u_xlat35 = max(u_xlat35, 9.99999997e-007);
        u_xlat35 = inversesqrt(u_xlat35);
        u_xlat4.xyz = vec3(u_xlat35) * u_xlat3.xyz;
        u_xlat36 = dot(u_xlat4.xyz, unity_SpotDirection[1].xyz);
        u_xlat36 = max(u_xlat36, 0.0);
        u_xlat16_9.x = u_xlat36 + (-unity_LightAtten[1].x);
        u_xlat16_9.x = u_xlat16_9.x * unity_LightAtten[1].y;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
#else
        u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_8 = u_xlat16_8 * 0.5;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat4.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_20.xyz = u_xlat16_9.xxx * _Color.xyz;
        u_xlat16_20.xyz = u_xlat16_20.xyz * unity_LightColor[1].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb36 = !!(0.0<u_xlat16_9.x);
#else
        u_xlatb36 = 0.0<u_xlat16_9.x;
#endif
        u_xlat16_10.xyz = u_xlat3.xyz * vec3(u_xlat35) + (-u_xlat2.xyz);
        u_xlat16_9.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = inversesqrt(u_xlat16_9.x);
        u_xlat16_10.xyz = u_xlat16_9.xxx * u_xlat16_10.xyz;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_9.x = log2(u_xlat16_9.x);
        u_xlat16_9.x = u_xlat16_40 * u_xlat16_9.x;
        u_xlat16_9.x = exp2(u_xlat16_9.x);
        u_xlat16_9.x = min(u_xlat16_9.x, 1.0);
        u_xlat16_9.x = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_10.xyz = u_xlat16_9.xxx * unity_LightColor[1].xyz + u_xlat16_19.xyz;
        u_xlat16_19.xyz = (bool(u_xlatb36)) ? u_xlat16_10.xyz : u_xlat16_19.xyz;
        u_xlat16_9.xyz = vec3(u_xlat16_8) * u_xlat16_20.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_9.xyz;
        u_xlati33 = 2;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb35 = !!(u_xlati33<unity_VertexLightParams.x);
#else
    u_xlatb35 = u_xlati33<unity_VertexLightParams.x;
#endif
    u_xlatb34 = u_xlatb34 && u_xlatb35;
    if(u_xlatb34){
        u_xlat3.xyz = (-u_xlat0.xyz) * unity_LightPosition[2].www + unity_LightPosition[2].xyz;
        u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat36 = unity_LightAtten[2].z * u_xlat35 + 1.0;
        u_xlat36 = float(1.0) / u_xlat36;
#ifdef UNITY_ADRENO_ES3
        u_xlatb4 = !!(unity_LightPosition[2].w!=0.0);
#else
        u_xlatb4 = unity_LightPosition[2].w!=0.0;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb15 = !!(unity_LightAtten[2].w<u_xlat35);
#else
        u_xlatb15 = unity_LightAtten[2].w<u_xlat35;
#endif
        u_xlatb4 = u_xlatb15 && u_xlatb4;
        u_xlat16_8 = (u_xlatb4) ? 0.0 : u_xlat36;
        u_xlat35 = max(u_xlat35, 9.99999997e-007);
        u_xlat35 = inversesqrt(u_xlat35);
        u_xlat4.xyz = vec3(u_xlat35) * u_xlat3.xyz;
        u_xlat36 = dot(u_xlat4.xyz, unity_SpotDirection[2].xyz);
        u_xlat36 = max(u_xlat36, 0.0);
        u_xlat16_9.x = u_xlat36 + (-unity_LightAtten[2].x);
        u_xlat16_9.x = u_xlat16_9.x * unity_LightAtten[2].y;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
#else
        u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_8 = u_xlat16_8 * 0.5;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat4.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_20.xyz = u_xlat16_9.xxx * _Color.xyz;
        u_xlat16_20.xyz = u_xlat16_20.xyz * unity_LightColor[2].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb36 = !!(0.0<u_xlat16_9.x);
#else
        u_xlatb36 = 0.0<u_xlat16_9.x;
#endif
        u_xlat16_10.xyz = u_xlat3.xyz * vec3(u_xlat35) + (-u_xlat2.xyz);
        u_xlat16_9.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = inversesqrt(u_xlat16_9.x);
        u_xlat16_10.xyz = u_xlat16_9.xxx * u_xlat16_10.xyz;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_9.x = log2(u_xlat16_9.x);
        u_xlat16_9.x = u_xlat16_40 * u_xlat16_9.x;
        u_xlat16_9.x = exp2(u_xlat16_9.x);
        u_xlat16_9.x = min(u_xlat16_9.x, 1.0);
        u_xlat16_9.x = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_10.xyz = u_xlat16_9.xxx * unity_LightColor[2].xyz + u_xlat16_19.xyz;
        u_xlat16_19.xyz = (bool(u_xlatb36)) ? u_xlat16_10.xyz : u_xlat16_19.xyz;
        u_xlat16_9.xyz = vec3(u_xlat16_8) * u_xlat16_20.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_9.xyz;
        u_xlati33 = 3;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb35 = !!(u_xlati33<unity_VertexLightParams.x);
#else
    u_xlatb35 = u_xlati33<unity_VertexLightParams.x;
#endif
    u_xlatb34 = u_xlatb34 && u_xlatb35;
    if(u_xlatb34){
        u_xlat3.xyz = (-u_xlat0.xyz) * unity_LightPosition[3].www + unity_LightPosition[3].xyz;
        u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat36 = unity_LightAtten[3].z * u_xlat35 + 1.0;
        u_xlat36 = float(1.0) / u_xlat36;
#ifdef UNITY_ADRENO_ES3
        u_xlatb4 = !!(unity_LightPosition[3].w!=0.0);
#else
        u_xlatb4 = unity_LightPosition[3].w!=0.0;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb15 = !!(unity_LightAtten[3].w<u_xlat35);
#else
        u_xlatb15 = unity_LightAtten[3].w<u_xlat35;
#endif
        u_xlatb4 = u_xlatb15 && u_xlatb4;
        u_xlat16_8 = (u_xlatb4) ? 0.0 : u_xlat36;
        u_xlat35 = max(u_xlat35, 9.99999997e-007);
        u_xlat35 = inversesqrt(u_xlat35);
        u_xlat4.xyz = vec3(u_xlat35) * u_xlat3.xyz;
        u_xlat36 = dot(u_xlat4.xyz, unity_SpotDirection[3].xyz);
        u_xlat36 = max(u_xlat36, 0.0);
        u_xlat16_9.x = u_xlat36 + (-unity_LightAtten[3].x);
        u_xlat16_9.x = u_xlat16_9.x * unity_LightAtten[3].y;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
#else
        u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_8 = u_xlat16_8 * 0.5;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat4.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_20.xyz = u_xlat16_9.xxx * _Color.xyz;
        u_xlat16_20.xyz = u_xlat16_20.xyz * unity_LightColor[3].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb36 = !!(0.0<u_xlat16_9.x);
#else
        u_xlatb36 = 0.0<u_xlat16_9.x;
#endif
        u_xlat16_10.xyz = u_xlat3.xyz * vec3(u_xlat35) + (-u_xlat2.xyz);
        u_xlat16_9.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = inversesqrt(u_xlat16_9.x);
        u_xlat16_10.xyz = u_xlat16_9.xxx * u_xlat16_10.xyz;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_9.x = log2(u_xlat16_9.x);
        u_xlat16_9.x = u_xlat16_40 * u_xlat16_9.x;
        u_xlat16_9.x = exp2(u_xlat16_9.x);
        u_xlat16_9.x = min(u_xlat16_9.x, 1.0);
        u_xlat16_9.x = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_10.xyz = u_xlat16_9.xxx * unity_LightColor[3].xyz + u_xlat16_19.xyz;
        u_xlat16_19.xyz = (bool(u_xlatb36)) ? u_xlat16_10.xyz : u_xlat16_19.xyz;
        u_xlat16_9.xyz = vec3(u_xlat16_8) * u_xlat16_20.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_9.xyz;
        u_xlati33 = 4;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb35 = !!(u_xlati33<unity_VertexLightParams.x);
#else
    u_xlatb35 = u_xlati33<unity_VertexLightParams.x;
#endif
    u_xlatb34 = u_xlatb34 && u_xlatb35;
    if(u_xlatb34){
        u_xlat3.xyz = (-u_xlat0.xyz) * unity_LightPosition[4].www + unity_LightPosition[4].xyz;
        u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat36 = unity_LightAtten[4].z * u_xlat35 + 1.0;
        u_xlat36 = float(1.0) / u_xlat36;
#ifdef UNITY_ADRENO_ES3
        u_xlatb4 = !!(unity_LightPosition[4].w!=0.0);
#else
        u_xlatb4 = unity_LightPosition[4].w!=0.0;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb15 = !!(unity_LightAtten[4].w<u_xlat35);
#else
        u_xlatb15 = unity_LightAtten[4].w<u_xlat35;
#endif
        u_xlatb4 = u_xlatb15 && u_xlatb4;
        u_xlat16_8 = (u_xlatb4) ? 0.0 : u_xlat36;
        u_xlat35 = max(u_xlat35, 9.99999997e-007);
        u_xlat35 = inversesqrt(u_xlat35);
        u_xlat4.xyz = vec3(u_xlat35) * u_xlat3.xyz;
        u_xlat36 = dot(u_xlat4.xyz, unity_SpotDirection[4].xyz);
        u_xlat36 = max(u_xlat36, 0.0);
        u_xlat16_9.x = u_xlat36 + (-unity_LightAtten[4].x);
        u_xlat16_9.x = u_xlat16_9.x * unity_LightAtten[4].y;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
#else
        u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_8 = u_xlat16_8 * 0.5;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat4.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_20.xyz = u_xlat16_9.xxx * _Color.xyz;
        u_xlat16_20.xyz = u_xlat16_20.xyz * unity_LightColor[4].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb36 = !!(0.0<u_xlat16_9.x);
#else
        u_xlatb36 = 0.0<u_xlat16_9.x;
#endif
        u_xlat16_10.xyz = u_xlat3.xyz * vec3(u_xlat35) + (-u_xlat2.xyz);
        u_xlat16_9.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = inversesqrt(u_xlat16_9.x);
        u_xlat16_10.xyz = u_xlat16_9.xxx * u_xlat16_10.xyz;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_9.x = log2(u_xlat16_9.x);
        u_xlat16_9.x = u_xlat16_40 * u_xlat16_9.x;
        u_xlat16_9.x = exp2(u_xlat16_9.x);
        u_xlat16_9.x = min(u_xlat16_9.x, 1.0);
        u_xlat16_9.x = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_10.xyz = u_xlat16_9.xxx * unity_LightColor[4].xyz + u_xlat16_19.xyz;
        u_xlat16_19.xyz = (bool(u_xlatb36)) ? u_xlat16_10.xyz : u_xlat16_19.xyz;
        u_xlat16_9.xyz = vec3(u_xlat16_8) * u_xlat16_20.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_9.xyz;
        u_xlati33 = 5;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb35 = !!(u_xlati33<unity_VertexLightParams.x);
#else
    u_xlatb35 = u_xlati33<unity_VertexLightParams.x;
#endif
    u_xlatb34 = u_xlatb34 && u_xlatb35;
    if(u_xlatb34){
        u_xlat3.xyz = (-u_xlat0.xyz) * unity_LightPosition[5].www + unity_LightPosition[5].xyz;
        u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat36 = unity_LightAtten[5].z * u_xlat35 + 1.0;
        u_xlat36 = float(1.0) / u_xlat36;
#ifdef UNITY_ADRENO_ES3
        u_xlatb4 = !!(unity_LightPosition[5].w!=0.0);
#else
        u_xlatb4 = unity_LightPosition[5].w!=0.0;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb15 = !!(unity_LightAtten[5].w<u_xlat35);
#else
        u_xlatb15 = unity_LightAtten[5].w<u_xlat35;
#endif
        u_xlatb4 = u_xlatb15 && u_xlatb4;
        u_xlat16_8 = (u_xlatb4) ? 0.0 : u_xlat36;
        u_xlat35 = max(u_xlat35, 9.99999997e-007);
        u_xlat35 = inversesqrt(u_xlat35);
        u_xlat4.xyz = vec3(u_xlat35) * u_xlat3.xyz;
        u_xlat36 = dot(u_xlat4.xyz, unity_SpotDirection[5].xyz);
        u_xlat36 = max(u_xlat36, 0.0);
        u_xlat16_9.x = u_xlat36 + (-unity_LightAtten[5].x);
        u_xlat16_9.x = u_xlat16_9.x * unity_LightAtten[5].y;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
#else
        u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_8 = u_xlat16_8 * 0.5;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat4.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_20.xyz = u_xlat16_9.xxx * _Color.xyz;
        u_xlat16_20.xyz = u_xlat16_20.xyz * unity_LightColor[5].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb36 = !!(0.0<u_xlat16_9.x);
#else
        u_xlatb36 = 0.0<u_xlat16_9.x;
#endif
        u_xlat16_10.xyz = u_xlat3.xyz * vec3(u_xlat35) + (-u_xlat2.xyz);
        u_xlat16_9.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = inversesqrt(u_xlat16_9.x);
        u_xlat16_10.xyz = u_xlat16_9.xxx * u_xlat16_10.xyz;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_9.x = log2(u_xlat16_9.x);
        u_xlat16_9.x = u_xlat16_40 * u_xlat16_9.x;
        u_xlat16_9.x = exp2(u_xlat16_9.x);
        u_xlat16_9.x = min(u_xlat16_9.x, 1.0);
        u_xlat16_9.x = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_10.xyz = u_xlat16_9.xxx * unity_LightColor[5].xyz + u_xlat16_19.xyz;
        u_xlat16_19.xyz = (bool(u_xlatb36)) ? u_xlat16_10.xyz : u_xlat16_19.xyz;
        u_xlat16_9.xyz = vec3(u_xlat16_8) * u_xlat16_20.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_9.xyz;
        u_xlati33 = 6;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb35 = !!(u_xlati33<unity_VertexLightParams.x);
#else
    u_xlatb35 = u_xlati33<unity_VertexLightParams.x;
#endif
    u_xlatb34 = u_xlatb34 && u_xlatb35;
    if(u_xlatb34){
        u_xlat3.xyz = (-u_xlat0.xyz) * unity_LightPosition[6].www + unity_LightPosition[6].xyz;
        u_xlat35 = dot(u_xlat3.xyz, u_xlat3.xyz);
        u_xlat36 = unity_LightAtten[6].z * u_xlat35 + 1.0;
        u_xlat36 = float(1.0) / u_xlat36;
#ifdef UNITY_ADRENO_ES3
        u_xlatb4 = !!(unity_LightPosition[6].w!=0.0);
#else
        u_xlatb4 = unity_LightPosition[6].w!=0.0;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb15 = !!(unity_LightAtten[6].w<u_xlat35);
#else
        u_xlatb15 = unity_LightAtten[6].w<u_xlat35;
#endif
        u_xlatb4 = u_xlatb15 && u_xlatb4;
        u_xlat16_8 = (u_xlatb4) ? 0.0 : u_xlat36;
        u_xlat35 = max(u_xlat35, 9.99999997e-007);
        u_xlat35 = inversesqrt(u_xlat35);
        u_xlat4.xyz = vec3(u_xlat35) * u_xlat3.xyz;
        u_xlat36 = dot(u_xlat4.xyz, unity_SpotDirection[6].xyz);
        u_xlat36 = max(u_xlat36, 0.0);
        u_xlat16_9.x = u_xlat36 + (-unity_LightAtten[6].x);
        u_xlat16_9.x = u_xlat16_9.x * unity_LightAtten[6].y;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
#else
        u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_8 = u_xlat16_8 * 0.5;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat4.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_20.xyz = u_xlat16_9.xxx * _Color.xyz;
        u_xlat16_20.xyz = u_xlat16_20.xyz * unity_LightColor[6].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb36 = !!(0.0<u_xlat16_9.x);
#else
        u_xlatb36 = 0.0<u_xlat16_9.x;
#endif
        u_xlat16_10.xyz = u_xlat3.xyz * vec3(u_xlat35) + (-u_xlat2.xyz);
        u_xlat16_9.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = inversesqrt(u_xlat16_9.x);
        u_xlat16_10.xyz = u_xlat16_9.xxx * u_xlat16_10.xyz;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_9.x = log2(u_xlat16_9.x);
        u_xlat16_9.x = u_xlat16_40 * u_xlat16_9.x;
        u_xlat16_9.x = exp2(u_xlat16_9.x);
        u_xlat16_9.x = min(u_xlat16_9.x, 1.0);
        u_xlat16_9.x = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_10.xyz = u_xlat16_9.xxx * unity_LightColor[6].xyz + u_xlat16_19.xyz;
        u_xlat16_19.xyz = (bool(u_xlatb36)) ? u_xlat16_10.xyz : u_xlat16_19.xyz;
        u_xlat16_9.xyz = vec3(u_xlat16_8) * u_xlat16_20.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_9.xyz;
        u_xlati33 = 7;
    //ENDIF
    }
#ifdef UNITY_ADRENO_ES3
    u_xlatb33 = !!(u_xlati33<unity_VertexLightParams.x);
#else
    u_xlatb33 = u_xlati33<unity_VertexLightParams.x;
#endif
    u_xlatb33 = u_xlatb33 && u_xlatb34;
    if(u_xlatb33){
        u_xlat0.xyz = (-u_xlat0.xyz) * unity_LightPosition[7].www + unity_LightPosition[7].xyz;
        u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
        u_xlat34 = unity_LightAtten[7].z * u_xlat33 + 1.0;
        u_xlat34 = float(1.0) / u_xlat34;
#ifdef UNITY_ADRENO_ES3
        u_xlatb35 = !!(unity_LightPosition[7].w!=0.0);
#else
        u_xlatb35 = unity_LightPosition[7].w!=0.0;
#endif
#ifdef UNITY_ADRENO_ES3
        u_xlatb3 = !!(unity_LightAtten[7].w<u_xlat33);
#else
        u_xlatb3 = unity_LightAtten[7].w<u_xlat33;
#endif
        u_xlatb35 = u_xlatb35 && u_xlatb3;
        u_xlat16_8 = (u_xlatb35) ? 0.0 : u_xlat34;
        u_xlat33 = max(u_xlat33, 9.99999997e-007);
        u_xlat33 = inversesqrt(u_xlat33);
        u_xlat3.xyz = vec3(u_xlat33) * u_xlat0.xyz;
        u_xlat34 = dot(u_xlat3.xyz, unity_SpotDirection[7].xyz);
        u_xlat34 = max(u_xlat34, 0.0);
        u_xlat16_9.x = u_xlat34 + (-unity_LightAtten[7].x);
        u_xlat16_9.x = u_xlat16_9.x * unity_LightAtten[7].y;
#ifdef UNITY_ADRENO_ES3
        u_xlat16_9.x = min(max(u_xlat16_9.x, 0.0), 1.0);
#else
        u_xlat16_9.x = clamp(u_xlat16_9.x, 0.0, 1.0);
#endif
        u_xlat16_8 = u_xlat16_8 * u_xlat16_9.x;
        u_xlat16_8 = u_xlat16_8 * 0.5;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat3.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_20.xyz = u_xlat16_9.xxx * _Color.xyz;
        u_xlat16_20.xyz = u_xlat16_20.xyz * unity_LightColor[7].xyz;
#ifdef UNITY_ADRENO_ES3
        u_xlatb34 = !!(0.0<u_xlat16_9.x);
#else
        u_xlatb34 = 0.0<u_xlat16_9.x;
#endif
        u_xlat16_10.xyz = u_xlat0.xyz * vec3(u_xlat33) + (-u_xlat2.xyz);
        u_xlat16_9.x = dot(u_xlat16_10.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = inversesqrt(u_xlat16_9.x);
        u_xlat16_10.xyz = u_xlat16_9.xxx * u_xlat16_10.xyz;
        u_xlat16_9.x = dot(u_xlat1.xyz, u_xlat16_10.xyz);
        u_xlat16_9.x = max(u_xlat16_9.x, 0.0);
        u_xlat16_9.x = log2(u_xlat16_9.x);
        u_xlat16_40 = u_xlat16_40 * u_xlat16_9.x;
        u_xlat16_40 = exp2(u_xlat16_40);
        u_xlat16_40 = min(u_xlat16_40, 1.0);
        u_xlat16_40 = u_xlat16_40 * u_xlat16_8;
        u_xlat16_10.xyz = vec3(u_xlat16_40) * unity_LightColor[7].xyz + u_xlat16_19.xyz;
        u_xlat16_19.xyz = (bool(u_xlatb34)) ? u_xlat16_10.xyz : u_xlat16_19.xyz;
        u_xlat16_9.xyz = vec3(u_xlat16_8) * u_xlat16_20.xyz;
        u_xlat16_9.xyz = min(u_xlat16_9.xyz, vec3(1.0, 1.0, 1.0));
        u_xlat16_7.xyz = u_xlat16_7.xyz + u_xlat16_9.xyz;
    //ENDIF
    }
    vs_COLOR1.xyz = u_xlat16_19.xyz * _SpecColor.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR1.xyz = min(max(vs_COLOR1.xyz, 0.0), 1.0);
#else
    vs_COLOR1.xyz = clamp(vs_COLOR1.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.xyz = u_xlat16_7.xyz;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.xyz = min(max(vs_COLOR0.xyz, 0.0), 1.0);
#else
    vs_COLOR0.xyz = clamp(vs_COLOR0.xyz, 0.0, 1.0);
#endif
    vs_COLOR0.w = _Color.w;
#ifdef UNITY_ADRENO_ES3
    vs_COLOR0.w = min(max(vs_COLOR0.w, 0.0), 1.0);
#else
    vs_COLOR0.w = clamp(vs_COLOR0.w, 0.0, 1.0);
#endif
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
in mediump vec4 vs_COLOR0;
in mediump vec3 vs_COLOR1;
in highp vec2 vs_TEXCOORD0;
layout(location = 0) out mediump vec4 SV_Target0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat10_0.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * vec3(2.0, 2.0, 2.0) + vs_COLOR1.xyz;
    SV_Target0.w = 1.0;
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
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "POINT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "POINT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SPOT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SPOT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SPOT" }
""
}
}
}
 Pass {
  LOD 100
  Tags { "LIGHTMODE" = "VertexLM" "RenderType" = "Opaque" }
  GpuProgramID 8257
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Lightmap_ST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_Lightmap_ST.xy) + unity_Lightmap_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tex_1;
  lowp vec4 col_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  mediump vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = (unity_Lightmap_HDR.x * tex_1.xyz);
  col_2 = (tmpvar_4 * _Color);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD2);
  tex_1 = tmpvar_5;
  col_2.xyz = (tmpvar_5.xyz * col_2.xyz);
  col_2.w = 1.0;
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Lightmap_ST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_Lightmap_ST.xy) + unity_Lightmap_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tex_1;
  lowp vec4 col_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  mediump vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = (unity_Lightmap_HDR.x * tex_1.xyz);
  col_2 = (tmpvar_4 * _Color);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD2);
  tex_1 = tmpvar_5;
  col_2.xyz = (tmpvar_5.xyz * col_2.xyz);
  col_2.w = 1.0;
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_Lightmap_ST;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_Lightmap_ST.xy) + unity_Lightmap_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tex_1;
  lowp vec4 col_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = texture2D (unity_Lightmap, xlv_TEXCOORD0);
  tex_1 = tmpvar_3;
  mediump vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = (unity_Lightmap_HDR.x * tex_1.xyz);
  col_2 = (tmpvar_4 * _Color);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD2);
  tex_1 = tmpvar_5;
  col_2.xyz = (tmpvar_5.xyz * col_2.xyz);
  col_2.w = 1.0;
  gl_FragData[0] = col_2;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_Lightmap_ST;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_TEXCOORD1;
in highp vec3 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * unity_Lightmap_ST.xy + unity_Lightmap_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat10_0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_Lightmap_ST;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_TEXCOORD1;
in highp vec3 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * unity_Lightmap_ST.xy + unity_Lightmap_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat10_0.xyz;
    SV_Target0.w = 1.0;
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
uniform 	vec4 unity_LightmapST;
uniform 	vec4 unity_Lightmap_ST;
uniform 	vec4 _MainTex_ST;
in highp vec3 in_POSITION0;
in highp vec3 in_TEXCOORD1;
in highp vec3 in_TEXCOORD0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_TEXCOORD0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * unity_Lightmap_ST.xy + unity_Lightmap_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
uniform 	mediump vec4 unity_Lightmap_HDR;
uniform 	mediump vec4 _Color;
uniform lowp sampler2D _MainTex;
uniform mediump sampler2D unity_Lightmap;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD2;
layout(location = 0) out mediump vec4 SV_Target0;
mediump vec3 u_xlat16_0;
lowp vec3 u_xlat10_0;
mediump vec3 u_xlat16_1;
void main()
{
    u_xlat16_0.xyz = texture(unity_Lightmap, vs_TEXCOORD0.xy).xyz;
    u_xlat16_1.xyz = u_xlat16_0.xyz * unity_Lightmap_HDR.xxx;
    u_xlat16_1.xyz = u_xlat16_1.xyz * _Color.xyz;
    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD2.xy).xyz;
    SV_Target0.xyz = u_xlat16_1.xyz * u_xlat10_0.xyz;
    SV_Target0.w = 1.0;
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
 Pass {
  Name "SHADOWCASTER"
  LOD 100
  Tags { "LIGHTMODE" = "SHADOWCASTER" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
  GpuProgramID 118440
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 wPos_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  wPos_2 = tmpvar_3;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp mat3 tmpvar_4;
    tmpvar_4[0] = unity_WorldToObject[0].xyz;
    tmpvar_4[1] = unity_WorldToObject[1].xyz;
    tmpvar_4[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_5;
    tmpvar_5 = normalize((_glesNormal * tmpvar_4));
    highp float tmpvar_6;
    tmpvar_6 = dot (tmpvar_5, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_3.xyz * _WorldSpaceLightPos0.w)
    )));
    wPos_2.xyz = (tmpvar_3.xyz - (tmpvar_5 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_6 * tmpvar_6)))
    )));
  };
  tmpvar_1 = (unity_MatrixVP * wPos_2);
  highp vec4 clipPos_7;
  clipPos_7.xyw = tmpvar_1.xyw;
  clipPos_7.z = (tmpvar_1.z + clamp ((unity_LightShadowBias.x / tmpvar_1.w), 0.0, 1.0));
  clipPos_7.z = mix (clipPos_7.z, max (clipPos_7.z, -(tmpvar_1.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_7;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 wPos_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  wPos_2 = tmpvar_3;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp mat3 tmpvar_4;
    tmpvar_4[0] = unity_WorldToObject[0].xyz;
    tmpvar_4[1] = unity_WorldToObject[1].xyz;
    tmpvar_4[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_5;
    tmpvar_5 = normalize((_glesNormal * tmpvar_4));
    highp float tmpvar_6;
    tmpvar_6 = dot (tmpvar_5, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_3.xyz * _WorldSpaceLightPos0.w)
    )));
    wPos_2.xyz = (tmpvar_3.xyz - (tmpvar_5 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_6 * tmpvar_6)))
    )));
  };
  tmpvar_1 = (unity_MatrixVP * wPos_2);
  highp vec4 clipPos_7;
  clipPos_7.xyw = tmpvar_1.xyw;
  clipPos_7.z = (tmpvar_1.z + clamp ((unity_LightShadowBias.x / tmpvar_1.w), 0.0, 1.0));
  clipPos_7.z = mix (clipPos_7.z, max (clipPos_7.z, -(tmpvar_1.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_7;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 unity_LightShadowBias;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 wPos_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  wPos_2 = tmpvar_3;
  if ((unity_LightShadowBias.z != 0.0)) {
    highp mat3 tmpvar_4;
    tmpvar_4[0] = unity_WorldToObject[0].xyz;
    tmpvar_4[1] = unity_WorldToObject[1].xyz;
    tmpvar_4[2] = unity_WorldToObject[2].xyz;
    highp vec3 tmpvar_5;
    tmpvar_5 = normalize((_glesNormal * tmpvar_4));
    highp float tmpvar_6;
    tmpvar_6 = dot (tmpvar_5, normalize((_WorldSpaceLightPos0.xyz - 
      (tmpvar_3.xyz * _WorldSpaceLightPos0.w)
    )));
    wPos_2.xyz = (tmpvar_3.xyz - (tmpvar_5 * (unity_LightShadowBias.z * 
      sqrt((1.0 - (tmpvar_6 * tmpvar_6)))
    )));
  };
  tmpvar_1 = (unity_MatrixVP * wPos_2);
  highp vec4 clipPos_7;
  clipPos_7.xyw = tmpvar_1.xyw;
  clipPos_7.z = (tmpvar_1.z + clamp ((unity_LightShadowBias.x / tmpvar_1.w), 0.0, 1.0));
  clipPos_7.z = mix (clipPos_7.z, max (clipPos_7.z, -(tmpvar_1.w)), unity_LightShadowBias.y);
  gl_Position = clipPos_7;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out highp vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out highp vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _WorldSpaceLightPos0;
uniform 	vec4 unity_LightShadowBias;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_WorldToObject[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
in highp vec3 in_NORMAL0;
vec4 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[0].xyz);
    u_xlat0.y = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[1].xyz);
    u_xlat0.z = dot(in_NORMAL0.xyz, hlslcc_mtx4x4unity_WorldToObject[2].xyz);
    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
    u_xlat9 = inversesqrt(u_xlat9);
    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
    u_xlat9 = sqrt(u_xlat9);
    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(unity_LightShadowBias.z!=0.0);
#else
    u_xlatb9 = unity_LightShadowBias.z!=0.0;
#endif
    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
    u_xlat2 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
#ifdef UNITY_ADRENO_ES3
    u_xlat1.x = min(max(u_xlat1.x, 0.0), 1.0);
#else
    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
#endif
    u_xlat6 = u_xlat0.z + u_xlat1.x;
    u_xlat1.x = max((-u_xlat0.w), u_xlat6);
    gl_Position.xyw = u_xlat0.xyw;
    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp int;
layout(location = 0) out highp vec4 SV_Target0;
void main()
{
    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_LightShadowBias;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
  , 0.999)));
  highp vec4 tmpvar_2;
  tmpvar_2 = (tmpvar_1 - (tmpvar_1.yzww * 0.003921569));
  gl_FragData[0] = tmpvar_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_LightShadowBias;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
  , 0.999)));
  highp vec4 tmpvar_2;
  tmpvar_2 = (tmpvar_1 - (tmpvar_1.yzww * 0.003921569));
  gl_FragData[0] = tmpvar_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _LightPositionRange;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((unity_ObjectToWorld * _glesVertex).xyz - _LightPositionRange.xyz);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_LightShadowBias;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = fract((vec4(1.0, 255.0, 65025.0, 1.658138e+07) * min (
    ((sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0)) + unity_LightShadowBias.x) * _LightPositionRange.w)
  , 0.999)));
  highp vec4 tmpvar_2;
  tmpvar_2 = (tmpvar_1 - (tmpvar_1.yzww * 0.003921569));
  gl_FragData[0] = tmpvar_2;
}


#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_CUBE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _LightPositionRange;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz + (-_LightPositionRange.xyz);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_LightShadowBias;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + unity_LightShadowBias.x;
    u_xlat0.x = u_xlat0.x * _LightPositionRange.w;
    u_xlat0.x = min(u_xlat0.x, 0.999000013);
    u_xlat0 = u_xlat0.xxxx * vec4(1.0, 255.0, 65025.0, 16581375.0);
    u_xlat0 = fract(u_xlat0);
    SV_Target0 = (-u_xlat0.yzww) * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886) + u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_CUBE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _LightPositionRange;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz + (-_LightPositionRange.xyz);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_LightShadowBias;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + unity_LightShadowBias.x;
    u_xlat0.x = u_xlat0.x * _LightPositionRange.w;
    u_xlat0.x = min(u_xlat0.x, 0.999000013);
    u_xlat0 = u_xlat0.xxxx * vec4(1.0, 255.0, 65025.0, 16581375.0);
    u_xlat0 = fract(u_xlat0);
    SV_Target0 = (-u_xlat0.yzww) * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886) + u_xlat0;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
"#ifdef VERTEX
#version 300 es

uniform 	vec4 _LightPositionRange;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
in highp vec4 in_POSITION0;
out highp vec3 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0.xyz = in_POSITION0.yyy * hlslcc_mtx4x4unity_ObjectToWorld[1].xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
    u_xlat0.xyz = hlslcc_mtx4x4unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
    vs_TEXCOORD0.xyz = u_xlat0.xyz + (-_LightPositionRange.xyz);
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
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
uniform 	vec4 _LightPositionRange;
uniform 	vec4 unity_LightShadowBias;
in highp vec3 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
void main()
{
    u_xlat0.x = dot(vs_TEXCOORD0.xyz, vs_TEXCOORD0.xyz);
    u_xlat0.x = sqrt(u_xlat0.x);
    u_xlat0.x = u_xlat0.x + unity_LightShadowBias.x;
    u_xlat0.x = u_xlat0.x * _LightPositionRange.w;
    u_xlat0.x = min(u_xlat0.x, 0.999000013);
    u_xlat0 = u_xlat0.xxxx * vec4(1.0, 255.0, 65025.0, 16581375.0);
    u_xlat0 = fract(u_xlat0);
    SV_Target0 = (-u_xlat0.yzww) * vec4(0.00392156886, 0.00392156886, 0.00392156886, 0.00392156886) + u_xlat0;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_DEPTH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "SHADOWS_CUBE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "SHADOWS_CUBE" }
""
}
}
}
}
}