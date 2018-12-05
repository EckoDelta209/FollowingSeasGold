using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class explodingTower : MonoBehaviour {

    public Toggleable objectToAffect;
    public Actions actionType;

    public void Exploded()
    {
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
