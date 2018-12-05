using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GrappleSwitch : MonoBehaviour{

    public Toggleable objectToAffect;
    public Actions actionType;
    Rigidbody rb;
    public void Start()
    {
        rb = GetComponent<Rigidbody>();
    }

    private void OnTriggerEnter(Collider other)
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
        rb.constraints = RigidbodyConstraints.FreezeAll;
    }
}
