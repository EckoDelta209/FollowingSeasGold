using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using System;//helps with save states
using System.Runtime.Serialization.Formatters.Binary;//makes binary files unreadable
using System.IO;//makes files

public class GameManager1 : MonoBehaviour {

    public static GameManager1 manager;//this is made so you can referense it at different classes
    public float shield1Count;
    public bool shield1a;
    public bool shield1b;
    public bool shield1c;
    public bool shield1d;
    public bool shield1e;
    public float shield2Count;
    public bool shield2a;
    public bool shield2b;
    public bool shield2c;
    public bool shield2d;
    public float shield3Count;
    public bool shield3a;
    public bool shield3b;
    public bool shield3c;
    public bool shield3d;
    public float shildnum;
    

    void Awake () {//loop dont destroy on load
        if(manager == null)
        {
            DontDestroyOnLoad(gameObject);
            manager = this;
        }
        else if(manager != this)
        {
            Destroy(gameObject);
        }
        
	}
    
    public void Save()
    {
        BinaryFormatter Bif = new BinaryFormatter();
        FileStream file = File.Create(Application.persistentDataPath + "/playerInfo.dat");

        PlayerData data = new PlayerData();//makes a new file
        data.shield1Count = shield1Count;//sets the data from the PlayerData file to local
        data.shield2Count = shield2Count;
        data.shield3Count = shield3Count;

        Bif.Serialize(file, data);//serializes the data
        file.Close();
    }

    public void Load()
    {
        if(File.Exists(Application.persistentDataPath + "/playerInfo.dat"))
        {
            BinaryFormatter Bif = new BinaryFormatter();
            FileStream file = File.Open(Application.persistentDataPath + "/playerInfo.dat", FileMode.Open);
            PlayerData data = (PlayerData)Bif.Deserialize(file);
            file.Close();

            shield1Count = data.shield1Count;
            shield2Count = data.shield2Count;
            shield3Count = data.shield3Count;

        }
    }
	
}
[Serializable]
class PlayerData//class and file that stores save data
{
    public float shield1Count;
    public GameObject shield1a;
    public GameObject shield1b;
    public GameObject shield1c;
    public GameObject shield1d;
    public GameObject shield1e;
    public float shield2Count;
    public GameObject shield2a;
    public GameObject shield2b;
    public GameObject shield2c;
    public GameObject shield2d;
    public float shield3Count;
    public GameObject shield3a;
    public GameObject shield3b;
    public GameObject shield3c;
    public GameObject shield3d;
    public float shieldnum;
}