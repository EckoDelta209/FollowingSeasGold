using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Boolswitch : MonoBehaviour {

    /// Script Purpose
    /// The purpose of this script is to have a gameobject change between two states - activated and deactivated.
    /// This will be determined with a boolean variable that will change the material within the renderer 
    /// depending on which state the object is in. 
    /// This will be used on switches for doors.

    //Material Holding Variables
    public Material material;
    public Material material2;

    //Renderer
    public Renderer rend;


    // public bool activated;
    public bool activated;
    

    // Use this for initialization
    void Start()
    {
        rend = GetComponent<Renderer>(); //Gets the renderer from the gameobject
        rend.enabled = true; // Double-checker to make sure that the renderer is in fact enabled.

        activated = false;
       // rend.sharedMaterial = material[0];

    }


    void Update()
    {
        if (activated == false)
        {
            //isNotActive();
            gameObject.GetComponent<Renderer>().material = material;
        }
        if (activated == true)
        {
            //isActive();
            gameObject.GetComponent<Renderer>().material = material2;
        }
    }

   /* void isNotActive()
    {
        rend.sharedMaterial = material[0];
    }
    void isActive()
    {
        rend.sharedMaterial = material[1];
    }*/
}
