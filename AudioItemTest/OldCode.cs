using Godot;
using System;

public partial class AudioItemTest : Node2D {
	private float sampleHz;
	private readonly float pulseHz = 440;
	private AudioStreamPlayer2D player;
	private AudioStreamGenerator generator;
	private AudioStreamGeneratorPlayback playback;

	private Vector2[] buffer;

	public override void _Ready() {
		player = GetNode<AudioStreamPlayer2D>("AudioPlayer");
		generator = (AudioStreamGenerator)player.Stream;

		sampleHz = generator.MixRate;
		GD.Print(sampleHz);

		PlaySound();
	}

	private float Decay(float progress) {
		float velocity = 2.0f;
		float decay = (float)Math.Exp(-velocity * progress);
		if (progress < 0.5) {
			return decay;
		} else {
			return (float)Mathf.Lerp(decay, 0, 2 * (progress - 0.5));
		}
	}

	void PlaySound() {
		player.Play();
		FillBuffer();
		Play();
	}

	private void FillBuffer() {
		playback = (AudioStreamGeneratorPlayback)player.GetStreamPlayback();
		float phase = 0;
		float increment = pulseHz / sampleHz;
		int framesAvailable = playback.GetFramesAvailable();
		buffer = new Vector2[framesAvailable];

		for (int i = 0; i < framesAvailable; i++) {
			float progress = (float)i / (float)framesAvailable;
			buffer[i] = Vector2.One * Decay(progress) * (float)Math.Sin(phase * Math.Tau);
			phase = (phase + increment) % 1;
		}
	}

	private void Play() {
		playback.PushBuffer(buffer);
	}
}
