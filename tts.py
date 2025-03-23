import pyttsx3

engine = pyttsx3.init()

voices = engine.getProperty('voices')
for voice in voices:
    print(f"Voice: {voice.name}, ID: {voice.id}")


# engine.setProperty('voice', 'com.apple.voice.premium.en-AU.Lee')
# engine.setProperty('voice', 'com.apple.voice.enhanced.en-US.Zoe')
# engine.setProperty('voice', 'com.apple.voice.premium.en-US.Ava')
# engine.setProperty('voice', 'com.apple.speech.synthesis.voice.Zarvox')


# engine.setProperty('voice', 'com.apple.voice.enhanced.hi-IN.Neel')
engine.setProperty('voice', 'com.apple.voice.premium.hi-IN.Kiyara')
# engine.setProperty('voice', 'com.apple.voice.compact.en-IN.Rishi')
engine.setProperty('rate', 180) 
engine.setProperty('volume', 1)

engine.say("")
engine.runAndWait()