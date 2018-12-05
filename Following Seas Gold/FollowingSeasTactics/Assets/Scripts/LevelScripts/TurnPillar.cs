using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TurnPillar : MonoBehaviour {
    Rigidbody myRB;
    bool solved;
    public GameObject output;

    // Use this for initialization
    void Start () {
        myRB = GetComponentInParent<Rigidbody>();
        output.SetActive(false);
    }

    void FixedUpdate()
    {
        /*float angle = (transform.localRotation.y + 360) % 90;
        if(angle <= 45)
        {
            myRB.AddTorque(Vector3.down * 3);
        }
        else
        {
            myRB.AddTorque(Vector3.up * 3);
        }*/

        if(Vector3.Angle(transform.parent.forward, transform.forward) <= 5)
        {
            solved = true;
            myRB.isKinematic = (true);
            output.SetActive(true);
        }
        else
        {
            solved = false;
        }
    }

    public bool GetSolved()
    {
        return solved;
    }
}
