using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class WindEffectGenerator : MonoBehaviour {

    float maxHeight;
    float minHeight;
    public LayerMask waterLayer;
    public float particleFrequency;
    float lastParticle = 0;
    public GameObject windEffectFab;

    // Use this for initialization
    void Start()
    {
        maxHeight = transform.position.y + transform.localScale.y / 2;

        RaycastHit surface;
        if (Physics.Raycast(new Vector3(transform.position.x, maxHeight, transform.position.z), Vector3.down, out surface, 100000, waterLayer)) //Look directly down for a water surface
        {
            minHeight = surface.point.y;
        }

    }

	// Update is called once per frame
	void Update () {
		if(Time.time - lastParticle >= particleFrequency)
        {
            lastParticle = Time.time;
            Instantiate(windEffectFab, new Vector3(transform.position.x + Random.Range(-transform.localScale.x / 2, transform.localScale.x / 2), Random.Range(minHeight + 0.05f, maxHeight), transform.position.z + Random.Range(-transform.localScale.z / 2, transform.localScale.z / 2)), Quaternion.identity);
        }
	}
}
