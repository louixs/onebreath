Output demo/social.gif

Set Shell "bash"
Set FontSize 18
Set Width 900
Set Height 500
Set Theme "Dracula"
Set Padding 20
Set TypingSpeed 30ms
Set LoopOffset 0%

# Reset PS1/PROMPT_COMMAND inherited from the parent shell before the
# visible portion starts — otherwise it can leak into vhs's spawned bash
# and render garbled prompt garbage. Clear the screen too so the Hide
# block's own typed commands don't show up in the recording.
Hide
Type "unset PROMPT_COMMAND; PS1='$ '"
Enter
Type "clear && bash demo/social.sh"
Enter
Sleep 300ms
Show

Sleep 12s
