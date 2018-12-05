using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RandomPitchAndVolume : MonoBehaviour {

	float randomPitch;
	public float randomPitchMax = 0.5f;
	public float randomPitchMin = 0.35f;
	float randomVolume;
	public float randomVolumeMax = 0.5f;
	public float randomVolumeMin = 0.35f;
	AudioSource audioSource;
	float timer = 10f;

	void Start () {
		audioSource = GetComponent<AudioSource>();
		randomPitch = Random.Range(randomPitchMin, randomPitchMax);
		randomVolume = Random.Range(randomVolumeMin, randomVolumeMax);
	}

	void Update () {

		timer -= Time.deltaTime;
		if (timer < 0){
			randomPitch = Random.Range(randomPitchMin, randomPitchMax);
			randomVolume = Random.Range(randomVolumeMin, randomVolumeMax);
			audioSource.pitch = randomPitch;
			audioSource.volume = randomVolume;
			timer = 10f;
		}
		
	}

}
