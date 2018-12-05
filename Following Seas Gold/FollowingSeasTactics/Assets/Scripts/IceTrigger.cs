using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class IceTrigger : MonoBehaviour {
    public Toggleable objectToAffect;
    GameObject myIce;
    bool hasBlock = false;
    public Actions actionType;

    private void Update()
    {
        if (hasBlock)
        {
            if(myIce == null)
            {
                hasBlock = false;
                objectToAffect.Primary();
            }
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        if ((other.gameObject.GetComponent("IceBlock") as IceBlock) != null)
        {
            myIce = other.gameObject;
            hasBlock = true;
            objectToAffect.Secondary();
            

        }
        
    }
    private void OnTriggerExit(Collider other)
    {
        if ((other.gameObject.GetComponent("IceBlock") as IceBlock) != null)
        {
            objectToAffect.Primary();

            hasBlock = false;
            myIce = null;
        }

    }
}
