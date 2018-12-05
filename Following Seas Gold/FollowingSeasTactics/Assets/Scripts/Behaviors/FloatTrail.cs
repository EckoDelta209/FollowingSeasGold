using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(Rigidbody))]
public class FloatTrail : MonoBehaviour {
    public LayerMask waterLayer;

	void Update () {
        RaycastHit surface;
        if (Physics.Raycast(transform.position + 5 * Vector3.up, Vector3.down, out surface, 100000, waterLayer)) //Look directly down for a water surface
        {
            transform.position = surface.point;
        }
    }
}
