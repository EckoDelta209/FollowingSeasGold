using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ConstantWind : MonoBehaviour {
    public GameObject arrow;
    public float force;
    Vector3 wind;

    void Start()
    {
        if (arrow != null)
        {
            wind = force * arrow.transform.forward;
            Destroy(arrow);
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        TrackWind windObject = other.GetComponentInParent<TrackWind>();
        if (windObject != null)
        {
            windObject.EnterWind(transform, wind);
        }
    }

    private void OnTriggerExit(Collider other)
    {
        TrackWind windObject = other.GetComponentInParent<TrackWind>();
        if (windObject != null)
        {
            windObject.LeaveWind(transform, wind);
        }
    }
}
