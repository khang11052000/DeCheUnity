using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Enemy : MonoBehaviour
{
    [SerializeField] private float moveSpeed = 3f;
    [SerializeField] private WayPoint waypoint;

    public Vector3 CurrentPointPosition => waypoint.GetWaypointPosition(_currenWaypointIndex);
    
    private int _currenWaypointIndex;

    private void Start()
    {
        _currenWaypointIndex = 0;
    }

    private void Update()
    {
        Move();
        if (CurrentPointPositionReached())
        {
            UpdateCurrentPointIndex();
        }
    }

    private void Move()
    {
        Vector3 currentPostion = waypoint.GetWaypointPosition(_currenWaypointIndex);
        transform.position = Vector3.MoveTowards(transform.position, 
            currentPostion, moveSpeed * Time.deltaTime);
    }

    private bool CurrentPointPositionReached()
    {
        float distanceToNextPointPosition = (transform.position - CurrentPointPosition).magnitude;
        if (distanceToNextPointPosition < 0.1f)
        {
            return true;
        }

        return false;
    }

    private void UpdateCurrentPointIndex()
    {
        int lastWaypointIndex = waypoint.Points.Length - 1;
        if (_currenWaypointIndex < lastWaypointIndex)
        {
            _currenWaypointIndex++;
        }
    }
}
