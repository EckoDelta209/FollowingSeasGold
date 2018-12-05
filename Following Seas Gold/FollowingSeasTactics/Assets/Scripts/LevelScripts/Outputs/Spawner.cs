using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Spawner : Toggleable {
    public GameObject primaryObject;
    public GameObject secondaryObject;

	// Use this for initialization
	void Start () {
        if(primaryObject != null)
        {
            primaryObject.SetActive(false);
        }
        if(secondaryObject != null)
        {
            secondaryObject.SetActive(false);
        }
	}
	
    public override void Primary()
    {
        primary = true;
        if (primaryObject != null)
        {
            GameObject newObj = Instantiate(primaryObject, primaryObject.transform.parent);
            newObj.SetActive(true);
        }
    }

    public override void Secondary()
    {
        primary = false;
        if(secondaryObject != null)
        {
            GameObject newObj = Instantiate(secondaryObject, secondaryObject.transform.parent);
            newObj.SetActive(true);
        }
    }

    public override void Toggle()
    {
        BasicToggle();
    }
}
