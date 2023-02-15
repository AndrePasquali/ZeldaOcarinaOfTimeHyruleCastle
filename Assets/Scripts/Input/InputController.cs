using System;
using System.Collections.Generic;
using System.Linq;
using MainLeaf.OcarinaOfTime.Character;
using UnityEngine;

namespace MainLeaf.OcarinaOfTime.Input
{
    public class InputController : MonoBehaviour
    {
        private Dictionary<string, InputCommand> _commands;

        public enum CommandState
        {
            Default,
            Jump,
            Push,
            Crouch
        }

        public CommandState CurrentCommand
        {
            get => _currentCommand;

            set
            {
                switch (value)
                {
                    case CommandState.Jump:
                        {
                            _commands["jump"].Execute();
                            break;
                        }
                    case CommandState.Push:
                        {
                            _commands["push"].Execute();
                            break;
                        }
                    case CommandState.Crouch:
                        {
                            //_commands["crouch"].Execute();
                            break;
                        }
                    case CommandState.Default: break;
                }
            }
        }

        private CommandState _currentCommand;

        [SerializeField] private Rigidbody _rigidbody;

        private void Start()
        {
            _commands = new Dictionary<string, InputCommand>
            {
                { "jump", new InputJump(GetComponent<CharacterJump>()) },
                { "push", new InputPush(GetComponent<CharacterPush>()) },
                { "climb", new InputClimb(GetComponent<CharacterClimb>())},
                { "crouch", new InputCrouch(GetComponent<CharacterCrouch>())}
            };
        }

        private void Update()
        {
            if (UnityEngine.Input.GetKeyDown(KeyCode.Space)) CurrentCommand = CommandState.Jump;
            else if (UnityEngine.Input.GetKeyDown(KeyCode.F)) CurrentCommand = CommandState.Push;
            else if (UnityEngine.Input.GetKeyDown(KeyCode.C)) CurrentCommand = CommandState.Crouch;
            else CurrentCommand = CommandState.Default;
        }
    }
}