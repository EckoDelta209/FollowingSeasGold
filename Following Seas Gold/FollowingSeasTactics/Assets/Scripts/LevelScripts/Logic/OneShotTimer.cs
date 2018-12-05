using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class OneShotTimer : Toggleable {

    public Toggleable objectToAffect;
    public Actions actionType;
    public float duration;
    float progress = 0;
    public bool interruptible;

    // Update is called once per frame
    void Update()
    {
        if (!primary)
        {
            progress += Time.deltaTime;
            if (progress >= duration)
            {
                Primary();
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

    //Stop Timer
    public override void Primary()
    {
        primary = true;
    }

    //Start Timer
    public override void Secondary()
    {
        if(primary || interruptible)
        {
            primary = false;
            progress = 0;
        }
    }

    public override void Toggle()
    {
        BasicToggle();
    }
}
