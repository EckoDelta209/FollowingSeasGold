using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraFollow : MonoBehaviour {
    public Transform target;
    public Transform cam;
    float chaseHeight = 0.5f;
    float chaseLength = 10;
    float horizontalSpeed = 3;
    float verticalSpeed = -2;
    float scrollSpeed = -6;
    float minLength = 5;
    float maxLength = 30;

	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
        transform.position = new Vector3(target.position.x, target.position.y + chaseHeight, target.position.z);
        if (Input.GetKey(KeyCode.Mouse1))
        {
            transform.rotation = Quaternion.Euler(verticalSpeed * Input.GetAxis("Mouse Y") + transform.rotation.eulerAngles.x, horizontalSpeed * Input.GetAxis("Mouse X") + transform.rotation.eulerAngles.y, 0);
        }
        chaseLength += Input.GetAxis("Mouse ScrollWheel") * scrollSpeed;
        chaseLength = Mathf.Min(chaseLength, maxLength);
        chaseLength = Mathf.Max(chaseLength, minLength);
        cam.localPosition = chaseLength * Vector3.back;
	}
}
