using MainLeaf.OcarinaOfTime.Character;

namespace MainLeaf.OcarinaOfTime.Input
{
    public class InputPush : InputCommand
    {
        private CharacterPush _characterAbility;

        public InputPush(CharacterAbility characterAbility)
        {
            _characterAbility = characterAbility as CharacterPush;
        }
        public void Execute()
        {
            _characterAbility.Push();
        }
    }
}