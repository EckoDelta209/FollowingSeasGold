using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ScoreManager : MonoBehaviour {

    public static int score1 = 0;
    
    private Text score1Text;
   

    private void Start()
    {
        score1Text = GetComponent<Text>();
       
    }
    void Update () {

       score1Text.text = ("shield1: " + GameManager1.manager.shield1Count + "/5");
       
    }
}
