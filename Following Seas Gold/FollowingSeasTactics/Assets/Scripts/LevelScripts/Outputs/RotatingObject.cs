using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RotatingObject : Toggleable {
    public Vector3 primaryRotation;
    public Vector3 secondaryRotation;
    Quaternion primaryQRotation;
    Quaternion secondaryQRotation;
    float remainingTime = 0;
    public float duration;

    private void Start()
    {
        primaryQRotation = Quaternion.Euler(primaryRotation);
        secondaryQRotation = Quaternion.Euler(secondaryRotation);

    }

    private void FixedUpdate()
    {
        remainingTime = Mathf.Max(remainingTime - Time.fixedDeltaTime, 0);

        if (primary)
        {
            transform.localRotation = Quaternion.Lerp(primaryQRotation, secondaryQRotation, remainingTime / duration);
        }
        else
        {
            transform.localRotation = Quaternion.Lerp(secondaryQRotation, primaryQRotation, remainingTime / duration);
        }
        
    }

    public override void Primary()
    {
        if (!primary)
        {
            primary = true;
            remainingTime = duration - remainingTime;
        }
    }

    public override void Secondary()
    {
        if (primary)
        {
            primary = false;
            remainingTime = duration - remainingTime;
        }
    }

    public override void Toggle()
    {
        BasicToggle();
    }
}
