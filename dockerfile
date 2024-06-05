# # -------------------------------- Build stage -----------------------------------------

#     FROM python:3.9.16-slim AS build

#     # Set working directory
#     WORKDIR /app
    
#     # Copy requirements and install dependencies
#     COPY requirements.txt .
#     RUN pip install --no-cache-dir --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org -r requirements.txt
    
#     # --------------------------- Runtime stage ---------------------------------------------
    
#     FROM python:3.9.16-slim
    
#     # Create a non-root user
#     RUN adduser --disabled-password --gecos "" django_user
    
#     # Copy installed packages from the build stage
#     COPY --from=build /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages
    
#     # Set working directory
#     WORKDIR /django_app
    
#     # Copy application code
#     COPY . /django_app/
    
#     # Change ownership of the application directory
#     RUN chown -R django_user:django_user /django_app
    
#     # Switch to non-root user
#     USER django_user
    
#     # Set environment variables
#     ENV DJANGO_SECRET_KEY=your_secret_key
    
#     # Expose the port the app runs on
#     EXPOSE 8000
    
#     # Add a health check
#     # HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 CMD curl -f http://localhost:8000/health || exit 1
    
#     # Command to run the application
#     CMD ["python", "django_web_app/manage.py", "runserver", "0.0.0.0:8000"]
    
# -------------------------------- Build stage -----------------------------------------
    FROM python:3.9.16-slim AS build

    # Set working directory
    WORKDIR /app
    
    # Copy requirements and install dependencies
    COPY requirements.txt .
    RUN python -m venv /opt/venv && \
        . /opt/venv/bin/activate && \
        pip install --upgrade pip && \
        pip install --no-cache-dir --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org -r requirements.txt
    
    # --------------------------- Runtime stage ---------------------------------------------
    FROM python:3.9.16-slim
    
    # Create a non-root user
    RUN adduser --disabled-password --gecos "" django_user
    
    # Copy virtual environment from the build stage
    COPY --from=build /opt/venv /opt/venv
    
    # Set working directory
    WORKDIR /django_app
    
    # Copy application code
    COPY . /django_app/
    
    # Change ownership of the application directory
    RUN chown -R django_user:django_user /django_app
    
    # Switch to non-root user
    USER django_user
    
    # Set environment variables
    ENV DJANGO_SECRET_KEY=your_secret_key
    ENV PATH="/opt/venv/bin:$PATH"
    
    # Expose the port the app runs on
    EXPOSE 8000
    
    # Add a health check
    # HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 CMD curl -f http://localhost:8000/health || exit 1
    
    # Command to run the application
    CMD ["python", "django_web_app/manage.py", "runserver", "0.0.0.0:8000"]
    