using System.Linq;
using System;
using MainLeaf.OcarinaOfTime.Enrironment;
using MainLeaf.OcarinaOfTime.Scenes;
using MainLeaf.OcarinaOfTime.Services;
using UnityEngine;
using UnityEngine.SceneManagement;
using Cysharp.Threading.Tasks;
using Mainleaf.OcarinaOfTime.UI;

namespace MainLeaf.OcarinaOfTime.Game.Level
{
    public enum EndGameReason
    {
        Completed,
        GameOver
    }

    public sealed class LevelController : MonoBehaviour
    {
        public static Action<SceneName> OnLevelStarted;
        public static Action<SceneName, EndGameReason> OnLevelEnded;

        private void Awake() => PauseToggle(false);

        private void Start() => Initialize();
        private void Initialize()
        {
            ServiceLocator.Register(this);

            OnLevelStarted += OnLevelStartedAction;
            OnLevelEnded += OnLevelEndedAction;

            OnLevelStarted.Invoke(GameRuntimeStateHolder.GetCurrentScene());
        }

        private async void OnLevelStartedAction(SceneName levelName)
        {
            GameRuntimeStateHolder.SetLoadedLevel(levelName);

            var levelIsCompleted = GameRuntimeStateHolder.IsLevelCompleted();

            if (levelIsCompleted && levelName == SceneName.HYRULE_CASTLE) RestoreBoxState();
        }

        private void OnLevelEndedAction(SceneName levelName, EndGameReason endGameReason)
        {
            //UIController.OnLevelEnded?.Invoke();

            if (endGameReason == EndGameReason.Completed) GameRuntimeStateHolder.MarkLevelCompleted(levelName);
            if (endGameReason == EndGameReason.Completed && levelName == SceneName.HYRULE_CASTLE)
            {
                if (GameRuntimeStateHolder.GetBoxPositionState().Count > 0) return;

                var boxes = GameObject.FindObjectsOfType<Box>().ToList();

                var box1 = new BoxState
                {
                    Position = boxes.First().transform.position,
                    Rotation = boxes.First().transform.rotation
                };
                var box2 = new BoxState
                {
                    Position = boxes.First().transform.position,
                    Rotation = boxes.First().transform.rotation
                };
                GameRuntimeStateHolder.SetBoxPositionState(box1, box2);

            }

        }

        private void RestoreBoxState()
        {
            var boxes = GameObject.FindObjectsOfType<Box>().ToList();
            var boxesCachedPositions = GameRuntimeStateHolder.GetBoxPositionState();

            if (boxes.Count == 0 || boxesCachedPositions.Count == 0) return;

            var box1Cache = boxesCachedPositions.First();
            var box2Cache = boxesCachedPositions.Last();

            if (boxes.First() != null && box1Cache != null)
            {
                boxes.First().DisablePhysics();
                boxes.First().transform.position = box1Cache.Position;
                boxes.First().transform.rotation = box1Cache.Rotation;

            }

            if (boxes.Last() != null && box2Cache != null)
            {
                boxes.Last().DisablePhysics();
                boxes.Last().transform.position = box2Cache.Position;
                boxes.Last().transform.rotation = box2Cache.Rotation;
            }
        }

        private void PauseToggle(bool paused)
        {
            Time.timeScale = paused ? 0 : 1;
        }

        private void OnDestroy()
        {
            OnLevelStarted -= OnLevelStartedAction;
            OnLevelEnded -= OnLevelEndedAction;
        }
    }
}