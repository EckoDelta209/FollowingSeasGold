using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;


[RequireComponent(typeof(Rigidbody), typeof(TrackWind))]
public class Player : MonoBehaviour {
    Rigidbody myRB;
    public float throttleSpeed = 7;
    public float rotateSpeed = 1.2f;
    public float grappleStrength = 10;

    public float forwardDrag = 0.5f;
    public float sidewaysDrag = 0.9f;
    public float maxSpeed = 25f;
    public bool playerJump=false;

    public LayerMask waterLayer;
    public LayerMask playerLayer;
    public LayerMask currentLayer;
    public LayerMask grappleLayer;
    public LayerMask harpoonLayer;
    public LayerMask defaultLayer;
    public LayerMask invisLayer;
    public float jumpForce = 1500f;

    LayerMask solidLayers;

    public Transform grappleGun;
    public GameObject hook;
    public GameObject rope;
    public GameObject mast;
    public GameObject flag;
    public static bool launched;
    public bool attached;
    public HarpoonLauncher harpoonLauncher;
    public Animator Anim;
    public float foldingSpeed;
    public Vector3 direction;
    private Vector3 vel;
    TrackWind windScript;
    bool sailEnabled = false;
    public bool grounded;
    public bool attachedToRB = false;
    float scrollSpeed = -75;
    bool reeling = true;
    public bool playerPushBack;
    bool onIce = false;
    float originalForwardDrag;
    float originalHorizontalDrag;
    float originalAirDrag;
    float scalingFactor;
    int sceneID;
    public bool IsScaled = false;
    // Use this for initialization
    void Start() {
        myRB = GetComponentInParent<Rigidbody>();
        originalForwardDrag = forwardDrag;
        originalHorizontalDrag = sidewaysDrag;
        originalAirDrag = myRB.drag;
    //Anim = GetComponent<Animator>();
    windScript = GetComponent<TrackWind>();
        solidLayers = ~(waterLayer | playerLayer | currentLayer | invisLayer);
        sceneID = SceneManager.GetActiveScene().buildIndex;
        if (!IsScaled)
        {
            scalingFactor = 1;
        }
        else
        {
            scalingFactor = 0.3f;
        }
        
    }

    // Update is called once per frame
    void Update() {
        vel = myRB.velocity;
      
        RaycastHit mouseHit;
        Vector3 lookTarget;
        if (Physics.Raycast(new Ray(transform.Find("Camera follow").position, Camera.main.transform.forward), out mouseHit, 10000, solidLayers))
        {
            Debug.DrawRay(transform.Find("Camera follow").position, (Camera.main.transform.forward *100f) ,Color.green);
            lookTarget = mouseHit.point;
        }
        else
        {
            lookTarget =(10000 * Camera.main.transform.forward + Camera.main.transform.position);
        }

        grappleGun.LookAt(lookTarget);
        if (Input.GetKeyDown(KeyCode.Mouse0))
        {
            harpoonLauncher.isShooting = true;
        }
        if (Input.GetMouseButtonUp(0))
        {
            harpoonLauncher.isShooting = false;
        }

        if (Input.GetKeyDown(KeyCode.Mouse1))
        {
            if (launched)
            {
                hook.GetComponent<Grapple>().Retract();
                attached = false;
            }
            else
            {
                Fire();
            }
        }
        if (Input.GetKeyDown(KeyCode.LeftShift))
        {
            sailEnabled = !sailEnabled;
            // mast.SetActive(sailEnabled);
            if (sailEnabled)
            {
                GetComponent<WindPush>().enabled = true;
                Anim.SetBool("FullMast", true);
                Anim.Play("FullMast");
                foldingSpeed = 1;
            }
            else
            {
                GetComponent<WindPush>().enabled = false;
                Anim.SetBool("FullMast", false);
                Anim.Play("FullMast");
                foldingSpeed = -1;
            }
        }
        if (Input.GetKeyDown(KeyCode.Space))
        {
            reeling = !reeling;
        }
        if (playerJump)
        {
            myRB.AddForce(Vector3.up * 6000f);
            playerJump = false;
        }


        rope.transform.LookAt(hook.transform.position);
        
        rope.transform.localScale= new Vector3(1, 1, Vector3.Distance(hook.transform.position, rope.transform.position)/scalingFactor);
    }

