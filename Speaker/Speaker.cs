using Godot;
using System;

public partial class Speaker : Area2D
{
	private AudioStreamPlayer2D player;
	private AudioStreamGenerator generator;

	public override void _Ready()
	{
		player = GetNode<AudioStreamPlayer2D>("AudioPlayer");
		generator = (AudioStreamGenerator)player.Stream;
	}

	public void PlaySound(Vector2[] buffer) {
		player.Play();
		AudioStreamGeneratorPlayback playback = (AudioStreamGeneratorPlayback)player.GetStreamPlayback();
		playback.PushBuffer(buffer);
	}
}
