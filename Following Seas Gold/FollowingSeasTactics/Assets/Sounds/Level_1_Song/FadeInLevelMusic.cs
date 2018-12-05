using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FadeInLevelMusic : MonoBehaviour {

	AudioSource levelMusic;
	float audioVolume = 0.0f;

	// Use this for initialization
	void Start () {
		levelMusic = GetComponent<AudioSource>();
		levelMusic.volume = 0;
	}
	
	// Update is called once per frame
	void Update () {
		
		if (audioVolume < 1){
			audioVolume += 0.1f * Time.deltaTime;
			levelMusic.volume = audioVolume;

		}

	}
}
