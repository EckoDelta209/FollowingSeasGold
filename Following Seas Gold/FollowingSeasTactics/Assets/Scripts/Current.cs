using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Current : MonoBehaviour {
    List<Rigidbody> affectedObjects;
    List<Rigidbody> toRemove = new List<Rigidbody>();
    public GameObject arrow;
    public float force;
    public Vector3 direction;

    void Start()
    {
        if(arrow != null)
        {
            direction = arrow.transform.forward;
            Destroy(arrow);
        }
        //GetComponent<MeshRenderer>().enabled = false;
        //GetComponent<Collider>().enabled = false;
    }

    /*void FixedUpdate()
    {
        if (affectedObjects == null)
        {
            affectedObjects = new List<Rigidbody>();
        }
        if(affectedObjects.Count > 0)
        {
            foreach (Rigidbody rb in affectedObjects)
            {
                try
                {
                    rb.AddForce(direction.normalized * force);
                }
                catch
                {
                    toRemove.Add(rb);
                }
            }
            RemoveDeletedObjects();
        }
    }    

    void RemoveDeletedObjects()
    {
        while(toRemove.Count > 0)
        {
            affectedObjects.Remove(toRemove[0]);
            toRemove.RemoveAt(0);
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        if (affectedObjects == null)
        {
            affectedObjects = new List<Rigidbody>();
        }
        Rigidbody otherBody = other.GetComponentInParent<Rigidbody>();
        if (otherBody != null)
        {
            affectedObjects.Add(otherBody);
        }
    }

    private void OnTriggerExit(Collider other)
    {
        Rigidbody otherBody = other.GetComponentInParent<Rigidbody>();
        if (otherBody != null)
        {
            if (affectedObjects.Contains(otherBody))
            {
                affectedObjects.Remove(otherBody);
            }
        }
    }*/

    public Vector3 GetForce()
    {
        return direction.normalized * force;
    }
}
