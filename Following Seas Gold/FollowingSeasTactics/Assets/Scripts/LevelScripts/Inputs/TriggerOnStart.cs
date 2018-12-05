using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TriggerOnStart : MonoBehaviour {
    public Toggleable objectToAffect;
    public Actions actionType;

	// Use this for initialization
	void Start () {
        switch (actionType)
        {
            case Actions.PRIMARY:
                objectToAffect.Primary();
                break;
            case Actions.SECONDARY:
                objectToAffect.Secondary();
                break;
            case Actions.TOGGLE:
                objectToAffect.Toggle();
                break;
        }
	}
}
