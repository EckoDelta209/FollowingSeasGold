using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Harpoon : MonoBehaviour
{
    Rigidbody rb;
    public float thrust = 500;
    private Transform anchor;
    public Collider psycicsCollider;
    AudioSource source;
    public AudioClip grappleclip;
    public AudioClip destroyclip;
    MeshRenderer meshRenderer;
    public GameObject GrappleHook;
    //private bool haveJoint = false;


    void Start()
    {
        GrappleHook = GameObject.Find("grappleClaw_animated");
        meshRenderer = GetComponent<MeshRenderer>();
        source = GetComponent<AudioSource>();
        rb = GetComponent<Rigidbody>();
        rb.AddForce(transform.forward * thrust);
    }
    private void Update()
    {
        
        if(this.anchor != null)
        {
            this.transform.position = anchor.transform.position;
            this.transform.rotation = anchor.transform.rotation;
        }
    }

  /*  public void OnTriggerEnter(Collider other)
    {

        HarpoonHit(other.gameObject);

    }*/
   public void OnCollisionEnter(Collision other)
    {

        /* if (other.gameObject.GetComponent<Rigidbody>() != null && !haveJoint)
         {
             FixedJoint joint = gameObject.AddComponent<FixedJoint>();
             joint.connectedBody = other.rigidbody;
             joint.breakForce = 2000f;
             joint.breakTorque = 2000f;
             haveJoint = true;
             rb.useGravity = true;
         }*/
        HarpoonHit(other.gameObject);
        GameObject anchor = new GameObject("Harpoon_Anchor");
        anchor.transform.position = this.transform.position;
        anchor.transform.rotation = this.transform.rotation;
        anchor.transform.parent = other.transform;
        if (other.gameObject.CompareTag("Grapple"))
        {
            source.PlayOneShot(grappleclip,1f);
        }
        else
        {
            source.Play();
        }

       
        this.anchor = anchor.transform;
    }

    void HarpoonHit(GameObject hit)
    {
        rb.constraints = RigidbodyConstraints.FreezeAll;
        rb.detectCollisions = false;
        rb.isKinematic = true;
        // psycicsCollider.enabled= false;
        if (hit.CompareTag("Barrel"))
        {
            GrappleHook.GetComponent<Grapple>().retracting = true;
            GrappleHook.GetComponent<Grapple>().Retract();

        }

        if (hit.CompareTag("Harpoon")||hit.CompareTag("Barrel")||hit.CompareTag("Crystal"))
        {
            source.PlayOneShot(destroyclip);
            meshRenderer.enabled=(false);
            Destroy(gameObject, 3f);
            
            try
            {
                hit.GetComponentInParent<IHarpoonable>().OnHarpoon();
            }
            catch
            {
                Debug.Log(hit);
                Debug.Log("Object does not have a harpoonable script but is tagged as harpoonable");
            }
        }
    }
}
