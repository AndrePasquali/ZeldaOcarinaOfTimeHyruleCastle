namespace MainLeaf.OcarinaOfTime.Character.StateMachine
{
    public interface ICharacterStateObserver
    {
        public void OnStateStart();
        public void OnStateFinish();
    }
}