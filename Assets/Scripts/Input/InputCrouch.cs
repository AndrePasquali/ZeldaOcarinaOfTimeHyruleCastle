using MainLeaf.OcarinaOfTime.Character;

namespace MainLeaf.OcarinaOfTime.Input
{
    public class InputCrouch : InputCommand
    {
        private CharacterCrouch _characterCrouch;

        public InputCrouch(CharacterAbility characterAbility)
        {
            _characterCrouch = characterAbility as CharacterCrouch;
        }
        public void Execute()
        {
            _characterCrouch.Crouch();
        }
    }
}