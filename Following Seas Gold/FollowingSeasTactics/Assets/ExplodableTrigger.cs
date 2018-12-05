using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ExplodableTrigger : MonoBehaviour {

	public Animator[] anims;
    public bool broken = false;
	
	
	void Update () {
        if (broken)
        {
            foreach (Animator a in anims)
            {
                a.SetBool("broke", true);
            }
        }
	}
}
