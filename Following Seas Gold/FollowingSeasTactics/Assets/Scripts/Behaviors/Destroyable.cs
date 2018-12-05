using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Destroyable : MonoBehaviour, IHarpoonable
{

    public Material crystalShader;

    public Rigidbody rigidbody;
    public float Radius = 30f;
    public float Force = 30f;
    public ParticleSystem destroyedParticle;
    public AudioClip explosionAudio;
    public float dieTime = 2f;
    bool isdestroyed = false;
    public GameObject barrel;
    public GameObject Crystals;
    AudioSource thisAudioSource;
    public void Awake()
    {

        rigidbody = GetComponent<Rigidbody>();
        //destroyedParticle = gameObject.GetComponent<ParticleSystem>();
        destroyedParticle = GetComponentInChildren<ParticleSystem>();
        thisAudioSource = GetComponent<AudioSource>();

    }

    public void Update()
    {
        if (gameObject.CompareTag("Barrel") || gameObject.CompareTag("Crystal"))
        {
            if (isdestroyed == true)
            {
                dieTime -= Time.deltaTime;
            }
            if (dieTime <= 0)
            {
                Destroy(gameObject);
            }


        }
    }
    public void OnHarpoon()
    {
        if (gameObject.CompareTag("Barrel"))
        {
            Collider[] colliders = Physics.OverlapSphere(gameObject.transform.position, Radius);
            thisAudioSource.PlayOneShot(explosionAudio, 0.8f);
            foreach (Collider c in colliders)
            {
                if (c.CompareTag("Exploding"))
                {
                    try
                    {
                        c.gameObject.GetComponent<ExplodableTrigger>().broken = true;
                    }
                    catch
                    {

                    }
                    Destroy(c.gameObject, 1f);
                }
                if (c.CompareTag("ETower"))
                {
                    c.GetComponent<explodingTower>().Exploded();
                    c.GetComponent<Animator>().SetBool("IsExploded", true);
                }
                if (c.GetComponent<Rigidbody>() == null) continue;
                try
                {
                    isdestroyed = true;
                    Destroy(barrel);
                    destroyedParticle.Play();

                }
                catch
                {
                }
                c.GetComponent<Rigidbody>().AddExplosionForce(Force, gameObject.transform.position, Radius, 1, ForceMode.Impulse);
            }



        }
        else if (gameObject.CompareTag("Crystal"))
        {
            //Collider[] colliders = Physics.OverlapSphere(gameObject.transform.position, Radius);
            GameObject crystal2 = Instantiate(Crystals, new Vector3(gameObject.transform.position.x, gameObject.transform.position.y, gameObject.transform.position.z), gameObject.transform.rotation, gameObject.transform);
            // crystal2.GetComponentInChildren<Mat>().
            //Instantiate(Crystals, gameObject.transform, false);
            Destroy(gameObject.GetComponent<MeshRenderer>());
            Destroy(gameObject.GetComponent<MeshCollider>());
            Destroy(gameObject, 5f);



        }
        else
        {
            Destroy(this.gameObject);
        }

    }
}
