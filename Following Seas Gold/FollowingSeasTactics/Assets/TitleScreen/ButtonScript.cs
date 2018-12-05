using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class ButtonScript : MonoBehaviour {

	// Changes scenes as a public function
	public void SceneChange (int buildOrder) {
        SceneManager.LoadScene(4);
        SceneManager.LoadScene (buildOrder);
	}
	// Enables and disables objects as needed
	public void ObjectToggle (GameObject target) {
		target.SetActive (!target.activeSelf);
	}
	// Exits the game
	public void GameClose () {
		Application.Quit ();
	}

    public void Load()
    {
        GameManager1.manager.Load();

    }
    public void reset()
    {
        GameManager1.manager.shield1Count = 0;
        GameManager1.manager.shield2Count = 0;
        GameManager1.manager.Save();
    }

    public void Awake()

    {
        Cursor.visible = true;
    }
}
