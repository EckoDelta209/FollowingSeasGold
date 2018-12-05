using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class CurrentEffectGenerator : MonoBehaviour {

    public LayerMask waterLayer;
    public float particleFrequency;
    float lastParticle = 0;
    public GameObject currentEffectFab;

	// Update is called once per frame
	void Update () {
		if(Time.time - lastParticle >= particleFrequency)
        {
            lastParticle = Time.time;
            float x = transform.position.x + Random.Range(-transform.localScale.x / 2, transform.localScale.x / 2);
            float z = transform.position.z + Random.Range(-transform.localScale.z / 2, transform.localScale.z / 2);
            RaycastHit surface;
            Physics.Raycast(new Vector3(transform.position.x, transform.position.y + transform.localScale.y / 2 + 1, transform.position.z), Vector3.down, out surface, 100000, waterLayer);
            Instantiate(currentEffectFab, new Vector3(x, surface.point.y, z), Quaternion.identity);
        }
	}
}
