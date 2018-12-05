using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HarpoonLauncher : MonoBehaviour {

    public bool isShooting;
    public Harpoon harpoon;
    public GameObject boat;
    public GameObject harpoonBlast;
    public float timeBetweenShots = 0.5f;
    private float shotCounter;
    public Transform firePoint;
     
    //public AudioClip clip;

   

    public void Update ()
    {
        shotCounter -= Time.deltaTime;
        if (isShooting)
        {
            if(shotCounter <= 0)
            {
                shotCounter = timeBetweenShots;
                Instantiate(harpoon, firePoint.position, (firePoint.rotation));
//<<<<<<< HEAD
                //make sound and dust particles
//=======
                //Instantiate(harpoonBlast, boat.transform.position, (boat.transform.rotation));
                //Destroy(harpoonBlast, 1f);
                
//>>>>>>> Jarrod!
                //gameObject.GetComponentInParent<Rigidbody>().AddForceAtPosition(-1 * transform.up, transform.position, ForceMode.Impulse);//this is our recoil
            }
            
        }
	}
}
