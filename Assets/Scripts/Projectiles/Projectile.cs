using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Projectile : MonoBehaviour
{
    public static Action<Enemy, float> OnEnemtHit;

    [SerializeField] protected float moveSpeed = 10f;
    [SerializeField] private float minDistanceToDealDamage = 50f;

    public TowerProjectile TowerOwner { get; set; }
    public float Damage { get; set; }

    protected Enemy _enemyTarget;
    
    protected virtual void Update()
    {
        if (_enemyTarget != null)
        {
            MoveProjectile();
            RotateProjectile(); 
        }
    }

    protected virtual void MoveProjectile()
    {
        transform.position = Vector2.MoveTowards(transform.position,
            _enemyTarget.transform.position, moveSpeed * Time.deltaTime);
        float distanceToTarget = (_enemyTarget.transform.position - transform.position).magnitude;
        if (distanceToTarget < minDistanceToDealDamage)
        {
            OnEnemtHit?.Invoke(_enemyTarget, Damage);
            _enemyTarget.EnemyHealth.DealDamege(Damage, gameObject.tag);
            TowerOwner.ResetTowerProjectile();
            ObjectPooler.ReturnToPool(gameObject);
        }
    }

    private void RotateProjectile()
    {
        Vector3 enemyPos = _enemyTarget.transform.position - transform.position;
        float angle = Vector3.SignedAngle(transform.up, enemyPos, transform.forward);
        transform.Rotate(0f, 0f, angle + 90);
    }
    
    public void SetEnemy(Enemy enemy)
    {
        _enemyTarget = enemy;
    }

    public void ResetProjectile()
    {
        _enemyTarget = null;
        transform.localRotation = Quaternion.identity;
    }
}
