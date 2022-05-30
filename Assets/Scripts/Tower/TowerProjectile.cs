using System;
using System.Collections;
using System.Collections.Generic;
using UnityEditor.Build;
using UnityEngine;

public class TowerProjectile : MonoBehaviour
{
    [SerializeField] private Transform projectileSpawnPosition;
    [SerializeField] private float delayBtwAttacks = 2f;

    private float _nextAttackTime;
    private ObjectPooler _pooler;
    private Tower _tower;
    private Projectile _currentProjectileLoaded;

    private void Start()
    {
        _tower = GetComponent<Tower>();
        _pooler = GetComponent<ObjectPooler>();
        
        //LoadProjectile();
    }

    private void Update()
    {
        if (IsTowerEmpty())
        {
            LoadProjectile();
        }

        if (Time.time > _nextAttackTime)
        {
            if (_tower.CurrentEnemyTarget != null && _currentProjectileLoaded != null
                                                  && _tower.CurrentEnemyTarget.EnemyHealth.CurrentHealth > 0f)
            {
                _currentProjectileLoaded.transform.parent = null;
                _currentProjectileLoaded.SetEnemy(_tower.CurrentEnemyTarget);
            }

            _nextAttackTime = Time.time + delayBtwAttacks;
        }
    }

    private void LoadProjectile()
    {
        GameObject newInstance = _pooler.GetInstanceFromPool();
        newInstance.transform.localPosition = projectileSpawnPosition.position;
        newInstance.transform.SetParent(projectileSpawnPosition);

        _currentProjectileLoaded = newInstance.GetComponent<Projectile>();
        _currentProjectileLoaded.TowerOwner = this;
        _currentProjectileLoaded.ResetProjectile();
        newInstance.SetActive(true);
    }

    private bool IsTowerEmpty()
    {
        return _currentProjectileLoaded == null;
    }
    
    public void ResetTowerProjectile()
    {
        _currentProjectileLoaded = null;
    }
}
