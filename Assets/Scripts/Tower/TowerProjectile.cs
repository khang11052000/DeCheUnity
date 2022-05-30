using System;
using System.Collections;
using System.Collections.Generic;
using UnityEditor.Build;
using UnityEngine;

public class TowerProjectile : MonoBehaviour
{
    [SerializeField] private Transform projectileSpawnPosition;

    private ObjectPooler _pooler;
    private Tower _tower;
    private Projectile _currentProjectileLoaded;

    private void Start()
    {
        _pooler = GetComponent<ObjectPooler>();
        _tower = GetComponent<Tower>();
    }

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.G))
        {
            LoadProjectile();
        }

        if (_tower.CurrentEnemyTarget != null && _currentProjectileLoaded != null
        && _tower.CurrentEnemyTarget.EnemyHealth.CurrentHealth > 0f)
        {
            _currentProjectileLoaded.transform.parent = null;
            _currentProjectileLoaded.SetEnemy(_tower.CurrentEnemyTarget);
        }
    }

    private void LoadProjectile()
    {
        GameObject newInstance = _pooler.GetInstanceFromPool();
        newInstance.transform.localPosition = projectileSpawnPosition.position;
        newInstance.transform.SetParent(projectileSpawnPosition);

        _currentProjectileLoaded = newInstance.GetComponent<Projectile>();
        newInstance.SetActive(true);
    }
}
