FROM python:3.9-slim
WORKDIR /app
COPY ./hello-world-gke/app.py .
RUN pip install flask
CMD ["python", "app.py"]
