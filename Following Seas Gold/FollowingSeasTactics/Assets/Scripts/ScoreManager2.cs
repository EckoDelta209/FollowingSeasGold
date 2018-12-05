using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ScoreManager2 : MonoBehaviour {
    
    public static int score2 = 0;
    
    private Text score2Text;
    // Use this for initialization
    void Start () {
        score2Text = GetComponent<Text>();
    }
	
	// Update is called once per frame
	void Update () {
        score2Text.text = ("shield2: " + GameManager1.manager.shield2Count + "/3");
    }
}
