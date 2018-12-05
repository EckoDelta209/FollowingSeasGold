using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class sheild2 : MonoBehaviour {

    public GameObject part1, part2, part3;


    private void Update()
    {

        if (GameManager1.manager.shield2a == true)
        {
            part1.SetActive(true);
        }

        if (GameManager1.manager.shield2b == true)
        {
            part2.SetActive(true);
        }

        if (GameManager1.manager.shield2c == true)
        {
            part3.SetActive(true);
        }


    }
}
