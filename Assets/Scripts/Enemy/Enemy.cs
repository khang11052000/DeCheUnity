using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Enemy : MonoBehaviour
{
    public static Action OnEndReached;
    
    [SerializeField] private float moveSpeed = 3f;

    public WayPoint Waypoint { get; set; }
    
    public Vector3 CurrentPointPosition => Waypoint.GetWaypointPosition(_currenWaypointIndex);
    
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
        transform.position = Vector3.MoveTowards(transform.position, 
            CurrentPointPosition, moveSpeed * Time.deltaTime);
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
        int lastWaypointIndex = Waypoint.Points.Length - 1;
        if (_currenWaypointIndex < lastWaypointIndex)
        {
            _currenWaypointIndex++;
        }
        else
        {
            ReturnEnymyToPool();
        }
    }

    private void ReturnEnymyToPool()
    {
        OnEndReached?.Invoke();
        ObjectPooler.ReturnToPool(gameObject);
    }

    public void ResetEnemy()
    {
        _currenWaypointIndex = 0;
    }
}
