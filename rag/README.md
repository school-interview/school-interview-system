# RAG Test

This is just my experimentation on RAG.

I used Python 3.12.4.

## rag-from-csv.ipynb

Required packages.

```
pip install langchain
pip install langchain-community
pip install faiss-cpu
```

1. Install LLM
   You need to install the LLM → ELYZA-japanese-Llama-2-13b-fast-instruct
   And then, put it at rag/model/directory!

   Warning⚠️: The model file is very large! (about 3.8GB). It will take much time to download.

2. Install required packages

3. Run it!
   open rag/main.ipynb in your VSCode and push 'Run All' button above on the VSCode window.
   (VSCode might ask you to install "ipykernel". please accept it.)

## rag-from-pdf.ipynb

Required packages.

```
pip install openai
pip install langchain
pip install pypdf
pip install tiktoken
pip install chromadb
```
