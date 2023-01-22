
using UnityEngine;

namespace MainLeaf.OcarinaOfTime.Enrironment
{

    public interface IPushable
    {
        public void Push(GameObject player, Rigidbody pushableObject);
    }
}
