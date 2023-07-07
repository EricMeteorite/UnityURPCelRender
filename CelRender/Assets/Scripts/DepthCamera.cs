using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DepthCamera : MonoBehaviour
{
    private Camera currentCamera = null;
    void Awake()
    {
        currentCamera = GetComponent<Camera>();
    }

    void Start()
    {
        currentCamera.depthTextureMode = DepthTextureMode.Depth;
    }

    void Update()
    {
        
    }
}
