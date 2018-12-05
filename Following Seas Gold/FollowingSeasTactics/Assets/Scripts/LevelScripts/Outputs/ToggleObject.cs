using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ToggleObject : Toggleable {
    public GameObject[] objectsToAffect;
    public bool startDisabled;

    public void Start()
    {
        if (startDisabled)
        {
            Secondary();
        }
    }

    public override void Primary()
    {
        primary = true;
        foreach(GameObject obj in objectsToAffect)
        {
            obj.SetActive(true);
        }
    }

    public override void Secondary()
    {
        primary = false;
        foreach(GameObject obj in objectsToAffect)
        {
            obj.SetActive(false);
        }
    }

    public override void Toggle()
    {
        BasicToggle();
    }
}
