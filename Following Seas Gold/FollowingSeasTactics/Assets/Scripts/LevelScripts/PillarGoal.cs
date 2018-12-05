using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PillarGoal : MonoBehaviour
{
    public TurnPillar[] pillars;
    public GameObject output;
    public Button[] buttons;
    public bool hasButtons = false;
    public Animator anim;
    // Use this for initialization
    void Start()
    {
        output.SetActive(false);
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        CheckPillars();
    }

    void CheckPillars()
    {
        if (!hasButtons)
        {
            foreach (TurnPillar pillar in pillars)
            {
                if (!pillar.GetSolved())
                {
                    return;
                }
            }
            try
            {
                output.SetActive(true);
            }
            catch
            {

            }
            try
            {
                anim.SetBool("Open", true);
            }
            catch
            {

            }
        }
        else
        {
            foreach (TurnPillar pillar in pillars)
            {
                if (!pillar.GetSolved())
                {
                    return;
                }
            }
            foreach (Button Button in buttons)
            {
                if (Button.on == false)
                {
                    return;
                }
            }
            try
            {
                output.SetActive(true);
            }
            catch
            {

            }
            try
            {
                anim.SetBool("Open", true);
            }
            catch
            {

            }
        }
    }
}
