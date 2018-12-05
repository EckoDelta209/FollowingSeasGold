using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(TrackWind))]
public class WindPush : MonoBehaviour {
    TrackWind windScript;
    Rigidbody myRB;
    static float windMult = 0.1f;

	void Start () {
        windScript = GetComponentInParent<TrackWind>();
        myRB = GetComponentInParent<Rigidbody>();
	}
	
    private void FixedUpdate()
    {
        Vector3 flatWind = TrackWind.MakeHorizontal(windScript.GetWind());
        if(windScript.GetWind().y > flatWind.y)
        {
            myRB.AddForce(windMult * windScript.GetWind());
        }
        else
        {
            myRB.AddForce(windMult * flatWind);
        }
    }
}
