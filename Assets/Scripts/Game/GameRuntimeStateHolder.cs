using System.Collections.Generic;
using MainLeaf.OcarinaOfTime.Scenes;
using MainLeaf.OcarinaOfTime.Character.StateMachine;
using UnityEngine;
using MainLeaf.OcarinaOfTime.Services;
using UnityEngine.SceneManagement;
using MainLeaf.OcarinaOfTime.Player;

namespace MainLeaf.OcarinaOfTime.Game
{
    public static class GameRuntimeStateHolder
    {
        private static HashSet<SceneName> _completedLevels = new HashSet<SceneName>();

        private static List<BoxState> _boxStateList = new List<BoxState>();

        private static SceneName _currentScene = SceneName.LOADING;

        private static SceneName _lastLevelLoaded;


        #region Box 

        public static List<BoxState> GetBoxPositionState() => _boxStateList;

        public static void SetBoxPositionState(BoxState box1, BoxState box2)
        {
            _boxStateList.Add(box1);
            _boxStateList.Add(box2);
        }
        #endregion

        #region Gameplay

        public static void ResetGameState()
        {
            ClearCompletedLevels();
            PlayerProgress.ResetPoints();
            _boxStateList.Clear();
        }

        public static void OnGameQuit()
        {
            GameRuntimeStateHolder.SetLoadedLevel(MainLeaf.OcarinaOfTime.Scenes.SceneName.LOADING);
            ResetGameState();
        }


        #endregion

        #region Levels

        public static bool IsLevelCompleted(SceneName level)
        {
            return _completedLevels.Contains(level);
        }
        public static bool IsLevelCompleted()
        {
            return _completedLevels.Contains(GetCurrentLevel());
        }

        public static void MarkLevelCompleted(SceneName level)
        {
            if (level == SceneName.COURTYARD_CASTLE)
            {
                ResetGameState();
                return;
            }

            _completedLevels.Add(level);
        }

        public static SceneName GetCurrentLevel()
        {
            return _lastLevelLoaded;
        }

        public static void SetLoadedLevel(SceneName level) => _lastLevelLoaded = level;

        public static SceneName GetCurrentScene()
        {
            return (SceneName)SceneManager.GetActiveScene().buildIndex;
        }


        public static void ClearCompletedLevels()
        {
            _completedLevels.Clear();
        }

        #endregion

        #region Movement
        public static CharacterMovement GetCurrentMovementState()
        {
            var state = ServiceLocator.Get<CharacterStateMachine>();

            return state.CurrentMovementState;
        }
        #endregion

    }

    public class BoxState
    {
        public Vector3 Position { get; set; }
        public Quaternion Rotation { get; set; }
    }

}

