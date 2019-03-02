# Cloud Cluster Template
## Introduction
Parallel Computing Project - Utilizing geographically distributed computing resources (processors & memory) to solve large scale sorting problems in a time efficient manner.

<b>Group Project:</b> \
Becca - beccabuoni \
Ben - bwal213 \
John - Spades86

## Table of Contents
* [What & Why Parallel Computing]() - Answers the question of Parallel Computing.
* [What is this Project]() - Explains what our project is and does.
* [Tools Used]() - Explains each tool in detail.
* [Files]() - A description and purpose of each file.
* [Definitions]() - 

## What & Why Parallel Computing
Imagine you had an incredibly long and unsorted list of data. Let’s say shopping receipts for the last 20 years of your life. You have many dollar amount totals and you want to sort them from smallest to largest. So you input them into a computer and click a button to sort them. We’ll say it takes 10 minutes for the computer to come back with an answer as it applies a sorting algorithm like merge sort or quick sort to your receipt data.

Great, but what if the computer took 30 days to come back with an answer because your data set was the past 20 years of receipts for everyone who ever shopped at a particular mall. How about an even larger scale of all the malls in the USA, now it’s over 2 years of processing time for one computer, how long is too long? So you decide to upgrade to a server, and you quickly max out the processing and memory capability. We’ll say you managed to compress the processing time down to 1 year.

What if we added a second exact copy of that powerful server we made and then we manually split the receipt data in half? What if there was so much data that we need 20-30 computers/servers to even begin to sort? What if instead of manually dividing up the data we could get all the computers to communicate and divide up the work automagically and then bring all of their sorted data back together to feed us the sorted answer we were looking for?

Enter parallel computing, which is exactly the solution to the problem we are describing. While parallel computing does have a minimum data size barrier to entry for it to be considered effective compared to having a single resource (computer) do the work, for all intents and purposes, it offers the greatest speed increase in finding answers to large scale problems. A good example is if you had to count the cars in a single parking lot. You would just do it manually because you are only going to do it once and creating any kind of tool to help you would take more time than the manual solution, but if you had to count the cars in 1000 parking lots, time spent creating an assistive tool would be a huge time saver. 

## What is this Project
What you are staring at is a Git repository, but a pretty nonstandard one at that, since this is not a mere software project. Contained here are a series of files that work in tandem with a website called CloudLab to create several virtual computers (think of these as workers in an office building). These files create fully fleshed out workers; everything from what their hardware configurations are, such as memory and processing capacities, to their operating systems and what software is installed on them. Furthermore, these files include a multitude of other neat features (MPI, MariaDB, SlurmDBD, and Hadoop MapReduce) that allow the virtual computers to intercommunicate beyond a basic networking level for the purpose of working in parallel to solve large scale problems. 

More specifically, this repository via profile.py (Python code) creates the following:
* metadata node (1) - Stores data about the data.
* storage node (1) - Stores pre-sorted and post-sorted data.
* head node (1) - Distributes instructions to the compute nodes on how to communicate. (Supervisor/Leader)
* compute node (12) - Receives a portion of unsorted data and sorts it following the head node’s instructions. (Worker)
Then it installs CentOS7 (Linux distribution) on these nodes. From this point forward the entire project was an experiment in installation, configuration, and utilization of parallel computing related software tools that were all configured to be installed via Linux commands, C code, and a few text files.

## Tools Used
[CloudLab](https://www.cloudlab.us/) - Gateway access to geographically distributed compute resources (memory/processing power) that allows the creation of a virtual cloud of computers/servers while also visually displaying them for easy configuration and experimentation. 

[GENI]() - [geni-lib]( https://geni-lib.readthedocs.io/en/latest/intro/intro.html) - Global Environment for Network Innovations - A software infrastructure suite that allows the programmatic configuration and control of all aspects of a parallel computing network (all the nodes in a network). Geni-lib is a Python library that utilizes the GENI software infrastructure suite. 

[Xen]( https://xenproject.org/about-us/) - An open source hypervisor (popular enough to be included in the Linux kernel by default). We utilize Xen through a geni-lib library Class called XenVM, which allows us to draft up nodes (hosts/clients/virtual computers…)

[VirtualBox]( https://www.virtualbox.org/) - Software hypervisor designed to allow you to host your own virtual computers on-top of your current operating system. ???

[Jupyter]( https://jupyter.org/) - Technically the tool in question is the Jupyter Notebook Application, but Jupyter in general is a collaboration tool that exists as a webpage. The webpage contains code and text shared by everyone in the group. The notebook can even be hosted on GitHub (acting as a server). For the purposes of this course, the class’s notes and sample code was all hosted via a Jupyter notebook. 

[MariaDB](https://mariadb.org/about/) - An open source fork of MySQL, which are both Relational Database Management Systems (RDBMS). Simply put, a place to hold information that is organized/interconnected by relationships. Think of a collection of tables of information. 

[MPI](http://mpitutorial.com/tutorials/mpi-introduction/) - [OMPI]( https://www.open-mpi.org/) - Message Passing Interface / Open Message Passing Interface - As simple as it sounds, it passes messages. MPI is the glue that holds the concept of parallel computing together. Allows the sending of instructions to-and-from nodes to help them pseudo operate as a single entity (compute resource). The OMPI variant is just the open source version.

[Slurm](https://slurm.schedmd.com/overview.html) - A job scheduler tool. Interprets the jobs (data and objectives fed from MPI) and distributes the data amongst the allotted compute resources available (it also manages the availability of these resources).

[Hadoop](https://www.sas.com/en_us/insights/big-data/hadoop.html) - [Hadoop MapReduce]( https://docs.marklogic.com/guide/mapreduce/hadoop#id_73616) - Manages data processing and storage for very large scale data sources. MapReduce is a framework of Hadoop that takes in large amounts of data and reduces and consolidates the final output. 

## Files
* [source]()
* [Extra_Head_Slurm.sh]() 
* [Extra_Metadata_Slurm.sh]() 
* [Extra_Node_Slurm.sh]() 
* [MungeKey_Create.sh]() 
* [dbd.sql]() 
* [innodb.cnf]() 
* [install_NFS_client.sh]() 
* [install_NFS_head.sh]() 
* [install_NFS_storage.sh]() 
* [install_mpi.sh]()
* [munge_setup.sh]() 
* [passwordless.sh]() 
* [profile.py]() 
* [sample_job.sh]() 
* [setup.sql]() 
* [setup_firewall.sh]() 
* [slurm-18.08.4.tar.bz2]() 
* [slurmdbd.conf]() 
* [source_client.sh]()
* [ssh_setup.sh]() 
