using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class TowerCard : MonoBehaviour
{
    [SerializeField] private Image towerImage;
    [SerializeField] private TextMeshProUGUI towerCost;

    public void SetupTowerButton(TowerSetting towerSetting)
    {
        towerImage.sprite = towerSetting.TowerShopSprite;
        towerCost.text = towerSetting.TowerShopCost.ToString();
    }
}
