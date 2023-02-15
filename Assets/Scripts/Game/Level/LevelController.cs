namespace MainLeaf.OcarinaOfTime.Game.Level
{

    public sealed class LevelController : MonoBehaviour
    {
        public static Action<SceneName> OnLevelStarted;
        public static Action<SceneName> OnLevelEnded;

        private void Start() => Initialize();
        private void Initialize()
        {
            OnLevelStarted += OnLevelStarted;
            OnLevelEnded += OnLevelEnded;
        }

        private void OnLevelStarted(SceneName sceneName)
        {

        }

        private void OnLevelEnded(SceneName sceneName)
        {

        }
    }
}