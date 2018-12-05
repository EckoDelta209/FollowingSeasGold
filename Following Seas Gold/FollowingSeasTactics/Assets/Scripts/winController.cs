using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class winController : MonoBehaviour {

    public GameObject Continue;
    public GameObject Exit;
    public GameObject Win;
    public bool Won;
    public int sceneNum;


    

    void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            Won = true;
            switch (sceneNum)
            {
                case 0: SceneManager.LoadScene(4);
                    break;
                case 1:
                    SceneManager.LoadScene(6);
                    break;
                case 2:
                    SceneManager.LoadScene(8);
                    break;
            }
           // Continue.SetActive(true);
            //Exit.SetActive(true);
           // Win.SetActive(true);
           // Cursor.lockState = CursorLockMode.None;
           // Cursor.visible = true;
        }
    }
}
