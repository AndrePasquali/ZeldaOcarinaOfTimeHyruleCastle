using System;
using MainLeaf.OcarinaOfTime.Audio;
using MainLeaf.OcarinaOfTime.Extensions;
using MainLeaf.OcarinaOfTime.Player;
using MainLeaf.OcarinaOfTime.Services;
using MainLeaf.OcarinaOfTime.UI.HUD;
using UnityEngine;

namespace MainLeaf.OcarinaOfTime.Enrironment.Item
{
    public class PickableItem : MonoBehaviour, ISound
    {
        [SerializeField] private AudioSource _audioSource;
        [SerializeField] private AudioClip _soundClip;
        public enum Type
        {
            Green = 10,
            Red = 20,
            Blue = 30,
            Purple = 40,
            Silver = 50,
            Gold = 60
        }

        public Type ItemType = Type.Blue;

        private void PickItem()
        {
            PlayerProgress.AddPoints((int)ItemType);
            UpdateHud();

            gameObject.Hide();
        }

        private void UpdateHud()
        {
            var serviceHud = ServiceLocator.Get<HUD>();

            serviceHud.UpdatePoints();
        }


        public void OnTriggerEnter(Collider other)
        {
            if (other.gameObject.tag.Equals("Player"))
            {
                PlaySoundFX();
                PickItem();
            }
        }

        public void PlaySoundFX()
        {
            _audioSource.PlayOneShot(_soundClip);
        }
    }
}