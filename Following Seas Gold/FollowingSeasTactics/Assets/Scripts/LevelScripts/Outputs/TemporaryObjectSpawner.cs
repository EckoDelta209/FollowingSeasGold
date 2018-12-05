using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TemporaryObjectSpawner : Toggleable {

    public Transform spawnPoint;
    public GameObject spawnObject;

	// Use this for initialization
	void Start () {
        Secondary();
	}

    public override void Primary()
    {
        if (!primary)
        {
            primary = true;
            GameObject newObj = Instantiate(spawnObject, spawnPoint.position, spawnPoint.rotation);
            newObj.GetComponent<TemporarySpawned>().spawner = this;
        }
    }

    public override void Secondary()
    {
        primary = false;
    }

    public override void Toggle()
    {
        //Do Nothing
    }
}
