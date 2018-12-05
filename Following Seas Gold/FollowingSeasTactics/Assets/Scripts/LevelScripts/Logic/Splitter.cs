using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Splitter : Toggleable {

    public Toggleable[] objectsToAffect;

    public override void Primary()
    {
        foreach(Toggleable obj in objectsToAffect)
        {
            obj.Primary();
        }
    }

    public override void Secondary()
    {
        foreach (Toggleable obj in objectsToAffect)
        {
            obj.Secondary();
        }
    }

    public override void Toggle()
    {
        foreach (Toggleable obj in objectsToAffect)
        {
            obj.Toggle();
        }
    }
}
