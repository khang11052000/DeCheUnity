using System;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using Unity.VisualScripting;
using UnityEngine;

public class EnemyFX : MonoBehaviour
{
    [SerializeField] private Transform textDamageSpawnPosition;

    private Enemy _enemy;

    private void Start()
    {
        _enemy = GetComponent<Enemy>();
    }

    private void EnemyHit(Enemy enemy, float damage)
    {
        if (_enemy == enemy)
        {
            GameObject newInstance = DamageTextManager.Instance.Pooler.GetInstanceFromPool();
            TextMeshProUGUI damageText = newInstance.GetComponent<DamageText>().DmgText;
            damageText.text = damage.ToString();
            
            newInstance.transform.SetParent(textDamageSpawnPosition);
            newInstance.transform.position = textDamageSpawnPosition.position;
            newInstance.SetActive(true);
        }
    }
    
    private void OnEnable()
    {
        Projectile.OnEnemtHit += EnemyHit;
    }

    private void OnDisable()
    {
        Projectile.OnEnemtHit -= EnemyHit;
    }
}
