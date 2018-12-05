using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class PausePanel : MonoBehaviour {

    private CanvasGroup pausePanel;
    public CanvasGroup levelSelect;
    public CanvasGroup regularPanal;
    public CanvasGroup LvlScore;
    private bool activated;
    private winController WinController;
    private GameObject WinVolume;
    private int sceneID;

    // Use this for initialization 
    void Awake()
    {
        pausePanel = GetComponent<CanvasGroup>();
        Time.timeScale = 1;
        pausePanel.alpha = 0;
        pausePanel.interactable = false;
        sceneID = SceneManager.GetActiveScene().buildIndex;

        if (sceneID == 5)
        {
            WinVolume = GameObject.Find("WinVolume1");
            WinController = GameObject.Find("WinVolume1").GetComponent<winController>(); ;
            WinVolume.SetActive(false);
        }
        else
        {
            WinController = GameObject.Find("WinVolume").GetComponent<winController>();
        }

    }

    // Update is called once per frame 
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Escape))
        {

            activated = !activated;

        }
        if (activated)
        {
            pausePanel.alpha = 1;
            LvlScore.alpha = 0;
            Cursor.lockState = CursorLockMode.None;
            Cursor.visible = true;
            pausePanel.blocksRaycasts = true;
            pausePanel.interactable = true;
            Time.timeScale = 0;
        }
        else
        {
            pausePanel.alpha = 0;
            LvlScore.alpha = 1;
            if (WinController.Won == false)
            {
                Cursor.lockState = CursorLockMode.Locked;
                Cursor.visible = false;

            }
            else
            {
                Cursor.lockState = CursorLockMode.None;
                Cursor.visible = true;
            }
            pausePanel.interactable = false;
            pausePanel.blocksRaycasts = false;
            Time.timeScale = 1;

        }
    }
    public void LevelSelect()
    {

        levelSelect.interactable = true;
        levelSelect.blocksRaycasts = true;
        levelSelect.alpha = 1;

        regularPanal.interactable = false;
        regularPanal.blocksRaycasts = false;
        regularPanal.alpha = 0;
    }
    public void Save()
    {
        GameManager1.manager.Save();
    }
    public void Load()
    {
        GameManager1.manager.Load();

    }
    public void sheild1Up(){
        GameManager1.manager.shield1Count += 1;
    }
    public void sheild1Down()
    {
        GameManager1.manager.shield1Count -= 1;
    }
    public void Back()
    {
        
        levelSelect.interactable = false;
        levelSelect.blocksRaycasts = false;
        levelSelect.alpha = 0;
       
        regularPanal.interactable = true;
        regularPanal.blocksRaycasts = true;
        regularPanal.alpha = 1;
    }
    public void UnPause()
    {

        activated = !activated;
    }

}