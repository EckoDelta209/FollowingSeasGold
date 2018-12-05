using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FadeInLevelMusic1 : MonoBehaviour {

	AudioSource levelMusic;
	float audioVolume = 0.0f;
	public float maxVolume = 0.8f;

	// Use this for initialization
	void Start () {
		levelMusic = GetComponent<AudioSource>();
		levelMusic.volume = 0;
	}
	
	// Update is called once per frame
	void Update () {
		
		if (audioVolume < maxVolume){
			audioVolume += 0.015f * Time.deltaTime;
			levelMusic.volume = audioVolume;

		}

	}
}
