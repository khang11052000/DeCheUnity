using System;
using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEditor;
using UnityEngine;

[CustomEditor(typeof(WayPoint))]
public class WayPointEditor : Editor
{
    WayPoint WayPoint => target as WayPoint;

    private void OnSceneGUI()
    {
        Handles.color = Color.red;
        for (int i = 0; i < WayPoint.Points.Length; i++)
        {
            EditorGUI.BeginChangeCheck();
            
            //Create Handles
            Vector3 currentWaypointPoint = WayPoint.CurrentPosition + WayPoint.Points[i];
            Vector3 newWaypointPoint = Handles.FreeMoveHandle(currentWaypointPoint, Quaternion.identity, 0.7f,
                new Vector3(0.3f, 0.3f, 0.3f), Handles.SphereHandleCap);
            
            //Create Text
            GUIStyle textStyle = new GUIStyle();
            textStyle.fontStyle = FontStyle.Bold;
            textStyle.fontSize = 16;
            textStyle.normal.textColor = Color.yellow;
            Vector3 textAlligment = Vector3.down * 0.35f + Vector3.right * 0.35f;
            Handles.Label(WayPoint.CurrentPosition + WayPoint.Points[i] + textAlligment, $"{i + 1}", textStyle);
            EditorGUI.EndChangeCheck();

            if (EditorGUI.EndChangeCheck())
            {
                Undo.RecordObject(target, "Free Move Handles");
                WayPoint.Points[i] = newWaypointPoint - WayPoint.CurrentPosition;   
            }
        }
    }
}
