# purchasing

###Fabrikam Purchasing Website using Chef cookbook


In this hands-on lab you will explore some of the new features and capabilities of Deploying Purchasing App via Chef Server to a VM in Azure.  

**Prerequisites**

- An on-prem Windows VM with VSO-Agent
- Azure Linux Virtual Machine (target)
- Hosted/Enterprise Chef account 

**Tasks**

1. Configure your organization in Chef Server
3. Configure the Chef Workstation
4. Create a Cookbook
5. Create a Role
6. Deploy the Application
8. Setup continuous delivery using Build and Release definitions 

###Task 1: Configure your organization in Chef Server

**Step 1.** Open a web browser and navigate to the Chef Server URL

**Step 2.** Create organization and download started kit onto your Windows VM

###Task 2: Configuring the Chef Workstation
In this exercise, you will configure your Windows VM as a Chef Workstation.

**Step 1.** Download and install Chef Development kit 

The ChefDK can be installed on any workstation across a variety of operating systems and configured to work with a Chef server. For this lab, we are using the Windows VM as our workstation to make things easier and faster for a lab.

**Step 2.** Set your environment to reference the ChefDK

    $PATH ...<TODO>

**Step 3.** Download Chef starter kit

This creates a chef repo in the chef-repo directory.

 Chef uses RSA keys to encrypt all communication between the Chef workstation and the Chef server. Chef starter kit contains a file called <user>.pem, which contains the key for the user account. When we created our <fabrikam> organization, we saved the organization key into a file called <yourname-validator>.pem in our home directory. 


**Step 4.** View the current chef-repo contents.

    dir c:\chef-repo

**Step 5.** Synchronize the Chef repo.

    knife download /

**Step 6.** Run the **dir** command from Step 4 again, and observe that additional files and folders have been created in the chef-repo directory. 

###Task 4: Create a Cookbook
In this exercise, you will create a cookbook to automate the installation of the Purchasing application and upload it to the Chef server.

**Step 1.** Use the knife tool to generate a cookbook template. 

    knife cookbook create purchasing

 A cookbook is a set of tasks for configuring an application or feature. It defines a scenario and everything required to support that scenario. Within a cookbook, there are a series of recipes that define a set of actions to perform. Cookbooks and recipes are written in the Ruby language.

This creates an “purchasing” directory in the chef-repo/cookbooks/ directory that contains all of the boilerplate code that defines a cookbook and a default recipe.

**Step 2.** Edit the metadata.rb file in our cookbook directory.
   
    c:\chef-repo\cookbooks\purchasing\metadata.rb
 
Cookbooks and recipes can leverage other cookbooks and recipes. Our cookbook will use a pre-existing recipe for managing APT repositories.

**Step 3.** Add the following line at the end of the file:

    depends 'apt'

**Step 4.** The file should look like this:
    
    name 'purchasing'
    maintainer   'YOUR_COMPANY_NAME'
    maintainer_email 'YOUR_EMAIL'
    license  'All rights reserved'
    description  'Installs/Configures mrpapp'
    long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
    version  '0.1.0'
    depends 'apt'

**Step 5.** Save the file 

