from fastapi import FastAPI

app = FastAPI()


@app.get("/hello")
async def hello():
    return {"message": "hello world!あ"}


# @app.get("/data")
# async def data():
