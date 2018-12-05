using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TrackWind : MonoBehaviour {
    Transform trigger;
    Vector3 wind;

    public void EnterWind(Transform trigger, Vector3 wind)
    {
        this.trigger = trigger;
        this.wind = MakeHorizontal(wind);
    }

    public void LeaveWind(Transform trigger, Vector3 wind)
    {
        if(this.trigger == trigger)
        {
            this.trigger = null;
            this.wind = Vector3.zero;
        }
    }

    public Vector3 GetWind()
    {
        return wind;
    }

    public static Vector3 MakeHorizontal(Vector3 before)
    {
        float force = before.magnitude;
        return force * (new Vector3(before.x, 0, before.z).normalized);
    }
}