**Step 6.** Download the apt cookbook. 

    knife cookbook site download apt

 We need to install two dependencies for our recipe: the apt cookbook, and the chef-client cookbook. This can be accomplished using the knife cookbook site command, which will download the cookbooks from the official Chef cookbook repository, [https://supermarket.chef.io/cookbooks](https://supermarket.chef.io/cookbooks).

**Step 7.** Download the chef-client cookbook.

    knife cookbook site download chef-client

**Step 8.** We will first open up a full copy of the recipe on the host machine where you are connected to the Chef Server, found at [https://raw.githubusercontent.com/RoopeshNair/purchasing/master/Deploy/default.rb](https://raw.githubusercontent.com/RoopeshNair/purchasing/master/Deploy/default.rb).

**Step 9.** Copy all of the contents of this page, open the file c:\chef-repo\cookbooks\purchasing\recipes\default.rb

**Step 10.** The file should look like this to start: 

    ↪	#
    ↪	# Cookbook Name:: purrchasing 
    ↪	# Recipe:: default
    ↪	Cd site insta#
    ↪	# Copyright 2015, YOUR_COMPANY_NAME
    ↪	#
    ↪	# All rights reserved - Do Not Redistribute
    ↪	#
    
**Step 12.** Paste the contents of the recipe into the purchasing recipe file, save and exit

**Step 13.** *The following explains what the recipe is doing to provision the application.*

The first thing the recipe will do will be to run the 'apt' resource – this will cause our recipe to execute 'apt-get update' prior to running, to make sure the package sources on the machine are up-to-date.

    ↪	# Runs apt-get update
    ↪	include_recipe "apt"

Now we add an apt_repository resource to make sure that the OpenJDK repository is part of our apt repository list and up-to-date.
    
    ↪	# Add the Open JDK apt repo
    ↪	apt_repository 'openJDK' do
    ↪		uri 'ppa:openjdk-r/ppa'
    ↪		distribution 'trusty'
    ↪	end

Next, we will use the apt-package recipe to ensure that the OpenJDK and OpenJRE are installed. 

    ↪	# Install JDK and JRE
    ↪	apt_package 'openjdk-8-jdk' do
    ↪		action :install
    ↪	end
    ↪	
    ↪	apt_package 'openjdk-8-jre' do
    ↪		action :install
    ↪	end

Next, we set the JAVA_HOME and PATH environment variables to reference OpenJDK.

    ↪	# Set Java environment variables
    ↪	ENV['JAVA_HOME'] = "/usr/lib/jvm/java-8-openjdk-amd64"
    ↪	ENV['PATH'] = "#{ENV['PATH']}:/usr/lib/jvm/java-8-openjdk-amd64/bin"

Next, we'll install the Tomcat web server.

    ↪	# Install Tomcat 7
    ↪	apt_package 'tomcat7' do
    ↪		action :install
    ↪	end

At this point, all of our dependencies will be installed, so we can start configuring the applications. 

Next, we need to set the port that Tomcat will run our purchasing application on. This uses a script resource to invoke a regular expression to update the /etc/tomcat7/server.xml file.
The "not_if" action is a guard statement – if the code in the "not_if" action returns true, the resource won't execute. This lets us make sure the script will only run if it needs to run.
Another thing to note: We are referencing an attribute called #{node['tomcat']['mrp_port']}. We haven't defined this value yet, but we will in the next exercise! With attributes, you can set variables, so the purchasing application can run on one port on one server, or a different port on a different server.
If the port changes, you see that it uses "notifies" to invoke a service restart.

    ↪	# Set tomcat port 
    ↪	script 'tomcat_port' do 
    ↪		interpreter "bash"
    ↪		code "sed -i 's/Connector port=\".*\" protocol=\"HTTP\\/1.1\"$/Connector port=\"#{node['tomcat']['mrp_port']}\" protocol=\"HTTP\\/1.1\"/g' /etc/tomcat7/server.xml"
    ↪		not_if "grep 'Connector port=\"#{node['tomcat']['mrp_port']}\" protocol=\"HTTP/1.1\"$' /etc/tomcat7/server.xml"
    ↪		notifies :restart, "service[tomcat7]", :immediately
    ↪	end

Now we can download the purchasing application and start running it in Tomcat. If we get a new version, it signals the Tomcat service to restart.

    ↪	# Install the MRP app, restart the Tomcat service if necessary
    ↪	remote_file 'mrp_app' do
    ↪		source 'node['purchasing']['blob']
    ↪		path 'node['tomcat']['webapp_dir'] + node['purchasing']['app_war']
    ↪		action :create
    ↪		notifies :restart, "service[tomcat7]", :immediately
    ↪	end

We can define the Tomcat servce's desired state, which is "running". This will cause the script to check the Tomcat service, and start it if it isn't running. We can also signal this resource to "restart" with "notifies" (see above).

    ↪	# Ensure Tomcat is running
    ↪	service 'tomcat7' do
    ↪		action :start
    ↪	end


**Step 14.** Now that the recipe is written, we can upload the cookbooks to the Chef server. From the command line, run: 

    knife cookbook upload purchasing chef-client apt 

Now that we have a recipe created and all of the dependencies installed, we can upload our cookbooks and recipes to the Chef server with the knife upload command.

###Task 5: Create a Role
In this exercise, you will use the Chef Console to create a role to define a baseline set of cookbooks and attributes that can be applied to multiple servers. 

At the start of this task, you should be logged in to the Chef Console in a web browser. 

**Step 1.** Click on the "Policy" tab.

**Step 2.** Click on the "Roles" tab.

**Step 3.** Click the "Create" button. 

**Step 4.** Enter the role name *purchasing*.

**Step 5.** Click **Next**.

**Step 6.** Under **Available Recipes**, find the *purchasing* recipe.

A run list is a series of recipes to apply. We're defining a role that can be applied to as many servers as we want that will run the MRP application.

**Step 7.** Drag the *purchasing* recipe to the **Current Run List** box.

**Step 8.** Repeat for the **chef-client::service** recipe.

**Step 9.** The run list should be:
    
	1.	purchasing
	2.	chef-client::service

**Step 10.** Click **Next**.

**Step 11.** In the **Default Attributes** box, paste the text: 

    {
      "tomcat": {
    	"mrp_port": 9080
      }
    }

In the previous exercise, we referenced an attribute called ['tomcat']['mrp_port'] in our recipe. This was referencing a JSON object. Now we can define default value to provide.

**Step 12.** Click **Next**.

**Step 13.** Paste the following JSON in the **Override Attributes** box:

    {
      "chef_client": {
    	"interval": "60",
    	"splay": "1"
      }
    }

The second recipe we added to the run list was chef-client:: service. This recipe ensure that the Chef client will run on a regular basis to ensure that the environment is in sync with what is defined in our recipe. However, the default value for the chef client service is to sync every 30 minutes. We can override that value here and set it to a more frequent interval.

**Step 14.** Click **Create Role**.

###Task 6: Install Knife-Reporting
In this exercise, you will configure your Chef Workstation to use the Knife-Reporting plugin to determine the run status

**Step 1.** Install Knife-Reporting: 

    chef gem install knife-reporting


###Task 4: Deploy the Application
In this exercise, you will create a script to automatically deploy your Azure server and assign the purchasing application role to that server.

**Step 3.** Test everything works from command-line. Use chef-client to invoke the provisioning script: 

    ↪	chef-client  default.rb

**Step 4.** The script will take approximately 15 minutes to run. You will see it do the following things:
-	Update the packages apt
-	Intall tomcat on the VM and 
-	Execute the *purchasing* recipe.

Once the deployment is complete, you should be able to navigate to the purchasing application website and use it normally.

**Step 5.** Open the URL you chose for your cloud service name in a browser. The URL should be something like [http://mycloudservice.cloudapp.net:9080/purchasing](http://mycloudservice.cloudapp.net:9080/purchasing). 

![](<media/task7-step5.png>)

**Step 6.** Click around the site and observe that it functions normally.


**Step 7.** Go to the Chef Console in your web browser on your workstation and click on the **Reports** tab. 
This will take you to the dashboard where you can see statistics about your deployments.

**Step 8.** Click **Run History**.

**Step 9.** Observe that the node has a first successful run that executed. You should see a run occur within a minute that shows number of resources executed. 


In this hands-on lab you explored some of the new features and capabilities of Deploying purchasing App via Chef Server in Azure. This hands-on lab was designed to point out new features, discuss and describe them, and enable you to understand and explain these features to customers as part of the DevOps Lifecycle.

