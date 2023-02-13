using UnityEngine;

namespace MainLeaf.OcarinaOfTime.Character
{

    public class CharacterMovement : MonoBehaviour
    {
        [SerializeField] private Animator _animator;

        [SerializeField] private Rigidbody _rigidbody;

        [Header("SLOPE")]
        [SerializeField] private float _slopeLimit = 45.0f;
        [SerializeField] private float _rayLength = 1.5f;
        [SerializeField] private float _slopeForce = 8.0f;

        [Header("Movement")]
        [SerializeField] private float _moveSpeed = 2;
        [SerializeField] private float _turnSpeed = 200;
        [SerializeField] private float _jumpForce = 10;
        private readonly float _interpolation = 10;
        private float _currentVertical = 0;
        private float _currentHorizontal = 0;


        private void FixedUpdate()
        {
            HandleSlope();
            UpdateMovement();
        }

        private void UpdateMovement()
        {
            float v = UnityEngine.Input.GetAxis("Vertical");
            float h = UnityEngine.Input.GetAxis("Horizontal");

            bool walk = UnityEngine.Input.GetKey(KeyCode.LeftShift);

            _currentVertical = Mathf.Lerp(_currentVertical, v, Time.deltaTime * _interpolation);
            _currentHorizontal = Mathf.Lerp(_currentHorizontal, h, Time.deltaTime * _interpolation);

            Vector3 forwardMovement = transform.forward * _currentVertical * _moveSpeed * Time.deltaTime;
            //Vector3 verticalMovement = Physics.gravity * Time.deltaTime;

            transform.position += forwardMovement;
            transform.Rotate(0, _currentHorizontal * _turnSpeed * Time.deltaTime, 0);

            _animator.SetFloat("Forward", _currentVertical);
            _animator.SetFloat("Turn", _currentHorizontal);
        }

        private bool OnSlope()
        {
            RaycastHit hit;
            if (UnityEngine.Physics.Raycast(transform.position, Vector3.down, out hit, _rayLength))
            {
                float angle = Vector3.Angle(hit.normal, Vector3.up);
                Vector3 surfaceNormal = new Vector3(Mathf.Sin(angle * Mathf.Deg2Rad), Mathf.Cos(angle * Mathf.Deg2Rad), 0);
                Debug.DrawRay(transform.position, surfaceNormal, Color.cyan);
                if (angle > _slopeLimit)
                {
                    Debug.Log("SLOPE DETECT");
                    return true;
                }
            }

            return false;
        }

        private void HandleSlope()
        {
            if (OnSlope()) _rigidbody.AddForce(Vector3.down * _slopeForce, ForceMode.Impulse);
        }
    }
}
