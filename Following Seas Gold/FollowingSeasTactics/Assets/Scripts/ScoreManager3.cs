using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ScoreManager3 : MonoBehaviour {
    
    public static int score3 = 0;
    
    private Text score3Text;
    // Use this for initialization
    void Start () {
        score3Text = GetComponent<Text>();
    }
	
	// Update is called once per frame
	void Update () {
        score3Text.text = ("shield3: " + GameManager1.manager.shield3Count + "/3");
    }
}
