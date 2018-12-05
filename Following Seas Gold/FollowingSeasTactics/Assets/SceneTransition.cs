using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class SceneTransition : MonoBehaviour {

    public int nextScene;
    public float timer = 4f;

	void Update () {
        timer -= Time.deltaTime;
        if(timer <= 0)
        {
            SceneManager.LoadScene(nextScene);
        }
        if (Input.anyKey&& timer <= 10)
        {
            SceneManager.LoadScene(nextScene);
        }
	}
}
