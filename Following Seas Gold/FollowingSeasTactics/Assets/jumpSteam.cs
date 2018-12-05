using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class jumpSteam : MonoBehaviour {
    
    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            if (other.GetComponent<Player>() != null)
            {
                other.GetComponent<Player>().playerJump = true;
            }
        }
    }
    private void OnTriggerExit(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            if (other.GetComponent<Player>() != null)
            {
                other.GetComponent<Player>().playerJump = false;
            }
        }
    }


}
