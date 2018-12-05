using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HelpPanel : MonoBehaviour {

	public GameObject panel, tab;

	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		if(Input.GetKeyDown(KeyCode.F1)){
			panel.SetActive(!panel.activeSelf);
			tab.SetActive(!panel.activeSelf);
		}
	}
}