    public void FixedUpdate()
    {
        
        if (!grounded && !onIce) {
            myRB.AddForce(Input.GetAxis("Vertical") * throttleSpeed * transform.forward, ForceMode.Acceleration);
            TurnShip();
            myRB.AddTorque(Input.GetAxis("Horizontal") * -1 * transform.forward);
            //myRB.AddTorque(Input.GetAxis("Horizontal") * -0.1f * transform.forward, ForceMode.Impulse);
            float thrust = Mathf.Max(0, Input.GetAxis("Vertical"));
            myRB.AddTorque(-0.5f * thrust * transform.right);
        }
        if (windScript.GetWind().magnitude > 0)
        {
            //Animate Flag
            flag.transform.LookAt(flag.transform.position + windScript.GetWind());
        }
        else
        {
            //Animate Flag
            flag.transform.LookAt(transform.position - 2 * transform.forward);
        }
        if (sailEnabled)
        {
            Vector3 playerForward = TrackWind.MakeHorizontal(transform.forward);
            float angle = Vector3.Angle(windScript.GetWind(), playerForward);
            float power = AngleToSailPower(angle);
            myRB.AddForce(windScript.GetWind().magnitude * power * transform.forward);


            if (windScript.GetWind().magnitude > 0)
            {
                //Animate Mast
                int side = Vector3.Cross(windScript.GetWind(), playerForward).y > 0 ? 1 : -1;
                mast.transform.localRotation = Quaternion.Euler(0, side * (180 - angle) / 2, 0);
            }
            else
            {
                //Animate Mast
                mast.transform.localRotation = Quaternion.identity;
            }

        }
        if (Input.GetKey(KeyCode.Q))
        {
            grappleStrength = grappleStrength + .2f;
            grappleStrength = Mathf.Clamp(grappleStrength, 2f, 100f);
        
        }
        if (Input.GetKey(KeyCode.E))
        {
            grappleStrength = grappleStrength - .2f;
            grappleStrength = Mathf.Clamp(grappleStrength, 2f, 100f);
        }
        if (Input.GetKeyUp(KeyCode.E) || Input.GetKeyUp(KeyCode.Q))
        {
            grappleStrength = 100f;
        }

        Vector3 direction = hook.transform.position - transform.position;
        if (playerPushBack)
        {
            myRB.AddForce(new Vector3(direction.x, 0, direction.z).normalized * (hook.GetComponent<Grapple>().ropeLength - hook.GetComponent<Grapple>().ropeDistanceMax) * 175);
            playerPushBack = false;
        }
        
        
        if (attached)//what happens if you are attached to a stationary
        {
            if (hook.GetComponent<Grapple>().ropeDistanceMax < hook.GetComponent<Grapple>().ropeLength)//prevents player from extending past distnace
            {
                playerPushBack = true;

            }
            else
            {
                playerPushBack = false;
            }
            
            if (reeling)
            {
                      
                myRB.AddForce(grappleStrength * new Vector3(direction.x, 0, direction.z).normalized);
            }
        }
        if (attachedToRB)
        {
            if (reeling)
            {
                //when you are connected to a moving object
               
                //this makes the player meet the attached rigid body in the middle of the grapple
               // myRB.AddForce((Input.GetAxis("Mouse ScrollWheel") * scrollSpeed) * new Vector3(direction.x, 0, direction.z).normalized);
               
            }
        }
        if (!launched)
        {
            
            hook.transform.localRotation = Quaternion.identity;
        }
        ApplyFriction();
    }

    void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.CompareTag("Ground"))
        {
            grounded = true;
        }
        if (collision.gameObject.CompareTag("IceSlide"))
        {
            onIce = true;
            forwardDrag = 0;
            sidewaysDrag = 0;
            myRB.drag = 0;
        }
        if (collision.gameObject.GetComponent<Rigidbody>())
        {
            myRB.velocity = new Vector3(vel.x, 0, vel.z);
        }
    }

    void OnCollisionExit(Collision collision)
    {
        if (collision.gameObject.CompareTag("Ground"))
        {
            grounded = false;
        }
        if (collision.gameObject.CompareTag("IceSlide"))
        {
            onIce = false;
            forwardDrag = originalForwardDrag;
            sidewaysDrag = originalHorizontalDrag;
            myRB.drag = originalAirDrag;
        }
    }
    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Steam"))
        {
            myRB.AddForce(Vector3.up * jumpForce);
        }
    }
    

    void Fire()
    {
        hook.transform.parent = null;
        hook.GetComponent<Grapple>().Activate();

        // hook.GetComponent<Grapple>().fired = (false);
        launched = true;
    }

    

    float AngleToSailPower(float angle)
    {
        //Calculate the sail thrust based on the angle
        float compliment = 180f - angle;
        float fraction = compliment / 180f;
        float power = 8f * (fraction * fraction * fraction) - 18f * (fraction * fraction) + 12f * fraction - 1.5f;
        //Debug.Log(power);
        return Mathf.Max(0, power);
    }

    void TurnShip()
    {
        Vector3 velocity = myRB.velocity;
        Vector3 onlyForward = Vector3.Project(velocity, transform.forward);
        Vector3 otherVel = velocity - onlyForward;
        float driftAmt = 0.1f;
        transform.Rotate(Input.GetAxis("Horizontal") * rotateSpeed * Vector3.up, Space.World);
        float sign = (onlyForward.normalized + transform.forward).magnitude > 1 ? 1 : -1;
        myRB.velocity = (onlyForward.magnitude * (1-driftAmt)) * sign * transform.forward + onlyForward * driftAmt + otherVel;
    }

    void ApplyFriction()
    {
        Vector3 velocity = myRB.velocity;
        Vector3 onlyForward = Vector3.Project(velocity, transform.forward);
        velocity -= onlyForward;
        Vector3 onlyVertical = Vector3.Project(velocity, Vector3.up);
        velocity -= onlyVertical;
        Vector3 onlySideways = velocity;
        float forwardFriction = forwardDrag * 0.04f;
        float sidewaysFriction = sidewaysDrag * 0.04f;
        //Vector3 newForward = -forwardFriction * onlyForward + onlyForward;
        //Vector3 newSideways = -sidewaysFriction * onlySideways + onlySideways;
        Vector3 newForward = -forwardFriction * onlyForward + onlyForward;
        Vector3 newSideways = -sidewaysFriction * onlySideways + onlySideways;
        if(newForward.magnitude > maxSpeed)
        {
           // newForward = newForward.normalized * maxSpeed;
        }
        myRB.velocity = newForward + newSideways + onlyVertical;
    }

    public void PlayerJump(GameObject location)
    {
       
       
    }
    
}

