using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Enemy : MonoBehaviour
{
    public static Action<Enemy> OnEndReached;
    
    [SerializeField] private float moveSpeed = 3f;

    public float MoveSpeed { get; set; }
    public WayPoint Waypoint { get; set; }
    
    public EnemyHealth EnemyHealth { get; set; }
    
    // Return the current Point Position where this enemy needs to go
    public Vector3 CurrentPointPosition => Waypoint.GetWaypointPosition(_currenWaypointIndex);
    
    private int _currenWaypointIndex;
    private Vector3 _lastPointPosition;

    private EnemyHealth _enemyHealth;
    private SpriteRenderer _spriteRenderer;

    private void Start()
    {
        _enemyHealth = GetComponent<EnemyHealth>();
        _spriteRenderer = GetComponent<SpriteRenderer>();
        EnemyHealth = GetComponent<EnemyHealth>();
        
        _currenWaypointIndex = 0;
        MoveSpeed = moveSpeed;
        _lastPointPosition = transform.position;
    }

    private void Update()
    {
        Move();
        Rotate();
        if (CurrentPointPositionReached())
        {
            UpdateCurrentPointIndex();
        }
    }

    private void Move()
    {
        transform.position = Vector3.MoveTowards(transform.position, 
            CurrentPointPosition, MoveSpeed * Time.deltaTime);
    }

    public void StopMovement()
    {
        MoveSpeed = 0f;
    }

    public void ResumeMovement()
    {
        MoveSpeed = moveSpeed;
    }

    private void Rotate()
    {
        if (CurrentPointPosition.x > _lastPointPosition.x)
        {
            _spriteRenderer.flipX = false;
        }
        else
        {
            _spriteRenderer.flipX = true;
        }
    }
    
    private bool CurrentPointPositionReached()
    {
        float distanceToNextPointPosition = (transform.position - CurrentPointPosition).magnitude;
        if (distanceToNextPointPosition < 0.1f)
        {
            _lastPointPosition = transform.position;
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
            EndPointReached();
        }
    }

    private void EndPointReached()
    {
        OnEndReached?.Invoke(this);
        _enemyHealth.ResetHealth();
        ObjectPooler.ReturnToPool(gameObject);
    }

    public void ResetEnemy()
    {
        _currenWaypointIndex = 0;
    }
}
