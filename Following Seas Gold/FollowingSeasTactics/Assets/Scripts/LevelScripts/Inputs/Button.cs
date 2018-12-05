using System.Collections;
using System.Collections.Generic;
using UnityEngine;



public class Button : MonoBehaviour, IHarpoonable {

    public Toggleable objectToAffect;
    public Toggleable[] objectToAffects;
    public GameObject colorChangeObject;
    public Actions actionType;

    public Boolswitch outputSwitch;
    public Boolswitch buttonswitch;
    public MeshCollider mesh;
    bool toggleSwitch = false;
    public bool on= false;
    public bool isOn = false;
    public AudioClip buttonSound;
    AudioSource buttonSource;
    void Awake()
    {
        if (isOn)
        {
            objectToAffect.Secondary();
        }
    }

   void Start()
    {
        buttonSource = GetComponent<AudioSource>();
    }
    public void OnHarpoon()
    {
        
        switch (actionType)
        {
            case Actions.TOGGLE:

                   try
                    {
                foreach (Toggleable toggle in objectToAffects)
                {
                   
                    toggle.Toggle();

                }
                 }
                   catch
                   {
                    objectToAffect.Toggle();
                 }
                
                buttonswitch = gameObject.GetComponent<Boolswitch>();
                if (toggleSwitch != true)
                {
                    buttonswitch.activated = true;
                    toggleSwitch = true;
                    buttonSource.PlayOneShot(buttonSound, 0.6f);
                    return;
                }
                if (toggleSwitch == true)
                {
                    buttonswitch.activated = false;
                    toggleSwitch = false;
                    buttonSource.PlayOneShot(buttonSound, 0.6f);
                    return;
                }
                break;
            case Actions.PRIMARY:
                try
                {
                    foreach (Toggleable toggle in objectToAffects)
                    {
                        //Debug.Log("hellyeah");
                        toggle.Primary();
                        buttonSource.PlayOneShot(buttonSound, 0.6f);
                    }
                }
                catch
                {
                    //Debug.Log("hellyeah");
                    objectToAffect.Primary();
                    buttonSource.PlayOneShot(buttonSound, 0.6f);
                }
                objectToAffect.Primary();
                //buttonSource.PlayOneShot(buttonSound, 0.6f);
                break;
            case Actions.SECONDARY:
                on = true;
                buttonswitch = gameObject.GetComponent<Boolswitch>();
                buttonswitch.activated = true;
                //buttonSource.PlayOneShot(buttonSound, 0.6f);

                try
                {
                    colorChangeObject.GetComponent<Boolswitch>().activated = true;
                    Destroy(mesh);
                    buttonSource.PlayOneShot(buttonSound, 0.6f);
                }
                catch
                {
                    Debug.Log("Output does NOT have a Color Switch");
                }


                try
                {
                    foreach (Toggleable toggle in objectToAffects)
                    {
                        // Debug.Log("hellyeah");
                        toggle.Secondary();
                        buttonSource.PlayOneShot(buttonSound, 0.6f);
                    }
                }
                catch
                {
                    //Debug.Log("hellyeah");
                    objectToAffect.Secondary();
                    buttonSource.PlayOneShot(buttonSound, 0.6f);
                }
                objectToAffect.Secondary();
                //buttonSource.PlayOneShot(buttonSound, 0.6f);
               

                break;
        }
    }
}
