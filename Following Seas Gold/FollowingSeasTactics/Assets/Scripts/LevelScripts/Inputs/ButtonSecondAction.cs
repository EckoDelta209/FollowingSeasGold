using System.Collections;
using System.Collections.Generic;
using UnityEngine;



public class ButtonSecondAction : MonoBehaviour, IHarpoonable {

    public Toggleable objectToAffect;
    public Toggleable[] objectToAffects;
    public GameObject colorChangeObject;
    public Actions actionType;

    public Boolswitch outputSwitch;
    public Boolswitch buttonswitch;
    public MeshCollider mesh;
    bool toggleSwitch = false;

    public void OnHarpoon()
    {
        
        switch (actionType)
        {
            case Actions.TOGGLE:
                
             //   try
            //    {
                    foreach (Toggleable toggle in objectToAffects) {
                    Debug.Log("hellyeah");
                    toggle.Toggle();
                       
                    }
               // }
             //   catch
             //   {
                //    objectToAffect.Toggle();
               // }
                buttonswitch = gameObject.GetComponent<Boolswitch>();
                if (toggleSwitch != true)
                {
                    buttonswitch.activated = true;
                    toggleSwitch = true;
                    return;
                }
                if (toggleSwitch == true)
                {
                    buttonswitch.activated = false;
                    toggleSwitch = false;
                    return;
                }
                break;
            case Actions.PRIMARY:
                try
                {
                    foreach (Toggleable toggle in objectToAffects)
                    {
                        Debug.Log("hellyeah");
                        toggle.Primary();
                    }
                }
                catch
                {
                    Debug.Log("hellyeah");
                    objectToAffect.Primary();
                }
                //objectToAffect.Primary();
                break;
            case Actions.SECONDARY:
                buttonswitch = gameObject.GetComponent<Boolswitch>();
                buttonswitch.activated = true;
                
                try
                {
                    colorChangeObject.GetComponent<Boolswitch>().activated = true;
                    Destroy(mesh);
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
                    }
                }
                catch
                {
                    Debug.Log("hellyeah");
                    objectToAffect.Secondary();
                }
                //objectToAffect.Secondary();
               
                break;
        }
    }
}
