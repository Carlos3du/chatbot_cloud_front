# Use Python 3.11 slim image as base
FROM python:3.11-slim

# Instalar uv - gerenciador de pacotes Python ultrarrápido
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Set working directory
WORKDIR /app

# Copiar arquivos de dependências
COPY pyproject.toml ./

# Instalar dependências usando uv
RUN uv pip install --system -r pyproject.toml

# Copy the frontend application
COPY frontend/ ./frontend/

# Expose Streamlit default port
EXPOSE 8501

# Set environment variables for Streamlit
ENV STREAMLIT_SERVER_PORT=8501
ENV STREAMLIT_SERVER_ADDRESS=0.0.0.0

# Run the Streamlit app
CMD ["streamlit", "run", "frontend/main.py", "--server.port=8501", "--server.address=0.0.0.0"]
