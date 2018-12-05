using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;


public class gondolaCart : MonoBehaviour {



    GameObject grappleHook;
    public int place;
    private int nextPlace;
    public List<Transform> TrailMarkers;
    float remainingTime = 0;
    public float speed =5f;
    public GameObject CartPrefab;

    private void Start()
    {
        //fix this with new boat
        grappleHook = GameObject.Find("grappleClaw_animated");
        speed = 10f;
        transform.position = TrailMarkers[place].position;
        nextPlace = place + 1;
       
}
    private void FixedUpdate()
    {
        transform.position = Vector3.MoveTowards(transform.position, TrailMarkers[nextPlace].position, speed * Time.deltaTime);
        if(transform.position == TrailMarkers[nextPlace].position)
        {
            if (nextPlace == TrailMarkers.Count - 1)
            {
                if(gameObject.transform.childCount != 0)
                {
                    grappleHook.GetComponent<Grapple>().retracting = true;
                    grappleHook.GetComponent<Grapple>().Detach();
                    transform.DetachChildren();


                }
                Instantiate(CartPrefab);
                Destroy(this.gameObject);
            }
            else nextPlace += 1;
        }
    }
}
    
