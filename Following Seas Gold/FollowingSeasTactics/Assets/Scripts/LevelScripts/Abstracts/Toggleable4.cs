using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public enum Actions4 { TOGGLE4, PRIMARY4, SECONDARY4, TERTIARY4, QUATERNARY4 }

public abstract class Toggleable4 : MonoBehaviour {
    protected int quadCount = 0;

    public abstract void Toggle4();

    public abstract void Primary4();

    public abstract void Secondary4();

    public abstract void Tertiary4();

    public abstract void Quaternary4();

    protected void AdvancedToggle()
    {
        if (quadCount == 0)
        {
            Primary4();
        }
        else if (quadCount == 1)
        {
            Secondary4();
        }
        else if (quadCount == 2)
        {
            Tertiary4();
        }
        else if (quadCount == 3)
        {
            Quaternary4();
        }
    }
}
