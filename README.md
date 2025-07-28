# 🚀 GKE Autopilot CI/CD via Cloud Build & Git Tags

This project demonstrates a **fully automated CI/CD pipeline** using **Cloud Build**, **Artifact Registry**, and **GKE Autopilot**, triggered by **Git tags**.

---

## 📦 Features

✅ Docker image build  
✅ Push to Artifact Registry  
✅ Dynamic image tagging via Git tags (`$TAG_NAME`)  
✅ Kubernetes manifest templating with `envsubst`  
✅ GKE Autopilot deployment

---

## 🧭 Project Structure

├── Dockerfile # Hello World container
├── cloudbuild.yaml # Cloud Build steps
├── k8s-deployment.yaml.template # Kubernetes manifest template

---

## ⚙️ Prerequisites

1️⃣ Enable APIs (Run once)
`gcloud services enable container.googleapis.com cloudbuild.googleapis.com artifactregistry.googleapis.com`

2️⃣ Create Artifact Registry (if not yet)
`gcloud artifacts repositories create cloud-security --repository-format=docker --location=us-central1 --description="Artifact Registry for Hello World"`

3️⃣ Create GKE Autopilot Cluster
`gcloud container clusters create-auto hello-world-cluster --region=us-central1`

4️⃣ Prepare App Directory

5️⃣ Create cloudbuild.yaml

6️⃣ Push to GitHub with a Git Tag

7️⃣ Create Cloud Build Trigger (Tag-based)
`Go to Cloud Build > Triggers > Create Trigger`

`Source Repository: Select GitHub or CSR`

`Event: Push to a tag`

`Tag filter: v.*`

`Build config file: cloudbuild.yaml`

`Substitution vars (optional):`

`None needed, $TAG_NAME is automatic on tag pushes`

`Service account permissions:`

`Ensure it has Kubernetes Engine Developer, Artifact Registry Writer`

### 🔐 GCP Resources

- **GKE Autopilot cluster**  
  Name: `hello-world-cluster`  
  Region: `northamerica-northeast1`

- **Artifact Registry**  
  Region: `northamerica-northeast1`  
  Repo: `cloud-security`  
  Image path:  
  `northamerica-northeast1-docker.pkg.dev/off-net-dev/cloud-security/hello-world`

---

## 🚀 Deployment via Git Tag

Tag your release:

```bash
git tag v1.0.12
git push origin main --tags


This will trigger Cloud Build to:

Build the Docker image with :v1.0.12

Push it to Artifact Registry

Inject it into the Kubernetes manifest

Deploy to GKE Autopilot


Key: TAG_NAME
Value: Cloud Build automatically provides this when using tag triggers

🔁 Rollback Example
Want to redeploy a previous version?

git tag v1.0.11 -f
git push origin v1.0.11 --force
```

🔁 Challenging part
`Make dynamic TAG`

# k8s yml is just template

`Connection of tag in cloud build is TAG Name: image: northamerica-northeast1-docker.pkg.dev/off-net-dev/cloud-security/hello-world:${TAG_NAME}`

# cloud build connection to k8s is `envsubst`

`envsubst < k8s-deployment.yaml.template > final.yaml`
