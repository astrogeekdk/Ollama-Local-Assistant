from ollama import chat
from ollama import ChatResponse
import speech_recognition as sr
import pyttsx3

engine = pyttsx3.init()

engine.setProperty('voice', 'com.apple.voice.premium.en-AU.Lee')
# engine.setProperty('voice', 'com.apple.voice.enhanced.en-US.Zoe')
# engine.setProperty('voice', 'com.apple.voice.premium.en-US.Ava')
# engine.setProperty('voice', 'com.apple.speech.synthesis.voice.Zarvox')

engine.setProperty('rate', 180) 
engine.setProperty('volume', 1)

messages = []

recognizer = sr.Recognizer()

with sr.Microphone() as source:
    recognizer.adjust_for_ambient_noise(source, duration=1)


while True:
    with sr.Microphone() as source:
        print(">>> ", end='')
        audio = recognizer.listen(source)

    try:
        text = recognizer.recognize_whisper(audio, language='en')
        print(text)
    except:
        pass
    
    prompt = text


    if messages:
        messages.append({'role': 'user', 'content': prompt})
    else:
        messages = [{'role': 'user', 'content': prompt}]
    response: ChatResponse = chat(model='stella', messages=messages)

    print(response['message']['content'])
    engine.say(response['message']['content'])
    engine.runAndWait() 

    messages.append({'role':'assistant', 'content':response['message']['content']})
    print(messages)