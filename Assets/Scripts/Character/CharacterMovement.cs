using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CharacterMovement : MonoBehaviour
{
    public float speed = 10.0f;
    private Vector3 _playerInput;
    private Animator _animator;

    private float _horizontalInput;
    private float _verticalInput;

    private Vector3 _currentMovementInput;

    [SerializeField] private CharacterController _characterController;

    private void Update()
    {
        // Get input axis for horizontal and vertical movement
        _horizontalInput = Input.GetAxis("Horizontal");
        _verticalInput= Input.GetAxis("Vertical");

        _playerInput.x = _horizontalInput;
        _playerInput.z = _verticalInput;

        var cameraRelativeMovement = ConvertToCameraSpace(_playerInput);

        _characterController.Move(cameraRelativeMovement * speed * Time.deltaTime);
    }

    private Vector3 ConvertToCameraSpace(Vector3 vectorToRotate)
    {
        var currentYValue = vectorToRotate.y;
        var cameraForward = Camera.main.transform.forward;
        var cameraRight = Camera.main.transform.right;

        cameraForward.y = 0;
        cameraRight.y = 0;

        cameraForward = cameraForward.normalized;
        cameraRight = cameraRight.normalized;

        var cameraForwardZProduct = vectorToRotate.z * cameraForward;
        var cameraRightXProduct = vectorToRotate.x * cameraRight;

        var vectorRotateToCameraSpace = cameraForwardZProduct + cameraRightXProduct;
        vectorRotateToCameraSpace.y = currentYValue;

        return vectorRotateToCameraSpace;
    }

    private void HandleRotation()
    {
        var positionToLookAt = new Vector3();
       // positionToLookAt.x = 
    }
}
