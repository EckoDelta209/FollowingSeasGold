using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class CrossHair : MonoBehaviour
{
    public LayerMask grappleLayer;
    public LayerMask harpoonLayer;
    public LayerMask waterLayer;
    public LayerMask currentLayer;
    public LayerMask playerLayer;
    LayerMask solidLayers;
    public GameObject GCrossHair;
    public GameObject DCrossHair;
    public GameObject ECrossHair;
    public GameObject crossHair;

    void Start()
    {
        solidLayers = ~(waterLayer | playerLayer | currentLayer);
    }

    void Update()
    {
        RaycastHit mouseHit;
       

        if (Physics.Raycast(new Ray(Camera.main.transform.position, Camera.main.transform.forward), out mouseHit, 100000, solidLayers))
        {
            if (mouseHit.collider.CompareTag("Harpoon")|| mouseHit.collider.CompareTag("Crystal"))
            {
                GCrossHair.SetActive(false);
                ECrossHair.SetActive(false);
                DCrossHair.SetActive(true);
                crossHair.GetComponent<Image>().color = Color.red;
                DCrossHair.GetComponent<Image>().color = Color.red;
            }
            else if (mouseHit.collider.CompareTag("Grapple"))
            {
                GCrossHair.SetActive(true);
                GCrossHair.transform.Rotate((Vector3.forward * -90) * Time.deltaTime);
                DCrossHair.SetActive(false);
                ECrossHair.SetActive(false);
                crossHair.GetComponent<Image>().color = Color.green;
                GCrossHair.GetComponent<Image>().color = Color.green;
            }
            else if (mouseHit.collider.CompareTag("Barrel"))
            {
                ECrossHair.SetActive(true);
                GCrossHair.SetActive(false);
                DCrossHair.SetActive(false);
                ECrossHair.transform.Rotate((Vector3.forward * 90) * Time.deltaTime);
                crossHair.GetComponent<Image>().color = Color.yellow;
                ECrossHair.GetComponent<Image>().color = Color.yellow;
            }
            else
            {
                GCrossHair.SetActive(false);
                DCrossHair.SetActive(false);
                ECrossHair.SetActive(false);
                crossHair.GetComponent<Image>().color = Color.white;
                GCrossHair.GetComponent<Image>().color = Color.white;
            }
        }
        else
        {
            crossHair.GetComponent<Image>().color = Color.white;
            GCrossHair.GetComponent<Image>().color = Color.white;
        }
    }
}
