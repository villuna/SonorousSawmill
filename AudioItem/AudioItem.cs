using Godot;
using System;

public partial class AudioItem : Area2D
{
	private Vector2[] buffer;
	private readonly int bufferLength = 32767; //Number of samples for 0.5 seconds

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
		}
	}

	public override void _Ready()
	{
		buffer = new Vector2[bufferLength];
	}
}
