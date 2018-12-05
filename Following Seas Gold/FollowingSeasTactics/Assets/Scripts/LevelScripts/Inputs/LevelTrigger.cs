using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LevelTrigger : MonoBehaviour {
    public Toggleable objectToAffect;
    public bool doActionOnEnter;
    public Actions enterActionType;
    public bool doActionOnExit;
    public Actions exitActionType;

    void OnTriggerEnter(Collider other)
    {
        if(doActionOnEnter && other.CompareTag("Player"))
        {
            switch (enterActionType)
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

    void OnTriggerExit(Collider other)
    {
        if (doActionOnExit && other.CompareTag("Player"))
        {
            switch (exitActionType)
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
