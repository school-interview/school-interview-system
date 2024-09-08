import pymupdf4llm
import pathlib
import sys

path_to_pdf = sys.argv[1]
path_to_destination = sys.argv[2]
if not path_to_pdf:
    print("Path to the pdf file is required")
    sys.exit(1)
if not path_to_destination:
    print("Path to the destination directory is required")
    sys.exit(1)


md_text = pymupdf4llm.to_markdown(path_to_pdf)
pathlib.Path(path_to_destination).write_bytes(md_text.encode())
