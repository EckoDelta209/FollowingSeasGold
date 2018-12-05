using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WaveGenerator : MonoBehaviour {
    public GameObject waveFab;
    public Vector3 direction;
    public float speed;

	// Use this for initialization
	void Start () {
        InvokeRepeating("SpawnWave", 0, 5f);
	}
	
	// Update is called once per frame
	void Update () {
		
	}

    void SpawnWave()
    {
        GameObject wave = Instantiate(waveFab, transform.position, Quaternion.identity);
        wave.GetComponent<Rigidbody>().velocity = speed * direction.normalized;
    }
}
