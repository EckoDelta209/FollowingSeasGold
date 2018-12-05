using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(BoxCollider))]
public class MultiBuoy : MonoBehaviour {

    public GameObject buoyFab;

	// Use this for initialization
	void Start () {
        GetComponent<BoxCollider>().enabled = false;
        int quality = Constants.buoyancyQuality;

        float cellHeight = transform.localScale.y / quality;
        float cellArea = (transform.localScale.x * transform.localScale.z) / (quality * quality);
        float offset = (quality - 1) / 2f;

        for(int y = 0; y < quality; y++)
        {
            for(int z = 0; z < quality; z++)
            {
                for(int x = 0; x < quality; x++)
                {
                    GameObject currentCell = Instantiate(buoyFab, transform);
                    currentCell.transform.localScale = new Vector3(1f / quality, 1f / quality, 1f / quality);
                    currentCell.transform.localPosition = new Vector3((x - offset) / quality, (y - offset) / quality, (z - offset) / quality);
                    currentCell.transform.localRotation = Quaternion.identity;

                    BuoyancyMulti cellBuoyancy = currentCell.GetComponent<BuoyancyMulti>();
                    cellBuoyancy.crossSection = cellArea;
                    cellBuoyancy.height = cellHeight;
                }
            }
        }
        this.enabled = false;
	}
}
