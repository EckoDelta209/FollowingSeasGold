using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TwoButtonDoor : MonoBehaviour {


    public GameObject buttonOne;
    public GameObject buttonTwo;
    public MovingObject MoveObjectScript;
    public Animator anim;
    //public AudioClip doorOpenSound;
    //AudioSource doorAudioSource;
    public Transform targetTransform;
    public GameObject doorAudioPreFab;
    bool canSpawnAudio = true;
    void Start()
    {
        //doorAudioSource = GetComponent<AudioSource>();
    }

    void Update () {
		if(buttonOne.GetComponent<Boolswitch>().activated == true && buttonTwo.GetComponent<Boolswitch>().activated == true && canSpawnAudio == true)
        {
            MoveObjectScript.twoButtons = false;
            try
            {
                anim.SetBool("Open", true);
                Instantiate(doorAudioPreFab, targetTransform);
                //Destroy(doorAudioPreFab, 5f);
                canSpawnAudio = false;
                //doorAudioSource.PlayOneShot(doorOpenSound, 0.7f);
            }
            catch
            {

            }
        }
	}
}
