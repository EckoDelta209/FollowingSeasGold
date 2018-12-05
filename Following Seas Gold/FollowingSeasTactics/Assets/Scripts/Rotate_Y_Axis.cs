using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Rotate_Y_Axis : MonoBehaviour {

	public int speed;
	void Start () {
	
	
	}
	
	// Update is called once per frame
	void Update () {
		transform.Rotate(0, speed*Time.deltaTime, 0);
	}

	
}
