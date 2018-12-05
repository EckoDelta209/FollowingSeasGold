using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class puzzleVolume : MonoBehaviour {

    //Game Object Variables and Booleans 

    //Key Objects. Create more of these to add more crates to the puzzle and adding the objects accordingly within the Inspector.
    public GameObject KeyObject; 
    public GameObject KeyObject2;


    public bool activated; //Activation for when the keyobject enters the space required.

	void Start () {


        activated = false;//Initial State of Activated
        
	}

	void Update () {
		
	}

    // Checks to see if KeyObject is within the trigger volume and will set the boolean 'activated' to true based on
    // what the keyobject is set to.
    void OnTriggerEnter(Collider other)
    {
        if (other.gameObject == KeyObject)
        {
            activated = true;
        }
        Debug.Log("Object has enter the trigger");
    }
    
}
