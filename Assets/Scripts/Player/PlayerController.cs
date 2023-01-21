using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerController : MonoBehaviour
{
    [SerializeField] private Animator _animator;
    [SerializeField] private Rigidbody _rigidbody;
    [SerializeField] private float _speed;
    [SerializeField] private float _gravity = 9.81F;
    private void FixedUpdate()
    {
        float horizontal = Input.GetAxis("Horizontal");
        float vertical = Input.GetAxis("Vertical");

        Vector3 movement = new Vector3(-horizontal, 0.0f, -vertical);
        movement = movement * _speed * Time.deltaTime;
        movement.y = -_gravity * Time.deltaTime;
        
        _animator.SetFloat("Forward", movement.z);
        _animator.SetFloat("Turn", movement.x);

        _rigidbody.MovePosition(_rigidbody.position + movement);
    }
}
