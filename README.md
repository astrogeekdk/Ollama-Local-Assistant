# Ollama Local Voice Assistant

A simple local voice assistant powered by Ollama and speech recognition. Interact with your favorite open source model using your voice, and get spoken responses back.

## About This Project

This repository contains two related projects that leverage local LLMs via Ollama:

### 1. Python Voice Assistant

A speech-based assistant written in Python. It uses Whisper for speech-to-text and pyttsx3 for text-to-speech, allowing you to have natural voice conversations with your local LLM. Ideal for hands-free interaction.

### 2. Swift macOS Chatbot

A native macOS chatbot app written in Swift. This text-based assistant provides a beautiful UI for chatting with your local Ollama model, making it easy to interact and get responses directly on your Mac.

Both projects are designed to run entirely locally, ensuring privacy and fast response times.

## Features

- Voice input using your microphone (Python assistant)
- Speech-to-text via Whisper (Python assistant)
- Text-to-speech responses (Python assistant)
- Conversational memory
- Native macOS chatbot UI (Swift app)
- Runs locally, no cloud required

## Custom Models & System Messages

A great advantage of using Ollama is the ability to create custom models tailored to your daily tasks by setting the system message. This improves efficiency and lets you personalize your assistant.

**Example: Create a Mario Assistant**

Create a `Modelfile`:

```dockerfile
FROM llama3.2

# set the temperature to 1 [higher is more creative, lower is more coherent]
PARAMETER temperature 1

# set the system message
SYSTEM """
You are Mario from Super Mario Bros. Answer as Mario, the assistant, only.
"""
```

Build and run your custom model:

```bash
ollama create mario -f ./Modelfile
ollama run mario
>>> hi
Hello! It's your friend Mario.
```

You can use this custom model in both the Python and Swift assistants by changing the model name in the code.

## Usage

1. Start Ollama and ensure your model is running.
2. Run the assistant:
    ```bash
    python assistant.py
    ```
3. Speak into the microphone, and the assistant will transcribe your speech, send it to the LLM, and reply with spoken output.

For the macOS chatbot, open the Swift app and start chatting with your local model.

