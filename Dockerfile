FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    tesseract-ocr \
    poppler-utils \
    tesseract-ocr-por \
    tesseract-ocr-eng \
    tesseract-ocr-spa \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip poetry
COPY pyproject.toml ./
RUN poetry config virtualenvs.create false

RUN poetry install --without dev --no-interaction --no-ansi -vvv

COPY . .

EXPOSE 5001

CMD ["uvicorn", "docling_serve.app:create_app", "--factory", "--host", "0.0.0.0", "--port", "5001"]