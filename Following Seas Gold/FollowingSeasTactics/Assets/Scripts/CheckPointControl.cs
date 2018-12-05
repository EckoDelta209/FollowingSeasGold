using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CheckPointControl : MonoBehaviour {

    public Transform[] checkPoints;
    public GameObject player;
	/// <summary>
    /// This script can only hold 5 spawn points
    /// </summary>
	void Update () {
        if (Input.GetKeyDown(KeyCode.Alpha1))
        {
            try
            {
                player.transform.position = checkPoints[0].position;
            }
            catch
            {
                Debug.Log("You have not made a checkpoint 1");
            }
         
        }
        if (Input.GetKeyDown(KeyCode.Alpha2))
        {
            try
            {
                player.transform.position = checkPoints[1].position;
            }
            catch
            {
            Debug.Log("You have not made a checkpoint 2");
            }
    }
        if (Input.GetKeyDown(KeyCode.Alpha3))
        {
            try
            {
                player.transform.position = checkPoints[2].position;
            }
            catch
            {
                Debug.Log("You have not made a checkpoint 3");
            }
        }
        if (Input.GetKeyDown(KeyCode.Alpha4))
        {
            try
            {
                player.transform.position = checkPoints[3].position;
            }
            catch
            {
                Debug.Log("You have not made a checkpoint 4");
            }
        }
        if (Input.GetKeyDown(KeyCode.Alpha5))
        {
            try
            {
                player.transform.position = checkPoints[4].position;
            }
            catch
            {
                Debug.Log("You have not made a checkpoint 5");
            }
        }
    }
}
