using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TrailMoving : MonoBehaviour {

    // Position of the box in the sequence of waipoints
    public int startPos = 0;
    public float speed = 5f;

    private int nextPos;

    // List of trail waitpoints
    public List<Transform> waitPoints;

	// Use this for initialization
	void Start () {
        // Set this box position to the starting position in the sequence
        transform.position = waitPoints[startPos].position;

        // Set the 1st target for this box to move to
        nextPos = startPos + 1;
	}
	
	void Update () {
        // Move the box to the next location in the sequence
        transform.position = Vector3.MoveTowards(transform.position, waitPoints[nextPos].position, speed * Time.deltaTime);

        // Find the next target in the sequence for the box to move to
        if (transform.position == waitPoints[nextPos].position)
        {
            // If the box is at the last point, loop back to the 1st point
            if (nextPos == waitPoints.Count - 1) nextPos = 0;
            // If not move to next target in the sequence
            else nextPos += 1;
        }
	}
}
