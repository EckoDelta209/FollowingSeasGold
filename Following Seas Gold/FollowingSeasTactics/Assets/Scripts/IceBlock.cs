using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class IceBlock : TemporarySpawned {
    public float targetScale = 0.1f;
    public float shrinkSpeed = 0.1f;
    public float lifeTime = 30f;
    Rigidbody rb;
    // Use this for initialization
    void Start () {
        rb = GetComponent<Rigidbody>();
	}
	
	// Update is called once per frame
	void Update () {

         
        transform.localScale = Vector3.Lerp(transform.localScale, new Vector3(targetScale, targetScale, targetScale), Time.deltaTime* shrinkSpeed); //transforms local scale to target scale by the shrink speed
        Destroy(gameObject, lifeTime);//destroys the iceblock after x seconds
}
    private void OnTriggerEnter(Collider other)
    {
        if((other.gameObject.GetComponent("IceTrigger") as IceTrigger) != null)
        {
            transform.localPosition = other.gameObject.transform.position;
            rb.constraints = RigidbodyConstraints.FreezePositionX | RigidbodyConstraints.FreezePositionZ | RigidbodyConstraints.FreezePositionY;
        }
    }

    public void OnDestroy()
    {
        spawner.Secondary();
    }
}
