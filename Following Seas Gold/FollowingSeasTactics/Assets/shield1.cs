using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class shield1 : MonoBehaviour {


    public GameObject part1, part2, part3, part4, part5;


    private void Update()
    {

        if (GameManager1.manager.shield1a == true)
        {
            part1.SetActive(true);
        }

        if (GameManager1.manager.shield1b == true)
        {
            part2.SetActive(true);
        }

        if (GameManager1.manager.shield1c == true)
        {
            part3.SetActive(true);
        }

        if (GameManager1.manager.shield1d == true)
        {
            part4.SetActive(true);
        }

        if (GameManager1.manager.shield1e == true)
        {
            part5.SetActive(true);
        }
        
    }

}
