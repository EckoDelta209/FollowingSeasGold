using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(Rigidbody))]
public class TrackCurrent : MonoBehaviour {
    List<Current> currents;
    Vector3 average = Vector3.zero;
    Rigidbody myRB;

    void Start()
    {
        myRB = GetComponentInParent<Rigidbody>();
    }

    void FixedUpdate()
    {
        if(average.sqrMagnitude > 0)
        {
            myRB.AddForce(average);
        }
    }

    void OnTriggerEnter(Collider other)
    {
        Current otherScript = other.GetComponent<Current>();
        if (otherScript != null)
        {
            if (currents == null)
            {
                currents = new List<Current>();
            }
            
            currents.Add(otherScript);
            RecalcualteAverage();
        }
        
    }

    void OnTriggerExit(Collider other)
    {
        Current otherScript = other.GetComponent<Current>();
        if (otherScript != null)
        {
            if (currents.Contains(otherScript))
            {
                currents.Remove(otherScript);
                RecalcualteAverage();
            }
        }
    }

    void RecalcualteAverage()
    {
        Vector3 sum = Vector3.zero;
        foreach(Current current in currents)
        {
            sum += current.GetForce();
        }
        average = sum / currents.Count;
    }
}
