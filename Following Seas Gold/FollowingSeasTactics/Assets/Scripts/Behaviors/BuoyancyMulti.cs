using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BuoyancyMulti : MonoBehaviour {
    Rigidbody myRB;
    public LayerMask waterLayer;
    public float height;    //Height and cross section used to calculate the magnitude of buoyant force (proportional to volume submerged/displaced)
    public float crossSection;

	void Start () {
        myRB = GetComponentInParent<Rigidbody>();
	}

	void FixedUpdate () {
        RaycastHit surface;
        if (Physics.Raycast(transform.position + 20 * Vector3.up, Vector3.down, out surface, 100000, waterLayer)) //Look directly down for a water surface
        {
            //Part 1: Floating
            Vector3 keel = transform.position + (height / 2 * -1 * transform.up); //Get a point at the very bottom of the floating object (used to determine how much of it is submerged)
            float depth = surface.point.y - keel.y; //Calculate the distance between the lowest point of the object and the water surface
            depth = Mathf.Max(0, depth); //Don't allow negative depth values
            float submergedVolume = Mathf.Min(depth, height) * crossSection; //Approximate the volume of the submerged area. Min is to cap it out at the object's entire volume
            myRB.AddForceAtPosition(submergedVolume * surface.normal/*Vector3.up*/, transform.position); //Apply the buoyant force

            //This is where it gets tricky. I tried several approaches before coming up with this one.
            //Part 2: Orientation Correction
            //float leanIntensity = Vector3.Angle(surface.normal, transform.up); //Calculate the angle difference between the boat's normal and the water surface's normal
            //Vector3 leanAxis = Vector3.Cross(surface.normal, transform.up); //Thank god for linear algebra. Gets an axis perpendicular to both normals.
            //Vector3 deltaAngle = Quaternion.AngleAxis(leanIntensity, leanAxis).eulerAngles; //Using this axis and the float angle difference, get a Vector3 rotation that is the difference between them

            //deltaAngle.x = deltaAngle.x > 180 ? deltaAngle.x - 360 : deltaAngle.x; //Unity doesn't like negative angles
            //deltaAngle.y = deltaAngle.y > 180 ? deltaAngle.y - 360 : deltaAngle.y; //But I do
            //deltaAngle.z = deltaAngle.z > 180 ? deltaAngle.z - 360 : deltaAngle.z; //So tough luck.

            //myRB.AddTorque(-leanIntensity * 0.1f * deltaAngle); //Now that we have the rotation from the water's normal to the boat's, we can torque the boat in the reverse direction to make it right itself (and overshoot it for style, angular drag will mellow things out in the end)
        }
    }
}
