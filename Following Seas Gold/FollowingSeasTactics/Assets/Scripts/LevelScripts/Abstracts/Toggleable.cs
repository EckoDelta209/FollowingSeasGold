using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public enum Actions { TOGGLE, PRIMARY, SECONDARY }

public abstract class Toggleable : MonoBehaviour {
    protected bool primary = true;

    public abstract void Toggle();

    public abstract void Primary();

    public abstract void Secondary();

    protected void BasicToggle()
    {
        if (primary)
        {
            Secondary();
        }
        else
        {
            Primary();
        }
    }
}
