using Godot;
using System;

public partial class AudioItem : Area2D
{
	[Signal]
	public delegate void ClickedEventHandler(Node self);
	private readonly int bufferLength = 32767; //Number of samples for 0.5 seconds
	private Vector2[] buffer = new Vector2[32767];

	public Vector2[] GetBuffer() {
		return buffer;
	}

	public void SetBuffer(Vector2[] inBuffer) {
		for (int i = 0; i < bufferLength; i++) {
			if (i < inBuffer.Length) {
				buffer[i] = inBuffer[i];
			} else {
				buffer[i] = Vector2.Zero;
			}

			GD.Print(buffer[i]);
		}
	}

	public void _OnClick(Node viewport, InputEvent inputEvent, int x) {
		if (inputEvent.IsActionPressed("left_click")) {
			EmitSignal(SignalName.Clicked, this);	
		}
	}
}
