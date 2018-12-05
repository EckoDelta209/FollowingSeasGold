using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CollectiblePickUp : MonoBehaviour {
    Object lockObj = new Object();
    bool claimed = false;
    public int type = 1;
    public int shieldNumber;
    
    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            lock (lockObj)
            {
                if (!claimed)
                {
                    if (type == 1)
                    {
                        ScoreManager.score1++;
                        GameManager1.manager.shield1Count += 1;
                        claimed = true;
                    }else if(type == 2){
                        ScoreManager2.score2++;
                        GameManager1.manager.shield2Count += 1;
                        claimed = true;
                    }
                    else if (type == 3)
                    {
                        ScoreManager3.score3++;
                        GameManager1.manager.shield3Count += 1;
                        claimed = true;
                    }
                    switch (shieldNumber)
                    {
                        case 0:
                            GameManager1.manager.shield1a = true;
                            break;
                        case 1:
                            GameManager1.manager.shield1b = true;
                            break;
                        case 2:
                            GameManager1.manager.shield1c = true;
                            break;
                        case 3:
                            GameManager1.manager.shield1d = true;
                            break;
                        case 4:
                            GameManager1.manager.shield1e = true;
                            break;
                        case 5:
                            GameManager1.manager.shield2a = true;
                            break;
                        case 6:
                            GameManager1.manager.shield2b = true;
                            break;
                        case 7:
                            GameManager1.manager.shield2c = true;
                            break;
                        case 8:
                            GameManager1.manager.shield3a = true;
                            break;
                        case 9:
                            GameManager1.manager.shield3b = true;
                            break;
                        case 10:
                            GameManager1.manager.shield3c = true;
                            break;

                        default:
                            break;
                    }
                }
            }
            Destroy(this.gameObject);
        }
    }
}
