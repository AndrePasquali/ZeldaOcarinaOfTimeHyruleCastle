using System.Collections.Generic;
using MainLeaf.OcarinaOfTime.Scenes;
using MainLeaf.OcarinaOfTime.Character.StateMachine;
using UnityEngine;
using MainLeaf.OcarinaOfTime.Services;

namespace MainLeaf.OcarinaOfTime.Game
{
    public static class GameRuntimeStateHolder
    {
        private static HashSet<int> _completedLevels = new HashSet<int>();
        public enum GameState
        {
            DEFAULT,
            GAMEPLAY,
            GAMEOVER,
            COMPLETED
        }

        private static GameState _currentGameState;

        private static BoxState _boxState = new BoxState();

        private static SceneName _currentScene = SceneName.LOADING;


        #region Box 

        public static BoxState GetBoxPositionState() => _boxState;

        public static void SetBoxPositionState(Vector3 box1Position, Vector3 box2Position)
        {
            _boxState.SetPositions(box1Position, box2Position);
        }
        #endregion

        #region Scene

        public static void SaveScene(SceneName newScene) => _currentScene = newScene;
        public static SceneName GetCurrentScene() => _currentScene;

        #endregion

        #region Gameplay

        public static void ChangeGameState(GameState newState) => _currentGameState = newState;

        public static GameState GetGameState() => _currentGameState;

        #endregion

        #region Levels

        public static bool IsLevelCompleted(int levelNumber)
        {
            return _completedLevels.Contains(levelNumber);
        }

        public static void MarkLevelCompleted(int levelNumber)
        {
            _completedLevels.Add(levelNumber);
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
}


public class BoxState
{
    public void SetPositions(Vector3 box1, Vector3 box2)
    {
        Box1PositionState = box1;
        Box2PositionState = box2;
    }
    public Vector3 Box1PositionState;
    public Vector3 Box2PositionState;
}