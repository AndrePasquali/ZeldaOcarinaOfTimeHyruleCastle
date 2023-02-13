using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;

namespace MainLeaf.OcarinaOfTime.Environment
{

    public class NextLevelAnimation : MonoBehaviour
    {
        [SerializeField] private PlayableDirector _playableDirector;
        public void OnTriggerEnter(Collider other)
        {
            if (other.gameObject.tag == "Player")
            {
                _playableDirector.Play();
                gameObject.SetActive(false);
            }

        }
    }
}

