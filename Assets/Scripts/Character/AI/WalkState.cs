using System;
using System.Collections;
using System.Collections.Generic;
using System.Threading.Tasks;
using UnityEngine;
using UnityEngine.AI;

namespace MainLeaf.OcarinaOfTime.Character.AI
{
    public class WalkState : AIState
    {
        public WalkState(SquareWalkAI parent, Transform[] points, NavMeshAgent agent) : base(parent, points, agent)
        {
            Parent = parent;
            Points = points;
            Agent = agent;
        }

        public override  AIState UpdateState()
        {
            Vector3 target = Points[Parent.CurrentPoint].position;
            Agent.destination = target;

            if (Agent.remainingDistance <= Agent.stoppingDistance + 0.75F)
            {
                Parent.CurrentPoint = (Parent.CurrentPoint + 1) % Points.Length;
                
                return new PauseState(Parent, Parent.PauseTime);
            }

            return this;
        }
    }
}
