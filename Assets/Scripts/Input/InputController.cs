using System;
using System.Collections.Generic;
using MainLeaf.OcarinaOfTime.Character;
using UnityEngine;

namespace MainLeaf.OcarinaOfTime
{
    public class InputController: MonoBehaviour
    {
        private Dictionary<string, InputCommand> _commands;

        private void Start()
        {
            _commands = new Dictionary<string, InputCommand>
            {
                { "jump", new InputJump(new CharacterJump()) },
                { "push", new InputPush(new CharacterPush()) }
            };
        }
        
        private void Update()
        {
            if (Input.GetKeyDown(KeyCode.Space)) _commands["jump"].Execute();
            if (Input.GetButtonDown("Push")) _commands["push"].Execute();
        }
    }
}