FROM python:3.11-slim-bookworm

RUN apt-get update && apt-get install -y \
    libgl1 \
    libglib2.0-0 \
    tesseract-ocr \
    tesseract-ocr-por \
    tesseract-ocr-eng \
    tesseract-ocr-spa \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN pip install --no-cache-dir "docling-serve[all]" --extra-index-url https://download.pytorch.org/whl/cpu

RUN docling-tools models download

COPY . .

EXPOSE 5001

CMD ["uvicorn", "docling_serve.app:create_app", "--factory", "--host", "0.0.0.0", "--port", "5001"]