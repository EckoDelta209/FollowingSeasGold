using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class barrelSpawner : MonoBehaviour {

    public GameObject BarrelInScene;
    public GameObject BarrelPrefab;

	
	void Update () {
		if(BarrelInScene == null)
        {
            GameObject currBarrel;
            currBarrel = Instantiate(BarrelPrefab,gameObject.transform);
            BarrelInScene = currBarrel;
        }
	}
}
