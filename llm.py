import ollama

prompt = "hello there"
# stream = chat(
#     model='assistant',
#     messages=[{'role': 'user', 'content': prompt}],
#     stream=True,
# )

# for chunk in stream:
#   print(chunk['message']['content'], end='', flush=True)
ollama.chat(model='stella', messages=[{'role': 'user', 'content': 'Why is the sky blue?'}])