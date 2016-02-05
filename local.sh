#from the source directory.
sudo apt-get upgrade

python setup.py install

export ANSIBLE_HOST_KEY_CHECKING=False

echo $1 > user.txt
if [ ! -d "ssh_keys" ]; then
  ssh-keygen -t rsa
  mkdir ssh_keys
  cp ~/.ssh/id_rsa ssh_keys/id_rsa
  cp ~/.ssh/id_rsa.pub ssh_keys/id_rsa.pub
  # Control will enter here if $DIRECTORY doesn't exist.
fi

#this will create 1 instance and we will install the packages and whatever is needed for that.
vcl-opsworks request add --image-id 3630 --node-type master -c 1 --playbook main.yml "https://vcl.ncsu.edu/scheduling/index.php?mode=xmlrpccall" "$1@NCSU"
#it will return a connecting ip address, use that to do ssh.

dir=$(pwd)
val=1
while read line           
do           
     val=$"$line"           
done < $dir/AutoSpark/Ansible/playbooks/master_inventory

#ssh to 1 of the ips
#ssh -X $1@$val

#distributed file system
#Contact vcl IT help desk

#Sending file to master node.
#scp /home/amrit/GITHUB/Enron/Datasets/SE/academia.txt $1@$val:/home/$1/academia
