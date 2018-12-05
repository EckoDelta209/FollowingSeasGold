using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class CameraFollowWithoutMouse : MonoBehaviour {
    public float cameraMoveSpeed = 120.0f;
    public GameObject cameraFollowObj;
    float followHeight;
    public float clampAngle = 66.0f;
    public float inputSensitivity = 150.0f;
    public GameObject cam;
    public GameObject player;
    
    public float mouseX;
    public float mouseY;

    public float smoothX;
    public float smoothY;
    private float rotationY = 0.0f;
    private float rotationX = 0.0f;
    public int sceneID;
    //Vector3 target;
    public bool IsScaled = false;
    private void Start()
    {
        followHeight = cameraFollowObj.transform.localPosition.y;
        transform.position = player.transform.position + Vector3.up * followHeight ;
        Vector3 rot = transform.localRotation.eulerAngles;
        rotationY = rot.y;
        rotationX = rot.x;
        Cursor.lockState = CursorLockMode.Locked;// Disables movement of mouse press escape while in play mode to move freely
        Cursor.visible = false; // Disables the mouses visiblity when playing the game
    }
    private void Update()
    {
        mouseY = Input.GetAxis("Mouse X");
        mouseX = Input.GetAxis("Mouse Y");

        rotationY += mouseY * inputSensitivity * Time.deltaTime;
        rotationX += mouseX * inputSensitivity * Time.deltaTime;

        rotationX = Mathf.Clamp(rotationX, -clampAngle, clampAngle);

        Quaternion localRotation = Quaternion.Euler(rotationX, rotationY, 0.0f);
        transform.rotation = localRotation;
    }
    private void LateUpdate()
    {
        CameraUpdater();
    }
    private void CameraUpdater()
    {
        //sceneID = SceneManager.GetActiveScene().buildIndex;
        if (!IsScaled)
        {
           Vector3 target = player.transform.position + Vector3.up * followHeight;
            float step = cameraMoveSpeed * Time.deltaTime;
            transform.position = Vector3.MoveTowards(transform.position, target, step);
        }
        else
              {
                  Vector3 target = player.transform.position + Vector3.up * followHeight * .3f;
                  float step = cameraMoveSpeed * Time.deltaTime;
                  transform.position = Vector3.MoveTowards(transform.position, target, step);
              }
                 //move toward the game object that is the target

             }
         }
