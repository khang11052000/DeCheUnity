using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AthleteTowerProjectile : TowerProjectile
{

    [SerializeField] private bool isDualAthlete;
    [SerializeField] private float spreadRange;

    
    protected override void Update()
    {
        
        if (Time.time > _nextAttackTime)
        {
            if (_tower.CurrentEnemyTarget != null)
            {
                Vector3 dirToTarget = _tower.CurrentEnemyTarget.transform.position - transform.position;
                FireProjectile(dirToTarget);
            }

            _nextAttackTime = Time.time + delayBtwAttacks;
        }
        
    }

    protected override void LoadProjectile()
    {
    }

    private void FireProjectile(Vector3 direction)
    {
        GameObject instance = _pooler.GetInstanceFromPool();
        instance.transform.position = projectileSpawnPosition.position;

        AthleteProjectile projectile = instance.GetComponent<AthleteProjectile>();
        projectile.Direction = direction;
        
        //Co the dung cho cung 4 sao
        if (isDualAthlete)
        {
            float radomSpread = Random.Range(-spreadRange, spreadRange);
            Vector3 spread = new Vector3(0f, 0f, radomSpread);
            Quaternion spreadValue = Quaternion.Euler(spread);
            Vector2 newDirection = spreadValue * direction;
            projectile.Direction = newDirection;
        }
        
        instance.SetActive(true);
    }
}
