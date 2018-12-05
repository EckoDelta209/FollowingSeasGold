using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class raisePillar : Toggleable {
    public Vector3 primaryPosition;
    public Vector3 secondaryPosition;
    public Vector3 thirdPosition;
    public Vector3 forthPosition;
    Vector3 currentPosition;
    //float remainingTime = 0;
    //public float duration;
    public bool twoButtons = false;
    public int buttonsPressed = 0;
    bool deactivated = false;
    public GameObject output;

    public float lerpTime = 3f;
    float firstLerpTime;
    float secondLerpTime;
    float thirdLerpTime;
    AudioSource beaconAudio;
    public AudioClip successSound;
    public AudioClip solvedSound;
   
    void Start()
    {
        output.SetActive(false);
        beaconAudio = GetComponent<AudioSource>();
        
    }

    void Update()
    {
        currentPosition = transform.localPosition;
    }
 
    private void FixedUpdate()
    {
        //remainingTime = Mathf.Max(remainingTime - Time.fixedDeltaTime, 0);

        if (buttonsPressed == 1)
        {
            //beaconAudio.PlayOneShot(successSound, 0.8f);
            firstLerpTime +=  Time.deltaTime;
            if(firstLerpTime >= lerpTime)
            {
                firstLerpTime = lerpTime;
            }
            float Perc = firstLerpTime/lerpTime;
            //transform.localPosition = Vector3.Lerp(primaryPosition, secondaryPosition, remainingTime / duration);
            transform.localPosition = Vector3.Lerp(primaryPosition, secondaryPosition, Perc);
        }
        else if (buttonsPressed == 2)
        {
            //beaconAudio.PlayOneShot(successSound, 0.8f);
            secondLerpTime +=  Time.deltaTime;
            if(secondLerpTime >= lerpTime)
            {
                secondLerpTime = lerpTime;
            }
            float Perc = secondLerpTime/lerpTime;
            //transform.localPosition = Vector3.Lerp(secondaryPosition, thirdPosition, remainingTime / duration);
            transform.localPosition = Vector3.Lerp(currentPosition, thirdPosition,  Perc);  
        }
        else if (buttonsPressed == 3)
        {
            //beaconAudio.PlayOneShot(solvedSound, 0.8f);
            thirdLerpTime +=  Time.deltaTime;
            if(thirdLerpTime >= lerpTime)
            {
                thirdLerpTime = lerpTime;
            }
            float Perc = thirdLerpTime/lerpTime;
            //transform.localPosition = Vector3.Lerp(thirdPosition, forthPosition, remainingTime / duration);
            transform.localPosition = Vector3.Lerp(currentPosition, forthPosition, Perc);
            output.SetActive(true);
        }

    }
    public override void Primary()
    {
        if (!primary)
        {
            primary = true;
            //remainingTime = duration - remainingTime;
        }
    }

    public override void Secondary()
    {
        
            if (primary)
            {
                buttonsPressed += 1;
                deactivated = true;
            }
        
    }
    

    public override void Toggle()
    {
        BasicToggle();
    }
}
