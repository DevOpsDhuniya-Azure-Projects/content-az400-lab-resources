Introduction
	• Objective: Deploy a Python application to AKS using a CI/CD pipeline in Azure DevOps.
	• Prerequisites: Access to Azure portal, Azure DevOps, and necessary credentials.
Step 1: Setup Azure DevOps
	1. Log in to Azure Portal.
	2. Create Azure DevOps Organization:
		○ Use the main search bar to find and select "Azure DevOps organizations".
		○ Click "My Azure DevOps Organizations".
		○ Choose your country/region and create a new organization.
		○ Set up your new project with the name "MyFirstProject" and set its visibility to "Private".
Step 2: Import Code and Prepare the Repository
	1. Import Repository:
		○ In Azure DevOps, navigate to "Repos".
		○ Click "Import" and use the repository URL https://github.com/ACloudGuru-Resources/content-az400-lab-resources.git.
		○ Switch the branch to "aks" after import.
	2. Create Personal Access Token (PAT):
		○ Go to User settings > Personal access tokens.
		○ Create a new token named "pat1" with full access.
		○ Save this token securely.
Step 3: Set Up Build Agent
	1. Download Self-Hosted Agent:
		○ Navigate to Project Settings > Agent pools > Default pool.
		○ Download the agent for Linux and copy the URL.
	2. Configure Agent on VM:
		○ SSH into your lab VM.
		○ Create a directory, download, and unzip the agent.
		○ Run ./config.sh to configure the agent using the PAT created earlier.
		○ Start the agent with ./run.sh.
Step 4: Configure CI/CD Pipeline
	1. Create Pipeline Environment:
		○ Go to Pipelines > Environments.
		○ Create an environment named "dev" for Kubernetes.
	2. Create Service Connection:
		○ Under Project Settings, create a new service connection for Docker Registry using details from Azure Container Registry (ACR).
Step 5: Build and Deploy the Application
	1. Update Deployment Image:
		○ Edit the vote.yml file under the manifests folder to update the deployment image with the ACR DNS name.
	2. Set Up CI/CD Pipeline:
		○ Create a new pipeline using the existing YAML file from the repo.
		○ Update the azure-pipelines.yml with the container registry details.
		○ Run the pipeline and approve necessary permissions during build and deployment phases.
Step 6: Verify Deployment
	1. Access AKS Cluster:
		○ Navigate to Kubernetes services via Azure portal.
		○ Check "Services and ingresses" for the External IP of the azure-vote-front service.
		○ Access the application via the provided IP to confirm the deployment.
Conclusion
	• Outcome: The Python application is successfully deployed to AKS via Azure Pipelines.
	• Next Steps: Consider adding more security features or integrating additional tests within the pipeline for better CI/CD practices.
