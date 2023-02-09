using System;
using System.Collections;
using System.Collections.Generic;
using MainLeaf.OcarinaOfTime.Character;
using UnityEngine;

namespace MainLeaf.OcarinaOfTime.Player
{
    public class PlayerController : MonoBehaviour
    {
        private CharacterAbility _characterAbility;
        [SerializeField] private float m_moveSpeed = 2;
        [SerializeField] private float m_turnSpeed = 200;
        [SerializeField] private float m_jumpForce = 10;

        [SerializeField] private Animator m_animator = null;
        [SerializeField] private Rigidbody m_rigidBody = null;
        
        private float m_currentV = 0;
        private float m_currentH = 0;

        private readonly float m_interpolation = 10;
        private readonly float m_walkScale = 0.33f;
        private readonly float m_backwardsWalkScale = 0.16f;
        private readonly float m_backwardRunScale = 0.66f;
        
        private float m_jumpTimeStamp = 0;
        private float m_minJumpInterval = 0.25f;
        private bool m_jumpInput = false;
        

        private void Awake()
        {
            if (!m_animator)
            {
                gameObject.GetComponent<Animator>();
            }

            if (!m_rigidBody)
            {
                gameObject.GetComponent<Animator>();
            }
        }
        private void FixedUpdate()
        {
          //  m_animator.SetBool("OnGround", m_isGrounded);

            UpdateMovement();
            //ThirdPersonMovement();
        }

        private void UpdateMovement()
        {
            float v = Input.GetAxis("Vertical");
            float h = Input.GetAxis("Horizontal");

            bool walk = Input.GetKey(KeyCode.LeftShift);

            if (v < 0)
            {
                //transform.Rotate(Vector3.up, 360F * Time.deltaTime);

                if (walk)
                {
                    v *= m_backwardsWalkScale;
                }
                else
                {
                    v *= m_backwardRunScale;
                }
            }
            else if (walk)
            {
                v *= m_walkScale;
            }

            m_currentV = Mathf.Lerp(m_currentV, v, Time.deltaTime * m_interpolation);
            m_currentH = Mathf.Lerp(m_currentH, h, Time.deltaTime * m_interpolation);

            transform.position += transform.forward * m_currentV * m_moveSpeed * Time.deltaTime;
            transform.Rotate(0, m_currentH * m_turnSpeed * Time.deltaTime, 0);

            m_animator.SetFloat("Forward", m_currentV);
            m_animator.SetFloat("Turn", m_currentH);
        }

        private void ThirdPersonMovement()
        {
            float horizontal = Input.GetAxis("Horizontal");
            float vertical = Input.GetAxis("Vertical");

            var moveDirection = new Vector3();

            moveDirection = new Vector3(horizontal, 0f, vertical);
           // moveDirection = Camera.main.transform.TransformDirection(moveDirection);
            moveDirection.y = 0f;
            moveDirection.Normalize();
            
            m_animator.SetFloat("Forward", moveDirection.magnitude);
            m_animator.SetFloat("Turn", horizontal);

            
            m_rigidBody.MovePosition(transform.position + moveDirection * m_moveSpeed * Time.deltaTime);

        }
    }
}
