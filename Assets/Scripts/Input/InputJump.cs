using MainLeaf.OcarinaOfTime.Character;

namespace MainLeaf.OcarinaOfTime
{
    public class InputJump: InputCommand
    {
        private CharacterJump _characterJump;

        public InputJump(CharacterAbility characterAbility)
        {
            _characterJump = characterAbility as CharacterJump;
        }
        public void Execute()
        {
            _characterJump.Jump();
        }
    }
}