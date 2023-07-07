using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Rotate : MonoBehaviour
{
    float degree = 0;
    float rotateSpeed = 72;
    bool isRotate = false;
    // Start is called before the first frame update
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {
        if(degree<=360 && isRotate)
        {
            gameObject.transform.Rotate(0, rotateSpeed*Time.deltaTime, 0, Space.Self);
            degree += rotateSpeed*Time.deltaTime;
        }
        else
        {
            isRotate = false;
            degree = 0;
        }
    }

    public void RotateEnabled(float _rotateSpeed)
    {
        rotateSpeed = _rotateSpeed;
        isRotate = true;
    }
}
