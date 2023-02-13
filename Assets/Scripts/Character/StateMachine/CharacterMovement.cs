namespace MainLeaf.OcarinaOfTime.Character.StateMachine
{
    public enum CharacterMovement
    {
        Default = 9,
        Idle = 1,
        Climb = 3,
        Grab = 10,
        Walking = 4,
        Falling = 5,
        Running = 6,
        Crouching = 7,
        Diving = 8,
        Jumping = 0,
        Pushing = 2,
        Attacking = 11,
        TakingHit = 12,
        Enter = 13
    }
}