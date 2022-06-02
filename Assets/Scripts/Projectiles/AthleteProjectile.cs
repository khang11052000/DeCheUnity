using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AthleteProjectile : Projectile
{
    public Vector2 Direction { get; set; }

    protected override void Update()
    {
        MoveProjectile();
        
    }

    protected override void MoveProjectile()
    {
        Vector2 movement = Direction.normalized * moveSpeed * Time.deltaTime;
        transform.Translate(movement);
    }

    private void OnTriggerStay2D(Collider2D other)
    {
        if (other.CompareTag("Enemy"))
        {
            Enemy enemy = other.GetComponent<Enemy>();
            if (enemy.EnemyHealth.CurrentHealth > 0f)
            {
                OnEnemtHit?.Invoke(enemy, Damage);
                enemy.EnemyHealth.DealDamege(Damage, gameObject.tag);
            }
            
            ObjectPooler.ReturnToPool(gameObject);
        }
    }

    private void OnEnable()
    {
        StartCoroutine(ObjectPooler.ReturnToPoolWithDelay(gameObject, 5f));
    }
}
