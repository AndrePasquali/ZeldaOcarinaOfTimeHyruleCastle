using MainLeaf.OcarinaOfTime.Character;

namespace MainLeaf.OcarinaOfTime.Input
{
    public class InputClimb : InputCommand
    {
        private CharacterClimb _characterJump;

        public InputClimb(CharacterAbility characterAbility)
        {
            _characterJump = characterAbility as CharacterClimb;
        }
        public void Execute()
        {
            _characterJump.Climb();
        }
    }
}