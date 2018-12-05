using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CollectibleAnim : MonoBehaviour {
    //this is the animation of the collectable
    
    public Transform shield;
    float yPos;

    private Rigidbody rb;
	void Start () {
        rb = GetComponent<Rigidbody>();
        yPos = shield.localPosition.y;
    }
	
	
	void Update () {
        transform.Rotate(new Vector3(0, 125 * Time.deltaTime, 0));
        //shield.Rotate(new Vector3(Mathf.Sin(8 * Time.time + Mathf.PI / 4), 0, 0));
        shield.localPosition = new Vector3(shield.localPosition.x, yPos + Mathf.PingPong(Time.time, 1) - 0.5f, shield.localPosition.z);
	}
}
