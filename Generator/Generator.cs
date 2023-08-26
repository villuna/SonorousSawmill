using Godot;
using System;

public partial class Generator : Area2D
{
	private float sampleHz = 44100;
	private readonly float pulseHz = 440;
	private readonly int bufferLength = 32767; //Number of samples for 0.5 seconds

	[Export]
	private PackedScene audioItem;
	// Called when the node enters the scene tree for the first time.

	private float Decay(float progress) {
		float velocity = 2.0f;
		float decay = (float)Math.Exp(-velocity * progress);
		if (progress < 0.5) {
			return decay;
		} else {
			return (float)Mathf.Lerp(decay, 0, 2 * (progress - 0.5));
		}
	}

	private Vector2[] CreateBuffer() {
		float phase = 0;
		float increment = pulseHz / sampleHz;
		Vector2[] buffer = new Vector2[bufferLength];

		for (int i = 0; i < bufferLength; i++) {
			float progress = (float)i / (float)bufferLength;
			buffer[i] = Vector2.One * Decay(progress) * (float)Math.Sin(phase * Math.Tau);
			phase = (phase + increment) % 1;
		}

		return buffer;
	}

	public AudioItem CreateAudioItem() {
		AudioItem item = (AudioItem)audioItem.Instantiate();

		item.SetBuffer(CreateBuffer());

		return item;
	}
}
