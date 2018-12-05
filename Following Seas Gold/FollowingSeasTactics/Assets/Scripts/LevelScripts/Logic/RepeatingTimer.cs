using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class RepeatingTimer : Toggleable {
    public Toggleable objectToAffect;
    public Actions actionType;
    public float duration;
    float progress = 0;
    public bool startDisabled;

    void Start()
    {
        if (startDisabled)
        {
            primary = false;
        }
    }
	
	// Update is called once per frame
	void Update () {
        if (primary)
        {
            progress += Time.deltaTime;
            if (progress >= duration)
            {
                progress = progress - duration;
                switch (actionType)
                {
                    case Actions.TOGGLE:
                        objectToAffect.Toggle();
                        break;
                    case Actions.PRIMARY:
                        objectToAffect.Primary();
                        break;
                    case Actions.SECONDARY:
                        objectToAffect.Secondary();
                        break;
                }
            }
        }
        
	}

    public override void Primary()
    {
        primary = true;
    }

    public override void Secondary()
    {
        progress = 0;
        primary = false;
    }

    public override void Toggle()
    {
        BasicToggle();
    }
}
