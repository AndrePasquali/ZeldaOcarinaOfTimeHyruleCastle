using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CharacterMovement : MonoBehaviour
{
    public float speed = 10.0f;
    private CharacterController _characterController;
    private Vector3 _movement;
    private Animator _animator;

    private void Start()
    {
        _characterController = GetComponent<CharacterController>();
        _animator = GetComponent<Animator>();
    }

    private void Update()
    {
        // Get input axis for horizontal and vertical movement
        float horizontal = Input.GetAxis("Horizontal");
        float vertical = Input.GetAxis("Vertical");

        // Set movement direction based on input
        _movement = new Vector3(horizontal, 0, vertical);

        // Normalize movement direction to ensure consistent speed
        _movement = _movement.normalized;

        // Apply movement to character controller
        _characterController.Move(_movement);
        
        _animator.SetFloat("Forward", -vertical);
        _animator.SetFloat("Turn", vertical);
    }
}
