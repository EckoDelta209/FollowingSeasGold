using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BoatScipt : MonoBehaviour {

    public GameObject sinkboat;
    public GameObject sinkboat2;
    public Buoyancy bscript;
    private void OnTriggerEnter(Collider other)
    {
        if(other.gameObject == sinkboat)
        {
            bscript.enabled = (false);
            transform.gameObject.tag = "ETower";
        }
        if (other.gameObject == sinkboat2)
        {
            bscript.enabled = (false);
            transform.gameObject.tag = "ETower";
        }
        if (other.gameObject.CompareTag("Player"))
        {
            gameObject.GetComponent<Rigidbody>().isKinematic = true;
        }
    }
    private void OnTriggerExit(Collider other)
    {
        if (other.gameObject.CompareTag("Player"))
        {
            gameObject.GetComponent<Rigidbody>().isKinematic = false;
        }
    }


}
