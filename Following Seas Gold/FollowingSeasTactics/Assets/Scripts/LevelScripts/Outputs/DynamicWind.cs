using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DynamicWind : Toggleable
{

    List<TrackWind> affectedObjects;
    List<TrackWind> toRemove = new List<TrackWind>();
    public GameObject primaryArrow;
    public GameObject secondaryArrow;
    public float primaryForce;
    public float secondaryForce;
    Vector3 primaryWind;
    Vector3 secondaryWind;
    Vector3 wind;

    void Start()
    {
        if (primaryArrow != null)
        {
            primaryWind = primaryForce * primaryArrow.transform.forward;
            Destroy(primaryArrow);
        }
        if (secondaryArrow != null)
        {
            secondaryWind = secondaryForce * secondaryArrow.transform.forward;
            Destroy(secondaryArrow);
        }
        GetComponent<MeshRenderer>().enabled = false;
        wind = primaryWind;
    }

    void UpdateWind()
    {
        if (affectedObjects == null)
        {
            affectedObjects = new List<TrackWind>();
        }
        if (affectedObjects.Count > 0)
        {
            foreach (TrackWind windObject in affectedObjects)
            {
                try
                {
                    windObject.EnterWind(transform, wind);
                }
                catch
                {
                    toRemove.Add(windObject);
                }
            }
            RemoveDeletedObjects();
        }
    }

    void RemoveDeletedObjects()
    {
        while (toRemove.Count > 0)
        {
            affectedObjects.Remove(toRemove[0]);
            toRemove.RemoveAt(0);
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        if (affectedObjects == null)
        {
            affectedObjects = new List<TrackWind>();
        }
        TrackWind windObject = other.GetComponentInParent<TrackWind>();
        if (windObject != null)
        {
            affectedObjects.Add(windObject);
            windObject.EnterWind(transform, wind);
        }
    }

    private void OnTriggerExit(Collider other)
    {
        TrackWind windObject = other.GetComponentInParent<TrackWind>();
        if (windObject != null)
        {
            windObject.LeaveWind(transform, wind);
            if (affectedObjects.Contains(windObject))
            {
                affectedObjects.Remove(windObject);
            }
        }
    }

    public override void Primary()
    {
        if (!primary)
        {
            primary = true;
            wind = primaryWind;
            UpdateWind();
        }
    }

    public override void Secondary()
    {
        if (primary)
        {
            primary = false;
            wind = secondaryWind;
            UpdateWind();
        }
    }

    public override void Toggle()
    {
        BasicToggle();
    }
}
