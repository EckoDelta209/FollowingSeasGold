using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WindDestroy : MonoBehaviour {

   void OnTriggerExit()
    {
        Destroy(this.gameObject);
    }

    void OnCollisionEnter()
    {
        Destroy(this.gameObject);
    }
}
