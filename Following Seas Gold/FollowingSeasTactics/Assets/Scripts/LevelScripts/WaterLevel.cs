using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WaterLevel : Toggleable {

	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		
	}

    public override void Primary()
    {
        //Raise water
    }

    public override void Secondary()
    {
        //lower water
    }

    public override void Toggle()
    {
        BasicToggle();
    }
}
