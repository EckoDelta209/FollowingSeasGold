using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class sheld3 : MonoBehaviour {

    public GameObject part1, part2, part3;


    private void Update()
    {

        if (GameManager1.manager.shield3a == true)
        {
            part1.SetActive(true);
        }

        if (GameManager1.manager.shield3b == true)
        {
            part2.SetActive(true);
        }

        if (GameManager1.manager.shield3c == true)
        {
            part3.SetActive(true);
        }


    }
}
