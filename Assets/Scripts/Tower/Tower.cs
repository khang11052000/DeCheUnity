using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Tower : MonoBehaviour
{
    [SerializeField] private float attackRange = 3f;

    public Enemy CurrentEnemyTarget { get; set; }

    public Vector3 CurrentPos;
    
    private bool _gameStarted;
    private List<Enemy> _enemies;
    private SpriteRenderer[] _spriteRenderer;

    private void Start()
    {
        _gameStarted = true;
        _enemies = new List<Enemy>();
        _spriteRenderer = GetComponentsInChildren<SpriteRenderer>();
    }

    private void Update()
    {
        GetCurrentEnemyTarget();
        FlipTowardsTarget();
    }

    public void GetCurrentEnemyTarget()
    {
        if (_enemies.Count <= 0)
        {
            CurrentEnemyTarget = null;
            return;
        }

        CurrentEnemyTarget = _enemies[0];
    }

    private void FlipTowardsTarget()
    {
        if (CurrentEnemyTarget == null)
        {
            return;
        }

        if (transform.position.x > CurrentEnemyTarget.transform.position.x)
        {
            _spriteRenderer[1].flipX = false;
        }
        else
        {
            _spriteRenderer[1].flipX = true;
        }
    }

    private void OnTriggerEnter2D(Collider2D other)
    {
        if (other.CompareTag("Enemy"))
        {
            Enemy newEnemy = other.GetComponent<Enemy>();
            _enemies.Add(newEnemy);
        }
    }

    private void OnTriggerExit2D(Collider2D other)
    {
        if (other.CompareTag("Enemy"))
        {
            Enemy enemy = other.GetComponent<Enemy>();
            if (_enemies.Contains(enemy))
            {
                _enemies.Remove(enemy);
            }
        }
    }

    private void OnDrawGizmos()
    {
        if (!_gameStarted)
        {
            GetComponent<CircleCollider2D>().radius = attackRange;
        }
        
        Gizmos.DrawWireSphere(transform.position, attackRange);
    }
}
