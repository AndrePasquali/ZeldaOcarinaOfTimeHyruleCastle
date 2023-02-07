using UnityEngine;
using UnityEngine.AI;

namespace MainLeaf.OcarinaOfTime.Character.AI
{
    public abstract class AIState : MonoBehaviour
    {
        protected SquareWalkAI Parent;
        protected Transform[] Points;
        protected float Speed;
        public NavMeshAgent Agent;

        public AIState(SquareWalkAI parent, Transform[] points, NavMeshAgent agent)
        {
            Parent = parent;
            Points = points;
            Agent = agent;
        }

        public abstract AIState UpdateState();
    }
}
