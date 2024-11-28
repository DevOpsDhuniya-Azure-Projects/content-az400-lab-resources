Deploy a Python App to an AKS Cluster Using Azure Pipelines
Introduction
You are responsible for deploying a Python app to AKS. You have the code and a pipeline template, and you must create a CI/CD pipeline in Azure DevOps.

Solution
Log in to the Azure portal using the credentials provided for the lab.

Create an Azure DevOps Organization
In the main search bar, search for and select Azure DevOps organizations.

Scroll down and click My Azure DevOps Organizations.

Select your country/region from the dropdown list.

Select Create new organization > Continue > Continue (complete the required CAPTCHA).

Set the following values to create a project:

Project name: MyFirstProject
Visibility: Private
Click + Create project.

Import Code and Set Up the Environment
Create Your Environment
In the sidebar menu, select Repos.

In the Import a repository section, click Import.

In the Clone URL field, enter the following repository:

https://github.com/ACloudGuru-Resources/content-az400-lab-resources.git
Click Import.

After the import completes successfully, the Files page should open automatically.

At the top of the page, use the dropdown to switch the branch from DSC to aks.

You should now see the files you need for the lab.

Create Personal Access Token
In the upper right-hand corner, click the User settings icon > Personal access tokens.

Click + New Token and set the following values:

Name: pat1
Scopes: Full access
Click Create.

Copy the pat1 token and save it in a safe location.

Click Close.

Download Self-Hosted Agent
At the top of the page, click the Azure DevOps icon, then select the project.

On the bottom left, click Project settings.

Scroll down the left-hand pane and under Pipelines, select Agent pools.

Select the Default pool.

Click New agent.

Select the Linux tab.

Click the Copy icon, next to Download to copy the agent URL to your clipboard. Paste it to a text file to use in the following steps. Keep this tab and popup open.

Log in to the lab-VM Linux virtual machine using the credentials provided in the lab environment:

ssh cloud_user@<PUBLIC_IP>
Change directory to the root:

cd ~
Make and navigate to a new directory called Downloads:

mkdir Downloads && cd Downloads
Run wget against the agent URL you just copied:

wget <AGENT_URL>
Navigate back to the root (cd ~).

Create and navigate to another directory called myagent:

mkdir myagent && cd myagent
Unzip the package you just downloaded. You can copy this same command from the popup in Azure DevOps to get the full package and version number:

tar zxvf <PACKAGE>
Review the contents of the directory (ls). Observe all of the files and folders for the agent.

Configure the Agent
Run the configuration script:

./config.sh
Type y to accept the license agreement.

When prompted for your server URL, go back to Azure DevOps and grab the URL from your browser. It will look something like https://dev.azure.com/clouduser..., followed by some characters (i.e., copy everything up to and not including /MyFirstProject). Paste this in the terminal.

Press Enter to accept the default authentication type of PAT.

For personal access token, copy and paste the personal access token you created and saved earlier in this lab.

Press Enter to accept the default agent pool.

Press Enter to accept the default name.

Press Enter to accept the default work folder.

Run the agent interactively so that it is always listening for any jobs:

./run.sh
Create Pipeline Environment
In the sidebar menu, select Pipelines, then select Environments.
Click Create environment.
Fill in the environment details:
Name: Enter dev.
Resource: Select Kubernetes.
Click Next.
Ensure the resource details auto-populate, then click Validate and create.
Create a Service Connection and an ACR
In the bottom-left corner, click Project Settings.

This opens the settings in a new tab.

In the sidebar menu, select Service connections.

In the top right, click New service connection.

In the pane on the right, select Docker Registry, then click Next.

You'll need to gather some information from an Azure Container Registry (ACR) before you finish creating your service connection.

Navigate back to your Azure DevOps tab.

Navigate to All resources using the hamburger menu in the top-left corner.

Select the link for the Azure container registry (ACR) that's been pre-deployed with the lab.

In the ACR's sidebar menu, select Access keys (under Settings). You'll use these details for your service connection.

Add the New Docker Registry service connection details:

Fill in the Docker Registry:
From the Access keys page, copy the Login server.
Navigate to the service connections tab and paste the login server into the Docker Registry field using the format https://<LOGIN_SERVER>.
Fill in the Docker ID:
Navigate to the ACR tab and copy the Username.
Navigate to the service connections tab and paste the username into the Docker ID field.
Fill in the Docker Password:
Navigate to the ACR tab and copy either password.
Navigate to the service connections tab and paste the password into the Docker Password field.
In the Service connection name field, enter ACR.
Below Security, check the Grant access permission to all pipelines checkbox.
Click Save.

Create the CI/CD Pipeline
Update the Deployment Image
From the service connections tab, use the sidebar menu to select Repos.

Select the manifests folder, and open the vote.yml file.

In the top right, click Edit.

Update the deployment image:

Navigate to the ACR tab and copy the Login server again.
Navigate to the vote.yaml tab and replace the container image on line 59 with the Azure ACR DNS registry name, following the format <LOGIN_SERVER>/azure-vote-front:v1.
Note: The ACR DNS name ends with azurecr.io.

In the top right, click Commit.

In the Commit pane, ensure the Branch name is set to aks, then click Commit.

Create the Pipeline
In the sidebar menu, select Pipelines.

Click Create Pipeline.

For the code location, select Azure Repos Git.

For the repository, select the MyFirstProject repo.

Select Existing Azure Pipelines YAML file.

Fill in the YAML file details:

Branch: Select aks.
Path: Select /azure-pipelines.yml.
Click Continue.

Update the azure-pipelines.yml code:

Navigate to the ACR tab and copy the Login server again.
Navigate to the pipeline tab and replace the value for containerRegistry with your copied Azure ACR DNS registry name.
In the top-right corner, click Save and run.

In the pane on the right, leave the default settings and click Save and run.

After the pipeline is triggered, select Build stage to monitor the build progress.

Note the banner in the terminal indicating that the pipeline needs additional permissions to continue the build.

Click View to the right of the banner.

Click Permit to the right of the requested permissions and confirm the selection.

After the build has completed, select Deploy to dev.

Note the banner in the terminal indicating that the pipeline needs additional permissions to continue the deployment. If the banner does not display. Click the back arrow above the deployment to go back to the job summary. Then, click View in the yellow notification box.

Like before, allow all permissions. The deployment will take a few minutes to complete.

Access the AKS Cluster
Navigate to the ACR tab.
At the top, click All resources.
Select the link for the Kubernetes service cluster. (You can ignore any errors that appear as they are related to restrictions on the lab environment.)
On the left menu, under Kubernetes resources, select Services and ingresses.
All services in the cluster are displayed. Observe the azure-vote-front service has an External IP. Click the link for the IP.
The app opens in a new tab where you can click to vote on cats or dogs.
Conclusion
Congratulations — you've completed this hands-on lab!
