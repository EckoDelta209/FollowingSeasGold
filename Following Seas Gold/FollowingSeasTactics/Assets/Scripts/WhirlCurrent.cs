using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WhirlCurrent : MonoBehaviour {
    List<Rigidbody> affectedObjects;
    float minForce = 0.5f;
    float maxForce = 10f;
    float maxRadius = 95;
    public bool clockwise;
    int spinDirection;

    private void Start()
    {
        spinDirection = clockwise ? 1 : -1;
    }

    void FixedUpdate () {
        if (affectedObjects == null)
        {
            affectedObjects = new List<Rigidbody>();
        }
        if(affectedObjects.Count > 0)
        {
            foreach (Rigidbody rb in affectedObjects)
            {
                Vector3 direction = Vector3.Cross(Vector3.up, rb.transform.position - transform.position).normalized;
                float radius = Vector3.Distance(transform.position, rb.transform.position);
                float force = Mathf.Lerp(maxForce, minForce, radius / maxRadius);
                rb.AddForce(spinDirection * direction * force);
                rb.AddForce((transform.position - rb.transform.position).normalized * 0.2f * /*force*/ 1);
            }
        }
	}

    private void OnTriggerEnter(Collider other)
    {
        if(affectedObjects == null)
        {
            affectedObjects = new List<Rigidbody>();
        }
        Rigidbody otherBody = other.GetComponentInParent<Rigidbody>();
        if(otherBody != null)
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
    }
}
