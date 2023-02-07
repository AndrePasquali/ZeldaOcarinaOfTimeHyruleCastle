using UnityEngine;

namespace MainLeaf.OcarinaOfTime.Character.AI
{
    public class PauseState: AIState
    {
        private float _timer = 5.0F;
        public PauseState(SquareWalkAI parent, float time) : base(parent, parent.Points, parent.Agent)
        {
            _timer = time;
        }

        public override AIState UpdateState()
        {
            Debug.Log($"Process Pause");
            _timer -= Time.deltaTime;

            if (_timer <= 0)
            {
                return new WalkState(Parent, Points, Agent);
            }

            return this;
        }
    }
}