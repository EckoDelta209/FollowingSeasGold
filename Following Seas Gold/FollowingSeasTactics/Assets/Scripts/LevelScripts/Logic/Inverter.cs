using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Inverter : Toggleable {

    public Toggleable objectToAffect;

    public override void Primary()
    {
        objectToAffect.Secondary();
    }

    public override void Secondary()
    {
        objectToAffect.Primary();
    }

    public override void Toggle()
    {
        objectToAffect.Toggle();
    }
}
